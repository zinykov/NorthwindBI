:setvar DWHDatabaseName NorthwindDW

USE [Logs];
GO

DECLARE @IsReadOnly AS BIT;
DECLARE @BackupFileName AS NVARCHAR(500);
DECLARE @SQL AS NVARCHAR(1000);
DECLARE @GroupName AS NVARCHAR(100);

SET @BackupFileName = (
		SELECT		TOP(1) [BackupFileName]
		FROM		[dbo].[DatabaseFiles]
		WHERE		  [BackupFileName] LIKE '%_FULL.bak'
		ORDER BY	  [BackupFileName] DESC
)	
SET @SQL = CONCAT (
	  N'USE [master]; RESTORE DATABASE [$(DWHDatabaseName)] READ_WRITE_FILEGROUPS FROM DISK = '''
	, @BackupFileName
	, N''' WITH PARTIAL, NORECOVERY;'
)

EXECUTE sp_executesql @SQL
						
SET @BackupFileName = (
	SELECT		TOP(1) [BackupFileName]
	FROM		[dbo].[DatabaseFiles]
	WHERE		  [BackupFileName] LIKE '%_DIFF.bak' 
	ORDER BY	  [BackupFileName] DESC
)
SET @SQL = CONCAT (
	  N'USE [master]; RESTORE DATABASE [$(DWHDatabaseName)] READ_WRITE_FILEGROUPS FROM DISK = '''
	, @BackupFileName
	, N''' WITH NORECOVERY;'
)

EXECUTE sp_executesql @SQL
			
SET @SQL = N'USE [master]; RESTORE DATABASE [$(DWHDatabaseName)] WITH RECOVERY;'
EXECUTE sp_executesql @SQL

DECLARE RestoreDWH CURSOR FOR 
	SELECT		  [BackupFileName]
	FROM		[dbo].[DatabaseFiles]
	WHERE		  [IsReadOnly] = 1
	ORDER BY	  [BackupFileName] ASC

OPEN RestoreDWH
	FETCH NEXT FROM RestoreDWH INTO @BackupFileName
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @GroupName = (
				SELECT	[GroupName]
				FROM	[dbo].[DatabaseFiles]
				WHERE	[BackupFileName] = @BackupFileName
			)

			SET @SQL = CONCAT (
					N'USE [master]; RESTORE DATABASE [$(DWHDatabaseName)] FILEGROUP = '''
				, @GroupName
				, N''' FROM DISK = '''
				, @BackupFileName
				, N''' WITH RECOVERY;'
			)

			EXECUTE sp_executesql @SQL
			
			FETCH NEXT FROM RestoreDWH INTO @BackupFileName
		END
CLOSE RestoreDWH
DEALLOCATE RestoreDWH