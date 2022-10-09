CREATE TABLE [dbo].[NW_Product] (
    [ProductID_Source]       INT            NULL,
    [ProductID_Output]       INT            NULL,
    [ProductID_Reason]       NVARCHAR (MAX) NULL,
    [ProductID_Confidence]   NVARCHAR (MAX) NULL,
    [ProductID_Status]       NVARCHAR (MAX) NULL,
    [ProductName_Source]     NVARCHAR (40)  NULL,
    [ProductName_Output]     NVARCHAR (MAX) NULL,
    [ProductName_Reason]     NVARCHAR (MAX) NULL,
    [ProductName_Confidence] NVARCHAR (MAX) NULL,
    [ProductName_Status]     NVARCHAR (MAX) NULL,
    [SupplierID_Output]      INT            NULL,
    [CategoryID_Source]      INT            NULL,
    [CategoryID_Output]      INT            NULL,
    [CategoryID_Reason]      NVARCHAR (MAX) NULL,
    [CategoryID_Confidence]  NVARCHAR (MAX) NULL,
    [CategoryID_Status]      NVARCHAR (MAX) NULL,
    [UnitPrice_Output]       MONEY          NULL,
    [Record_Status]          NVARCHAR (MAX) NULL
);

