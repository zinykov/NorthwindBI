USE [NorthwindLogs];

TRUNCATE TABLE [dbo].[DatabaseFiles];

TRUNCATE TABLE [dbo].[Lineage];

INSERT INTO [dbo].[DatabaseFiles] SELECT * FROM [NorthwindDW].[Maintenance].[DatabaseFiles];

INSERT INTO [dbo].[Lineage] SELECT * FROM [NorthwindDW].[Integration].[Lineage];