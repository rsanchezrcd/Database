SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[dispositivo] (
		[id_dispositivo]         [char](36) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[activo]                 [bit] NULL,
		[id_locacion]            [char](36) NOT NULL,
		[_name]                  [nvarchar](50) NOT NULL,
		[_hostname]              [nvarchar](255) NULL,
		[_port]                  [smallint] NULL,
		[_ischecador]            [bit] NULL,
		[_iscomedor]             [bit] NULL,
		[_istest]                [bit] NULL
)
GO
ALTER TABLE [cat].[dispositivo] SET (LOCK_ESCALATION = TABLE)
GO
