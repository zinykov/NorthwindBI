CREATE PROCEDURE [Maintenance].[SetFilegroupReadOnly]
	  @CutoffTime AS DATE
	, @FactTableName AS NVARCHAR(100)
	, @IsYearOptimisationWorked AS NVARCHAR(5)
AS BEGIN
	IF ( CONVERT ( BIT , @IsYearOptimisationWorked ) = 1 )
	BEGIN
		DECLARE @FilegroupName AS NVARCHAR(100) = CONCAT (
			  @FactTableName
			, N'_'
			, YEAR ( @CutoffTime ) - 2
			, N'_Data'
		)
		DECLARE @ReadOnly AS BIT = (
			SELECT	CONVERT ( BIT, ( STATUS & 0x08 ) )
			FROM	sysfilegroups
			WHERE	groupname = @FilegroupName
		)
		DECLARE @SQL AS NVARCHAR(1000) = CONCAT (
			  N'ALTER DATABASE [NorthwindDW] MODIFY FILEGROUP ['
			, @FilegroupName
			, N'] READONLY'
		)
		
		IF ( @readonly = 0 )
			BEGIN
				EXECUTE sp_executesql @SQL
			END

		SET @FilegroupName = CONCAT (
			  @FactTableName
			, N'_'
			, YEAR ( @CutoffTime ) - 2
			, N'_Index'
		)
		SET @ReadOnly = (
			SELECT	CONVERT ( BIT, ( STATUS & 0x08 ) )
			FROM	sysfilegroups
			WHERE	groupname = @FilegroupName
		)
		SET @SQL = CONCAT (
			  N'ALTER DATABASE [NorthwindDW] MODIFY FILEGROUP ['
			, @FilegroupName
			, N'] READONLY'
		)

		IF ( @readonly = 0 )
			BEGIN
				EXECUTE sp_executesql @SQL
			END
	END
END