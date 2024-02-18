--:setvar DatabaseName "NorthwindDW"
--:setvar Cutofftime '01.01.1998'

/*
	"-S "++" -E -i \""++"Scripts\SetFilegroupsReadOnly.sql" -v DatabaseName="++" CutoffTime='"++"' IsStartOptimization="++" && timeout /t 5"
*/

USE [master];
GO

DECLARE @DatabaseName AS SYSNAME = ?;
DECLARE @stmt AS NVARCHAR(MAX)

SET @stmt = CONCAT (
				  N'ALTER DATABASE '
				, QUOTENAME ( @DatabaseName )
				, N' SET SINGLE_USER WITH ROLLBACK IMMEDIATE; USE '
				, QUOTENAME ( @DatabaseName )
				, N';'
			)

EXECUTE sp_executesql @stmt;
GO

DECLARE @FilegroupName AS NVARCHAR(100)
DECLARE @ReadOnly AS BIT
DECLARE @Print AS NVARCHAR(250)
DECLARE @DatabaseName AS SYSNAME = ?;
DECLARE @CutoffTime AS DATE = ?;
DECLARE @stmt AS NVARCHAR(MAX)

DECLARE FactTables CURSOR FOR
	SELECT		[groupname]
	FROM		sys.sysfilegroups
	WHERE		[groupname] LIKE CONCAT ( N'%_', YEAR ( @CutoffTime ) - 2, N'_%' )

OPEN FactTables
	FETCH NEXT FROM FactTables INTO @FilegroupName
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @readonly = [is_read_only] FROM sys.filegroups WHERE [name] = @FilegroupName
			IF ( @readonly = 0 )
				BEGIN
					SET @stmt = CONCAT (
									  N'ALTER DATABASE '
									, QUOTENAME ( @DatabaseName )
									, N' MODIFY FILEGROUP '
									, QUOTENAME ( @FilegroupName )
									, N' READONLY'
								)
					EXECUTE sp_executesql @stmt

					UPDATE	[Maintenance].[DatabaseFiles]
					SET		[IsReadOnly] = 1
					WHERE	[GroupName] = @FilegroupName
				END
			FETCH NEXT FROM FactTables INTO @FilegroupName
		END
CLOSE FactTables
DEALLOCATE FactTables;
GO

USE [master];
GO

DECLARE @DatabaseName AS SYSNAME = ?;
DECLARE @stmt AS NVARCHAR(MAX)

SET @stmt = CONCAT (
				  N'ALTER DATABASE '
				, QUOTENAME ( @DatabaseName )
				, N' SET MULTI_USER;'
			)

EXECUTE sp_executesql @stmt;
GO