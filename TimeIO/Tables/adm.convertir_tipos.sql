SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[convertir_tipos] (
		[id_tipo]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_tipo]                  [nvarchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[convertir_tipos]
	ADD
	CONSTRAINT [PK__converti__CF901089E2471841]
	PRIMARY KEY
	CLUSTERED
	([id_tipo])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[convertir_tipos]
	ADD
	CONSTRAINT [DF__convertir__activ__6EAB62A3]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[convertir_tipos]
	ADD
	CONSTRAINT [DF__convertir__id_ti__6DB73E6A]
	DEFAULT (newid()) FOR [id_tipo]
GO
ALTER TABLE [adm].[convertir_tipos]
	ADD
	CONSTRAINT [DF__convertir__inser__6F9F86DC]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[convertir_tipos]
	ADD
	CONSTRAINT [DF__convertir__updat__7093AB15]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [adm].[convertir_tipos] SET (LOCK_ESCALATION = TABLE)
GO
