CREATE TABLE [dbo].[NW_Category] (
    [CategoryID_Source]       INT            NULL,
    [CategoryID_Output]       INT            NULL,
    [CategoryID_Reason]       NVARCHAR (MAX) NULL,
    [CategoryID_Confidence]   NVARCHAR (MAX) NULL,
    [CategoryID_Status]       NVARCHAR (MAX) NULL,
    [CategoryName_Source]     NVARCHAR (15)  NULL,
    [CategoryName_Output]     NVARCHAR (MAX) NULL,
    [CategoryName_Reason]     NVARCHAR (MAX) NULL,
    [CategoryName_Confidence] NVARCHAR (MAX) NULL,
    [CategoryName_Status]     NVARCHAR (MAX) NULL,
    [Description_Output]      NVARCHAR (MAX) NULL,
    [Record_Status]           NVARCHAR (MAX) NULL
);

