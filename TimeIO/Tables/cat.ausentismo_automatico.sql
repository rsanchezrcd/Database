SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[ausentismo_automatico] (
		[id]                     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[id_locacion]            [char](36) NOT NULL,
		[id_ausentismo]          [char](36) NOT NULL,
		[_clase]                 [nvarchar](6) NULL,
		[_week_day]              [int] NOT NULL
)
GO
ALTER TABLE [cat].[ausentismo_automatico] SET (LOCK_ESCALATION = TABLE)
GO
