CREATE TABLE [Hash].[Order Details]
(
    [OrderID]           INT         NOT NULL,
    [ProductID]         INT         NOT NULL,
    [CheckSum]          INT         NOT NULL,

    CONSTRAINT [PK_Hash_Order_Details] PRIMARY KEY CLUSTERED ( [OrderID] ASC, [ProductID] ASC )
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO