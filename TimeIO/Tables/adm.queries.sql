SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[queries] (
		[id_query]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NULL,
		[_query_name]            [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_query_script]          [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[queries]
	ADD
	CONSTRAINT [PK__queries__B9DB27861B84EB6E]
	PRIMARY KEY
	CLUSTERED
	([id_query])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[queries]
	ADD
	CONSTRAINT [DF__queries__active__7D8391DF]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[queries]
	ADD
	CONSTRAINT [DF__queries__id_quer__7AA72534]
	DEFAULT (newid()) FOR [id_query]
GO
ALTER TABLE [adm].[queries]
	ADD
	CONSTRAINT [DF__queries__insert___7B9B496D]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[queries]
	ADD
	CONSTRAINT [DF__queries__update___7C8F6DA6]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [adm].[queries] SET (LOCK_ESCALATION = TABLE)
GO
