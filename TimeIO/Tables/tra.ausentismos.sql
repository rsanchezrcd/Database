SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[ausentismos] (
		[id_tra_ausentismo]      [int] IDENTITY(1, 1) NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[active]                 [bit] NOT NULL,
		[id_ausentismo]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_ausentismo_date]       [datetime] NOT NULL,
		[employee_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_cN]                    [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_periodo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_sync]                  [bit] NULL,
		[_deleted]               [bit] NULL,
		[_folio]                 [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_ps_type]               [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_comentarios_viejo]     [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_viejo]                 [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [tra].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism__activ__2FA4FD58]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [tra].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism__inser__6DD739FB]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism__updat__6ECB5E34]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [tra].[ausentismos]
	ADD
	CONSTRAINT [DF_ausentismos__sync]
	DEFAULT ((0)) FOR [_sync]
GO
CREATE UNIQUE CLUSTERED INDEX [ci_id_tra_ausentismo]
	ON [tra].[ausentismos] ([id_tra_ausentismo])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [nci_ausentismo_date]
	ON [tra].[ausentismos] ([_ausentismo_date])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Folio de Incapacidad', 'SCHEMA', N'tra', 'TABLE', N'ausentismos', 'COLUMN', N'_folio'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Tipo de Incapacidad PS', 'SCHEMA', N'tra', 'TABLE', N'ausentismos', 'COLUMN', N'_ps_type'
GO
ALTER TABLE [tra].[ausentismos] SET (LOCK_ESCALATION = TABLE)
GO
