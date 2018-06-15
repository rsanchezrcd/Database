SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[handpunch_resync] (
		[id_source]              [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[sync]                   [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ifc].[handpunch_resync]
	ADD
	CONSTRAINT [pk_id_source]
	PRIMARY KEY
	CLUSTERED
	([id_source])
	ON [PRIMARY]
GO
ALTER TABLE [ifc].[handpunch_resync]
	ADD
	CONSTRAINT [DF__handpunch___sync__5AC46587]
	DEFAULT ((0)) FOR [sync]
GO
ALTER TABLE [ifc].[handpunch_resync]
	ADD
	CONSTRAINT [DF__handpunch__inser__59D0414E]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [ifc].[handpunch_resync]
	WITH CHECK
	ADD CONSTRAINT [FK_handpunch_resync_operator]
	FOREIGN KEY ([insert_operator_id]) REFERENCES [cat].[operator] ([operator_id])
ALTER TABLE [ifc].[handpunch_resync]
	CHECK CONSTRAINT [FK_handpunch_resync_operator]

GO
CREATE NONCLUSTERED INDEX [nci_insert_date]
	ON [ifc].[handpunch_resync] ([insert_date] DESC)
	ON [PRIMARY]
GO
ALTER TABLE [ifc].[handpunch_resync] SET (LOCK_ESCALATION = TABLE)
GO
