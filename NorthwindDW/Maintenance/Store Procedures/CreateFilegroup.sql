CREATE PROCEDURE [Maintenance].[CreateFilegroup]
	  @CutoffTime AS DATE
	, @FactTableName AS NVARCHAR(100)
	, @FilePath AS NVARCHAR(500)
AS BEGIN
    --BEGIN TRY
    --    BEGIN TRANSACTION
			DECLARE @GroupName AS NVARCHAR(100)
			DECLARE @Name AS NVARCHAR(100)
			DECLARE @FileName AS NVARCHAR(500)
			DECLARE	@SQL AS NVARCHAR(2000)

			EXECUTE [Maintenance].[GetOrInsertDatabaseFilesData]
				  @CutoffTime = @CutoffTime
				, @FactTableName = @FactTableName
				, @FilePath = @FilePath
	
			SET @CutoffTime = DATEADD ( DAY, 1, @CutoffTime )
	
			DECLARE CreateFilegroupsInDatabase CURSOR FOR
				SELECT		DBF.[GroupName], DBF.[Name], DBF.[FileName]
				FROM		[Maintenance].[DatabaseFiles] AS DBF
				LEFT JOIN	sys.sysfilegroups AS SFG ON DBF.[GroupName] = SFG.[groupname]
				WHERE		SFG.[groupid] IS NULL
							AND DBF.[GroupName] LIKE CONCAT ( @FactTableName, N'_', YEAR ( @CutoffTime ), N'_%' )


			OPEN CreateFilegroupsInDatabase
				FETCH NEXT FROM CreateFilegroupsInDatabase INTO @GroupName, @Name, @FileName
				WHILE @@FETCH_STATUS = 0
					BEGIN
						IF NOT EXISTS ( SELECT 1 FROM sys.sysfilegroups WHERE [groupname] = @GroupName )
							BEGIN
								SET @SQL = CONCAT (
									  N'ALTER DATABASE [$(DatabaseName)] ADD FILEGROUP ['
									, @GroupName
									, N']'
								)
								EXECUTE sp_executesql @SQL
							END
						IF NOT EXISTS ( SELECT 1 FROM sys.sysfiles WHERE [name] = @Name )
							BEGIN
								SET @SQL = CONCAT (
									  N'ALTER DATABASE [$(DatabaseName)] ADD FILE ( NAME = ['
									, @Name
									, N'], FILENAME = '''
									, @FileName
									, N''' ) TO FILEGROUP ['
									, @GroupName
									, N']'
								)
								EXECUTE sp_executesql @SQL
							END
						FETCH NEXT FROM CreateFilegroupsInDatabase INTO @GroupName, @Name, @FileName
					END
			CLOSE CreateFilegroupsInDatabase
    
			DEALLOCATE CreateFilegroupsInDatabase;
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END