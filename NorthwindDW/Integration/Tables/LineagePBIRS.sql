CREATE TABLE [Integration].[LineagePBIRS]
(
    [LineageKey]        BIGINT          CONSTRAINT [SQ_LineagePBIRS_Key] DEFAULT ( NEXT VALUE FOR [Integration].[LineageKey] ) NOT NULL,
    [ReportName]        SYSNAME         NOT NULL,
    [ReportPath]        NVARCHAR (255)  NOT NULL,
    [ReportType]        NVARCHAR (3)    NOT NULL,
    [RefreshStarted]    DATETIME2       NOT NULL,
    [RefreshCompleted]  DATETIME2       NULL,
    [WasSuccessful]     BIT             NOT NULL,
    [ExecutionId]       NVARCHAR (50)   NOT NULL,

    CONSTRAINT [PK_Integration_LineagePBIRS] PRIMARY KEY CLUSTERED ( [LineageKey] ASC )
)
    ON [Dimention_Data]
    WITH (DATA_COMPRESSION = PAGE);
GO

CREATE NONCLUSTERED INDEX [IX_Integration_LineagePBIRS_ReportName] ON [Integration].[LineagePBIRS] ( [ReportName] ASC )
    INCLUDE ([WasSuccessful], [RefreshStarted])
    WITH (DATA_COMPRESSION = PAGE)
    ON [Dimention_Index];
GO