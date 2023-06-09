﻿--:setvar DWHDatabaseName NorthwindDW

USE [master];
GO

ALTER DATABASE [$(DWHDatabaseName)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
PRINT N'$(DWHDatabaseName) setted in SINGLE_USER mode';
GO

IF EXISTS ( SELECT 1 FROM [sys].[databases] WHERE [name] = N'$(DWHDatabaseName)' )
	BEGIN
		DROP DATABASE [$(DWHDatabaseName)]
		PRINT N'$(DWHDatabaseName) dropped'
	END;
GO