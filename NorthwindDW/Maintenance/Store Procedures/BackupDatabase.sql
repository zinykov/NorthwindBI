CREATE PROCEDURE [Maintenance].[BackupDatabase]
	  @CutoffTime AS DATE
	, @BackupsReadOnlyPath AS NVARCHAR(1000)
	, @BackupsReadWritePath AS NVARCHAR(1000)
	, @LoadDateInitialEnd AS DATE
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
			DECLARE @GroupName					AS NVARCHAR(100);
			DECLARE @BackupFileName				AS NVARCHAR(500);
			DECLARE @BackupName					AS NVARCHAR(100);

			DECLARE [BackupReadOnlyFilegroups] CURSOR FOR
				SELECT		DISTINCT [GroupName]
				FROM		[Maintenance].[DatabaseFiles] 
				WHERE		[IsReadOnly] = 1
							AND [BackupFileName] NOT LIKE N'%_backup_read_only_filegroup_%'

			OPEN [BackupReadOnlyFilegroups]
				FETCH NEXT FROM [BackupReadOnlyFilegroups] INTO @GroupName
				WHILE @@FETCH_STATUS = 0
					BEGIN
						SET @BackupFileName = CONCAT (
							  @BackupsReadOnlyPath
							, N'\$(DatabaseName)_backup_read_only_filegroup_'
							, @GroupName
							, N'.bak'
						)

						UPDATE	[Maintenance].[DatabaseFiles]
						SET		[BackupFileName] = @BackupFileName
						WHERE	[GroupName] = @GroupName
			
						BACKUP DATABASE [$(DatabaseName)]
							FILEGROUP = @GroupName
							TO DISK = @BackupFileName
							WITH
								  NAME = @BackupName
								, COMPRESSION

						FETCH NEXT FROM [BackupReadOnlyFilegroups] INTO @GroupName
					END
			CLOSE [BackupReadOnlyFilegroups]
			DEALLOCATE [BackupReadOnlyFilegroups]

			IF ( ( SELECT [DayOfWeekNumber] FROM [Dimension].[Date] WHERE [DateKey] = @CutoffTime ) = 6
				OR @CutoffTime = @LoadDateInitialEnd )
				BEGIN
					SET @BackupFileName = CONCAT (
						  @BackupsReadWritePath
						, N'\$(DatabaseName)_backup_read_write_filegroups_'
						, FORMAT ( @CutoffTime, 'yyyyMMdd' )
						, N'_FULL.bak'
					)

					UPDATE	[Maintenance].[DatabaseFiles]
					SET		[BackupFileName] = @BackupFileName
					WHERE	[IsReadOnly] = 0
			
					BACKUP DATABASE [$(DatabaseName)]
						READ_WRITE_FILEGROUPS
						TO DISK = @BackupFileName
						WITH
							  NAME = @BackupName
							, COMPRESSION
				END
			ELSE
				BEGIN
					SET @BackupFileName = CONCAT (
						  @BackupsReadWritePath
						, N'\$(DatabaseName)_backup_read_write_filegroups_'
						, FORMAT ( @CutoffTime, 'yyyyMMdd' )
						, N'_DIFF.bak'
					)
			
					UPDATE	[Maintenance].[DatabaseFiles]
					SET		[BackupFileName] = @BackupFileName
					WHERE	[IsReadOnly] = 0
							AND [GroupName] <> 'PRIMARY'
			
					BACKUP DATABASE [$(DatabaseName)]
						READ_WRITE_FILEGROUPS
						TO DISK = @BackupFileName
						WITH
							  DIFFERENTIAL
							, NAME = @BackupName
							, COMPRESSION
				END;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END