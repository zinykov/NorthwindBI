CREATE TABLE [Dimension].[Customer]
(
	[CustomerKey]           INT             CONSTRAINT [SQ_Customer_Key] DEFAULT ( NEXT VALUE FOR [Sequences].[CustomerKey] )     NOT NULL, 
    [CustomerAlterKey]      NVARCHAR(5)                         NOT NULL, 
    [Customer]              NVARCHAR(50)                        NOT NULL, 
    [ContactName]           NVARCHAR(50)                        NULL, 
    [ContactTitle]          NVARCHAR(50)                        NULL,
    [Country]               NVARCHAR(25)                        NULL,
    [City]                  NVARCHAR(25)                        NULL,
    [Phone]                 NVARCHAR(30)                        NULL, 
    [Fax]                   NVARCHAR(30)                        NULL,
    [StartDate]             DATETIME2                           NOT NULL,
    [EndDate]               DATETIME2                           NULL,
    [Current]               BIT                                 NOT NULL,
    [LineageKey]            INT                                 NOT NULL,

    CONSTRAINT [PK_Dimension_Customer] PRIMARY KEY CLUSTERED ( [CustomerKey] ASC ),

    CONSTRAINT [FK_Dimension_Customer_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Alter_Key] ON [Dimension].[Customer] ( [CustomerAlterKey] ASC )
    INCLUDE ( [StartDate], [EndDate], [Current] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Customer] ON [Dimension].[Customer] ( [Customer] ASC )
    WITH ( DATA_COMPRESSION = PAGE ) 
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Country_City] ON [Dimension].[Customer] ( [Country] ASC, [City] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO