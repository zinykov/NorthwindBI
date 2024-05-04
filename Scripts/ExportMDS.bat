cd  C:\Program Files\Microsoft SQL Server\150\Master Data Services\Configuration
MDSModelDeploy createpackage -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\CustomerNW.pkg" -model CustomerNW -version VERSION_1 -includedata
MDSModelDeploy createpackage -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\EmployeeNW.pkg" -model EmployeeNW -version VERSION_1 -includedata
MDSModelDeploy createpackage -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\Holidays.pkg" -model Holidays -version VERSION_1 -includedata
MDSModelDeploy createpackage -package "C:\Users\zinyk\OneDrive\DisasterRecovery\MDS\ProductNW.pkg" -model ProductNW -version VERSION_1 -includedata
::cd C:\Users\zinyk\OneDrive\DisasterRecovery\MDS
::tar -a -c -f MDS.zip *.pkg