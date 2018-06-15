SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[fechas] (
		[id_fecha]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[fecha_int]              [int] NOT NULL,
		[fecha_nat]              [datetime] NOT NULL,
		[id_locacion]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_year]                  [int] NOT NULL,
		[_month]                 [int] NOT NULL,
		[_day]                   [int] NOT NULL,
		[_per]                   [int] NOT NULL,
		[_day_week]              [int] NOT NULL,
		[_day_txt]               [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_cN]                    [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_festivo]               [int] NOT NULL,
		[_dia_corte]             [int] NOT NULL,
		[_cerrado]               [int] NOT NULL,
		[active]                 [int] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_etiqueta]              [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_month_txt]             [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[id_periodo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [PK__fechas__E9FBC1BFB46EF10A]
	PRIMARY KEY
	CLUSTERED
	([id_fecha])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [DF__fechas___cerrado__0539C240]
	DEFAULT ((0)) FOR [_cerrado]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [DF__fechas___cN__025D5595]
	DEFAULT ('c00') FOR [_cN]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [DF__fechas___dia_cor__04459E07]
	DEFAULT ((0)) FOR [_dia_corte]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [DF__fechas___festivo__035179CE]
	DEFAULT ((0)) FOR [_festivo]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [DF__fechas__active__062DE679]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [DF__fechas__id_fecha__0169315C]
	DEFAULT (newid()) FOR [id_fecha]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [DF__fechas__insert_d__07220AB2]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[fechas]
	ADD
	CONSTRAINT [DF__fechas__update_d__08162EEB]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [adm].[fechas] SET (LOCK_ESCALATION = TABLE)
GO
