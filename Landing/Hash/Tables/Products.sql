CREATE TABLE [Hash].[Products]
(
    [ProductID]   INT           NOT NULL,
    [CheckSum]    INT           NOT NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO