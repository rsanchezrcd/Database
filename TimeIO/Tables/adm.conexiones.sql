SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[conexiones] (
		[id_conexion]            [char](36) NOT NULL,
		[_name]                  [varchar](32) NOT NULL,
		[_engine]                [varchar](32) NOT NULL,
		[_server]                [varchar](128) NOT NULL,
		[_port]                  [int] NULL,
		[_user]                  [varchar](32) NULL,
		[_pass]                  [varchar](32) NULL,
		[_data]                  [varchar](32) NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
)
GO
ALTER TABLE [adm].[conexiones] SET (LOCK_ESCALATION = TABLE)
GO
