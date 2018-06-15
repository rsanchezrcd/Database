SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[role_elemento] (
		[id_rol_elemento]        [char](36) NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[active]                 [bit] NOT NULL,
		[id_role]                [char](36) NOT NULL,
		[_table]                 [nvarchar](128) NOT NULL,
		[_id_column_name]        [nvarchar](64) NOT NULL,
		[_id_elemento]           [char](36) NOT NULL,
		[_table_destino]         [nvarchar](128) NULL,
		[_full]                  [bit] NULL,
		[_read]                  [bit] NULL,
		[_write]                 [bit] NULL,
		[_special]               [bit] NULL
)
GO
ALTER TABLE [cat].[role_elemento] SET (LOCK_ESCALATION = TABLE)
GO
