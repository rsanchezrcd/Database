SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[puestos] (
		[puestos_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_puestos_name]          [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_puestos_code]          [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_father_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[puestos]
	ADD
	CONSTRAINT [PK__puestos__195C9A2DFDA1009B]
	PRIMARY KEY
	CLUSTERED
	([puestos_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[puestos]
	ADD
	CONSTRAINT [DF__puestos__active__5EBF139D]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[puestos]
	ADD
	CONSTRAINT [DF__puestos__insert___5FB337D6]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[puestos]
	ADD
	CONSTRAINT [DF__puestos__insert___60A75C0F]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[puestos]
	ADD
	CONSTRAINT [DF__puestos__puestos__5DCAEF64]
	DEFAULT (newid()) FOR [puestos_id]
GO
ALTER TABLE [cat].[puestos]
	ADD
	CONSTRAINT [DF__puestos__update___619B8048]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[puestos] SET (LOCK_ESCALATION = TABLE)
GO
