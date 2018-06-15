SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[operator_request] (
		[id_operator_request]     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]             [datetime] NOT NULL,
		[insert_operator_id]      [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_date]             [datetime] NULL,
		[update_operator_id]      [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                  [bit] NOT NULL,
		[id_employee]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_role]                 [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_locacion]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_correo]                 [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_atendida]               [bit] NULL,
		[id_email]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[operator_request]
	ADD
	CONSTRAINT [PK__operator__90AE02F1A8CBD289]
	PRIMARY KEY
	CLUSTERED
	([id_operator_request])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[operator_request]
	ADD
	CONSTRAINT [DF__operator____aten__7BBB44FE]
	DEFAULT ((0)) FOR [_atendida]
GO
ALTER TABLE [adm].[operator_request]
	ADD
	CONSTRAINT [DF__operator___activ__7AC720C5]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[operator_request]
	ADD
	CONSTRAINT [DF__operator___inser__79D2FC8C]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[operator_request] SET (LOCK_ESCALATION = TABLE)
GO
