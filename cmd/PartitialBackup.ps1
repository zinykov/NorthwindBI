#param([DateTime] $CutoffTime, [String] $DWHServerName, $DWHDatabaseName)

If ( $CutoffTime -eq $null ) { $CutoffTime=Get-Date -Year:1998 -Month:01 -Day:03 -Hour:00 -Minute:00 -Second:00 -Format:"yyyy-MM-dd"}
If ( $DWHServerName -eq $null ) { $DWHServerName = "SWIFT3" }
If ( $DWHServerName -eq $null ) { $DWHDatabaseName = "NorthwindDW" }

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

$IsSetFilegroupReadonly = Invoke-Sqlcmd -ServerInstance:$DWHServerName -Database:$DWHDatabaseName -Query:$query | Select-Object -ExpandProperty:"IsSetFilegroupReadonly"

$IsSetFilegroupReadonly