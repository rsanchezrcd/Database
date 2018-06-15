SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[role_elemento] (
		[id_rol_elemento]        [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[active]                 [bit] NOT NULL,
		[id_role]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_table]                 [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_id_column_name]        [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_id_elemento]           [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_table_destino]         [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_full]                  [bit] NULL,
		[_read]                  [bit] NULL,
		[_write]                 [bit] NULL,
		[_special]               [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[role_elemento]
	ADD
	CONSTRAINT [PK__role_ele__1B28FE6947D2B2B8]
	PRIMARY KEY
	CLUSTERED
	([id_rol_elemento])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[role_elemento]
	ADD
	CONSTRAINT [DF__role_elem__activ__53E25DCE]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[role_elemento]
	ADD
	CONSTRAINT [DF__role_elem__id_ro__51FA155C]
	DEFAULT (newid()) FOR [id_rol_elemento]
GO
ALTER TABLE [cat].[role_elemento]
	ADD
	CONSTRAINT [DF__role_elem__inser__52EE3995]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[role_elemento]
	WITH CHECK
	ADD CONSTRAINT [FK_role_elemento_roles]
	FOREIGN KEY ([id_role]) REFERENCES [cat].[roles] ([id_role])
ALTER TABLE [cat].[role_elemento]
	CHECK CONSTRAINT [FK_role_elemento_roles]

GO
ALTER TABLE [cat].[role_elemento] SET (LOCK_ESCALATION = TABLE)
GO
