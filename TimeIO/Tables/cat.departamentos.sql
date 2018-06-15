SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[departamentos] (
		[id_departamento]        [char](36) NOT NULL,
		[_departamento_name]     [varchar](32) NOT NULL,
		[_departamento_code]     [varchar](32) NULL,
		[_father_id]             [char](36) NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
)
GO
ALTER TABLE [cat].[departamentos] SET (LOCK_ESCALATION = TABLE)
GO
