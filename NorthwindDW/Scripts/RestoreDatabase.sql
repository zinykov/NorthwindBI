USE [master];
GO

RESTORE DATABASE [NorthwindDW]
	READ_WRITE_FILEGROUPS
	FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\NorthwindDW\1997-12-27\NorthwindDW_backup_read_write_filegroups_19971227_FULL.bak'
	WITH PARTIAL, NORECOVERY;
GO

RESTORE DATABASE [NorthwindDW]
	READ_WRITE_FILEGROUPS
	FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\NorthwindDW\1997-12-27\NorthwindDW_backup_read_write_filegroups_19980102_DIFF.bak'
	WITH NORECOVERY;
GO

RESTORE DATABASE [NorthwindDW]
	WITH RECOVERY;
GO

--SELECT	MIN ( [OrderDateKey] ), MAX ( [OrderDateKey] )
--FROM	[NorthwindDW].[Fact].[Order]
--WHERE	[OrderDateKey] >= 19970101;
--GO

--RESTORE DATABASE [NorthwindDW]
--	FILEGROUP = 'Order_1996_Data'
--	FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\NorthwindDW\ReadOnly\NorthwindDW_backup_read_only_filegroup_Order_1996_Data.bak'
--	WITH RECOVERY;
--GO

--RESTORE DATABASE [NorthwindDW]
--	FILEGROUP = 'Order_1996_Index'
--	FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\NorthwindDW\ReadOnly\NorthwindDW_backup_read_only_filegroup_Order_1996_Index.bak'
--	WITH RECOVERY;
--GO

--SELECT	MIN ( [OrderDateKey] ), MAX ( [OrderDateKey] )
--FROM	[NorthwindDW].[Fact].[Order];
--GO