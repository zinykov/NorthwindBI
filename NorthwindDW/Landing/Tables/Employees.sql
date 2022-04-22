CREATE TABLE [Landing].[Employees]
(
    [EmployeeID]        INT             NOT NULL,
    [LastName]          NVARCHAR(20)    NOT NULL,
    [FirstName]         NVARCHAR(10)    NOT NULL,
    [Title]             NVARCHAR(30)    NULL,
    [TitleOfCourtesy]   NVARCHAR(25)    NULL,
    [City]              NVARCHAR(15)    NULL,
    [Country]           NVARCHAR(15)    NULL
)
    ON [PRIMARY]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO