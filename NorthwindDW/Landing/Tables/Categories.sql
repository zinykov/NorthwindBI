CREATE TABLE [Landing].[Categories]
(
    [CategoryID]        INT             NOT NULL,
    [CategoryName]      NVARCHAR(15)    NOT NULL,
    [Description]       NTEXT           NULL
)
    ON [PRIMARY];
GO