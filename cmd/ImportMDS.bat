cd  C:\Program Files\Microsoft SQL Server\150\Master Data Services\Configuration
MDSModelDeploy deploynew -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\CustomerNW.pkg" -model CustomerNW -service MDS
MDSModelDeploy deploynew -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\EmployeeNW.pkg" -model EmployeeNW -service MDS
MDSModelDeploy deploynew -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\Holidays.pkg" -model Holidays -service MDS
MDSModelDeploy deploynew -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\ProductNW.pkg" -model ProductNW -service MDS
