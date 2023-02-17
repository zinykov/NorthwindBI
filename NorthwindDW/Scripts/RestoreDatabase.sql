--:setvar DWHDatabaseName NorthwindDW

USE [Logs];
GO

DECLARE @IsReadOnly AS BIT;
DECLARE @BackupFileName AS NVARCHAR(500);
DECLARE @SQL AS NVARCHAR(1000);
DECLARE @GroupName AS NVARCHAR(100);

DECLARE RestoreDWH CURSOR FOR 
	SELECT		  DISTINCT [IsReadOnly], [BackupFileName]
	FROM		[dbo].[DatabaseFiles]
	ORDER BY	  [IsReadOnly] ASC
				, [BackupFileName] ASC

OPEN RestoreDWH
	FETCH NEXT FROM RestoreDWH INTO @IsReadOnly, @BackupFileName
	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF ( @IsReadOnly = 0 )
				BEGIN
					IF ( @BackupFileName LIKE '%_FULL.bak' )
						BEGIN
							SET @SQL = CONCAT (
								  N'USE [master]; RESTORE DATABASE [$(DWHDatabaseName)] READ_WRITE_FILEGROUPS FROM DISK = '''
								, @BackupFileName
								, N''' WITH PARTIAL, NORECOVERY;'
							)

							EXECUTE sp_executesql @SQL
						END
					ELSE IF ( @BackupFileName LIKE '%_DIFF.bak' )
						BEGIN
							SET @SQL = CONCAT (
								  N'USE [master]; RESTORE DATABASE [$(DWHDatabaseName)] READ_WRITE_FILEGROUPS FROM DISK = '''
								, @BackupFileName
								, N''' WITH NORECOVERY;'
							)

							EXECUTE sp_executesql @SQL
						END
						
						SET @SQL = N'USE [master]; RESTORE DATABASE [$(DWHDatabaseName)] WITH RECOVERY;'
						
						EXECUTE sp_executesql @SQL
				END
			ELSE IF ( @IsReadOnly = 1 )
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
				END
			FETCH NEXT FROM RestoreDWH INTO @IsReadOnly, @BackupFileName
		END
CLOSE RestoreDWH
DEALLOCATE RestoreDWH