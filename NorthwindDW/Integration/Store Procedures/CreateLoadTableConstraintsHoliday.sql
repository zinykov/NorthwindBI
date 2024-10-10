CREATE PROCEDURE [Integration].[CreateLoadTableConstraintsHoliday]
AS BEGIN
    ALTER TABLE [Integration].[Holiday]
        ADD CONSTRAINT [PK_Load_Table_Holiday_Date] PRIMARY KEY CLUSTERED ( [Date] ASC );
END;