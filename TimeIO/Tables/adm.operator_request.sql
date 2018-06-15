SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[operator_request] (
		[id_operator_request]     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]             [datetime] NOT NULL,
		[insert_operator_id]      [char](36) NOT NULL,
		[update_date]             [datetime] NULL,
		[update_operator_id]      [char](36) NULL,
		[active]                  [bit] NOT NULL,
		[id_employee]             [char](36) NOT NULL,
		[id_role]                 [char](36) NOT NULL,
		[id_locacion]             [char](36) NOT NULL,
		[_correo]                 [nvarchar](64) NOT NULL,
		[_atendida]               [bit] NULL,
		[id_email]                [char](36) NOT NULL
)
GO
ALTER TABLE [adm].[operator_request] SET (LOCK_ESCALATION = TABLE)
GO
