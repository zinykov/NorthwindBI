CREATE PROCEDURE [Maintenance].[GetOrInsertDatabaseFilesData]
	  @CutoffTime AS DATE
	, @FactTableName AS NVARCHAR(100)
	, @FilePath AS NVARCHAR(500)
AS BEGIN
	DECLARE @GroupName AS NVARCHAR(100)
	DECLARE @Year AS INT
	DECLARE @Name AS NVARCHAR(100)
	DECLARE @FileName AS NVARCHAR(500)

	SET @GroupName = CONCAT ( @FactTableName, N'_', YEAR ( DATEADD ( DAY, 1, @CutoffTime ) ) )

	IF NOT EXISTS (
		SELECT		1
		FROM		[Maintenance].[DatabaseFiles] AS DBF
		INNER JOIN	sys.sysfilegroups AS FG ON FG.[groupname] = DBF.[GroupName]
		WHERE		DBF.[GroupName] = CONCAT ( @GroupName, N'_Data' )
	) BEGIN
		EXECUTE [Maintenance].[InsertDatabaseFilesData]
			  @CutoffTime = @CutoffTime
			, @FactTableName = @FactTableName
			, @FilePath = @FilePath
			, @IsClustered = 1
	END

	IF NOT EXISTS (
		SELECT		*
		FROM		[Maintenance].[DatabaseFiles] AS DBF
		INNER JOIN	sys.sysfilegroups AS FG ON FG.[groupname] = DBF.[GroupName]
		WHERE		DBF.[GroupName] = CONCAT ( @GroupName, N'_Index' )
	) BEGIN
		EXECUTE [Maintenance].[InsertDatabaseFilesData]
			  @CutoffTime = @CutoffTime
			, @FactTableName = @FactTableName
			, @FilePath = @FilePath
			, @IsClustered = 0
	END;
END