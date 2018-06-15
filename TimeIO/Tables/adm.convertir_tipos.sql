SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[convertir_tipos] (
		[id_tipo]                [char](36) NOT NULL,
		[_tipo]                  [nvarchar](36) NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL
)
GO
ALTER TABLE [adm].[convertir_tipos] SET (LOCK_ESCALATION = TABLE)
GO
