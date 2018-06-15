SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[causa] (
		[id_causa]               [char](36) NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[insert_date]            [datetime] NULL,
		[update_operator_id]     [char](36) NULL,
		[update_date]            [datetime] NULL,
		[activo]                 [bit] NULL,
		[id_ausentismo]          [char](36) NOT NULL,
		[_causa]                 [nvarchar](128) NOT NULL,
		[_comentarios]           [bit] NOT NULL,
		[_requiere_fecha]        [bit] NOT NULL,
		[_min_fecha]             [date] NULL,
		[_max_fecha]             [date] NULL,
		[id_role]                [char](36) NULL,
		[_valida_festivo]        [bit] NULL,
		[_auto]                  [bit] NULL
)
GO
ALTER TABLE [cat].[causa] SET (LOCK_ESCALATION = TABLE)
GO
