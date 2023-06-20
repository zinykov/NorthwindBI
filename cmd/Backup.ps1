<#
	Call Script
PowerShell -ExecutionPolicy Unrestricted -command "C:/SSIS/NorthwindBI/Scripts/Backup.ps1 ( Get-Date -Date:31.12.1997 ) "SWIFT3" "NorthwindDW" "C:/SSIS/NorthwindBI/" 3 "C:/SSIS/NorthwindBI/Backups/""

	Call Expression
"-ExecutionPolicy Unrestricted -command \"" + @[$User::var_ExternalFilesPath] + "Scripts/Backup.ps1 ( Get-Date -Date:" + (DT_WSTR, 10) @[$Package::CutoffTime] + " ) \""+ @[$Project::DWHServerName] +"\" \"" + @[$Project::DWHDatabaseName] + "\" \"" + @[$User::var_ExternalFilesPath] + "\" " + (DT_WSTR, 2) @[$Project::RetrainWeeks] + " \"" + @[$User::var_BackupFilesPath] + "\"\""
#>

param(
	[DateTime]$CutoffTime,
	[String]$DWHServerName,
	[String]$DWHDatabaseName,
	[String]$ExternalFilesPath,
	[Int]$RetrainWeeks,
	[String]$BackupFilesPath
)

$CutoffTimeStr = $CutoffTime.ToString('yyyy-MM-dd')

$query = "
DECLARE	@IsStartOptimization BIT = 0,
		@IsSetFilegroupReadonly BIT = 0

EXECUTE	[Maintenance].[CheckReferenceDate]
		@CutoffTime = N'$CutoffTimeStr',
		@IsMonthlyOptimization = 0,
		@IsStartOptimization = @IsStartOptimization OUTPUT,
		@IsSetFilegroupReadonly = @IsSetFilegroupReadonly OUTPUT

SELECT	[IsSetFilegroupReadonly] = @IsSetFilegroupReadonly;
"

$IsSetFilegroupReadonly = Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -Query:$query -Verbose | Select-Object -ExpandProperty:'IsSetFilegroupReadonly'

If ( $IsSetFilegroupReadonly )
{
    $InputFile = $ExternalFilesPath + 'Scripts/SetFilegroupsReadOnly.sql'
    Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -InputFile:$InputFile -Variable:"DatabaseName=$DWHDatabaseName","Cutofftime=$CutoffTimeStr" -Verbose
}

$query = "
    DECLARE	@BackupFolderName nvarchar(10),
		    @BackupOldFolderName nvarchar(10)

    EXECUTE	[Maintenance].[GetBackupFolderNames]
		    @CutoffTime = N'$CutoffTimeStr',
		    @RetrainWeeks = $RetrainWeeks,
		    @BackupFolderName = @BackupFolderName OUTPUT,
		    @BackupOldFolderName = @BackupOldFolderName OUTPUT

    SELECT	[BackupFolderName] = @BackupFolderName,
		    [BackupOldFolderName] = @BackupOldFolderName;
"
$Output = Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -Query:$query -Verbose

$BackupsReadOnly = $BackupFilesPath + $DWHDatabaseName + '/ReadOnly'
If ( !( Test-Path -Path:$BackupsReadOnly ) ) { New-Item -ItemType:'directory' -Path:$BackupsReadOnly }

$BackupFolderName = $BackupFilesPath + $DWHDatabaseName + '/' + ( $Output | Select-Object -ExpandProperty:'BackupFolderName' )
If ( !( Test-Path -Path:$BackupFolderName ) ) { New-Item -ItemType:'directory' -Path:$BackupFolderName }

If ( Test-Path -Path:$BackupFolderName, $BackupsReadOnly )
{
	$query = "
		EXECUTE	[Maintenance].[BackupDatabase]
				@CutoffTime = N'$CutoffTimeStr',
				@BackupsReadOnlyPath = N'$BackupsReadOnly',
				@BackupsReadWritePath = N'$BackupFolderName'
	"
	Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -Query:$query -Verbose
}
$BackupOldFolderName = $BackupFilesPath + $DWHDatabaseName + '/' + ( $Output | Select-Object -ExpandProperty:'BackupOldFolderName' )
If ( Test-Path -Path:$BackupOldFolderName ) { Remove-Item -Path:$BackupOldFolderName -Recurse }