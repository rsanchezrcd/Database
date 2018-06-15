SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[ausentismo_causa] (
		[id_ausentismo_causa]     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]             [datetime] NOT NULL,
		[insert_operator_id]      [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[activo]                  [bit] NOT NULL,
		[id_tra_ausentismo]       [int] NOT NULL,
		[id_causa]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_comentarios]            [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_fecha_pasada]           [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [tra].[ausentismo_causa]
	ADD
	CONSTRAINT [pk_id_ausentismo_causa]
	PRIMARY KEY
	CLUSTERED
	([id_ausentismo_causa])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[ausentismo_causa]
	ADD
	CONSTRAINT [DF__ausentism__activ__29EC2402]
	DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [tra].[ausentismo_causa]
	ADD
	CONSTRAINT [DF__ausentism__inser__28F7FFC9]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[ausentismo_causa]
	WITH CHECK
	ADD CONSTRAINT [fk_id_causa]
	FOREIGN KEY ([id_causa]) REFERENCES [cat].[causa] ([id_causa])
ALTER TABLE [tra].[ausentismo_causa]
	CHECK CONSTRAINT [fk_id_causa]

GO
ALTER TABLE [tra].[ausentismo_causa]
	WITH CHECK
	ADD CONSTRAINT [fk_id_tra_ausentismo]
	FOREIGN KEY ([id_tra_ausentismo]) REFERENCES [tra].[ausentismos] ([id_tra_ausentismo])
ALTER TABLE [tra].[ausentismo_causa]
	CHECK CONSTRAINT [fk_id_tra_ausentismo]

GO
ALTER TABLE [tra].[ausentismo_causa] SET (LOCK_ESCALATION = TABLE)
GO
