SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stg].[ausentismos_eliminados] (
		[id_tra_ausentismo]      [int] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[active]                 [bit] NOT NULL,
		[id_ausentismo]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_ausentismo_date]       [datetime] NOT NULL,
		[employee_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_cN]                    [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_periodo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_sync]                  [bit] NOT NULL,
		[_folio]                 [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_ps_type]               [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [stg].[ausentismos_eliminados]
	ADD
	CONSTRAINT [ci_id_tra_ausentismo]
	PRIMARY KEY
	CLUSTERED
	([id_tra_ausentismo])
	ON [PRIMARY]
GO
ALTER TABLE [stg].[ausentismos_eliminados]
	ADD
	CONSTRAINT [DF__ausentism___sync__097F5470]
	DEFAULT ((0)) FOR [_sync]
GO
ALTER TABLE [stg].[ausentismos_eliminados]
	ADD
	CONSTRAINT [DF__ausentism__activ__088B3037]
	DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [stg].[ausentismos_eliminados]
	ADD
	CONSTRAINT [DF__ausentism__inser__06A2E7C5]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [stg].[ausentismos_eliminados]
	ADD
	CONSTRAINT [DF__ausentism__updat__07970BFE]
	DEFAULT (getdate()) FOR [update_date]
GO
CREATE NONCLUSTERED INDEX [nci_ausentismo_date]
	ON [stg].[ausentismos_eliminados] ([_ausentismo_date])
	ON [PRIMARY]
GO
ALTER TABLE [stg].[ausentismos_eliminados] SET (LOCK_ESCALATION = TABLE)
GO
