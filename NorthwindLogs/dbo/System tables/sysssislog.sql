CREATE TABLE [dbo].[sysssislog] (
	  [Id]			INT					IDENTITY(1,1)	NOT NULL
	, [event]		SYSNAME				NOT NULL
	, [computer]	NVARCHAR(128)		NOT NULL
	, [operator]	NVARCHAR(128)		NOT NULL
	, [source]		NVARCHAR(1024)		NOT NULL
	, [sourceid]	UNIQUEIDENTIFIER	NOT NULL
	, [executionid]	UNIQUEIDENTIFIER	NOT NULL
	, [starttime]	datetime			NOT NULL
	, [endtime]		datetime			NOT NULL
	, [datacode]	INT					NOT NULL
	, [databytes]	IMAGE				NULL
	, [message]		NVARCHAR(2048)		NOT NULL

    , CONSTRAINT [PK_dbo_sysssislog] PRIMARY KEY CLUSTERED ( [Id] ASC )
)
