CREATE TABLE [Maintenance].[DatabaseFiles] (
	[DatabaseFileKey]					INT				CONSTRAINT [SQ_DatabaseFile_Key] DEFAULT ( NEXT VALUE FOR [Sequences].[DatabaseFileKey] ) NOT NULL,
	[GroupName]							NVARCHAR(100)	NOT NULL,
	[IsReadOnly]						BIT				NOT NULL,
	[Name]								NVARCHAR(100)	NOT NULL,
	[FileName]							NVARCHAR(500)	NOT NULL,
	[BackupFileName]					NVARCHAR(500)	NULL,
	[CutoffTime]						DATE			NULL,

	CONSTRAINT [PK_Maintenance_DatabaseFiles] PRIMARY KEY CLUSTERED ( [DatabaseFileKey] ASC )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Maintenance_DatabaseFiles_FilegroupName] ON [Maintenance].[DatabaseFiles] ( [GroupName] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO