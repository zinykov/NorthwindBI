CREATE TABLE [Landing].[Employees]
(
    [EmployeeID]        INT             NOT NULL,
    [LastName]          NVARCHAR(20)    NOT NULL,
    [FirstName]         NVARCHAR(20)    NOT NULL,
    [Title]             NVARCHAR(30)    NULL,
    [TitleOfCourtesy]   NVARCHAR(10)    NULL,
    [City]              NVARCHAR(25)    NULL,
    [Country]           NVARCHAR(25)    NULL,
    [HashDiff]          VARBINARY(100)  NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO