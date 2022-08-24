CREATE TABLE [Staging].[Employee]
(
    [EmployeeAlterKey]      INT                               NOT NULL,
    [Name]                  NVARCHAR(35)                      NOT NULL,
    [Title]                 NVARCHAR(30)                      NULL,
    [TitleOfCourtesy]       NVARCHAR(25)                      NULL,
    [City]                  NVARCHAR(15)                      NULL,
    [Country]               NVARCHAR(15)                      NULL
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO