SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[navigator] (
		[id_navigator]           [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_clave]                 [int] IDENTITY(1, 1) NOT NULL,
		[_item_name]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_item_icon]             [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_is_father]             [bit] NOT NULL,
		[_is_child]              [bit] NOT NULL,
		[_father]                [int] NULL,
		[_order]                 [int] NOT NULL,
		[_url]                   [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_title]                 [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_table]                 [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_insert_query]          [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[navigator]
	ADD
	CONSTRAINT [PK__navigato__D08F646483F5F0DC]
	PRIMARY KEY
	CLUSTERED
	([id_navigator])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[navigator]
	ADD
	CONSTRAINT [DF__navigator___is_c__2CDD9F46]
	DEFAULT ((0)) FOR [_is_child]
GO
ALTER TABLE [adm].[navigator]
	ADD
	CONSTRAINT [DF__navigator___is_f__2BE97B0D]
	DEFAULT ((0)) FOR [_is_father]
GO
ALTER TABLE [adm].[navigator]
	ADD
	CONSTRAINT [DF__navigator__activ__2DD1C37F]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[navigator]
	ADD
	CONSTRAINT [DF__navigator__id_na__2AF556D4]
	DEFAULT (newid()) FOR [id_navigator]
GO
ALTER TABLE [adm].[navigator]
	ADD
	CONSTRAINT [DF__navigator__inser__2EC5E7B8]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[navigator]
	ADD
	CONSTRAINT [DF__navigator__updat__2FBA0BF1]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [adm].[navigator] SET (LOCK_ESCALATION = TABLE)
GO
