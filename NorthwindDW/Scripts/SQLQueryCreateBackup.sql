:setvar DatabaseName NorthwindDW
--CREATE PROCEDURE [Maintenance].[CreateBackup]
	DECLARE @CutoffTime AS DATE = DATEFROMPARTS ( 1998, 01, 01 )
	DECLARE @BackupFilesPath AS NVARCHAR(500) = N'C:\Users\zinyk\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB'
--AS 
BEGIN
	DECLARE @IsStartOptimization	AS BIT;
	DECLARE @IsStartFullBackup		AS BIT;
	DECLARE @DatabaseFileKey		AS INT;
	DECLARE @GroupName				AS NVARCHAR(100);
	DECLARE @IsReadOnly				AS BIT;
	DECLARE @Name					AS NVARCHAR(100);
	DECLARE @FileName				AS NVARCHAR(500);
	DECLARE @BackupFileName			AS NVARCHAR(500);
	DECLARE @BackupName				AS NVARCHAR(100);
	DECLARE @SQL					AS NVARCHAR(2000);

	--Проверка даты запуска
    EXECUTE [Maintenance].[CheckReferenceDate]
        @CutoffTime = @CutoffTime
      , @IsMonthlyOptimization = 1
      , @IsStartOptimization = @IsStartOptimization OUTPUT
	  , @IsStartFullBackup = @IsStartFullBackup OUTPUT

	SET @BackupName = CONCAT (
		  N'$(DatabaseName)_backup_READ_WRITE_FILEGROUPS_'
		, DATENAME ( yyyy, @CutoffTime )
		, N'_'
		, CAST ( DATEPART ( mm, @CutoffTime ) AS NVARCHAR(2) )
		, N'_'
		, DATENAME ( dd, @CutoffTime )
		, N'.bak'
	)
	SET @BackupFilesPath = CONCAT ( @BackupFilesPath, N'\NorthwindDW' )
	SET @BackupFileName = CONCAT ( @BackupFilesPath, N'\', @BackupName )
	
	EXECUTE [master].[dbo].[xp_create_subdir] @BackupFilesPath );

	IF ( @IsStartFullBackup = 0 )
		BEGIN
			BACKUP DATABASE [$(DatabaseName)]
				READ_WRITE_FILEGROUPS
				TO DISK = @BackupFileName
				WITH
					  DIFFERENTIAL
					, NAME = @BackupFileName
					, COMPRESSION
					, RETAINDAYS = 14
			
			UPDATE	[Maintenance].[DatabaseFiles]
			SET		[BackupFileName] = @BackupFileName
			WHERE	[IsReadOnly] = 0
		END
	ELSE
		BEGIN
			BACKUP DATABASE [$(DatabaseName)]
				READ_WRITE_FILEGROUPS
				TO DISK = @BackupFileName
				WITH
					  NAME = @BackupFileName
					, COMPRESSION
					, RETAINDAYS = 14

			UPDATE	[Maintenance].[DatabaseFiles]
			SET		[BackupFileName] = @BackupFileName
			WHERE	[IsReadOnly] = 0
		END

	DECLARE [BackupReadOnlyFilegroups] CURSOR FOR
		SELECT		DISTINCT [GroupName]
		FROM		[Maintenance].[DatabaseFiles] 
		WHERE		[IsReadOnly] = 1
					AND [BackupFileName] IS NULL

	OPEN [BackupReadOnlyFilegroups]
		FETCH NEXT FROM [BackupReadOnlyFilegroups] INTO @GroupName
		WHILE @@FETCH_STATUS <> 0
		BEGIN
			SET @BackupName = CONCAT (
					N'$(DatabaseName)_backup_'
				, @GroupName
				, N'_'
				, DATENAME ( yyyy, @CutoffTime )
				, N'_'
				, CAST ( DATEPART ( mm, @CutoffTime ) AS NVARCHAR(2) )
				, N'_'
				, DATENAME ( dd, @CutoffTime )
				, N'.bak'
			)
			SET @BackupFileName = CONCAT ( @BackupFilesPath, N'\', @BackupName )

			BACKUP DATABASE [$(DatabaseName)]
				FILEGROUP = @GroupName
				TO DISK = @BackupFileName
				WITH
					  NAME = @BackupName
					, COMPRESSION

			UPDATE	[Maintenance].[DatabaseFiles]
			SET		[BackupFileName] = @BackupFileName
			WHERE	[GroupName] = @GroupName

			FETCH NEXT FROM [BackupReadOnlyFilegroups] INTO @GroupName
		END
	CLOSE [BackupReadOnlyFilegroups]
	DEALLOCATE [BackupReadOnlyFilegroups]
END