SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[ausentismo_automatico] (
		[id]                     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_locacion]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_ausentismo]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_clase]                 [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_week_day]              [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismo_automatico]
	ADD
	CONSTRAINT [PK__ausentis__3213E83FCC089B30]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[ausentismo_automatico]
	ADD
	CONSTRAINT [DF__ausentism__activ__7D6E8346]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[ausentismo_automatico]
	ADD
	CONSTRAINT [DF__ausentism__inser__7C7A5F0D]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[ausentismo_automatico] SET (LOCK_ESCALATION = TABLE)
GO
