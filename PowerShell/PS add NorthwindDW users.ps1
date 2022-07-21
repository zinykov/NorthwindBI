$Server = "SWIFT3"
$Database = "NorthwindDW"
$InputFile = "$(System.DefaultWorkingDirectory)\_Build solution\drop\CreateUsers.sql"
 
Invoke-Sqlcmd -ServerInstance $Server -Database $Database -InputFile $InputFile