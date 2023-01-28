--:setvar DatabaseName "NorthwindDW"
--:setvar Cutofftime '01.01.1998'
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
	DECLARE @FactTableName AS NVARCHAR(100)
	DECLARE @FilegroupName AS NVARCHAR(100)
	DECLARE @ReadOnly AS BIT
	DECLARE @SQL AS NVARCHAR(1000)

	DECLARE FactTables CURSOR FOR
		SELECT		T.[name]
		FROM		sys.tables AS T
		INNER JOIN	sys.schemas AS S ON S.[schema_id] = T.[schema_id]
					AND S.[name] = N'Fact'

	OPEN FactTables
		FETCH NEXT FROM FactTables INTO @FactTableName
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @FilegroupName = CONCAT (
					  @FactTableName
					, N'_'
					, YEAR ( $(Cutofftime) ) - 2
					, N'_Data'
				)

				SELECT @readonly = [is_read_only] FROM sys.filegroups WHERE [name] = @FilegroupName
				IF ( @readonly = 0 )
					BEGIN
						SET @SQL = CONCAT (
							  N'ALTER DATABASE [$(DatabaseName)] MODIFY FILEGROUP ['
							, @FilegroupName
							, N'] READONLY'
						)
						EXECUTE sp_executesql @SQL
					END

				SET @FilegroupName = CONCAT (
					  @FactTableName
					, N'_'
					, YEAR ( $(Cutofftime) ) - 2
					, N'_Data'
				)

				SELECT @readonly = [is_read_only] FROM sys.filegroups WHERE [name] = @FilegroupName
				IF ( @readonly = 0 )
					BEGIN
						SET @SQL = CONCAT (
							  N'ALTER DATABASE [$(DatabaseName)] MODIFY FILEGROUP ['
							, @FilegroupName
							, N'] READONLY'
						)
						EXECUTE sp_executesql @SQL
					END

				FETCH NEXT FROM FactTables INTO @FactTableName
			END
	CLOSE FactTables
	DEALLOCATE FactTables
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