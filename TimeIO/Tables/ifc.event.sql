SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[event] (
		[id_event]         [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]      [datetime] NULL,
		[id_interface]     [char](36) NOT NULL,
		[_type]            [tinyint] NULL,
		[_message]         [nvarchar](max) NOT NULL,
		[_flag]            [bit] NULL,
		[_inserted]        [int] NULL,
		[_updated]         [int] NULL,
		[_ini]             [datetime] NULL,
		[_fin]             [datetime] NULL,
		[_dif]             [int] NULL
)
GO
ALTER TABLE [ifc].[event] SET (LOCK_ESCALATION = TABLE)
GO
