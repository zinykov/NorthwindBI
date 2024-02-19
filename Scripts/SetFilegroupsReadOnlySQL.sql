DECLARE @SQLStatment AS NVARCHAR(MAX);
DECLARE @DatabaseName AS SYSNAME = ?;

SELECT @SQLStatment = CONCAT (
								  @SQLStatment
								, N'KILL '
								, CONVERT ( NVARCHAR(5), [session_id] )
								, ';'
							)
FROM sys.dm_exec_sessions
WHERE [database_id]  = db_id( @DatabaseName );

EXECUTE sp_executesql @SQLStatment;

SET @SQLStatment = CONCAT (
					  N'USE '
					, QUOTENAME ( ? )
					, N';'
					)

EXECUTE sp_executesql @SQLStatment;

DECLARE @FilegroupName AS NVARCHAR(100)
DECLARE @ReadOnly AS BIT
DECLARE @SQL AS NVARCHAR(1000)
DECLARE @Print AS NVARCHAR(250)

DECLARE FactTables CURSOR FOR
	SELECT		[groupname]
	FROM		sys.sysfilegroups
	WHERE		[groupname] LIKE CONCAT ( N'%_', ?, N'_%' )

OPEN FactTables
	FETCH NEXT FROM FactTables INTO @FilegroupName
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @readonly = [is_read_only] FROM sys.filegroups WHERE [name] = @FilegroupName
			IF ( @readonly = 0 )
				BEGIN
					SET @SQL = CONCAT (
							N'ALTER DATABASE '
						, QUOTENAME ( ? )
						,N' MODIFY FILEGROUP '
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