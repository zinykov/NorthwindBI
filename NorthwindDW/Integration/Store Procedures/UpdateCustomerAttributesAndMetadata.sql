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
	UPDATE [Dimension].[Customer]
	SET [Customer] = @Customer, [ContactName] = @ContactName, [ContactTitle] = @ContactTitle, [Phone] = @Phone, [Fax] = @Fax, [LineageKey] = @LineageKey
	WHERE	[CustomerAlterKey] = @CustomerAlterKey;

	UPDATE [Dimension].[Customer]
	SET [EndDate] = @EndDate, [Current] = 0, [LineageKey] = @LineageKey
	WHERE	[Current] = 1 AND [CustomerAlterKey] = @CustomerAlterKey;
END