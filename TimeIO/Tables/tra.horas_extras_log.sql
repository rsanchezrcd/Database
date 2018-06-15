SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[horas_extras_log] (
		[id_he_log]              [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[active]                 [bit] NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_horas_extras]        [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[id_employee]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_periodo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_cn]                    [char](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_pagadas]               [int] NOT NULL,
		[id_fecha]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [tra].[horas_extras_log]
	ADD
	CONSTRAINT [DF__horas_ext__activ__34F3C25A]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [tra].[horas_extras_log]
	ADD
	CONSTRAINT [DF__horas_ext__inser__33FF9E21]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[horas_extras_log]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_extras_log_employees]
	FOREIGN KEY ([id_employee]) REFERENCES [cat].[employees] ([employee_id])
ALTER TABLE [tra].[horas_extras_log]
	CHECK CONSTRAINT [FK_horas_extras_log_employees]

GO
ALTER TABLE [tra].[horas_extras_log]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_extras_log_horas_extras]
	FOREIGN KEY ([id_horas_extras]) REFERENCES [tra].[horas_extras] ([id_horas_extras])
ALTER TABLE [tra].[horas_extras_log]
	CHECK CONSTRAINT [FK_horas_extras_log_horas_extras]

GO
ALTER TABLE [tra].[horas_extras_log]
	WITH CHECK
	ADD CONSTRAINT [FK_horas_extras_log_periodos]
	FOREIGN KEY ([id_periodo]) REFERENCES [cat].[periodos] ([id_periodo])
ALTER TABLE [tra].[horas_extras_log]
	CHECK CONSTRAINT [FK_horas_extras_log_periodos]

GO
CREATE UNIQUE CLUSTERED INDEX [ci_identity]
	ON [tra].[horas_extras_log] ([id_he_log])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[horas_extras_log] SET (LOCK_ESCALATION = TABLE)
GO
