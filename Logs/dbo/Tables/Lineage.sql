CREATE TABLE [dbo].[Lineage]
(
	  [LineageKey]					INT				NOT NULL,
	  [DataLoadStarted]				DATETIME2		NOT NULL,
	  [TableName]					SYSNAME			NOT NULL,
	  [DataLoadCompleted]			DATETIME2		NULL,
	  [WasSuccessful]				BIT				NOT NULL,
	  [CutoffTime]					DATETIME2		NOT NULL,
	  [ExecutionId]					NVARCHAR (50)	NOT NULL,
	
	CONSTRAINT [PK_Integration_Lineage] PRIMARY KEY CLUSTERED ( [LineageKey] ASC )
)
    ON [PRIMARY]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO