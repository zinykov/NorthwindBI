cd  "C:\Program Files\Microsoft SQL Server\160\Master Data Services\Configuration"
MDSModelDeploy createpackage -package "C:\Users\zinyk\source\repos\Northwind_BI_Solution\MDS\CustomerNW.pkg" -model CustomerNW -version VERSION_1 -includedata
MDSModelDeploy createpackage -package "C:\Users\zinyk\source\repos\Northwind_BI_Solution\MDS\EmployeeNW.pkg" -model EmployeeNW -version VERSION_1 -includedata
MDSModelDeploy createpackage -package "C:\Users\zinyk\source\repos\Northwind_BI_Solution\MDS\Holidays.pkg" -model Holidays -version VERSION_1 -includedata
MDSModelDeploy createpackage -package "C:\Users\zinyk\source\repos\Northwind_BI_Solution\MDS\ProductNW.pkg" -model ProductNW -version VERSION_1 -includedata