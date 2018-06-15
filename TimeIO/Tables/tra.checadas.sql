SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[checadas] (
		[id_checada]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]           [datetime] NOT NULL,
		[update_date]           [datetime] NOT NULL,
		[employee_id]           [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_checada]              [datetime] NOT NULL,
		[_checada_fecha]        [date] NOT NULL,
		[_checada_hora]         [time](7) NOT NULL,
		[_dispositivo_code]     [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_tipo]                 [bit] NOT NULL,
		[_sync]                 [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [tra].[checadas]
	ADD
	CONSTRAINT [PK__checadas__B454E29912F87C0A]
	PRIMARY KEY
	CLUSTERED
	([id_checada])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[checadas]
	ADD
	CONSTRAINT [DF__checadas___sync__7DB89C09]
	DEFAULT ((0)) FOR [_sync]
GO
ALTER TABLE [tra].[checadas]
	ADD
	CONSTRAINT [DF__checadas___tipo__7CC477D0]
	DEFAULT ((0)) FOR [_tipo]
GO
ALTER TABLE [tra].[checadas]
	ADD
	CONSTRAINT [DF__checadas__id_che__79E80B25]
	DEFAULT (newid()) FOR [id_checada]
GO
ALTER TABLE [tra].[checadas]
	ADD
	CONSTRAINT [DF__checadas__insert__7ADC2F5E]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[checadas]
	ADD
	CONSTRAINT [DF__checadas__update__7BD05397]
	DEFAULT (getdate()) FOR [update_date]
GO
CREATE NONCLUSTERED INDEX [nci_checada]
	ON [tra].[checadas] ([_checada] DESC)
	ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [unique_empleado_checada]
	ON [tra].[checadas] ([employee_id], [_checada])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[checadas] SET (LOCK_ESCALATION = TABLE)
GO
