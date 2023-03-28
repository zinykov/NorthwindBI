CREATE TABLE [Hash].[Orders]
(
    [OrderID]      INT           NOT NULL,
    [CheckSum]     INT           NOT NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO