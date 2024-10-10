CREATE PROCEDURE [Integration].[CreateLoadTableHoliday]
AS BEGIN
    CREATE TABLE [Integration].[Holiday]
    (
	    [Date]                  DATE            NOT NULL,
        [Holiday]               NVARCHAR(100)   NULL,
        [WorkDayType]           NVARCHAR(25)    NOT NULL,
        [WorkDayHours]          TINYINT         NOT NULL
    )
        ON [Dimention_Data]
        WITH ( DATA_COMPRESSION = PAGE );
END;