CREATE PROCEDURE [Integration].[UpdateCustomerChangingAttributes]
	  @CustomerAlterKey AS NVARCHAR(5)
	, @LineageKey AS INT
	, @Customer AS NVARCHAR(50)
	, @ContactName AS NVARCHAR(50)
	, @ContactTitle AS NVARCHAR(50)
	, @Phone AS NVARCHAR(30)
	, @Fax AS NVARCHAR(30)
	, @AllAttributes AS NVARCHAR(MAX)
AS BEGIN
	UPDATE	[Dimension].[Customer]
	SET		  [Customer] = @Customer
			, [ContactName] = @ContactName
			, [ContactTitle] = @ContactTitle
			, [Phone] = @Phone
			, [Fax] = @Fax
			, [AllAttributes] = @AllAttributes
			, [LineageKey] = @LineageKey
	WHERE	[CustomerAlterKey] = @CustomerAlterKey;
END