/*
/C SQLCmd -S SWIFT3 -d NorthwindDW -E -i "C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\SetFilegroupsReadOnly.sql" -v DatabaseName=NorthwindDW CutoffTime='0:00:00

"/C SQLCmd -S "+@[$Project::DWHServerName]+" -d "+@[$Project::DWHDatabaseName]+" -E -i \""+@[$Project::ExternalFilesPath]+"Scripts\\SetFilegroupsReadOnly.sql\" -v DatabaseName="+@[$Project::DWHDatabaseName]+" CutoffYear="+(DT_WSTR,4)YEAR(@[$Package::CutoffTime])
*/

USE [master];
GO

ALTER DATABASE [$(DatabaseName)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
PRINT N'[$(DatabaseName)] setted in SINGLE_USER mode';
GO

USE [$(DatabaseName)];
GO

DECLARE @FilegroupName AS NVARCHAR(100)
DECLARE @ReadOnly AS BIT
DECLARE @SQL AS NVARCHAR(1000)
DECLARE @Print AS NVARCHAR(250)

DECLARE FactTables CURSOR FOR
	SELECT		[groupname]
	FROM		sys.sysfilegroups
	WHERE		[groupname] LIKE CONCAT ( N'%_', CAST ( N'$(CutoffYear)' AS INT ) - 2, N'_%' )

OPEN FactTables
	FETCH NEXT FROM FactTables INTO @FilegroupName
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @readonly = [is_read_only] FROM sys.filegroups WHERE [name] = @FilegroupName
			IF ( @readonly = 0 )
				BEGIN
					SET @SQL = CONCAT (
							N'ALTER DATABASE [$(DatabaseName)] MODIFY FILEGROUP '
						, QUOTENAME ( @FilegroupName )
						, N' READONLY'
					)
					EXECUTE sp_executesql @SQL

					UPDATE	[Maintenance].[DatabaseFiles]
					SET		[IsReadOnly] = 1
					WHERE	[GroupName] = @FilegroupName

					SET @Print = CONCAT ( @FilegroupName, N' setted as Read_only filegroup' )

					PRINT @Print
				END
			FETCH NEXT FROM FactTables INTO @FilegroupName
		END
CLOSE FactTables
DEALLOCATE FactTables;
GO

USE [master];
GO

ALTER DATABASE [$(DatabaseName)] SET MULTI_USER
PRINT N'[$(DatabaseName)] setted in MULTI_USER mode';
GO