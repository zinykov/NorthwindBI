USE [NorthwindDW];

DECLARE @CutoffTime date = ( SELECT MAX ( [CutoffTime] ) FROM [Integration].[Lineage] );
DECLARE @IsMonthlyOptimization bit = 0;
DECLARE @IsStartOptimization bit;
DECLARE @IsSetFilegroupReadonly bit;
DECLARE @LoadDateInitialEnd date = DATEFROMPARTS ( 1997, 12, 31 );

EXECUTE [Maintenance].[CheckReferenceDate] 
   @CutoffTime
  ,@IsMonthlyOptimization
  ,@IsStartOptimization OUTPUT
  ,@IsSetFilegroupReadonly OUTPUT
  ,@LoadDateInitialEnd;

IF @IsSetFilegroupReadonly = 1
BEGIN
	USE [master];
	--GO
	ALTER DATABASE [NorthwindDW] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

	USE [NorthwindDW];
	--GO
	DECLARE @Year AS SMALLINT = CAST ( ( SELECT MAX ( YEAR ( [CutoffTime] ) ) FROM [Integration].[Lineage] ) - 2 AS NVARCHAR(4) );
	DECLARE @FilegroupName AS NVARCHAR(100);
	DECLARE @ReadOnly AS BIT;
	DECLARE @SQL AS NVARCHAR(1000);
	DECLARE @Print AS NVARCHAR(250);

	DECLARE FactTables CURSOR FOR
		SELECT		[groupname]
		FROM		sys.sysfilegroups
		WHERE		[groupname] LIKE CONCAT ( N'%_', @Year, N'_%' );

	OPEN FactTables
		FETCH NEXT FROM FactTables INTO @FilegroupName
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @readonly = [is_read_only] FROM sys.filegroups WHERE [name] = @FilegroupName
				IF ( @readonly = 0 )
					BEGIN
						SET @SQL = CONCAT (
								N'ALTER DATABASE [NorthwindDW] MODIFY FILEGROUP '
							, QUOTENAME ( @FilegroupName )
							, N' READONLY;'
						)
						EXECUTE sp_executesql @SQL

						UPDATE	[Maintenance].[DatabaseFiles]
						SET		[IsReadOnly] = 1
						WHERE	[GroupName] = @FilegroupName

						SET @Print = CONCAT ( @FilegroupName, N' setted as Read_only filegroup' )

						PRINT @Print
					END
				FETCH NEXT FROM FactTables INTO @FilegroupName
			END
	CLOSE FactTables
	DEALLOCATE FactTables;
	--GO

	USE [master];
	--GO
	ALTER DATABASE [NorthwindDW] SET MULTI_USER;
	--GO
END;

USE [NorthwindDW]

DECLARE @RetrainWeeks tinyint = 3;
DECLARE @BackupFolderName nvarchar(10);
DECLARE @BackupOldFolderName nvarchar(10);

EXECUTE [Maintenance].[GetBackupFolderNames] 
   @CutoffTime
  ,@RetrainWeeks
  ,@BackupFolderName OUTPUT
  ,@BackupOldFolderName OUTPUT;

DECLARE @BackupsReadOnlyPath nvarchar(1000) = N'C:\Users\ZinukovD\source\repos\Northwind_BI_Solution\Backup\NorthwindDW\ReadOnly\';
DECLARE @BackupsReadWritePath nvarchar(1000) = CONCAT ( N'C:\Users\ZinukovD\source\repos\Northwind_BI_Solution\Backup\NorthwindDW\', @BackupFolderName, N'\' );

EXECUTE [Maintenance].[BackupDatabase] 
   @CutoffTime
  ,@BackupsReadOnlyPath
  ,@BackupsReadWritePath
  ,@LoadDateInitialEnd;