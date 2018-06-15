SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[area] (
		[area_id]                [char](36) NOT NULL,
		[_area_name]             [varchar](32) NOT NULL,
		[_area_code]             [varchar](32) NULL,
		[_father_id]             [char](36) NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
)
GO
ALTER TABLE [cat].[area] SET (LOCK_ESCALATION = TABLE)
GO
