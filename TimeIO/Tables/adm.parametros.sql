SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[parametros] (
		[id_parametro]           [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_parametro]             [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_valor]                 [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_convert_to]            [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [UQ__parametr__0A5B9A536542B93B]
		UNIQUE
		NONCLUSTERED
		([_parametro])
		ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [adm].[parametros]
	ADD
	CONSTRAINT [PK__parametr__3D24E325F77BBF3C]
	PRIMARY KEY
	CLUSTERED
	([id_parametro])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[parametros]
	ADD
	CONSTRAINT [DF__parametro___conv__25A691D2]
	DEFAULT ('varchar') FOR [_convert_to]
GO
ALTER TABLE [adm].[parametros]
	ADD
	CONSTRAINT [DF__parametro__activ__269AB60B]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[parametros]
	ADD
	CONSTRAINT [DF__parametro__id_pa__24B26D99]
	DEFAULT (newid()) FOR [id_parametro]
GO
ALTER TABLE [adm].[parametros]
	ADD
	CONSTRAINT [DF__parametro__inser__278EDA44]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[parametros]
	ADD
	CONSTRAINT [DF__parametro__updat__2882FE7D]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [adm].[parametros] SET (LOCK_ESCALATION = TABLE)
GO
