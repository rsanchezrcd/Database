SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[ausentismo_employee] (
		[id]                     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_date]            [datetime] NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[id_employee]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_ausentismo]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_dias_atras]            [int] NOT NULL,
		[_max_periodo]           [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismo_employee]
	ADD
	CONSTRAINT [PK__ausentis__3213E83F4788AFD9]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismo_employee]
	ADD
	CONSTRAINT [DF__ausentism___dias__72F0F4D3]
	DEFAULT ((3)) FOR [_dias_atras]
GO
ALTER TABLE [cat].[ausentismo_employee]
	ADD
	CONSTRAINT [DF__ausentism___max___73E5190C]
	DEFAULT ((3)) FOR [_max_periodo]
GO
ALTER TABLE [cat].[ausentismo_employee]
	ADD
	CONSTRAINT [DF__ausentism__activ__71FCD09A]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[ausentismo_employee]
	ADD
	CONSTRAINT [DF__ausentism__inser__7108AC61]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[ausentismo_employee]
	WITH CHECK
	ADD CONSTRAINT [FK_ausentismo_employee_ausentismos]
	FOREIGN KEY ([id_ausentismo]) REFERENCES [cat].[ausentismos] ([id_ausentismo])
ALTER TABLE [cat].[ausentismo_employee]
	CHECK CONSTRAINT [FK_ausentismo_employee_ausentismos]

GO
ALTER TABLE [cat].[ausentismo_employee]
	WITH CHECK
	ADD CONSTRAINT [FK_ausentismo_employee_employees]
	FOREIGN KEY ([id_employee]) REFERENCES [cat].[employees] ([employee_id])
ALTER TABLE [cat].[ausentismo_employee]
	CHECK CONSTRAINT [FK_ausentismo_employee_employees]

GO
ALTER TABLE [cat].[ausentismo_employee] SET (LOCK_ESCALATION = TABLE)
GO
