CREATE PROCEDURE [Integration].[AddUnknownEmployee] AS
BEGIN
    IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Employee] WHERE [EmployeeKey] = -1 )
    INSERT INTO [Dimension].[Employee] (
          [EmployeeKey]
        , [EmployeeAlterKey]
        , [Name]
        , [Title]
        , [TitleOfCourtesy]
        , [City]
        , [Country]
        , [StartDate]
        , [EndDate]
        , [Current]
    ) VALUES (
          -1
        , -1
        , 'N/A'
        , NULL
        , NULL
        , NULL
        , NULL
        , DATEFROMPARTS ( 1996, 01, 01 )
        , NULL
        , NULL
    )
END