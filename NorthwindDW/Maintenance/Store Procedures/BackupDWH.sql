﻿CREATE PROCEDURE [Maintenance].[BackupDWH]
	@CutoffTime AS DATE
AS
/*
    Процедура объединяет секции таблицы фактов.

    Алгоритм:
        1. Проверка даты запуска, если суббота, то запускать полный backup
*/
BEGIN
	--DECLARE @CutoffTime		    AS DATE;
	DECLARE @ReferenceDate      AS DATE;
    DECLARE @StartYearDate      AS DATE;
	DECLARE @EndYearDate	    AS DATE;
	DECLARE @StartKey		    AS INT;
	DECLARE @EndKey			    AS INT;
	DECLARE @Bondaries		    AS NVARCHAR(2000);
	DECLARE @CreatePF		    AS NVARCHAR(4000);
	DECLARE @CreatePS		    AS NVARCHAR(4000);
    DECLARE @PartitionNumber    AS INT;
    DECLARE @PartitionValue     AS INT;
    
	--SET @CutoffTime = DATEFROMPARTS ( 1998, 5, 3 )


END