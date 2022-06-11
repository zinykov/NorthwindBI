CREATE TABLE [Integration].[Lineage]
(
	  [LineageKey]					INT			CONSTRAINT [SQ_Lineage_Key] DEFAULT ( NEXT VALUE FOR [Sequences].[LineageKey] ) NOT NULL,
	  [DataLoadStarted]				DATETIME2	NOT NULL,
	  [TableName]					SYSNAME		NOT NULL,
	  [DataLoadCompleted]			DATETIME2	NOT NULL,
	  [WasSuccessful]				BIT			NOT NULL,
	  [CutoffTime]					DATETIME2	NOT NULL,
	
	CONSTRAINT [PK_Integration_Lineage] PRIMARY KEY CLUSTERED ( [LineageKey] ASC )
)
