DECLARE @SQLStatment AS NVARCHAR(MAX)

SET @SQLStatment = CONCAT (
							  N'ALTER DATABASE '
							, QUOTENAME ( ? )
							, N' SET SINGLE_USER WITH ROLLBACK IMMEDIATE'
						)

EXECUTE sp_executesql @SQLStatment;