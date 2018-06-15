SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[horas_nocturnas_log] (
		[id_hn_log]              [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[active]                 [bit] NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_horas_nocturnas]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[id_employee]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_periodo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_cn]                    [char](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_horas]                 [int] NOT NULL,
		[id_fecha]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [tra].[horas_nocturnas_log]
	ADD
	CONSTRAINT [DF__horas_noc__activ__3C5FD9F8]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [tra].[horas_nocturnas_log]
	ADD
	CONSTRAINT [DF__horas_noc__inser__3B6BB5BF]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[horas_nocturnas_log]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_nocturnas_log_employees]
	FOREIGN KEY ([id_employee]) REFERENCES [cat].[employees] ([employee_id])
ALTER TABLE [tra].[horas_nocturnas_log]
	CHECK CONSTRAINT [FK_horas_nocturnas_log_employees]

GO
ALTER TABLE [tra].[horas_nocturnas_log]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_nocturnas_log_horas_nocturnas]
	FOREIGN KEY ([id_horas_nocturnas]) REFERENCES [tra].[horas_nocturnas] ([id_horas_nocturnas])
ALTER TABLE [tra].[horas_nocturnas_log]
	CHECK CONSTRAINT [FK_horas_nocturnas_log_horas_nocturnas]

GO
ALTER TABLE [tra].[horas_nocturnas_log]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_nocturnas_log_periodos]
	FOREIGN KEY ([id_periodo]) REFERENCES [cat].[periodos] ([id_periodo])
ALTER TABLE [tra].[horas_nocturnas_log]
	CHECK CONSTRAINT [FK_horas_nocturnas_log_periodos]

GO
ALTER TABLE [tra].[horas_nocturnas_log] SET (LOCK_ESCALATION = TABLE)
GO
