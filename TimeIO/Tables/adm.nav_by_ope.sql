SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[nav_by_ope] (
		[id]                     [int] IDENTITY(1, 1) NOT NULL,
		[id_operator]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_navigator]           [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_full]                  [bit] NOT NULL,
		[_read]                  [bit] NOT NULL,
		[_write]                 [bit] NOT NULL,
		[_special]               [bit] NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[nav_by_ope]
	ADD
	CONSTRAINT [PK__nav_by_o__3213E83F1F61E71A]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[nav_by_ope]
	ADD
	CONSTRAINT [DF__nav_by_op___full__3296789C]
	DEFAULT ((0)) FOR [_full]
GO
ALTER TABLE [adm].[nav_by_ope]
	ADD
	CONSTRAINT [DF__nav_by_op___read__338A9CD5]
	DEFAULT ((1)) FOR [_read]
GO
ALTER TABLE [adm].[nav_by_ope]
	ADD
	CONSTRAINT [DF__nav_by_op___spec__3572E547]
	DEFAULT ((0)) FOR [_special]
GO
ALTER TABLE [adm].[nav_by_ope]
	ADD
	CONSTRAINT [DF__nav_by_op___writ__347EC10E]
	DEFAULT ((0)) FOR [_write]
GO
ALTER TABLE [adm].[nav_by_ope]
	ADD
	CONSTRAINT [DF__nav_by_op__activ__36670980]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[nav_by_ope]
	ADD
	CONSTRAINT [DF__nav_by_op__inser__375B2DB9]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[nav_by_ope]
	ADD
	CONSTRAINT [DF__nav_by_op__updat__384F51F2]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [adm].[nav_by_ope]
	WITH CHECK
	ADD CONSTRAINT [FK_navbyope_to_navigator]
	FOREIGN KEY ([id_navigator]) REFERENCES [adm].[navigator] ([id_navigator])
	ON DELETE CASCADE
ALTER TABLE [adm].[nav_by_ope]
	CHECK CONSTRAINT [FK_navbyope_to_navigator]

GO
ALTER TABLE [adm].[nav_by_ope]
	WITH CHECK
	ADD CONSTRAINT [FK_navbyope_to_operator]
	FOREIGN KEY ([id_operator]) REFERENCES [cat].[operator] ([operator_id])
	ON DELETE CASCADE
ALTER TABLE [adm].[nav_by_ope]
	CHECK CONSTRAINT [FK_navbyope_to_operator]

GO
CREATE UNIQUE NONCLUSTERED INDEX [nci_nav_ope]
	ON [adm].[nav_by_ope] ([id_operator], [id_navigator])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[nav_by_ope] SET (LOCK_ESCALATION = TABLE)
GO
