SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[empresas] (
		[empresa_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[country_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_empresa_name]          [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_empresa_code]          [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_rfc]                   [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_phone]                 [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_domain]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[empresas]
	ADD
	CONSTRAINT [PK__empresas__536BE4A2FECEED85]
	PRIMARY KEY
	CLUSTERED
	([empresa_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[empresas]
	ADD
	CONSTRAINT [DF__empresas__active__3C69FB99]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[empresas]
	ADD
	CONSTRAINT [DF__empresas__empres__3B75D760]
	DEFAULT (newid()) FOR [empresa_id]
GO
ALTER TABLE [cat].[empresas]
	ADD
	CONSTRAINT [DF__empresas__insert__3D5E1FD2]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[empresas]
	ADD
	CONSTRAINT [DF__empresas__insert__3E52440B]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[empresas]
	ADD
	CONSTRAINT [DF__empresas__update__3F466844]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[empresas] SET (LOCK_ESCALATION = TABLE)
GO
