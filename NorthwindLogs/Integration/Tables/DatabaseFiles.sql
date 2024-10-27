CREATE TABLE [Integration].[DatabaseFiles] (
	[DatabaseFileKey]					INT				NOT NULL,
	[GroupName]							NVARCHAR(100)	NOT NULL,
	[IsReadOnly]						BIT				NOT NULL,
	[Name]								NVARCHAR(100)	NOT NULL,
	[FileName]							NVARCHAR(500)	NOT NULL,
	[BackupFileName]					NVARCHAR(500)	NULL,
	[CutoffTime]						DATE			NULL,

	CONSTRAINT [PK_Integration_DatabaseFiles] PRIMARY KEY CLUSTERED ( [DatabaseFileKey] ASC )
)
    ON [Integration_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO