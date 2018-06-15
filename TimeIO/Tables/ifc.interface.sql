SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[interface] (
		[id_interface]            [char](36) NOT NULL,
		[active]                  [bit] NOT NULL,
		[insert_operator_id]      [char](36) NOT NULL,
		[insert_date]             [datetime] NULL,
		[update_operator_id]      [char](36) NULL,
		[update_date]             [datetime] NULL,
		[_interface_name]         [nvarchar](64) NOT NULL,
		[id_query]                [char](36) NULL,
		[_by_agent]               [bit] NULL,
		[_by_hits]                [bit] NULL,
		[_order]                  [int] NULL,
		[_minutes]                [int] NULL,
		[id_interface_father]     [char](36) NULL,
		[_need_op]                [bit] NULL,
		[_running]                [bit] NULL
)
GO
ALTER TABLE [ifc].[interface] SET (LOCK_ESCALATION = TABLE)
GO
