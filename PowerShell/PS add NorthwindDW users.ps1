$Server = "SWIFT3"
$Database = "NorthwindDW"
$InputFile = "$(System.DefaultWorkingDirectory)\_Build solution\drop\NorthwindDW\Scripts\CreateUsers.sql"
 
Invoke-Sqlcmd -ServerInstance $Server -Database $Database -InputFile $InputFile