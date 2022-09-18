CREATE TABLE [Integration].[ErrorLog]
(
      [LogKey]						INT						IDENTITY ( 1, 1 ) NOT NULL,
	  [ErrorCode]					INT						NOT NULL,
	  [ErrorDescription]			NVARCHAR ( 2048 )		NOT NULL,
	  [MachineName]					NVARCHAR ( 128 )		NOT NULL,
	  [PackageName]					NVARCHAR ( 1024 )		NOT NULL,
	  [SourceName]					NVARCHAR ( 1024 )		NOT NULL,
	  [StartTime]					DATETIME2				NOT NULL,
	  [UserName]					NVARCHAR ( 128 )		NOT NULL,
	  [LineageKey]					INT						NOT NULL,
	
	CONSTRAINT [PK_Integration_ErrorLog] PRIMARY KEY CLUSTERED ( [LogKey] ASC )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO