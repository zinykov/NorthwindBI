CREATE TABLE [Dimension].[Product]
(
	[ProductKey]            INT             IDENTITY (1, 1)     NOT NULL ,
    [ProductAlterKey]       INT                                 NOT NULL ,
    [Product]               NVARCHAR(50)                        NULL, 
    [Category]              NVARCHAR(50)                        NULL,
    [StartDate]             DATE                                NULL,
    [EndDate]               DATE                                NULL,
    [Current]               BIT                                 NULL,

    CONSTRAINT [PK_Dimention_Product] PRIMARY KEY CLUSTERED ( [ProductKey] ASC )
)
    ON [PRIMARY]
    WITH ( DATA_COMPRESSION = PAGE );
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Product_Alter_Key] ON [Dimension].[Product] ( [ProductAlterKey] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Product_Category_Product] ON [Dimension].[Product] ( [Category] ASC, [Product] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PRIMARY];
GO