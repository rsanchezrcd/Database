SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[festivo] (
		[id_festivo]             [char](36) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_date]            [datetime] NULL,
		[update_operator_id]     [char](36) NULL,
		[active]                 [bit] NOT NULL,
		[_festivo_date]          [date] NOT NULL,
		[_festivo_desc]          [nvarchar](128) NULL,
		[id_locacion]            [char](36) NOT NULL,
		[_calificado]            [bit] NULL
)
GO
ALTER TABLE [cat].[festivo] SET (LOCK_ESCALATION = TABLE)
GO
