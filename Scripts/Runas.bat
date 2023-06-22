::RunAs /user:UserBI "\"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe\" http://swift3/reports/browse/Monitoring"
::RunAs /user:UserBI "C:\Program Files (x86)\Microsoft SQL Server Management Studio 19\Common7\IDE\Ssms.exe"

RunAs /noprofile /user:AzPipelineAgent cmd

::PowerShell -ExecutionPolicy Unrestricted -command "C:\SSIS\NorthwindBI\Scripts\Backup.ps1 ( Get-Date -Date:31.12.1998 ) "SWIFT3" "NorthwindDW" "C:\SSIS\NorthwindBI\" 3 "C:\SSIS\NorthwindBI\Backups""