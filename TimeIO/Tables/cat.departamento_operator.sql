SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[departamento_operator] (
		[id_departamento_operator]     [char](36) NOT NULL,
		[insert_date]                  [datetime] NOT NULL,
		[insert_operator_id]           [char](36) NOT NULL,
		[id_departamento]              [char](36) NOT NULL,
		[id_operator]                  [char](36) NOT NULL,
		[_favorite]                    [bit] NOT NULL
)
GO
ALTER TABLE [cat].[departamento_operator] SET (LOCK_ESCALATION = TABLE)
GO
