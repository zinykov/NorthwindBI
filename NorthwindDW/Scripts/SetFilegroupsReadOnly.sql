--:setvar DatabaseName "NorthwindDW"
--:setvar Cutofftime '01.01.1998'
--:setvar IsSetFilegroupReadonly "true"

USE [master];
GO

IF ( CONVERT ( BIT , N'$(IsSetFilegroupReadonly)' ) = 1 )
BEGIN
	ALTER DATABASE [$(DatabaseName)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	PRINT N'[$(DatabaseName)] setted in SINGLE_USER mode'
END;
GO

USE [$(DatabaseName)];
GO

IF ( CONVERT ( BIT , N'$(IsSetFilegroupReadonly)' ) = 1 )
BEGIN
	DECLARE @FilegroupName AS NVARCHAR(100)
	DECLARE @ReadOnly AS BIT
	DECLARE @SQL AS NVARCHAR(1000)

	DECLARE FactTables CURSOR FOR
		SELECT		[groupname]
		FROM		sys.sysfilegroups
		WHERE		[groupname] LIKE CONCAT ( N'%_', YEAR ( $(Cutofftime) ) - 2, N'_%' )

	OPEN FactTables
		FETCH NEXT FROM FactTables INTO @FilegroupName
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @readonly = [is_read_only] FROM sys.filegroups WHERE [name] = @FilegroupName
				IF ( @readonly = 0 )
					BEGIN
						SET @SQL = CONCAT (
							  N'ALTER DATABASE [$(DatabaseName)] MODIFY FILEGROUP ['
							, @FilegroupName
							, N'] READONLY'
						)
						EXECUTE sp_executesql @SQL

						UPDATE	[Maintenance].[DatabaseFiles]
						SET		[IsReadOnly] = 1
						WHERE	[GroupName] = @FilegroupName
					END
				FETCH NEXT FROM FactTables INTO @FilegroupName
			END
	CLOSE FactTables
	DEALLOCATE FactTables
END;
GO

USE [master];
GO

IF ( CONVERT ( BIT , N'$(IsSetFilegroupReadonly)' ) = 1 )
BEGIN
	ALTER DATABASE [$(DatabaseName)] SET MULTI_USER
	PRINT N'[$(DatabaseName)] setted in MULTI_USER mode'
END;
GO

IF ( CONVERT ( BIT , N'$(IsSetFilegroupReadonly)' ) = 1 )
BEGIN
	WAITFOR DELAY '00:00:05'
END;
GO

USE [$(DatabaseName)];
GO

IF ( CONVERT ( BIT , N'$(IsSetFilegroupReadonly)' ) = 1 )
BEGIN
	SELECT 1 FROM sys.tables
END;
GO