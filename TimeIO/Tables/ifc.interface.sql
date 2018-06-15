SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[interface] (
		[id_interface]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                  [bit] NOT NULL,
		[insert_operator_id]      [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]             [datetime] NULL,
		[update_operator_id]      [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[update_date]             [datetime] NULL,
		[_interface_name]         [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_query]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_by_agent]               [bit] NULL,
		[_by_hits]                [bit] NULL,
		[_order]                  [int] NULL,
		[_minutes]                [int] NULL,
		[id_interface_father]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_need_op]                [bit] NULL,
		[_running]                [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [PK__interfac__05A2862E5B90D166]
	PRIMARY KEY
	CLUSTERED
	([id_interface])
	ON [PRIMARY]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface___by_a__5A054B78]
	DEFAULT ((0)) FOR [_by_agent]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface___by_h__5AF96FB1]
	DEFAULT ((0)) FOR [_by_hits]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface___minu__5CE1B823]
	DEFAULT ((30)) FOR [_minutes]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface___need__629A9179]
	DEFAULT ((1)) FOR [_need_op]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface___orde__5BED93EA]
	DEFAULT ((0)) FOR [_order]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface___runn__550B8C31]
	DEFAULT ((0)) FOR [_running]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface__activ__5728DECD]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface__id_in__5634BA94]
	DEFAULT (newid()) FOR [id_interface]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface__inser__581D0306]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [ifc].[interface]
	ADD
	CONSTRAINT [DF__interface__updat__5911273F]
	DEFAULT (getdate()) FOR [update_date]
GO
CREATE UNIQUE NONCLUSTERED INDEX [nci_interface_name]
	ON [ifc].[interface] ([_interface_name])
	ON [PRIMARY]
GO
ALTER TABLE [ifc].[interface] SET (LOCK_ESCALATION = TABLE)
GO
