SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[departamento_operator] (
		[id_departamento_operator]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]                  [datetime] NOT NULL,
		[insert_operator_id]           [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_departamento]              [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_operator]                  [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_favorite]                    [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[departamento_operator]
	ADD
	CONSTRAINT [PK__departam__0DE4C994F1D8D351]
	PRIMARY KEY
	CLUSTERED
	([id_departamento_operator])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[departamento_operator]
	ADD
	CONSTRAINT [DF__departame___favo__36870511]
	DEFAULT ((0)) FOR [_favorite]
GO
ALTER TABLE [cat].[departamento_operator]
	ADD
	CONSTRAINT [DF__departame__id_de__349EBC9F]
	DEFAULT (newid()) FOR [id_departamento_operator]
GO
ALTER TABLE [cat].[departamento_operator]
	ADD
	CONSTRAINT [DF__departame__inser__3592E0D8]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[departamento_operator]
	WITH CHECK
	ADD CONSTRAINT [FK_departamento_operator_departamento_operator]
	FOREIGN KEY ([insert_operator_id]) REFERENCES [cat].[operator] ([operator_id])
ALTER TABLE [cat].[departamento_operator]
	CHECK CONSTRAINT [FK_departamento_operator_departamento_operator]

GO
ALTER TABLE [cat].[departamento_operator]
	WITH CHECK
	ADD CONSTRAINT [FK_departamento_operator_departamentos]
	FOREIGN KEY ([id_departamento]) REFERENCES [cat].[departamentos] ([id_departamento])
ALTER TABLE [cat].[departamento_operator]
	CHECK CONSTRAINT [FK_departamento_operator_departamentos]

GO
ALTER TABLE [cat].[departamento_operator]
	WITH CHECK
	ADD CONSTRAINT [FK_departamento_operator_operator]
	FOREIGN KEY ([id_operator]) REFERENCES [cat].[operator] ([operator_id])
ALTER TABLE [cat].[departamento_operator]
	CHECK CONSTRAINT [FK_departamento_operator_operator]

GO
ALTER TABLE [cat].[departamento_operator] SET (LOCK_ESCALATION = TABLE)
GO
