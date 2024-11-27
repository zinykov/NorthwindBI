CREATE PROCEDURE [Reports].[GetDatabaseFilesInfo]
WITH EXECUTE AS OWNER
AS BEGIN
	SELECT	  [DatabaseFileKey]
			, [GroupName]
			, [IsReadOnly]
			, [Name]
			, [FileName]
			, [BackupFileName]
			, [CutoffTime]
	
	FROM [Maintenance].[DatabaseFiles]
END