::logman import -name "SQL Server" -xml "C:\Users\zinyk\source\repos\Northwind_BI_Solution\Monitoring\PerformanceMonitoring.xml"
logman start -name "SQL Server"
::/C "logman stop -name "SQL Server" -as"