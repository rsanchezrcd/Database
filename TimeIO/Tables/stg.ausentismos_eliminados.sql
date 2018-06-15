SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stg].[ausentismos_eliminados] (
		[id_tra_ausentismo]      [int] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[active]                 [bit] NOT NULL,
		[id_ausentismo]          [char](36) NOT NULL,
		[_ausentismo_date]       [datetime] NOT NULL,
		[employee_id]            [char](36) NOT NULL,
		[_cN]                    [nvarchar](3) NOT NULL,
		[id_periodo]             [char](36) NOT NULL,
		[_sync]                  [bit] NOT NULL,
		[_folio]                 [nvarchar](10) NULL,
		[_ps_type]               [char](1) NULL
)
GO
ALTER TABLE [stg].[ausentismos_eliminados] SET (LOCK_ESCALATION = TABLE)
GO
