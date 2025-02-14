CREATE PROCEDURE [Integration].[AddUnknownEmployee]
      @EmployeeAlterKey AS INT
    , @Employee AS NVARCHAR(35)
    , @AllAttributes AS NVARCHAR(MAX)
    , @StartDate AS DATE
    , @LineageKey AS BIGINT
AS BEGIN
    INSERT INTO [Dimension].[Employee] (
          [EmployeeKey]
        , [EmployeeAlterKey]
        , [Employee]
        , [Title]
        , [TitleOfCourtesy]
        , [City]
        , [Country]
        , [AllAttributes]
        , [StartDate]
        , [EndDate]
        , [Current]
        , [LineageKey]
    ) VALUES (
          -1
        , @EmployeeAlterKey
        , @Employee
        , NULL
        , NULL
        , NULL
        , NULL
        , @AllAttributes
        , @StartDate
        , NULL
        , 1
        , @LineageKey
    );
END