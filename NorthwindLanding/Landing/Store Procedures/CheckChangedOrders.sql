CREATE PROCEDURE [Landing].[CheckChangedOrders]
	@AreThereAnyChangesInOrders AS BIT OUTPUT
AS BEGIN
	ALTER TABLE [Landing].[Orders] ADD CONSTRAINT [PK_Landing_Orders] PRIMARY KEY CLUSTERED ( [OrderID] ASC )
		WITH ( DATA_COMPRESSION = PAGE )
		ON [Landing_FG]
	ALTER TABLE [Landing].[Order Details] ADD CONSTRAINT [PK_Landing_Order_Details] PRIMARY KEY CLUSTERED ( [OrderID] ASC, [ProductID] ASC )
		WITH ( DATA_COMPRESSION = PAGE )
		ON [Landing_FG]

	UPDATE [Landing].[Orders]
		SET [HashDiff] = CAST (
							HASHBYTES ( 
								  N'SHA2_512'
								, CONCAT (
									  ISNULL ( [CustomerID], CAST ( N'' AS NCHAR(5) ) ), N'#'
									, ISNULL ( [EmployeeID], 0 ), N'#'
									, ISNULL ( [OrderDate], DATEFROMPARTS ( 1995, 12, 31 ) ), N'#'
									, ISNULL ( [RequiredDate], DATEFROMPARTS ( 1995, 12, 31 ) ), N'#'
									, ISNULL ( [ShippedDate], DATEFROMPARTS ( 1995, 12, 31 ) )
								)
							)
							AS VARBINARY(64)
						)

	UPDATE [Landing].[Order Details]
		SET [HashDiff] = CAST (
							HASHBYTES ( 
								  N'SHA2_512'
								, CONCAT (
									  ISNULL ( [UnitPrice], CAST ( 0 AS MONEY ) ), N'#'
									, ISNULL ( [Quantity], CAST ( 0 AS SMALLINT ) ), N'#'
									, ISNULL ( [Discount], CAST ( 0 AS REAL ) )
								)
							)
							AS VARBINARY(64)
						)

	SET @AreThereAnyChangesInOrders = ( SELECT COUNT(*) FROM [Landing].[ChangedOrders] )
END