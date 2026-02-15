CREATE TABLE [Integration].[LineagePBIRS]
(
    [LineageKey]        BIGINT          NOT NULL,
    [ReportName]        SYSNAME         NOT NULL,
    [ReportPath]        NVARCHAR (255)  NOT NULL,
    [ReportType]        NVARCHAR (3)    NOT NULL,
    [RefreshStarted]    DATETIME2       NOT NULL,
    [RefreshCompleted]  DATETIME2       NULL,
    [WasSuccessful]     BIT             NOT NULL,
    [ExecutionId]       NVARCHAR (50)   NOT NULL,

    CONSTRAINT [PK_Integration_LineagePBIRS] PRIMARY KEY CLUSTERED ( [LineageKey] ASC )
)
    ON [Integration_FG]
    WITH (DATA_COMPRESSION = PAGE);
GO