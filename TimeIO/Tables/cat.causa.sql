SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[causa] (
		[id_causa]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]            [datetime] NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[update_date]            [datetime] NULL,
		[activo]                 [bit] NULL,
		[id_ausentismo]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_causa]                 [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_comentarios]           [bit] NOT NULL,
		[_requiere_fecha]        [bit] NOT NULL,
		[_min_fecha]             [date] NULL,
		[_max_fecha]             [date] NULL,
		[id_role]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_valida_festivo]        [bit] NULL,
		[_auto]                  [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[causa]
	ADD
	CONSTRAINT [PK__causa__D200EA9B1F66967D]
	PRIMARY KEY
	CLUSTERED
	([id_causa])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[causa]
	ADD
	CONSTRAINT [DF__causa___comentar__224B023A]
	DEFAULT ((0)) FOR [_comentarios]
GO
ALTER TABLE [cat].[causa]
	ADD
	CONSTRAINT [DF__causa___requiere__1B33F057]
	DEFAULT ((0)) FOR [_requiere_fecha]
GO
ALTER TABLE [cat].[causa]
	ADD
	CONSTRAINT [DF__causa___valida_f__61C668D1]
	DEFAULT ((0)) FOR [_valida_festivo]
GO
ALTER TABLE [cat].[causa]
	ADD
	CONSTRAINT [DF__causa__activo__2156DE01]
	DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [cat].[causa]
	ADD
	CONSTRAINT [DF__causa__id_causa__1F6E958F]
	DEFAULT (newid()) FOR [id_causa]
GO
ALTER TABLE [cat].[causa]
	ADD
	CONSTRAINT [DF__causa__insert_da__2062B9C8]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[causa]
	ADD
	CONSTRAINT [DF_causa__auto]
	DEFAULT ((0)) FOR [_auto]
GO
ALTER TABLE [cat].[causa] SET (LOCK_ESCALATION = TABLE)
GO
