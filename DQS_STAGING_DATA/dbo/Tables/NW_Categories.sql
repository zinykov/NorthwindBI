CREATE TABLE [dbo].[NW_Categories](
    [CategoryID_Source]       INT               NULL,
    [CategoryID_Output]       INT               NULL,
    [CategoryID_Reason]       NVARCHAR(MAX)     NULL,
    [CategoryID_Confidence]   NVARCHAR(100)     NULL,
    [CategoryID_Status]       NVARCHAR(100)     NULL,
    [CategoryName_Source]     NVARCHAR(15)      NULL,
    [CategoryName_Output]     NVARCHAR(15)      NULL,
    [CategoryName_Reason]     NVARCHAR(MAX)     NULL,
    [CategoryName_Confidence] NVARCHAR(100)     NULL,
    [CategoryName_Status]     NVARCHAR(100)     NULL,
    [Record Status]           NVARCHAR(100)     NULL,
    [Appended data]           NVARCHAR(MAX)     NULL,
    [Appended data schema]    NVARCHAR(MAX)     NULL
);

