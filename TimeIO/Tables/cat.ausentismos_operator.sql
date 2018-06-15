SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[ausentismos_operator] (
		[id_ausentismos_operator]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                      [bit] NOT NULL,
		[insert_operator_id]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]                 [datetime] NULL,
		[update_date]                 [datetime] NULL,
		[id_operator]                 [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_ausentismo]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismos_operator]
	ADD
	CONSTRAINT [PK__ausentis__922FA7076531AD27]
	PRIMARY KEY
	CLUSTERED
	([id_ausentismos_operator])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismos_operator]
	ADD
	CONSTRAINT [DF__ausentism__activ__4AF81212]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[ausentismos_operator]
	ADD
	CONSTRAINT [DF__ausentism__id_au__4A03EDD9]
	DEFAULT (newid()) FOR [id_ausentismos_operator]
GO
ALTER TABLE [cat].[ausentismos_operator]
	ADD
	CONSTRAINT [DF__ausentism__inser__4BEC364B]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[ausentismos_operator]
	WITH CHECK
	ADD CONSTRAINT [FK_ausentismos_operator_ausentismos]
	FOREIGN KEY ([id_ausentismo]) REFERENCES [cat].[ausentismos] ([id_ausentismo])
	ON DELETE CASCADE
ALTER TABLE [cat].[ausentismos_operator]
	CHECK CONSTRAINT [FK_ausentismos_operator_ausentismos]

GO
ALTER TABLE [cat].[ausentismos_operator]
	WITH CHECK
	ADD CONSTRAINT [FK_ausentismosoperator_to_operator]
	FOREIGN KEY ([id_operator]) REFERENCES [cat].[operator] ([operator_id])
	ON DELETE CASCADE
ALTER TABLE [cat].[ausentismos_operator]
	CHECK CONSTRAINT [FK_ausentismosoperator_to_operator]

GO
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-operator_ausentismo]
	ON [cat].[ausentismos_operator] ([id_operator], [id_ausentismo])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismos_operator] SET (LOCK_ESCALATION = TABLE)
GO
