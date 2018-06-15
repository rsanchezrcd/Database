SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[test] (
		[testid]          [char](36) NOT NULL,
		[teststr]         [varchar](64) NOT NULL,
		[inserted_at]     [datetime] NOT NULL
)
GO
ALTER TABLE [adm].[test] SET (LOCK_ESCALATION = TABLE)
GO
