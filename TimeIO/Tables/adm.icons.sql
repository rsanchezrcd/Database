SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[icons] (
		[id_icon]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[icon]            [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]          [bit] NULL,
		[insert_date]     [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[icons]
	ADD
	CONSTRAINT [DF__icons__id_icon__086B34A6]
	DEFAULT (newid()) FOR [id_icon]
GO
ALTER TABLE [adm].[icons]
	ADD
	CONSTRAINT [DF__icons__insert_da__095F58DF]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[icons] SET (LOCK_ESCALATION = TABLE)
GO
