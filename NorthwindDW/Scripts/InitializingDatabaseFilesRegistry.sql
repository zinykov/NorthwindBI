--Move database files using information from Designing File Storage.

USE [$(DatabaseName)];
GO

IF NOT EXISTS ( SELECT 1 FROM [Maintenance].[DatabaseFiles] )
BEGIN
	INSERT INTO [Maintenance].[DatabaseFiles] (
		  [GroupName]
		, [IsReadOnly]
		, [Name]
		, [FileName]
		, [TargetBackupFolder]
	)
		SELECT		  FG.[groupname]
					, FG1.[is_read_only]
					, F.[name]
					, F.[filename]
					, N'$(TargetBackupFolder)\'
		FROM		sys.sysfilegroups AS FG
		INNER JOIN	sys.sysfiles AS F ON FG.[groupid] = F.[groupid]
		INNER JOIN	sys.filegroups AS FG1 ON FG.[groupname] = FG1.[name];
END
GO