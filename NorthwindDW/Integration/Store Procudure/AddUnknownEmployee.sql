CREATE PROCEDURE [Integration].[AddUnknownEmployee]
      @StartDate AS DATE
    , @LineageKey AS INT
AS BEGIN
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
        , [LineageKey]
    ) VALUES (
          -1
        , -1
        , 'N/A'
        , NULL
        , NULL
        , NULL
        , NULL
        , @StartDate
        , NULL
        , 1
        , @LineageKey
    )
END