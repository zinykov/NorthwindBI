CREATE TABLE [Hash].[Order Details]
(
    [OrderID]           INT         NOT NULL,
    [ProductID]         INT         NOT NULL,
    [CheckSum]          INT         NOT NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO