CREATE TABLE [Hash].[Customers]
(
    [CustomerID]        NCHAR(5)        NOT NULL,
    [CheckSum]          INT             NOT NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO