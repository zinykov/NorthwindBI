DECLARE @SQLStatment AS NVARCHAR(MAX);
DECLARE @DatabaseName AS SYSNAME = ?;

SELECT @SQLStatment = CONCAT (
								  @SQLStatment
								, N'KILL '
								, CONVERT ( NVARCHAR(5), [session_id] )
								, ';'
							)
FROM sys.dm_exec_sessions
WHERE [database_id]  = db_id( @DatabaseName )

SET @SQLStatment = CONCAT (
							  @SQLStatment
							, N'ALTER DATABASE '
							, QUOTENAME ( @DatabaseName )
							, N' SET MULTI_USER;'
						)

EXECUTE sp_executesql @SQLStatment;