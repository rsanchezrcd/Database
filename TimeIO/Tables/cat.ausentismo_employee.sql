SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[ausentismo_employee] (
		[id]                     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_date]            [datetime] NULL,
		[update_operator_id]     [char](36) NULL,
		[active]                 [bit] NOT NULL,
		[id_employee]            [char](36) NOT NULL,
		[id_ausentismo]          [char](36) NOT NULL,
		[_dias_atras]            [int] NOT NULL,
		[_max_periodo]           [int] NOT NULL
)
GO
ALTER TABLE [cat].[ausentismo_employee] SET (LOCK_ESCALATION = TABLE)
GO
