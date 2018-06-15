SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[handpunch_resync] (
		[id_source]              [char](36) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[sync]                   [bit] NOT NULL
)
GO
ALTER TABLE [ifc].[handpunch_resync] SET (LOCK_ESCALATION = TABLE)
GO
