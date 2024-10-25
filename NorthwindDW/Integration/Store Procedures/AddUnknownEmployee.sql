CREATE PROCEDURE [Integration].[AddUnknownEmployee]
      @StartDate AS DATE
    , @LineageKey AS BIGINT
AS BEGIN
    IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Employee] WHERE [EmployeeKey] = -1 )
    INSERT INTO [Dimension].[Employee] (
          [EmployeeKey]
        , [EmployeeAlterKey]
        , [Employee]
        , [Title]
        , [TitleOfCourtesy]
        , [City]
        , [Country]
        , [AllAttributies]
        , [StartDate]
        , [EndDate]
        , [Current]
        , [LineageKey]
    ) VALUES (
          -1
        , -1
        , N'N/A'
        , NULL
        , NULL
        , NULL
        , NULL
        , N'{}'
        , @StartDate
        , NULL
        , 1
        , @LineageKey
    );
END