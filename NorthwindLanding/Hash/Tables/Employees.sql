CREATE TABLE [Hash].[Employees]
(
    [EmployeeID]        INT             NOT NULL,
    [HashDiff]          VARBINARY(MAX)  NOT NULL,

    CONSTRAINT [PK_Hash_Employees] PRIMARY KEY CLUSTERED ( [EmployeeID] ASC )
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO