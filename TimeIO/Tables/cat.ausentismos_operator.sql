SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[ausentismos_operator] (
		[id_ausentismos_operator]     [char](36) NOT NULL,
		[active]                      [bit] NOT NULL,
		[insert_operator_id]          [char](36) NOT NULL,
		[update_operator_id]          [char](36) NULL,
		[insert_date]                 [datetime] NULL,
		[update_date]                 [datetime] NULL,
		[id_operator]                 [char](36) NOT NULL,
		[id_ausentismo]               [char](36) NOT NULL
)
GO
ALTER TABLE [cat].[ausentismos_operator] SET (LOCK_ESCALATION = TABLE)
GO
