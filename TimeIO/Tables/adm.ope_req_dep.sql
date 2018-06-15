SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[ope_req_dep] (
		[id]                      [int] IDENTITY(1, 1) NOT NULL,
		[id_operator_request]     [int] NOT NULL,
		[insert_date]             [datetime] NOT NULL,
		[id_departamento]         [char](36) NULL
)
GO
ALTER TABLE [adm].[ope_req_dep] SET (LOCK_ESCALATION = TABLE)
GO
