SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[dominios] (
		[id_dominio]      [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]          [bit] NOT NULL,
		[insert_date]     [datetime] NOT NULL,
		[_ou_grupo]       [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_base_dn]        [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_host]           [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_port]           [int] NOT NULL,
		[_grupo]          [nvarchar](54) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_bind_user]      [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_bind_pass]      [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[dominios]
	ADD
	CONSTRAINT [PK__dominios__8A741A6AF3AA8C06]
	PRIMARY KEY
	CLUSTERED
	([id_dominio])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[dominios]
	ADD
	CONSTRAINT [DF__dominios___port__157B1701]
	DEFAULT ((389)) FOR [_port]
GO
ALTER TABLE [adm].[dominios]
	ADD
	CONSTRAINT [DF__dominios__active__1392CE8F]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[dominios]
	ADD
	CONSTRAINT [DF__dominios__insert__1486F2C8]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[dominios] SET (LOCK_ESCALATION = TABLE)
GO
