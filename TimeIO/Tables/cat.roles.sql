SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[roles] (
		[id_role]                       [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                        [bit] NOT NULL,
		[insert_operator_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]                   [datetime] NULL,
		[update_date]                   [datetime] NULL,
		[_role_name]                    [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_role_descr]                   [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_order]                        [tinyint] NULL,
		[_aus_max_periodo_override]     [bit] NULL,
		[_aus_dias_atras_override]      [bit] NULL,
		[_he_override]                  [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[roles]
	ADD
	CONSTRAINT [PK__roles__3D48441DE666496A]
	PRIMARY KEY
	CLUSTERED
	([id_role])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[roles]
	ADD
	CONSTRAINT [DF__roles___aus_dias__3E7D2C94]
	DEFAULT ((0)) FOR [_aus_dias_atras_override]
GO
ALTER TABLE [cat].[roles]
	ADD
	CONSTRAINT [DF__roles___aus_max___3D89085B]
	DEFAULT ((0)) FOR [_aus_max_periodo_override]
GO
ALTER TABLE [cat].[roles]
	ADD
	CONSTRAINT [DF__roles___he_overr__583CFE97]
	DEFAULT ((0)) FOR [_he_override]
GO
ALTER TABLE [cat].[roles]
	ADD
	CONSTRAINT [DF__roles__active__5D16C24D]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[roles]
	ADD
	CONSTRAINT [DF__roles__id_role__5C229E14]
	DEFAULT (newid()) FOR [id_role]
GO
ALTER TABLE [cat].[roles]
	ADD
	CONSTRAINT [DF__roles__insert_da__5E0AE686]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[roles]
	ADD
	CONSTRAINT [DF_roles__order]
	DEFAULT ((0)) FOR [_order]
GO
CREATE UNIQUE NONCLUSTERED INDEX [nci_order]
	ON [cat].[roles] ([_order])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[roles] SET (LOCK_ESCALATION = TABLE)
GO
