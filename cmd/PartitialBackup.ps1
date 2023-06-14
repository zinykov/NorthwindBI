param( [DateTime]$CutoffTime, [String]$DWHServerName, [String]$DWHDatabaseName, [String]$ExternalFilesPath, [Int]$RetrainWeeks, [String]$BackupFilesPath )

#If ( $CutoffTime -eq $null ) { $CutoffTime=Get-Date -Year:1998 -Month:01 -Day:03 -Hour:00 -Minute:00 -Second:00 -Format:"yyyy-MM-dd"}
#If ( $DWHServerName -eq $null ) { $DWHServerName = "SWIFT3" | Write-Host }
#If ( $DWHDatabaseName -eq $null ) { $DWHDatabaseName = "NorthwindDW" | Write-Host }
#If ( $ExternalFilesPath -eq $null ) { $ExternalFilesPath = "C:\SSIS\NorthwindBI\" | Write-Host }
#If ( $RetrainWeeks -eq $null ) { $RetrainWeeks = 3 }
#If ( $BackupFilesPath -eq $null ) { $BackupFilesPath = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\" }

$query = "
DECLARE	@IsStartOptimization BIT = 0,
		@IsSetFilegroupReadonly BIT = 0

EXECUTE	[Maintenance].[CheckReferenceDate]
		@CutoffTime = N'"+$CutoffTime+"',
		@IsMonthlyOptimization = 0,
		@IsStartOptimization = @IsStartOptimization OUTPUT,
		@IsSetFilegroupReadonly = @IsSetFilegroupReadonly OUTPUT

SELECT	[IsSetFilegroupReadonly] = @IsSetFilegroupReadonly;
"

$IsSetFilegroupReadonly = Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -Query:$query -Verbose | Select-Object -ExpandProperty:"IsSetFilegroupReadonly"


If ( $IsSetFilegroupReadonly )
{
    $InputFile = $ExternalFilesPath + "Scripts\SetFilegroupsReadOnly.sql"
    Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -InputFile:$InputFile -Variable:"DatabaseName=$DWHDatabaseName","Cutofftime=$CutoffTime" -Verbose
}

$query = "
    DECLARE	@BackupFolderName nvarchar(10),
		    @BackupOldFolderName nvarchar(10)

    EXECUTE	[Maintenance].[GetBackupFolderNames]
		    @CutoffTime = N'"+$CutoffTime+"',
		    @RetrainWeeks = "+$RetrainWeeks+",
		    @BackupFolderName = @BackupFolderName OUTPUT,
		    @BackupOldFolderName = @BackupOldFolderName OUTPUT

    SELECT	[BackupFolderName] = @BackupFolderName,
		    [BackupOldFolderName] = @BackupOldFolderName;
"
$Output = Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -Query:$query -Verbose

$BackupsReadOnly = $BackupFilesPath + $DWHDatabaseName + "\ReadOnly"
$BackupFolderName = $BackupFilesPath + $DWHDatabaseName + "\" + ( $Output | Select-Object -ExpandProperty:"BackupFolderName" )

If ( !( Test-Path -Path:$BackupsReadOnly ) ) { New-Item -ItemType:"directory" -Path:$BackupsReadOnly }
If ( !( Test-Path -Path:$BackupFolderName ) ) { New-Item -ItemType:"directory" -Path:$BackupFolderName }

$query = "
    EXECUTE	[Maintenance].[BackupDatabase]
		    @CutoffTime = N'1998-01-03',
		    @BackupsReadOnlyPath = N'"+$BackupsReadOnly+"',
		    @BackupsReadWritePath = N'"+$BackupFolderName+"'
"
Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -Query:$query -Verbose

$BackupOldFolderName = $BackupFilesPath + $DWHDatabaseName + "\" + ( $Output | Select-Object -ExpandProperty:"BackupOldFolderName" )
If ( Test-Path -Path:$BackupOldFolderName ) { Remove-Item -Path:$BackupOldFolderName -Recurse }