CREATE PROCEDURE [Integration].[UpdateCustomerAttributesAndMetadata]
	  @CustomerAlterKey AS NVARCHAR(5)
	, @LineageKey AS INT
	, @Customer AS NVARCHAR(50)
	, @ContactName AS NVARCHAR(50)
	, @ContactTitle AS NVARCHAR(50)
	, @Phone AS NVARCHAR(30)
	, @Fax AS NVARCHAR(30)
	, @EndDate AS DATE
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
			UPDATE [Dimension].[Customer]
			SET [Customer] = @Customer, [ContactName] = @ContactName, [ContactTitle] = @ContactTitle, [Phone] = @Phone, [Fax] = @Fax, [LineageKey] = @LineageKey
			WHERE	[CustomerAlterKey] = @CustomerAlterKey;

			UPDATE [Dimension].[Customer]
			SET [EndDate] = @EndDate, [Current] = 0, [LineageKey] = @LineageKey
			WHERE	[Current] = 1 AND [CustomerAlterKey] = @CustomerAlterKey;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END