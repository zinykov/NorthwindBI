CREATE TABLE [Landing].[Categories]
(
    [CategoryID]        INT             NOT NULL,
    [CategoryName]      NVARCHAR(15)    NOT NULL,
    [Description]       NTEXT           NULL,
    [HashDiff]          VARBINARY(100)  NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO