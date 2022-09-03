CREATE PROCEDURE [Integration].[ExtractProductFromLanding] AS
BEGIN
	SELECT		  [ProductAlterKey]
				, [Product]
				, [Category]

	FROM		[Landing].[ProductV]
END;
GO