SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[lengua] (
		[lengua_id]              [char](36) NOT NULL,
		[_lengua_code]           [varchar](2) NULL,
		[_lengua_txt]            [varchar](128) NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
)
GO
ALTER TABLE [cat].[lengua] SET (LOCK_ESCALATION = TABLE)
GO
