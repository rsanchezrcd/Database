SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[navigator] (
		[id_navigator]           [char](36) NOT NULL,
		[_clave]                 [int] IDENTITY(1, 1) NOT NULL,
		[_item_name]             [nvarchar](20) NOT NULL,
		[_item_icon]             [nvarchar](64) NULL,
		[_is_father]             [bit] NOT NULL,
		[_is_child]              [bit] NOT NULL,
		[_father]                [int] NULL,
		[_order]                 [int] NOT NULL,
		[_url]                   [nvarchar](128) NULL,
		[_title]                 [nvarchar](128) NULL,
		[_table]                 [nvarchar](128) NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_insert_query]          [nvarchar](256) NULL
)
GO
ALTER TABLE [adm].[navigator] SET (LOCK_ESCALATION = TABLE)
GO
