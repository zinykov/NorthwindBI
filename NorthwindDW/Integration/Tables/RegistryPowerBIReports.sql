CREATE TABLE [Integration].[RegistryPBIRSReports] (
    [ReportKey]  INT            CONSTRAINT [SQ_RegistryPowerBIReports_Key] DEFAULT ( NEXT VALUE FOR [Integration].[RegistryPowerBIReportsKey] ) NOT NULL,
    [ReportName] SYSNAME        NOT NULL,
    [ReportPath] NVARCHAR (255) NOT NULL,
    [ReportType] NVARCHAR (3)   NOT NULL,
    [IsActive]   BIT            NOT NULL,
    [Priority]   INT            NOT NULL,

    CONSTRAINT [PK_Integration_RegistryPowerBIReports] PRIMARY KEY CLUSTERED ( [ReportKey] ASC )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE );
GO

CREATE NONCLUSTERED INDEX [IX_Integration_RegistryPowerBIReports_ActivePath] ON [Integration].[RegistryPBIRSReports] ( [ReportPath] ASC )
    INCLUDE ( [ReportName], [ReportType], [Priority] )
    WHERE [IsActive] = 1
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO
