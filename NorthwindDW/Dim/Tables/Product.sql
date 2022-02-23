CREATE TABLE [Dimension].[Product]
(
	[ProductID]         INT             IDENTITY (1, 1)     NOT NULL , 
    [Product]           NVARCHAR(50)                        NULL, 
    [Category]          NVARCHAR(50)                        NULL,

    CONSTRAINT [PK_Dimention_Product] PRIMARY KEY CLUSTERED ( [ProductID] ASC )
)
