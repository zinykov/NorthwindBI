$Server = "SWIFT3"
$Database = "NorthwindDW"
$InputFile = "$(System.DefaultWorkingDirectory)\_Build solution\drop\PowerShell scripts\CreateUsers.sql"
 
Invoke-Sqlcmd -ServerInstance $Server -Database $Database -InputFile $InputFile