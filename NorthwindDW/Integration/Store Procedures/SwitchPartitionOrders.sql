CREATE PROCEDURE [Integration].[SwitchPartitionOrders]
	  @Partition_number AS INT
AS BEGIN
-- ШАГ 4. Применение предложения SWITCH PARTITION для добавления новых записей за последний временной промежуток
    BEGIN TRY
        BEGIN TRANSACTION
			ALTER TABLE [Integration].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number
-- ШАГ 5. Применение предложения MERGE для записей, обновлённых задним числом
--		  Если первичный ключ не совпадает, то создаются новая строка, если совпадает, то обновноляется совпавшая
			IF ( SELECT COUNT ( * ) FROM [Integration].[Order] ) > 0
			MERGE
				INTO [Fact].[Order] AS TRG
				USING [Integration].[Order] AS SRC
				ON	(
						SRC.[OrderKey]		=	TRG.[OrderKey]
					AND SRC.[ProductKey]	=	TRG.[ProductKey]
					)
				WHEN MATCHED THEN UPDATE SET
						  [OrderKey]				=	SRC.[OrderKey]
						, [ProductKey]				=	SRC.[ProductKey]
						, [CustomerKey]				=	SRC.[CustomerKey]
						, [EmployeeKey]				=	SRC.[EmployeeKey]
						, [OrderDateKey]			=	SRC.[OrderDateKey]
						, [RequiredDateKey]			=	SRC.[RequiredDateKey]
						, [ShippedDateKey]			=	SRC.[ShippedDateKey]
						, [UnitPrice]				=	SRC.[UnitPrice]
						, [Quantity]				=	SRC.[Quantity]
						, [Discount]				=	SRC.[Discount]
						, [SalesAmount]				=	SRC.[SalesAmount]
						, [SalesAmountWithDiscount]	=	SRC.[SalesAmountWithDiscount]
						, [LineageKey]				=	SRC.[LineageKey]
				WHEN NOT MATCHED BY TARGET THEN INSERT (
						  [OrderKey]
						, [ProductKey]
						, [CustomerKey]
						, [EmployeeKey]
						, [OrderDateKey]
						, [RequiredDateKey]
						, [ShippedDateKey]
						, [UnitPrice]
						, [Quantity]
						, [Discount]
						, [SalesAmount]
						, [SalesAmountWithDiscount]
						, [LineageKey]
					) VALUES (
						  SRC.[OrderKey]
						, SRC.[ProductKey]
						, SRC.[CustomerKey]
						, SRC.[EmployeeKey]
						, SRC.[OrderDateKey]
						, SRC.[RequiredDateKey]
						, SRC.[ShippedDateKey]
						, SRC.[UnitPrice]
						, SRC.[Quantity]
						, SRC.[Discount]
						, SRC.[SalesAmount]
						, SRC.[SalesAmountWithDiscount]
						, SRC.[LineageKey]
					);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END