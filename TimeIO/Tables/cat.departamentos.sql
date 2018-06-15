SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[departamentos] (
		[id_departamento]        [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_departamento_name]     [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_departamento_code]     [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_father_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[departamentos]
	ADD
	CONSTRAINT [PK__departam__75D30A9C4408E078]
	PRIMARY KEY
	CLUSTERED
	([id_departamento])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[departamentos]
	ADD
	CONSTRAINT [DF__departame__activ__37A5467C]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[departamentos]
	ADD
	CONSTRAINT [DF__departame__depar__36B12243]
	DEFAULT (newid()) FOR [id_departamento]
GO
ALTER TABLE [cat].[departamentos]
	ADD
	CONSTRAINT [DF__departame__inser__38996AB5]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[departamentos]
	ADD
	CONSTRAINT [DF__departame__inser__398D8EEE]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[departamentos]
	ADD
	CONSTRAINT [DF__departame__updat__3A81B327]
	DEFAULT (getdate()) FOR [update_date]
GO
CREATE UNIQUE NONCLUSTERED INDEX [nci]
	ON [cat].[departamentos] ([_departamento_code])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[departamentos] SET (LOCK_ESCALATION = TABLE)
GO
