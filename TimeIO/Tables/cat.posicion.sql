SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[posicion] (
		[posicion_id]            [char](36) NOT NULL,
		[_posicion_name]         [varchar](32) NOT NULL,
		[_posicion_code]         [varchar](32) NULL,
		[_father_id]             [char](36) NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_festivos]              [bit] NULL,
		[_horas_extras]          [bit] NULL,
		[_prima_dominical]       [bit] NULL,
		[_horas_nocturnas]       [bit] NULL,
		[_jornada]               [smallint] NULL
)
GO
ALTER TABLE [cat].[posicion] SET (LOCK_ESCALATION = TABLE)
GO
