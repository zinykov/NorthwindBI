--:setvar DatabaseName NorthwindDW
--:setvar Cutofftime '1998-01-01'
--:setvar FactTableName Order
	
--	DECLARE @ReferenceDate AS DATE = (
--        SELECT	[AlterDateKey]
--        FROM	[Dimension].[Date]
--        WHERE	[DayOfWeekNumber] = 6
--			    AND [DayOfMonth] BETWEEN 2 AND 8
--			    AND [MonthNumber] = 1
--                AND [Year] = YEAR ( $(Cutofftime) )
--    )

--    IF @CutoffTime <> @ReferenceDate OR @CutoffTime = DATEFROMPARTS ( 1997, 1, 4 ) ;

USE [$(DatabaseName)];
GO

ALTER DATABASE [$(DatabaseName)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

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
	END;
GO

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
	END;
GO

USE [master];
GO

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
	END;
GO

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
	END;
GO

ALTER DATABASE [$(DatabaseName)] SET MULTI_USER WITH ROLLBACK IMMEDIATE;
GO