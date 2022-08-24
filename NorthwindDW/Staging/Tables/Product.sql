CREATE TABLE [Staging].[Product]
(
	[ProductAlterKey]       INT                                 NOT NULL,
    [Product]               NVARCHAR(50)                        NOT NULL, 
    [Category]              NVARCHAR(50)                        NOT NULL
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE );
GO