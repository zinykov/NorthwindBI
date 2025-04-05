cd "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Binn"
dqsinstaller -importkbs "C:\Users\zinyk\OneDrive\DisasterRecovery\DQS\DQSBackup.dqsb" -collation "Cyrillic_General_CI_AS_KS_WS"

cd  "C:\Program Files\Microsoft SQL Server\160\Master Data Services\Configuration"
MDSModelDeploy deploynew -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\CustomerNW.pkg" -model CustomerNW -service MDS1
MDSModelDeploy deploynew -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\EmployeeNW.pkg" -model EmployeeNW -service MDS1
MDSModelDeploy deploynew -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\Holidays.pkg" -model Holidays -service MDS1
MDSModelDeploy deploynew -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\ProductNW.pkg" -model ProductNW -service MDS1
