SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[horas_extras] (
		[id_horas_extras]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_employee]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_periodo]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_horas]              [smallint] NOT NULL,
		[_c01]                [smallint] NOT NULL,
		[_c02]                [smallint] NOT NULL,
		[_c03]                [smallint] NOT NULL,
		[_c04]                [smallint] NOT NULL,
		[_c05]                [smallint] NOT NULL,
		[_c06]                [smallint] NOT NULL,
		[_c07]                [smallint] NOT NULL,
		[_c08]                [smallint] NOT NULL,
		[_c09]                [smallint] NOT NULL,
		[_c10]                [smallint] NOT NULL,
		[_c11]                [smallint] NOT NULL,
		[_c12]                [smallint] NOT NULL,
		[_c13]                [smallint] NOT NULL,
		[_c14]                [smallint] NOT NULL,
		[_c15]                [smallint] NOT NULL,
		[_c16]                [smallint] NULL,
		[active]              [bit] NOT NULL,
		[insert_date]         [datetime] NOT NULL,
		[update_date]         [datetime] NULL,
		[_p01]                [smallint] NULL,
		[_p02]                [smallint] NULL,
		[_p03]                [smallint] NULL,
		[_p04]                [smallint] NULL,
		[_p05]                [smallint] NULL,
		[_p06]                [smallint] NULL,
		[_p07]                [smallint] NULL,
		[_p08]                [smallint] NULL,
		[_p09]                [smallint] NULL,
		[_p10]                [smallint] NULL,
		[_p11]                [smallint] NULL,
		[_p12]                [smallint] NULL,
		[_p13]                [smallint] NULL,
		[_p14]                [smallint] NULL,
		[_p15]                [smallint] NULL,
		[_p16]                [smallint] NULL,
		[_pagadas]            [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [PK__horas_ex__B0BB79F6887F1518]
	PRIMARY KEY
	CLUSTERED
	([id_horas_extras])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_ext___hora__2121D3D7]
	DEFAULT ((0)) FOR [_horas]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_ext__activ__31583BA0]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_ext__id_ho__202DAF9E]
	DEFAULT (newid()) FOR [id_horas_extras]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_ext__inser__324C5FD9]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c01__2215F810]
	DEFAULT ((0)) FOR [_c01]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c02__230A1C49]
	DEFAULT ((0)) FOR [_c02]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c03__23FE4082]
	DEFAULT ((0)) FOR [_c03]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c04__24F264BB]
	DEFAULT ((0)) FOR [_c04]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c05__25E688F4]
	DEFAULT ((0)) FOR [_c05]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c06__26DAAD2D]
	DEFAULT ((0)) FOR [_c06]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c07__27CED166]
	DEFAULT ((0)) FOR [_c07]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c08__28C2F59F]
	DEFAULT ((0)) FOR [_c08]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c09__29B719D8]
	DEFAULT ((0)) FOR [_c09]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c10__2AAB3E11]
	DEFAULT ((0)) FOR [_c10]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c11__2B9F624A]
	DEFAULT ((0)) FOR [_c11]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c12__2C938683]
	DEFAULT ((0)) FOR [_c12]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c13__2D87AABC]
	DEFAULT ((0)) FOR [_c13]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c14__2E7BCEF5]
	DEFAULT ((0)) FOR [_c14]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c15__2F6FF32E]
	DEFAULT ((0)) FOR [_c15]
GO
ALTER TABLE [tra].[horas_extras]
	ADD
	CONSTRAINT [DF__horas_extr___c16__30641767]
	DEFAULT ((0)) FOR [_c16]
GO
ALTER TABLE [tra].[horas_extras]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_extras_employees]
	FOREIGN KEY ([id_employee]) REFERENCES [cat].[employees] ([employee_id])
ALTER TABLE [tra].[horas_extras]
	CHECK CONSTRAINT [FK_horas_extras_employees]

GO
ALTER TABLE [tra].[horas_extras]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_extras_periodos]
	FOREIGN KEY ([id_periodo]) REFERENCES [cat].[periodos] ([id_periodo])
ALTER TABLE [tra].[horas_extras]
	CHECK CONSTRAINT [FK_horas_extras_periodos]

GO
ALTER TABLE [tra].[horas_extras] SET (LOCK_ESCALATION = TABLE)
GO
