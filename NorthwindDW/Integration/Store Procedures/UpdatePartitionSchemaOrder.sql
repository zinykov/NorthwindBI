CREATE PROCEDURE [Integration].[UpdatePartitionSchemaOrder]
	    @CutoffTime AS DATE
	  , @Partition_number AS INT OUTPUT
AS BEGIN
    --BEGIN TRY
    --    BEGIN TRANSACTION
			-- Объявление переменных
				DECLARE		@PartitionParameter AS DATE
				DECLARE		@NewPartitionParameter AS DATE
				DECLARE		@SQL AS NVARCHAR(2000)

			-- Определение границы новой секции
				SET @NewPartitionParameter = DATEADD ( DAY, 1, @CutoffTime )
			-- Переменной @NewPartitionParameter присваивается значение @NewPartitionDate в формате OrderDateKey
				SET @PartitionParameter = @CutoffTime

			-- ШАГ 1. Определение файловых групп для схем секционирования
				SET @SQL = CONCAT (
						N'ALTER PARTITION SCHEME [PS_Order_Date_Data] NEXT USED [Order_'
					, CONVERT ( NVARCHAR(4), YEAR ( @NewPartitionParameter ) )
					, N'_Data]'
					)
				EXECUTE sp_executesql @SQL

				SET @SQL = CONCAT (
						N'ALTER PARTITION SCHEME [PS_Order_Date_Index] NEXT USED [Order_'
					, CONVERT ( NVARCHAR(4), YEAR ( @NewPartitionParameter ) )
					, N'_Index]'
					)
				EXECUTE sp_executesql @SQL

			-- ШАГ 2. Создание новой секции
				IF NOT EXISTS ( SELECT 1 FROM [sys].[partition_range_values] WHERE [value] = @NewPartitionParameter )
				BEGIN
					ALTER PARTITION FUNCTION [PF_Order_Date] () SPLIT RANGE ( @NewPartitionParameter )
				END

			-- Переменной @Partition_number присваивается номер предпоследней секции
				SET @Partition_number = $PARTITION.[PF_Order_Date] ( @PartitionParameter );
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END