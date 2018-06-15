SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[periodos] (
		[id_periodo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_locacion]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_per]                   [int] NOT NULL,
		[_days]                  [tinyint] NOT NULL,
		[ini_date]               [datetime] NOT NULL,
		[end_date]               [datetime] NOT NULL,
		[ini_nat_date]           [datetime] NOT NULL,
		[end_nat_date]           [datetime] NOT NULL,
		[_year]                  [smallint] NOT NULL,
		[_cerrado]               [bit] NOT NULL,
		[_dia_cierre]            [datetime] NULL,
		[active]                 [int] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_actual]                [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[periodos]
	ADD
	CONSTRAINT [PK__periodos__801188B72BA0101B]
	PRIMARY KEY
	CLUSTERED
	([id_periodo])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[periodos]
	ADD
	CONSTRAINT [DF__periodos___actua__3F1C4B12]
	DEFAULT ((0)) FOR [_actual]
GO
ALTER TABLE [cat].[periodos]
	ADD
	CONSTRAINT [DF__periodos___cerra__7BB05806]
	DEFAULT ((0)) FOR [_cerrado]
GO
ALTER TABLE [cat].[periodos]
	ADD
	CONSTRAINT [DF__periodos__active__7CA47C3F]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[periodos]
	ADD
	CONSTRAINT [DF__periodos__id_per__7ABC33CD]
	DEFAULT (newid()) FOR [id_periodo]
GO
ALTER TABLE [cat].[periodos]
	ADD
	CONSTRAINT [DF__periodos__insert__7D98A078]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[periodos]
	ADD
	CONSTRAINT [DF__periodos__update__7E8CC4B1]
	DEFAULT (getdate()) FOR [update_date]
GO
CREATE NONCLUSTERED INDEX [nci_ini_date]
	ON [cat].[periodos] ([ini_date])
	ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [nci_per_year]
	ON [cat].[periodos] ([_per], [_year])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[periodos] SET (LOCK_ESCALATION = TABLE)
GO
