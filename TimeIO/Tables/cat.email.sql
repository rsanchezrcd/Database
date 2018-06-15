SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[email] (
		[id_email]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                 [bit] NOT NULL,
		[_domain]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[email]
	ADD
	CONSTRAINT [PK__email__F3B378DFAD7E4A81]
	PRIMARY KEY
	CLUSTERED
	([id_email])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[email]
	ADD
	CONSTRAINT [DF__email__active__67B44C51]
	DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [cat].[email]
	ADD
	CONSTRAINT [DF__email__id_email__65CC03DF]
	DEFAULT (newid()) FOR [id_email]
GO
ALTER TABLE [cat].[email]
	ADD
	CONSTRAINT [DF__email__insert_da__66C02818]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[email] SET (LOCK_ESCALATION = TABLE)
GO
