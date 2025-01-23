--:r C:\Users\ZinukovD\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

DECLARE @reference_id AS INT = (
	SELECT [reference_id] FROM [catalog].[environment_references] WHERE [environment_name] = N'$(BuildConfiguration)'
);
PRINT @reference_id
GO