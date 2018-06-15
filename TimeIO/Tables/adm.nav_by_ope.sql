SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[nav_by_ope] (
		[id]                     [int] IDENTITY(1, 1) NOT NULL,
		[id_operator]            [char](36) NOT NULL,
		[id_navigator]           [char](36) NOT NULL,
		[_full]                  [bit] NOT NULL,
		[_read]                  [bit] NOT NULL,
		[_write]                 [bit] NOT NULL,
		[_special]               [bit] NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
)
GO
ALTER TABLE [adm].[nav_by_ope] SET (LOCK_ESCALATION = TABLE)
GO
