SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[horas_nocturnas] (
		[id_horas_nocturnas]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_employee]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_periodo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_horas]                 [smallint] NOT NULL,
		[_c01]                   [smallint] NOT NULL,
		[_c02]                   [smallint] NOT NULL,
		[_c03]                   [smallint] NOT NULL,
		[_c04]                   [smallint] NOT NULL,
		[_c05]                   [smallint] NOT NULL,
		[_c06]                   [smallint] NOT NULL,
		[_c07]                   [smallint] NOT NULL,
		[_c08]                   [smallint] NOT NULL,
		[_c09]                   [smallint] NOT NULL,
		[_c10]                   [smallint] NOT NULL,
		[_c11]                   [smallint] NOT NULL,
		[_c12]                   [smallint] NOT NULL,
		[_c13]                   [smallint] NOT NULL,
		[_c14]                   [smallint] NOT NULL,
		[_c15]                   [smallint] NOT NULL,
		[_c16]                   [smallint] NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [PK__horas_no__F5E1DDC335052642]
	PRIMARY KEY
	CLUSTERED
	([id_horas_nocturnas])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noc___hora__18227982]
	DEFAULT ((0)) FOR [_horas]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noc__activ__2858E14B]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noc__id_ho__172E5549]
	DEFAULT (newid()) FOR [id_horas_nocturnas]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noc__inser__294D0584]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c01__19169DBB]
	DEFAULT ((0)) FOR [_c01]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c02__1A0AC1F4]
	DEFAULT ((0)) FOR [_c02]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c03__1AFEE62D]
	DEFAULT ((0)) FOR [_c03]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c04__1BF30A66]
	DEFAULT ((0)) FOR [_c04]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c05__1CE72E9F]
	DEFAULT ((0)) FOR [_c05]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c06__1DDB52D8]
	DEFAULT ((0)) FOR [_c06]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c07__1ECF7711]
	DEFAULT ((0)) FOR [_c07]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c08__1FC39B4A]
	DEFAULT ((0)) FOR [_c08]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c09__20B7BF83]
	DEFAULT ((0)) FOR [_c09]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c10__21ABE3BC]
	DEFAULT ((0)) FOR [_c10]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c11__22A007F5]
	DEFAULT ((0)) FOR [_c11]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c12__23942C2E]
	DEFAULT ((0)) FOR [_c12]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c13__24885067]
	DEFAULT ((0)) FOR [_c13]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c14__257C74A0]
	DEFAULT ((0)) FOR [_c14]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c15__267098D9]
	DEFAULT ((0)) FOR [_c15]
GO
ALTER TABLE [tra].[horas_nocturnas]
	ADD
	CONSTRAINT [DF__horas_noct___c16__2764BD12]
	DEFAULT ((0)) FOR [_c16]
GO
ALTER TABLE [tra].[horas_nocturnas]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_nocturnas_employees]
	FOREIGN KEY ([id_employee]) REFERENCES [cat].[employees] ([employee_id])
ALTER TABLE [tra].[horas_nocturnas]
	CHECK CONSTRAINT [FK_horas_nocturnas_employees]

GO
ALTER TABLE [tra].[horas_nocturnas]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_nocturnas_periodos]
	FOREIGN KEY ([id_periodo]) REFERENCES [cat].[periodos] ([id_periodo])
ALTER TABLE [tra].[horas_nocturnas]
	CHECK CONSTRAINT [FK_horas_nocturnas_periodos]

GO
ALTER TABLE [tra].[horas_nocturnas] SET (LOCK_ESCALATION = TABLE)
GO
