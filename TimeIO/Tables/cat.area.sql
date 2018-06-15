SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[area] (
		[area_id]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_area_name]             [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_area_code]             [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_father_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[area]
	ADD
	CONSTRAINT [PK__area__985D6D6BC571887C]
	PRIMARY KEY
	CLUSTERED
	([area_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[area]
	ADD
	CONSTRAINT [DF__area__active__32E0915F]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[area]
	ADD
	CONSTRAINT [DF__area__area_id__31EC6D26]
	DEFAULT (newid()) FOR [area_id]
GO
ALTER TABLE [cat].[area]
	ADD
	CONSTRAINT [DF__area__insert_dat__34C8D9D1]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[area]
	ADD
	CONSTRAINT [DF__area__insert_ope__33D4B598]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[area]
	ADD
	CONSTRAINT [DF__area__update_dat__35BCFE0A]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[area] SET (LOCK_ESCALATION = TABLE)
GO
