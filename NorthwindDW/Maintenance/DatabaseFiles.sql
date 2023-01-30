CREATE TABLE [Maintenance].[DatabaseFiles] (
	[DatabaseFileKey]					INT				CONSTRAINT [SQ_DatabaseFile_Key] DEFAULT ( NEXT VALUE FOR [Sequences].[DatabaseFileKey] ) NOT NULL,
	[FilegroupName]						NVARCHAR(100)	NOT NULL,
	[FilePath]							NVARCHAR(500)	NOT NULL,

	CONSTRAINT [PK_Maintenance_DatabaseFiles] PRIMARY KEY CLUSTERED ( [DatabaseFileKey] ASC )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Maintenance_DatabaseFiles_FilegroupName] ON [Maintenance].[DatabaseFiles] ( [FilegroupName] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO