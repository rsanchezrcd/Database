SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[locacion] (
		[locacion_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_locacion_name]         [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_locacion_code]         [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_father_source]         [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_father_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_alter_code]            [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_soporte_mail]          [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_sabado]                [bit] NULL,
		[_domingo]               [bit] NULL,
		CONSTRAINT [UQ__locacion__943FD830C064C492]
		UNIQUE
		NONCLUSTERED
		([_locacion_code])
		ON [PRIMARY],
		CONSTRAINT [UQ__locacion__E0F3C3F185448C7E]
		UNIQUE
		NONCLUSTERED
		([_locacion_name])
		ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [cat].[locacion]
	ADD
	CONSTRAINT [PK__locacion__0FE040D55941EF1D]
	PRIMARY KEY
	CLUSTERED
	([locacion_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[locacion]
	ADD
	CONSTRAINT [DF__locacion___domin__799DF262]
	DEFAULT ((0)) FOR [_domingo]
GO
ALTER TABLE [cat].[locacion]
	ADD
	CONSTRAINT [DF__locacion___sabad__78A9CE29]
	DEFAULT ((0)) FOR [_sabado]
GO
ALTER TABLE [cat].[locacion]
	ADD
	CONSTRAINT [DF__locacion__active__13DCE752]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[locacion]
	ADD
	CONSTRAINT [DF__locacion__insert__14D10B8B]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[locacion]
	ADD
	CONSTRAINT [DF__locacion__insert__15C52FC4]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[locacion]
	ADD
	CONSTRAINT [DF__locacion__locaci__12E8C319]
	DEFAULT (newid()) FOR [locacion_id]
GO
ALTER TABLE [cat].[locacion]
	ADD
	CONSTRAINT [DF__locacion__update__16B953FD]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[locacion]
	WITH CHECK
	ADD CONSTRAINT [FK_locacion_operator]
	FOREIGN KEY ([insert_operator_id]) REFERENCES [cat].[operator] ([operator_id])
ALTER TABLE [cat].[locacion]
	CHECK CONSTRAINT [FK_locacion_operator]

GO
ALTER TABLE [cat].[locacion] SET (LOCK_ESCALATION = TABLE)
GO
