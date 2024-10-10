CREATE PROCEDURE [Integration].[DropLoadTableHoliday]
AS BEGIN
	DROP TABLE IF EXISTS [Integration].[Holiday];
END