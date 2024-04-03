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