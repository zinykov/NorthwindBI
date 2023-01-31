CREATE PROCEDURE [Maintenance].[GetOrInsertDatabaseFilesData]
	  @CutoffTime AS DATE
	, @FactTableName AS NVARCHAR(100)
	, @FilePath AS VARCHAR(500)

AS BEGIN
	DECLARE @GroupName AS NVARCHAR(100)
	DECLARE @Year AS INT
	DECLARE @Name AS NVARCHAR(100)
	DECLARE @FileName AS NVARCHAR(500)

	SET @Year = YEAR ( DATEADD ( DAY, 1, @CutoffTime ) )
	SET @GroupName = CONCAT ( @FactTableName, N'_', @Year )

	IF NOT EXISTS (
		SELECT		1
		FROM		[Maintenance].[DatabaseFiles] AS DBF
		INNER JOIN	sys.sysfilegroups AS FG ON FG.[groupname] = DBF.[GroupName]
		WHERE		DBF.[GroupName] = CONCAT ( @GroupName, N'_Data' )
	)
		EXECUTE [Maintenance].[InsertDatabaseFilesData]
				@Year = @Year
			, @FactTableName = @FactTableName
			, @FilePath = @FilePath
			, @IsClustered = 1
	
	IF NOT EXISTS (
		SELECT		1
		FROM		[Maintenance].[DatabaseFiles] AS DBF
		INNER JOIN	sys.sysfilegroups AS FG ON FG.[groupname] = DBF.[GroupName]
		WHERE		DBF.[GroupName] = CONCAT ( @GroupName, N'_Data' )
	)		
		EXECUTE [Maintenance].[InsertDatabaseFilesData]
				@Year = @Year
			, @FactTableName = @FactTableName
			, @FilePath = @FilePath
			, @IsClustered = 0

END