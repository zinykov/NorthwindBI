CREATE ROLE [dwh_user] AUTHORIZATION [dbo];
GO

GRANT SELECT ON SCHEMA::[Reports] TO [dwh_user];
GO

GRANT EXECUTE ON SCHEMA::[Reports] TO [dwh_user];
GO