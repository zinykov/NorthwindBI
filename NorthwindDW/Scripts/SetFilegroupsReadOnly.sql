--:setvar DatabaseName "NorthwindDW"
--:setvar Cutofftime '1998-01-01'
--:setvar FactTableName "Order"
--:setvar IsYearOptimisationWorked "false"

USE [$(DatabaseName)];
GO

IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	ALTER DATABASE [$(DatabaseName)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
END;
GO
IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	DECLARE @FilegroupName AS NVARCHAR(100) = CONCAT (
		  N'$(FactTableName)_'
		, CONVERT ( INT, LEFT ( $(Cutofftime), 4 ) - 2 )
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
			EXECUTE sp_executesql @SQL;
			PRINT CONCAT ( N'@readonly = ', @readonly, N' @SQL = ', @SQL )
		END
END;
GO

IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	DECLARE @FilegroupName AS NVARCHAR(100) = CONCAT (
		  N'$(FactTableName)_'
		, CONVERT ( INT, LEFT ( $(Cutofftime), 4 ) - 2 )
		, N'_Index'
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
			EXECUTE sp_executesql @SQL;
			PRINT CONCAT ( N'@readonly = ', @readonly, N' @SQL = ', @SQL )
		END
END;
GO

USE [master];
GO

IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	DECLARE @FilegroupName AS NVARCHAR(100) = CONCAT (
		  N'$(FactTableName)_'
		, CONVERT ( INT, LEFT ( $(Cutofftime), 4 ) - 2 )
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
			EXECUTE sp_executesql @SQL;
			PRINT CONCAT ( N'@readonly = ', @readonly, N' @SQL = ', @SQL )
		END
END;
GO

IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	DECLARE @FilegroupName AS NVARCHAR(100) = CONCAT (
		  N'$(FactTableName)_'
		, CONVERT ( INT, LEFT ( $(Cutofftime), 4 ) - 2 )
		, N'_Index'
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
			EXECUTE sp_executesql @SQL;
			PRINT CONCAT ( N'@readonly = ', @readonly, N' @SQL = ', @SQL )
		END
END;
GO

IF ( CONVERT ( BIT , N'$(IsYearOptimisationWorked)' ) = 1 )
BEGIN
	ALTER DATABASE [$(DatabaseName)] SET MULTI_USER WITH ROLLBACK IMMEDIATE
END;
GO