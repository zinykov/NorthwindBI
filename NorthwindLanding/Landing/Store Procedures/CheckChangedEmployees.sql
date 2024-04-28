CREATE PROCEDURE [Landing].[CheckChangedEmployees]
	@AreThereAnyChangesInEmployees AS BIT OUTPUT
AS BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			ALTER TABLE [Landing].[Employees] ADD CONSTRAINT [PK_Landing_Employees]
				PRIMARY KEY CLUSTERED ( [EmployeeID] ASC );

				UPDATE [Landing].[Employees]
				SET [HashDiff] = CAST (
									 HASHBYTES ( 
										  N'MD5'
										, CONCAT (
											  ISNULL ( [LastName], N'' ), N'#'
											, ISNULL ( [FirstName], N'' ), N'#'
											, ISNULL ( [Title], N'' ), N'#'
											, ISNULL ( [TitleOfCourtesy], N'' ), N'#'
											, ISNULL ( [City], N'' ), N'#'
											, ISNULL ( [Country], N'' )
										)
									)
								AS VARBINARY(100)
								);

				SET @AreThereAnyChangesInEmployees = ( SELECT COUNT(*) FROM [Landing].[ChangedEmployees] )
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END