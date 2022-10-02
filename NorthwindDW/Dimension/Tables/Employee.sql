CREATE TABLE [Dimension].[Employee]
(
    [EmployeeKey]           INT           CONSTRAINT [SQ_Employee_Key] DEFAULT ( NEXT VALUE FOR [Sequences].[EmployeeKey] )     NOT NULL,
    [EmployeeAlterKey]      INT                               NOT NULL,
    [Name]                  NVARCHAR(35)                      NOT NULL,
    [Title]                 NVARCHAR(30)                      NULL,
    [TitleOfCourtesy]       NVARCHAR(10)                      NULL,
    [City]                  NVARCHAR(25)                      NULL,
    [Country]               NVARCHAR(25)                      NULL,
    [StartDate]             DATETIME2                         NOT NULL,
    [EndDate]               DATETIME2                         NULL,
    [Current]               BIT                               NOT NULL,
    [LineageKey]            INT                               NOT NULL,
    
    CONSTRAINT [PK_Dimension_Employees] PRIMARY KEY CLUSTERED ( [EmployeeKey] ASC ),

    CONSTRAINT [FK_Dimension_Employees_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_Alter_Key] ON [Dimension].[Employee] ( [EmployeeAlterKey] ASC )
    INCLUDE ( [StartDate], [EndDate], [Current] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_LastName] ON [Dimension].[Employee] ( [Name] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_Country_City] ON [Dimension].[Employee] ( [Country] ASC, [City] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO