CREATE TABLE [Landing].[Order Details]
(
    [OrderID]           INT         NOT NULL,
    [ProductID]         INT         NOT NULL,
    [UnitPrice]         MONEY       NOT NULL,
    [Quantity]          SMALLINT    NOT NULL,
    [Discount]          REAL        NOT NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO