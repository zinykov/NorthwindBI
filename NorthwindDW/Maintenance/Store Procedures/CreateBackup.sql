CREATE PROCEDURE [Maintenance].[CreateBackup]
	  @CutoffTime AS DATE
	, @BackupsReadOnlyPath AS NVARCHAR(1000)
	, @BackupsReadWritePath AS NVARCHAR(1000)
AS BEGIN
	DECLARE @GroupName					AS NVARCHAR(100);
	DECLARE @BackupFileName				AS NVARCHAR(500);
	DECLARE @BackupName					AS NVARCHAR(100);

	DECLARE [BackupReadOnlyFilegroups] CURSOR FOR
		SELECT		DISTINCT [GroupName]
		FROM		[Maintenance].[DatabaseFiles] 
		WHERE		[IsReadOnly] = 1
					AND [BackupFileName] NOT LIKE N'%\$(DatabaseName)_backup_read_only_filegroup_%'

	OPEN [BackupReadOnlyFilegroups]
		FETCH NEXT FROM [BackupReadOnlyFilegroups] INTO @GroupName
		WHILE @@FETCH_STATUS > 0
		BEGIN
			SET @BackupFileName = CONCAT (
				  @BackupsReadOnlyPath
				, N'\$(DatabaseName)_backup_read_only_filegroup_'
				, @GroupName
				, N'.bak'
			)
			
			BACKUP DATABASE [$(DatabaseName)]
				FILEGROUP = @GroupName
				TO DISK = @BackupFileName
				WITH
					  NAME = @BackupName
					--, COMPRESSION

			UPDATE	[Maintenance].[DatabaseFiles]
			SET		[BackupFileName] = @BackupFileName
			WHERE	[GroupName] = @GroupName

			FETCH NEXT FROM [BackupReadOnlyFilegroups] INTO @GroupName
		END
	CLOSE [BackupReadOnlyFilegroups]
	DEALLOCATE [BackupReadOnlyFilegroups]

	IF ( ( SELECT [DayOfWeekNumber] FROM [Dimension].[Date] WHERE [AlterDateKey] = @CutoffTime ) = 6
		OR @CutoffTime = DATEFROMPARTS ( 1996, 12, 31 ) )
		BEGIN
			SET @BackupFileName = CONCAT (
				  @BackupsReadWritePath
				, N'\$(DatabaseName)_backup_read_write_filegroups_'
				, FORMAT ( @CutoffTime, 'yyyyMMdd' )
				, N'_FULL.bak'
			)
			
			BACKUP DATABASE [$(DatabaseName)]
				READ_WRITE_FILEGROUPS
				TO DISK = @BackupFileName
				WITH
					  NAME = @BackupName
					--, COMPRESSION

			UPDATE	[Maintenance].[DatabaseFiles]
			SET		[BackupFileName] = @BackupFileName
			WHERE	[IsReadOnly] = 0
		END
	ELSE
		BEGIN
			SET @BackupFileName = CONCAT (
				  @BackupsReadWritePath
				, N'\$(DatabaseName)_backup_read_write_filegroups_'
				, FORMAT ( @CutoffTime, 'yyyyMMdd' )
				, N'_DIFF.bak'
			)
			
			BACKUP DATABASE [$(DatabaseName)]
				READ_WRITE_FILEGROUPS
				TO DISK = @BackupFileName
				WITH
					  DIFFERENTIAL
					, NAME = @BackupName
					--, COMPRESSION
			
			UPDATE	[Maintenance].[DatabaseFiles]
			SET		[BackupFileName] = @BackupFileName
			WHERE	[IsReadOnly] = 0
		END
	RETURN 0;
END