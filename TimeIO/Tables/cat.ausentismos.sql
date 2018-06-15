SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[ausentismos] (
		[id_ausentismo]          [char](36) NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_letra]                 [char](1) NOT NULL,
		[_color]                 [nvarchar](64) NOT NULL,
		[_max_periodo]           [int] NOT NULL,
		[_dias_atras]            [int] NOT NULL,
		[_descripcion]           [nvarchar](128) NOT NULL,
		[_alter_id]              [nvarchar](32) NULL,
		[_descuenta]             [bit] NOT NULL,
		[_asistencia]            [bit] NULL,
		[_permitido]             [bit] NULL,
		[_reescribible]          [bit] NULL,
		[_futuro]                [bit] NULL,
		[_reportes]              [bit] NULL,
		[id_role]                [char](36) NULL,
		[_requiere_jornada]      [bit] NULL
)
GO
ALTER TABLE [cat].[ausentismos] SET (LOCK_ESCALATION = TABLE)
GO
