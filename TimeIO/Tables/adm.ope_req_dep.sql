SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[ope_req_dep] (
		[id]                      [int] IDENTITY(1, 1) NOT NULL,
		[id_operator_request]     [int] NOT NULL,
		[insert_date]             [datetime] NOT NULL,
		[id_departamento]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[ope_req_dep]
	ADD
	CONSTRAINT [PK__ope_req___3213E83FB65CE9F7]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[ope_req_dep]
	ADD
	CONSTRAINT [DF__ope_req_d__inser__7231DAC4]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[ope_req_dep]
	WITH CHECK
	ADD CONSTRAINT [FK_ope_req_dep_operator_request]
	FOREIGN KEY ([id_operator_request]) REFERENCES [adm].[operator_request] ([id_operator_request])
	ON DELETE CASCADE
	ON UPDATE CASCADE
ALTER TABLE [adm].[ope_req_dep]
	CHECK CONSTRAINT [FK_ope_req_dep_operator_request]

GO
ALTER TABLE [adm].[ope_req_dep] SET (LOCK_ESCALATION = TABLE)
GO
