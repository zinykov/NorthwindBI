CREATE TABLE [Hash].[Employees]
(
    [EmployeeID]        INT             NOT NULL,
    [HashDiff]          VARBINARY(64)   NOT NULL
)
    ON [Hash_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO