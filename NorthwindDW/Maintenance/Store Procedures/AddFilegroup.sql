CREATE PROCEDURE [Maintenance].[AddFilegroup]
	  @CutoffTime AS DATE
	, @FactTableName AS NVARCHAR(100)
	, @FilePath AS VARCHAR(500)
AS BEGIN
	DECLARE @FileGroupDataName AS NVARCHAR(200)
	DECLARE @FileGroupIndexName AS NVARCHAR(200)
	DECLARE @CheckFilegroupName AS NVARCHAR(500)
	DECLARE @FileDataName AS VARCHAR(500)
	DECLARE @FileDataPath AS VARCHAR(500)
	DECLARE @FileIndexName AS VARCHAR(500)
	DECLARE @FileIndexPath AS VARCHAR(500)
	DECLARE @CutoffTimeYear AS INT
	DECLARE @SQL AS NVARCHAR(2000)

	SET @CutoffTimeYear = YEAR ( DATEADD ( DAY, 1, @CutoffTime ) )
	
	SET @FileGroupDataName = CONCAT ( @FactTableName, N'_', @CutoffTimeYear, '_Data' )
	SET @FileDataName = CONCAT ( @FileGroupDataName, N'_', LEFT ( CONVERT ( NVARCHAR(36), NEWID () ), 8 ) )
	SET @FileDataPath = CONCAT ( @FilePath, '$(DatabaseName)', '_', @FileDataName, '.ndf' )

	SET @FileGroupIndexName = CONCAT ( @FactTableName, N'_', @CutoffTimeYear, '_Index' )
	SET @FileIndexName = CONCAT ( @FileGroupIndexName, N'_', LEFT ( CONVERT ( NVARCHAR(36), NEWID () ), 8 ) )
	SET @FileIndexPath = CONCAT ( @FilePath, '$(DatabaseName)', '_', @FileIndexName, '.ndf' )
	
	SET @CheckFilegroupName = CONCAT ( N'%', @FileGroupDataName, N'%' )
	
	IF NOT EXISTS ( SELECT 1 FROM [sys].[filegroups] WHERE [name] LIKE @CheckFilegroupName )
		BEGIN
			SET @SQL = CONCAT (
			  N'ALTER DATABASE [$(DatabaseName)] ADD FILEGROUP ['
			, @FileGroupDataName
			, N']'
			)

			EXECUTE sp_executesql @SQL

			SET @SQL = CONCAT (
				  N'ALTER DATABASE [$(DatabaseName)] ADD FILE ( NAME = ['
				, @FileDataName
				, N'], FILENAME = '''
				, @FileDataPath
				, ''' ) TO FILEGROUP ['
				, @FileGroupDataName
				, ']'
			)

			EXECUTE sp_executesql @SQL

			SET @SQL = CONCAT (
			  N'ALTER DATABASE [$(DatabaseName)] ADD FILEGROUP ['
			, @FileGroupIndexName
			, N']'
			)

			EXECUTE sp_executesql @SQL

			SET @SQL = CONCAT (
				  N'ALTER DATABASE [$(DatabaseName)] ADD FILE ( NAME = ['
				, @FileIndexName
				, N'], FILENAME = '''
				, @FileIndexPath
				, ''' ) TO FILEGROUP ['
				, @FileGroupIndexName
				, ']'
			)

			EXECUTE sp_executesql @SQL
		END
END