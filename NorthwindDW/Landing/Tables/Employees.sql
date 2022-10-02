CREATE TABLE [Landing].[Employees]
(
    [EmployeeID]        INT             NOT NULL,
    [LastName]          NVARCHAR(20)    NOT NULL,
    [FirstName]         NVARCHAR(10)    NOT NULL,
    [Title]             NVARCHAR(10)    NULL,
    [TitleOfCourtesy]   NVARCHAR(25)    NULL,
    [City]              NVARCHAR(25)    NULL,
    [Country]           NVARCHAR(25)    NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO