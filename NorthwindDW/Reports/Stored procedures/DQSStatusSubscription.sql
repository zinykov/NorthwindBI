CREATE PROCEDURE [Reports].[DQSStatusSubscription]
AS BEGIN
	IF OBJECT_ID ( N'#tempDQSstatus' ) IS NOT NULL
		BEGIN
			DROP TABLE #tempDQSstatus
		END
			
	CREATE TABLE #tempDQSstatus (
		  [Table] NVARCHAR(50)
		, [Record_Status] NVARCHAR(50)
		, [Row Count] INT
	)
	
	INSERT #tempDQSstatus EXECUTE [Reports].[DQS_status];
		
	IF EXISTS ( SELECT 1 FROM #tempDQSstatus WHERE [Record_Status] NOT IN ( 'Correct' ) )
		BEGIN
			SELECT	  [Кому]				=	'zinykov@hotmail.com'
					, [Копия]				=	NULL
					, [СК]					=	NULL
					, [Обратный адрес]		=	NULL
					, [Включить отчет]		=	CAST ( 1 AS bit )
					, [Формат отображения]	=	'MHTML'
					, [Приоритет]			=	'Normal'
					, [Тема]				=	'DQS Cleansing projects status'
					, [Комментарий]			=	NULL
					, [Включить ссылку]		=	CAST ( 1 AS bit )
		END
			
	DROP TABLE #tempDQSstatus;
END