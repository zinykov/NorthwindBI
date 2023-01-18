--:setvar SSISEnvironmentName SWIFT3

SELECT [environment_id] FROM [catalog].[environments] WHERE [name] = N'$(SSISEnvironmentName)';
GO