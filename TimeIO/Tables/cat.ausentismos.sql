SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[ausentismos] (
		[id_ausentismo]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_letra]                 [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_color]                 [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_max_periodo]           [int] NOT NULL,
		[_dias_atras]            [int] NOT NULL,
		[_descripcion]           [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_alter_id]              [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_descuenta]             [bit] NOT NULL,
		[_asistencia]            [bit] NULL,
		[_permitido]             [bit] NULL,
		[_reescribible]          [bit] NULL,
		[_futuro]                [bit] NULL,
		[_reportes]              [bit] NULL,
		[id_role]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_requiere_jornada]      [bit] NULL,
		CONSTRAINT [UQ__ausentis__AA70E54050674643]
		UNIQUE
		NONCLUSTERED
		([_letra])
		ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [PK__ausentis__1725B3E0F517708C]
	PRIMARY KEY
	CLUSTERED
	([id_ausentismo])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism___asis__56F3D4A3]
	DEFAULT ((0)) FOR [_asistencia]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism___desc__46335CF5]
	DEFAULT ((0)) FOR [_descuenta]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism___dias__453F38BC]
	DEFAULT ((3)) FOR [_dias_atras]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism___futu__1A3FCC1E]
	DEFAULT ((0)) FOR [_futuro]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism___max___444B1483]
	DEFAULT ((16)) FOR [_max_periodo]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism___repo__452A2A23]
	DEFAULT ((0)) FOR [_reportes]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism___requ__5EB4F1FC]
	DEFAULT ((0)) FOR [_requiere_jornada]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism__activ__4262CC11]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism__id_au__416EA7D8]
	DEFAULT (newid()) FOR [id_ausentismo]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF__ausentism__inser__4356F04A]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[ausentismos]
	ADD
	CONSTRAINT [DF_ausentismos__reescribible]
	DEFAULT ((0)) FOR [_reescribible]
GO
ALTER TABLE [cat].[ausentismos] SET (LOCK_ESCALATION = TABLE)
GO
