SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[queries] (
		[id_query]               [char](36) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[active]                 [bit] NULL,
		[_query_name]            [nvarchar](32) NOT NULL,
		[_query_script]          [nvarchar](256) NOT NULL
)
GO
ALTER TABLE [adm].[queries] SET (LOCK_ESCALATION = TABLE)
GO
