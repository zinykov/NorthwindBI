CREATE PROCEDURE [Landing].[CheckChangedHolidays]
	@AreThereAnyChangesInHolidays AS BIT OUTPUT
AS BEGIN
	ALTER TABLE [Landing].[Holidays] ADD CONSTRAINT [PK_Landing_Holidays]
		PRIMARY KEY CLUSTERED ( [Date] ASC )

	UPDATE [Landing].[Holidays]
	SET [HashDiff] = CAST (
							HASHBYTES ( 
								N'SHA2_512'
							, CONCAT (
									ISNULL ( [DateType], N'' ), N'#'
								, ISNULL ( [HolidayName], N'' )
							)
						)
						AS VARBINARY(64)
					)
	
	CREATE INDEX [IX_Landing_Holidays_HashDiff] ON [Landing].[Holidays] ( [HashDiff] ASC )

	SET @AreThereAnyChangesInHolidays = ( SELECT COUNT(*) FROM [Landing].[ChangedHolidays] )
END