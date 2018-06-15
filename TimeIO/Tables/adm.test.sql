SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[test] (
		[testid]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[teststr]         [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[inserted_at]     [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[test]
	ADD
	CONSTRAINT [PK__test__A29AFFE0589C02CD]
	PRIMARY KEY
	CLUSTERED
	([testid])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[test]
	ADD
	CONSTRAINT [DF__test__inserted_a__71C7C670]
	DEFAULT (getdate()) FOR [inserted_at]
GO
ALTER TABLE [adm].[test]
	ADD
	CONSTRAINT [DF__test__testid__70D3A237]
	DEFAULT (newid()) FOR [testid]
GO
ALTER TABLE [adm].[test] SET (LOCK_ESCALATION = TABLE)
GO
