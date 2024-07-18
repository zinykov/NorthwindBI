CREATE PROCEDURE [Landing].[CheckChangedEmployees]
	@AreThereAnyChangesInEmployees AS BIT OUTPUT
AS BEGIN
	ALTER TABLE [Landing].[Employees] ADD CONSTRAINT [PK_Landing_Employees]
		PRIMARY KEY CLUSTERED ( [EmployeeID] ASC )

	UPDATE [Landing].[Employees]
	SET [HashDiff] = CAST (
							HASHBYTES ( 
							  N'SHA2_512'
							, CONCAT (
								  ISNULL ( [LastName], N'' ), N'#'
								, ISNULL ( [FirstName], N'' ), N'#'
								, ISNULL ( [Title], N'' ), N'#'
								, ISNULL ( [TitleOfCourtesy], N'' ), N'#'
								, ISNULL ( [City], N'' ), N'#'
								, ISNULL ( [Country], N'' )
							)
						)
					AS VARBINARY(64)
					)
	
	CREATE INDEX [IX_Landing_Employees_HashDiff] ON [Landing].[Employees] ( [HashDiff] ASC )

	SET @AreThereAnyChangesInEmployees = ( SELECT COUNT(*) FROM [Landing].[ChangedEmployees] )
END