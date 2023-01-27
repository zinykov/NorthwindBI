--:setvar DatabaseName "NorthwindDW"
--:setvar Cutofftime '01.01.1998'
--:setvar FactTableName "Order"
--:setvar IsYearOptimisationWorked "true"

USE [master];
GO

IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	ALTER DATABASE [$(DatabaseName)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	PRINT N'[$(DatabaseName)] setted in SINGLE_USER mode'
END;
GO

USE [$(DatabaseName)];
GO

IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	DECLARE @FilegroupName AS NVARCHAR(100) = CONCAT (
		  N'$(FactTableName)_'
		, YEAR ( $(Cutofftime) ) - 2
		, N'_Data'
	)
	DECLARE @ReadOnly AS BIT
	DECLARE @SQL AS NVARCHAR(1000) = CONCAT (
		  N'ALTER DATABASE [$(DatabaseName)] MODIFY FILEGROUP ['
		, @FilegroupName
		, N'] READONLY'
	)

	SELECT @readonly = CONVERT ( BIT, ( STATUS & 0x08 ) ) FROM sysfilegroups WHERE groupname = @FilegroupName
	IF ( @readonly = 0 )
		BEGIN
			EXECUTE sp_executesql @SQL
		END

	SET @FilegroupName = CONCAT (
		  N'$(FactTableName)_'
		, YEAR ( $(Cutofftime) ) - 2
		, N'_Index'
	)
	SET @SQL = CONCAT (
		  N'ALTER DATABASE [$(DatabaseName)] MODIFY FILEGROUP ['
		, @FilegroupName
		, N'] READONLY'
	)

	SELECT @readonly = CONVERT ( BIT, ( STATUS & 0x08 ) ) FROM sysfilegroups WHERE groupname = @FilegroupName
	IF ( @readonly = 0 )
		BEGIN
			EXECUTE sp_executesql @SQL
		END
END;
GO

USE [master];
GO

IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	ALTER DATABASE [$(DatabaseName)] SET MULTI_USER
	PRINT N'[$(DatabaseName)] setted in MULTI_USER mode'
END;
GO