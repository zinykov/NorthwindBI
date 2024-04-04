CREATE PROCEDURE [Integration].[CreateLoadTableHoliday]
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            CREATE TABLE [Integration].[Holiday]
            (
	            [Date]                  DATE            NOT NULL,
                [Holiday]               NVARCHAR(100)   NULL,
                [WorkDayType]           NVARCHAR(25)    NOT NULL,
                [WorkDayHours]          TINYINT         NOT NULL

                CONSTRAINT [PK_Load_Table_Holiday_Date] PRIMARY KEY CLUSTERED ( [Date] ASC )
            )
                ON [Dimention_Data]
                WITH ( DATA_COMPRESSION = PAGE );
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END;