CREATE TABLE [Dimension].[Employee]
(
    [EmployeeKey]           INT           IDENTITY (1, 1)     NOT NULL,
    [EmployeeAlterKey]      INT                               NOT NULL,
    [Name]                  NVARCHAR(35)                      NOT NULL,
    [Title]                 NVARCHAR(30)                      NULL,
    [TitleOfCourtesy]       NVARCHAR(25)                      NULL,
    [City]                  NVARCHAR(15)                      NULL,
    [Country]               NVARCHAR(15)                      NULL,
    [StartDate]             DATE                              NULL,
    [EndDate]               DATE                              NULL,
    [Current]               BIT                               NULL,
    
    CONSTRAINT [PK_Dimension_Employees] PRIMARY KEY CLUSTERED ( [EmployeeKey] ASC )
)
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_Alter_Key] ON [Dimension].[Employee] ( [EmployeeAlterKey] ASC )
    INCLUDE ( [StartDate], [EndDate], [Current] )
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_LastName] ON [Dimension].[Employee] ( [Name] ASC )
    ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_Country_City] ON [Dimension].[Employee] ( [Country] ASC, [City] ASC )
    ON [PRIMARY];
GO