--:setvar SSISEnvironmentName Release

DECLARE @reference_id AS INT = (
	SELECT [reference_id] FROM [catalog].[environment_references] WHERE [environment_name] = N'$(SSISEnvironmentName)'
);
PRINT @reference_id
GO