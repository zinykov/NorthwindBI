﻿CREATE TABLE [dbo].[DatabaseFiles] (
	[DatabaseFileKey]					INT				NOT NULL,
	[GroupName]							NVARCHAR(100)	NOT NULL,
	[IsReadOnly]						BIT				NOT NULL,
	[Name]								NVARCHAR(100)	NOT NULL,
	[FileName]							NVARCHAR(500)	NOT NULL,
	[BackupFileName]					NVARCHAR(500)	NULL,

	CONSTRAINT [PK_Maintenance_DatabaseFiles] PRIMARY KEY CLUSTERED ( [DatabaseFileKey] ASC )
)
    ON [PRIMARY]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO