/*
Шаблон скрипта после развертывания							
--------------------------------------------------------------------------------------
 В данном файле содержатся инструкции SQL, которые будут добавлены в скрипт построения.		
 Используйте синтаксис SQLCMD для включения файла в скрипт после развертывания.			
 Пример:      :r .\myfile.sql								
 Используйте синтаксис SQLCMD для создания ссылки на переменную в скрипте после развертывания.		
 Пример:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
:r .\Scripts\ResourceGovernor.sql

USE [$(DatabaseName)];
GO

IF NOT EXISTS ( SELECT 1 FROM [Maintenance].[DatabaseFiles] )
BEGIN
	INSERT INTO [Maintenance].[DatabaseFiles] (
		  [GroupName]
		, [IsReadOnly]
		, [Name]
		, [FileName]
	)
		SELECT		  FG.[groupname]
					, FG1.[is_read_only]
					, F.[name]
					, F.[filename]
		FROM		sys.sysfilegroups AS FG
		INNER JOIN	sys.sysfiles AS F ON FG.[groupid] = F.[groupid]
		INNER JOIN	sys.filegroups AS FG1 ON FG.[groupname] = FG1.[name];
END
GO

USE [$(DatabaseName)];
GO

EXECUTE sp_addmessage
	  @MSGNUM = 50001
	, @severity = 16
	, @msgtext = N'Could not find directory ''%s'''
	, @lang = N'us_english'
	, @with_log = TRUE
	, @replace = 'replace';
GO

EXECUTE sp_addmessage
	  @MSGNUM = 50001
	, @severity = 16
	, @msgtext = N'Не удаётся найти папку ''%s'''
	, @lang = N'russian'
	, @replace = 'replace';
GO