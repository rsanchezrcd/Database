SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[jornadas] (
		[id_jornada]                [char](36) NOT NULL,
		[insert_date]               [datetime] NOT NULL,
		[update_date]               [datetime] NOT NULL,
		[employee_id]               [char](36) NOT NULL,
		[id_checada_entrada]        [char](36) NOT NULL,
		[_entrada]                  [datetime] NOT NULL,
		[_fecha_ent]                [date] NOT NULL,
		[_hora_ent]                 [time](7) NOT NULL,
		[_dispositivo_code_ent]     [nvarchar](64) NOT NULL,
		[id_checada_salida]         [char](36) NULL,
		[_salida]                   [datetime] NULL,
		[_fecha_sal]                [date] NULL,
		[_hora_sal]                 [time](7) NULL,
		[_dispositivo_code_sal]     [nvarchar](64) NULL,
		[_jornada]                  [int] NULL,
		[_cN]                       [nvarchar](3) NOT NULL,
		[id_periodo]                [char](36) NOT NULL,
		[_sync]                     [bit] NOT NULL
)
GO
ALTER TABLE [tra].[jornadas] SET (LOCK_ESCALATION = TABLE)
GO
