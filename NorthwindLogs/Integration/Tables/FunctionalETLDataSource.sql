CREATE TABLE [Integration].[FunctionalETLDataSource]
(
    [CutoffTime]   DATETIME2(7)    NOT NULL,
	
	CONSTRAINT [PK_Integration_FunctionalETLDataSource] PRIMARY KEY CLUSTERED ( [CutoffTime] ASC )
)
WITH ( DATA_COMPRESSION = PAGE ) ;
GO
