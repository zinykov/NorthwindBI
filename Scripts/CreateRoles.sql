--:r C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

USE [$(MDSDatabaseName)]
GO

IF NOT EXISTS (
				SELECT      1
				FROM        [sys].[database_role_members] AS DBRM
				INNER JOIN  [sys].[database_principals] AS R
							ON DBRM.[role_principal_id] = R.[principal_id]
				WHERE       R.[name] = 'RDLexec'
)
	BEGIN
		CREATE ROLE [RDLexec] AUTHORIZATION [dbo]
	END
GO

GRANT SELECT ON [mdm].[MasterCustomer] TO [RDLexec]
GO

GRANT SELECT ON [mdm].[MasterEmployee] TO [RDLexec]
GO

GRANT SELECT ON [mdm].[MasterHolidays] TO [RDLexec]
GO

GRANT SELECT ON [mdm].[MasterProduct] TO [RDLexec]
GO

GRANT SELECT ON SCHEMA::[stg] TO [RDLexec]
GO