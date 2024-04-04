USE [$(DatabaseName)];
GO

EXECUTE sp_addmessage
	  @MSGNUM = 50001
	, @severity = 16
	, @msgtext = N'Error #%i in line %i Could not find directory ''%s'''
	, @lang = N'us_english'
	, @with_log = TRUE
	, @replace = 'replace';
GO

EXECUTE sp_addmessage
	  @MSGNUM = 50001
	, @severity = 16
	, @msgtext = N'Ошибка №%i в строке %i Не удаётся найти папку ''%s'''
	, @lang = N'russian'
	, @replace = 'replace';
GO



EXECUTE sp_addmessage
	  @MSGNUM = 50002
	, @severity = 16
	, @msgtext = N'Error #%i in line %i with error message ''%s'''
	, @lang = N'us_english'
	, @with_log = TRUE
	, @replace = 'replace';
GO

EXECUTE sp_addmessage
	  @MSGNUM = 50002
	, @severity = 16
	, @msgtext = N'Ошибка №%i в строке %i, сообщение об ошибке ''%s'''
	, @lang = N'russian'
	, @replace = 'replace';
GO