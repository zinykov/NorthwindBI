CREATE PROCEDURE [Maintenance].[InsertDatabaseFilesData]
	  @CutoffTime AS DATE
	, @FactTableName AS NVARCHAR(100)
	, @FilePath AS VARCHAR(500)
	, @IsClustered AS BIT

AS BEGIN
	DECLARE @GroupName AS NVARCHAR(100)
	DECLARE @Name AS NVARCHAR(100)
	DECLARE @FileName AS NVARCHAR(500)
	DECLARE @Year AS INT

	SET @Year = YEAR ( DATEADD ( DAY, 1, @CutoffTime ) )
	
	IF ( @IsClustered = 1 )
		SET @GroupName = CONCAT ( @FactTableName, N'_', @Year, '_Data' )
	ELSE
		SET @GroupName = CONCAT ( @FactTableName, N'_', @Year, '_Index' )

	SET @Name = CONCAT ( @GroupName, N'_', LEFT ( CONVERT ( NVARCHAR(36), NEWID () ), 8 ) )
	SET @FileName = CONCAT ( @FilePath, '$(DatabaseName)', '_', @Name, '.ndf' )

	DROP TABLE IF EXISTS #file_exist
	
	CREATE TABLE #file_exist (
		  File_Exists				INT
		, File_is_a_Directory		INT
		, Parent_Directory_Exists	INT
	)

	INSERT INTO #file_exist
	EXEC [master].[dbo].xp_fileexist @FileName

	IF EXISTS ( SELECT 1 FROM #file_exist WHERE [Parent_Directory_Exists] = 1 )
		BEGIN
			INSERT INTO [Maintenance].[DatabaseFiles] ( [GroupName], [IsReadOnly], [Name], [FileName], [CutoffTime] )
			VALUES ( @GroupName, 0, @Name, @FileName, @CutoffTime )
		END
	ELSE
		BEGIN
			RAISERROR ( 50001, 16, 1, @FileName )
		END

	DROP TABLE IF EXISTS #file_exist
END