CREATE TABLE [Dimension].[Customer]
(
	[CustomerKey]       INT             IDENTITY (1, 1)     NOT NULL, 
    [CustomerAlterKey]  INT                                 NOT NULL, 
    [Customer]          NVARCHAR(50)                        NULL, 
    [ContactName]       NVARCHAR(50)                        NULL, 
    [ContactTitle]      NVARCHAR(50)                        NULL,
    [Country]           NVARCHAR(25)                        NULL,
    [City]              NVARCHAR(25)                        NULL,
    [Phone]             NVARCHAR(20)                        NULL, 
    [Fax]               NVARCHAR(20)                        NULL,

    CONSTRAINT [PK_Dimension_Customer] PRIMARY KEY CLUSTERED ( [CustomerKey] ASC )
)
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Alter_Key] ON [Dimension].[Customer] ( [CustomerAlterKey] ASC )
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Customer] ON [Dimension].[Customer] ( [Customer] ASC )
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_Country_City] ON [Dimension].[Customer] ( [Country] ASC, [City] ASC )
    ON [PRIMARY];
GO