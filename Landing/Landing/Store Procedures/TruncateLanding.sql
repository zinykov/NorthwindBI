CREATE PROCEDURE [Landing].[TruncateLanding] AS
BEGIN
	SET NOCOUNT ON;

	TRUNCATE TABLE [Landing].[Categories];
	TRUNCATE TABLE [Landing].[Customers];
	TRUNCATE TABLE [Landing].[Employees];
	TRUNCATE TABLE [Landing].[Order Details];
	TRUNCATE TABLE [Landing].[Orders];
	TRUNCATE TABLE [Landing].[Products];
	TRUNCATE TABLE [Landing].[Holidays];

	SET NOCOUNT OFF;
END;
GO