SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[conexiones] (
		[id_conexion]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_name]                  [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_engine]                [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_server]                [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_port]                  [int] NULL,
		[_user]                  [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_pass]                  [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_data]                  [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[conexiones]
	ADD
	CONSTRAINT [PK__conexion__99B939BA24DF0868]
	PRIMARY KEY
	CLUSTERED
	([id_conexion])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[conexiones]
	ADD
	CONSTRAINT [DF__conexione___engi__39AD8A7F]
	DEFAULT ('SQLServer') FOR [_engine]
GO
ALTER TABLE [adm].[conexiones]
	ADD
	CONSTRAINT [DF__conexione__activ__3AA1AEB8]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[conexiones]
	ADD
	CONSTRAINT [DF__conexione__id_co__38B96646]
	DEFAULT (newid()) FOR [id_conexion]
GO
ALTER TABLE [adm].[conexiones]
	ADD
	CONSTRAINT [DF__conexione__inser__3B95D2F1]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[conexiones]
	ADD
	CONSTRAINT [DF__conexione__updat__3C89F72A]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [adm].[conexiones] SET (LOCK_ESCALATION = TABLE)
GO
