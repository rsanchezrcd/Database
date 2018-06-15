SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[posicion] (
		[posicion_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_posicion_name]         [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_posicion_code]         [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_father_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_festivos]              [bit] NULL,
		[_horas_extras]          [bit] NULL,
		[_prima_dominical]       [bit] NULL,
		[_horas_nocturnas]       [bit] NULL,
		[_jornada]               [smallint] NULL,
		CONSTRAINT [UQ__posicion__E2D6B60169BA7DC9]
		UNIQUE
		NONCLUSTERED
		([_posicion_code])
		ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [PK__posicion__8343A4EA080AB60C]
	PRIMARY KEY
	CLUSTERED
	([posicion_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF__posicion__active__222B06A9]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF__posicion__insert__231F2AE2]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF__posicion__insert__24134F1B]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF__posicion__posici__2136E270]
	DEFAULT (newid()) FOR [posicion_id]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF__posicion__update__25077354]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF_posicion__festivos]
	DEFAULT ((0)) FOR [_festivos]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF_posicion__horas_extras]
	DEFAULT ((0)) FOR [_horas_extras]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF_posicion__horas_nocturnas]
	DEFAULT ((0)) FOR [_horas_nocturnas]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF_posicion__jornada]
	DEFAULT ((8)) FOR [_jornada]
GO
ALTER TABLE [cat].[posicion]
	ADD
	CONSTRAINT [DF_posicion__prima_dominical]
	DEFAULT ((0)) FOR [_prima_dominical]
GO
ALTER TABLE [cat].[posicion] SET (LOCK_ESCALATION = TABLE)
GO
