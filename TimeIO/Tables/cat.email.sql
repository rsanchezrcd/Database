SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[email] (
		[id_email]               [char](36) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[active]                 [bit] NOT NULL,
		[_domain]                [nvarchar](64) NOT NULL
)
GO
ALTER TABLE [cat].[email] SET (LOCK_ESCALATION = TABLE)
GO
