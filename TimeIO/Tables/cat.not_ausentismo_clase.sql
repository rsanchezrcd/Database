SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[not_ausentismo_clase] (
		[id]                     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                 [bit] NOT NULL,
		[_clase]                 [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_ausentismo]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[not_ausentismo_clase]
	ADD
	CONSTRAINT [PK__not_ause__3213E83F11967BBE]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[not_ausentismo_clase]
	ADD
	CONSTRAINT [DF__not_ausen__activ__6C43F744]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[not_ausentismo_clase]
	ADD
	CONSTRAINT [DF__not_ausen__inser__6B4FD30B]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[not_ausentismo_clase]
	WITH CHECK
	ADD CONSTRAINT [FK_not_ausentismo_clase_ausentismos]
	FOREIGN KEY ([id_ausentismo]) REFERENCES [cat].[ausentismos] ([id_ausentismo])
ALTER TABLE [cat].[not_ausentismo_clase]
	CHECK CONSTRAINT [FK_not_ausentismo_clase_ausentismos]

GO
ALTER TABLE [cat].[not_ausentismo_clase] SET (LOCK_ESCALATION = TABLE)
GO
