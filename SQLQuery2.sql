﻿USE [Зинуков Денис Витальевич]
GO

DECLARE	@return_value Int

EXEC	@return_value = [Integration].[TrancateDWH]

SELECT	@return_value as 'Return Value'

GO
