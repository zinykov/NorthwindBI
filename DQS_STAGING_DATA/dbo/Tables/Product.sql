CREATE TABLE [dbo].[Product] (
    [ProductAlterKey_Source]     BIGINT         NULL,
    [ProductAlterKey_Output]     BIGINT         NULL,
    [ProductAlterKey_Reason]     NVARCHAR (MAX) NULL,
    [ProductAlterKey_Confidence] NVARCHAR (MAX) NULL,
    [ProductAlterKey_Status]     NVARCHAR (MAX) NULL,
    [Product_Source]             NVARCHAR (MAX) NULL,
    [Product_Output]             NVARCHAR (MAX) NULL,
    [Product_Reason]             NVARCHAR (MAX) NULL,
    [Product_Confidence]         NVARCHAR (MAX) NULL,
    [Product_Status]             NVARCHAR (MAX) NULL,
    [Category_Source]            NVARCHAR (MAX) NULL,
    [Category_Output]            NVARCHAR (MAX) NULL,
    [Category_Reason]            NVARCHAR (MAX) NULL,
    [Category_Confidence]        NVARCHAR (MAX) NULL,
    [Category_Status]            NVARCHAR (MAX) NULL,
    [Record_Status]              NVARCHAR (MAX) NULL
);

