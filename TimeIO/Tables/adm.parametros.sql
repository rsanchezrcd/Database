SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[parametros] (
		[id_parametro]           [char](36) NOT NULL,
		[_parametro]             [nvarchar](32) NOT NULL,
		[_valor]                 [nvarchar](256) NOT NULL,
		[_convert_to]            [nvarchar](32) NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL
)
GO
ALTER TABLE [adm].[parametros] SET (LOCK_ESCALATION = TABLE)
GO
