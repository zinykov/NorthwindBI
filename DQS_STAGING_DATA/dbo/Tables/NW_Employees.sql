﻿CREATE TABLE [dbo].[NW_Employees](
    [EmployeeID_Source]          INT            NULL,
    [EmployeeID_Output]          INT            NULL,
    [EmployeeID_Reason]          NVARCHAR(MAX)  NULL,
    [EmployeeID_Confidence]      NVARCHAR(100)  NULL,
    [EmployeeID_Status]          NVARCHAR(100)  NULL,
    [LastName_Source]            NVARCHAR(20)   NULL,
    [LastName_Output]            NVARCHAR(20)   NULL,
    [LastName_Reason]            NVARCHAR(MAX)  NULL,
    [LastName_Confidence]        NVARCHAR(100)  NULL,
    [LastName_Status]            NVARCHAR(100)  NULL,
    [FirstName_Source]           NVARCHAR(20)   NULL,
    [FirstName_Output]           NVARCHAR(20)   NULL,
    [FirstName_Reason]           NVARCHAR(MAX)  NULL,
    [FirstName_Confidence]       NVARCHAR(100)  NULL,
    [FirstName_Status]           NVARCHAR(100)  NULL,
    [Title_Source]               NVARCHAR(30)   NULL,
    [Title_Output]               NVARCHAR(30)   NULL,
    [Title_Reason]               NVARCHAR(MAX)  NULL,
    [Title_Confidence]           NVARCHAR(100)  NULL,
    [Title_Status]               NVARCHAR(100)  NULL,
    [TitleOfCourtesy_Source]     NVARCHAR(10)   NULL,
    [TitleOfCourtesy_Output]     NVARCHAR(10)   NULL,
    [TitleOfCourtesy_Reason]     NVARCHAR(MAX)  NULL,
    [TitleOfCourtesy_Confidence] NVARCHAR(100)  NULL,
    [TitleOfCourtesy_Status]     NVARCHAR(100)  NULL,
    [City_Source]                NVARCHAR(25)   NULL,
    [City_Output]                NVARCHAR(25)   NULL,
    [City_Reason]                NVARCHAR(MAX)  NULL,
    [City_Confidence]            NVARCHAR(100)  NULL,
    [City_Status]                NVARCHAR(100)  NULL,
    [Country_Source]             NVARCHAR(25)   NULL,
    [Country_Output]             NVARCHAR(25)   NULL,
    [Country_Reason]             NVARCHAR(MAX)  NULL,
    [Country_Confidence]         NVARCHAR(100)  NULL,
    [Country_Status]             NVARCHAR(100)  NULL,
    [Record Status]              NVARCHAR(100)  NULL,
    [Appended data]              NVARCHAR(MAX)  NULL,
    [Appended data schema]       NVARCHAR(MAX)  NULL
);

