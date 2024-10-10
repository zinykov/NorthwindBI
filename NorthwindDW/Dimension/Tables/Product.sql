CREATE TABLE [Dimension].[Product]
(
	[ProductKey]            BIGINT          CONSTRAINT [SQ_Product_Key] DEFAULT ( NEXT VALUE FOR [Dimension].[ProductKey] )     NOT NULL,
    [ProductAlterKey]       INT             NOT NULL,
    [Product]               NVARCHAR(50)    NOT NULL,
    [Category]              NVARCHAR(50)    NOT NULL,
    [AllAttributes]         NVARCHAR(MAX)   NOT NULL,
    [LineageKey]            BIGINT          NOT NULL,

    CONSTRAINT [PK_Dimention_Product] PRIMARY KEY CLUSTERED ( [ProductKey] ASC ),

    CONSTRAINT [FK_Dimension_Product_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] )
)
    ON [Dimention_Data] TEXTIMAGE_ON [JSON_FG]
    WITH ( DATA_COMPRESSION = PAGE );
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Product_Alter_Key] ON [Dimension].[Product] ( [ProductAlterKey] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Product_Category_Product] ON [Dimension].[Product] ( [Category] ASC, [Product] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO