SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[festivo] (
		[id_festivo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_date]            [datetime] NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[_festivo_date]          [date] NOT NULL,
		[_festivo_desc]          [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[id_locacion]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_calificado]            [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[festivo]
	ADD
	CONSTRAINT [PK__festivo__A8CEC7E43F54DB4B]
	PRIMARY KEY
	CLUSTERED
	([id_festivo])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[festivo]
	ADD
	CONSTRAINT [DF__festivo___califi__0F8D3381]
	DEFAULT ((0)) FOR [_calificado]
GO
ALTER TABLE [cat].[festivo]
	ADD
	CONSTRAINT [DF__festivo__active__2F05DEDA]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[festivo]
	ADD
	CONSTRAINT [DF__festivo__id_fest__7A0806B6]
	DEFAULT (newid()) FOR [id_festivo]
GO
ALTER TABLE [cat].[festivo]
	ADD
	CONSTRAINT [DF__festivo__insert___7AFC2AEF]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[festivo]
	WITH CHECK
	ADD CONSTRAINT [FK_festivo_locacion]
	FOREIGN KEY ([id_locacion]) REFERENCES [cat].[locacion] ([locacion_id])
ALTER TABLE [cat].[festivo]
	CHECK CONSTRAINT [FK_festivo_locacion]

GO
ALTER TABLE [cat].[festivo] SET (LOCK_ESCALATION = TABLE)
GO
