CREATE TABLE [Integration].[Lineage]
(
	  [LineageKey]					BIGINT			CONSTRAINT [SQ_Lineage_Key] DEFAULT ( NEXT VALUE FOR [Integration].[LineageKey] ) NOT NULL,
	  [TableName]					SYSNAME			NOT NULL,
	  [CutoffTime]					DATETIME2		NOT NULL,
	  [DataLoadStarted]				DATETIME2		NOT NULL,
	  [DataLoadCompleted]			DATETIME2		NULL,
	  [WasSuccessful]				BIT				NOT NULL,
	  [ExecutionId]					NVARCHAR (50)	NOT NULL,
	
	CONSTRAINT [PK_Integration_Lineage] PRIMARY KEY CLUSTERED ( [LineageKey] ASC )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Integration_Lineage_TableName] ON [Integration].[Lineage] ( [TableName] ASC )
	INCLUDE ( [WasSuccessful] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO