::RunAs /user:UserBI "\"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe\" http://swift3/reports/browse/Monitoring"
::RunAs /user:UserBI "C:\Program Files (x86)\Microsoft SQL Server Management Studio 19\Common7\IDE\Ssms.exe"

RunAs /noprofile /user:AzPipelineAgent "C:\Users\zinyk\source\repos\Northwind_BI_Solution\cmd\logman.bat"