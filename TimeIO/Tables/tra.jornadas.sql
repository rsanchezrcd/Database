SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[jornadas] (
		[id_jornada]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]               [datetime] NOT NULL,
		[update_date]               [datetime] NOT NULL,
		[employee_id]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_checada_entrada]        [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_entrada]                  [datetime] NOT NULL,
		[_fecha_ent]                [date] NOT NULL,
		[_hora_ent]                 [time](7) NOT NULL,
		[_dispositivo_code_ent]     [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_checada_salida]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_salida]                   [datetime] NULL,
		[_fecha_sal]                [date] NULL,
		[_hora_sal]                 [time](7) NULL,
		[_dispositivo_code_sal]     [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_jornada]                  [int] NULL,
		[_cN]                       [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_periodo]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_sync]                     [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [tra].[jornadas]
	ADD
	CONSTRAINT [PK__jornadas__6BD46D1A3F1AEEE2]
	PRIMARY KEY
	CLUSTERED
	([id_jornada])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[jornadas]
	ADD
	CONSTRAINT [DF__jornadas___sync__2101D846]
	DEFAULT ((0)) FOR [_sync]
GO
ALTER TABLE [tra].[jornadas]
	ADD
	CONSTRAINT [DF__jornadas__id_jor__1E256B9B]
	DEFAULT (newid()) FOR [id_jornada]
GO
ALTER TABLE [tra].[jornadas]
	ADD
	CONSTRAINT [DF__jornadas__insert__1F198FD4]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[jornadas]
	ADD
	CONSTRAINT [DF__jornadas__update__200DB40D]
	DEFAULT (getdate()) FOR [update_date]
GO
CREATE UNIQUE NONCLUSTERED INDEX [unique_empleado_checada_entrada]
	ON [tra].[jornadas] ([employee_id], [id_checada_entrada])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[jornadas] SET (LOCK_ESCALATION = TABLE)
GO
