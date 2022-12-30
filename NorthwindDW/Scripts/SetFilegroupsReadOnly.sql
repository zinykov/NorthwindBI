ALTER DATABASE [$(DatabaseName)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
EXECUTE [Maintenance].[SetFilegroupReadOnly] @CutoffTime = $(CutoffTime), @FactTableName = $(FactTableName)
GO
ALTER DATABASE [$(DatabaseName)] SET MULTI_USER;
GO