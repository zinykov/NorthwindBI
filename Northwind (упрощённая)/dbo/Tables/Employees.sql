CREATE TABLE [dbo].[Employees] (
    [EmployeeID]      INT           IDENTITY (1, 1) NOT NULL,
    [LastName]        NVARCHAR (20) NOT NULL,
    [FirstName]       NVARCHAR (10) NOT NULL,
    [Title]           NVARCHAR (30) NULL,
    [TitleOfCourtesy] NVARCHAR (25) NULL,
    [City]            NVARCHAR (15) NULL,
    [Country]         NVARCHAR (15) NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [LastName]
    ON [dbo].[Employees]([LastName] ASC);

