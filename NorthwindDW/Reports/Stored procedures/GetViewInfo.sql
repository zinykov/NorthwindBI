CREATE PROCEDURE [Reports].[GetViewInfo]
AS BEGIN
		SELECT		  [Schema]		= S.[name]
					, [Table]		= T.[name]
					, [Description]	= SEP.[value]
		FROM		sys.views AS T
		INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]
		LEFT JOIN	sys.extended_properties AS SEP ON T.[object_id] = SEP.[major_id]
					AND SEP.[minor_id] = 0
					AND SEP.[name] = N'MS_Description';
END