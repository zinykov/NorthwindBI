﻿CREATE PROCEDURE [Integration].[TruncateLanding] AS
BEGIN
	SET NOCOUNT ON;

	TRUNCATE TABLE [Landing].[Categories];
	TRUNCATE TABLE [Landing].[Customers];
	TRUNCATE TABLE [Landing].[Employees];
	TRUNCATE TABLE [Landing].[Order Details];
	TRUNCATE TABLE [Landing].[Orders];
	TRUNCATE TABLE [Landing].[Products];

	SET NOCOUNT OFF;
END;
GO