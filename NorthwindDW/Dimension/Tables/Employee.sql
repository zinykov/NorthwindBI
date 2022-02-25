CREATE TABLE [Dimension].[Employee]
(
    [EmployeeKey]     INT           IDENTITY (1, 1)     NOT NULL,
    [LastName]        NVARCHAR(20)                      NOT NULL,
    [FirstName]       NVARCHAR(10)                      NOT NULL,
    [Title]           NVARCHAR(30)                      NULL,
    [TitleOfCourtesy] NVARCHAR(25)                      NULL,
    [City]            NVARCHAR(15)                      NULL,
    [Country]         NVARCHAR(15)                      NULL,
    
    CONSTRAINT [PK_Dimension_Employees] PRIMARY KEY CLUSTERED ( [EmployeeKey] ASC )
);
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_LastName] ON [Dimension].[Employee] ( [LastName] ASC )
    INCLUDE ( [FirstName] );
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_FirstName] ON [Dimension].[Employee] ( [FirstName] ASC )
    INCLUDE ( [LastName] );
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_Country_City] ON [Dimension].[Employee] ( [Country] ASC, [City] ASC );
GO