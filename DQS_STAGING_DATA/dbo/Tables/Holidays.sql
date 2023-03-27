CREATE TABLE [dbo].[Holidays] (
    [Date_Source]            DATE           NULL,
    [Date_Output]            DATE           NULL,
    [Date_Reason]            NVARCHAR (MAX) NULL,
    [Date_Confidence]        NVARCHAR (MAX) NULL,
    [Date_Status]            NVARCHAR (MAX) NULL,
    [DateType_Source]        TINYINT        NULL,
    [DateType_Output]        TINYINT        NULL,
    [DateType_Reason]        NVARCHAR (MAX) NULL,
    [DateType_Confidence]    NVARCHAR (MAX) NULL,
    [DateType_Status]        NVARCHAR (MAX) NULL,
    [HolidayName_Source]     NVARCHAR (255) NULL,
    [HolidayName_Output]     NVARCHAR (MAX) NULL,
    [HolidayName_Reason]     NVARCHAR (MAX) NULL,
    [HolidayName_Confidence] NVARCHAR (MAX) NULL,
    [HolidayName_Status]     NVARCHAR (MAX) NULL,
    [Record_Status]          NVARCHAR (MAX) NULL,
    [Appended_data]          NVARCHAR (MAX) NULL,
    [Appended_data_schema]   NVARCHAR (MAX) NULL
);

