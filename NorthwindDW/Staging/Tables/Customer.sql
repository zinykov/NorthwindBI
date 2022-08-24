CREATE TABLE [Staging].[Customer]
(
	[CustomerAlterKey]      NVARCHAR(5)                         NOT NULL, 
    [Customer]              NVARCHAR(50)                        NOT NULL, 
    [ContactName]           NVARCHAR(50)                        NULL, 
    [ContactTitle]          NVARCHAR(50)                        NULL,
    [Country]               NVARCHAR(25)                        NULL,
    [City]                  NVARCHAR(25)                        NULL,
    [Phone]                 NVARCHAR(30)                        NULL, 
    [Fax]                   NVARCHAR(30)                        NULL
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO