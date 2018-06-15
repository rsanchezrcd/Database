SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[roles] (
		[id_role]                       [char](36) NOT NULL,
		[active]                        [bit] NOT NULL,
		[insert_operator_id]            [char](36) NOT NULL,
		[update_operator_id]            [char](36) NULL,
		[insert_date]                   [datetime] NULL,
		[update_date]                   [datetime] NULL,
		[_role_name]                    [nvarchar](64) NOT NULL,
		[_role_descr]                   [nvarchar](128) NOT NULL,
		[_order]                        [tinyint] NULL,
		[_aus_max_periodo_override]     [bit] NULL,
		[_aus_dias_atras_override]      [bit] NULL,
		[_he_override]                  [bit] NULL
)
GO
ALTER TABLE [cat].[roles] SET (LOCK_ESCALATION = TABLE)
GO
