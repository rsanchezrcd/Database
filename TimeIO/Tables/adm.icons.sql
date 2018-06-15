SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[icons] (
		[id_icon]         [char](36) NULL,
		[icon]            [varchar](64) NULL,
		[active]          [bit] NULL,
		[insert_date]     [datetime] NULL
)
GO
ALTER TABLE [adm].[icons] SET (LOCK_ESCALATION = TABLE)
GO
