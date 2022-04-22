CREATE TABLE [Dimension].[Customer]
(
	[CustomerKey]           INT             IDENTITY (1, 1)     NOT NULL, 
    [CustomerAlterKey]      NVARCHAR(5)                         NOT NULL, 
    [Customer]              NVARCHAR(50)                        NULL, 
    [ContactName]           NVARCHAR(50)                        NULL, 
    [ContactTitle]          NVARCHAR(50)                        NULL,
    [Country]               NVARCHAR(25)                        NULL,
    [City]                  NVARCHAR(25)                        NULL,
    [Phone]                 NVARCHAR(30)                        NULL, 
    [Fax]                   NVARCHAR(30)                        NULL,
    [StartDate]             DATE                                NULL,
    [EndDate]               DATE                                NULL,
    [Current]               BIT                                 NULL,

    CONSTRAINT [PK_Dimension_Customer] PRIMARY KEY CLUSTERED ( [CustomerKey] ASC )
)
    ON [PRIMARY]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Alter_Key] ON [Dimension].[Customer] ( [CustomerAlterKey] ASC )
    INCLUDE ( [StartDate], [EndDate], [Current] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Customer] ON [Dimension].[Customer] ( [Customer] ASC )
    WITH ( DATA_COMPRESSION = PAGE ) 
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Country_City] ON [Dimension].[Customer] ( [Country] ASC, [City] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PRIMARY];
GO