::logman import -name "SQL Server" -xml "C:\Users\zinyk\source\repos\Northwind_BI_Solution\Monitoring\PerformanceMonitoring.xml"
::/C "logman start -name "SQL Server" -as"
::/C "logman stop -name "SQL Server" -as"