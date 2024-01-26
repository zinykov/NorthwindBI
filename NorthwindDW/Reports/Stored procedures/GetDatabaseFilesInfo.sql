CREATE PROCEDURE [Reports].[GetDatabaseFilesInfo]
AS BEGIN
	SELECT	  [DatabaseFileKey]
			, [GroupName]
			, [IsReadOnly]
			, [Name]
			, [FileName]
			, [BackupFileName]
	
	FROM [Maintenance].[DatabaseFiles]
END