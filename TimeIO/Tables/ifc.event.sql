SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[event] (
		[id_event]         [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]      [datetime] NULL,
		[id_interface]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_type]            [tinyint] NULL,
		[_message]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_flag]            [bit] NULL,
		[_inserted]        [int] NULL,
		[_updated]         [int] NULL,
		[_ini]             [datetime] NULL,
		[_fin]             [datetime] NULL,
		[_dif]             [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [ifc].[event]
	ADD
	CONSTRAINT [PK__event__913E426FE34951F3]
	PRIMARY KEY
	CLUSTERED
	([id_event])
	ON [PRIMARY]
GO
ALTER TABLE [ifc].[event]
	ADD
	CONSTRAINT [DF__event___flag__7D4E87B5]
	DEFAULT ((0)) FOR [_flag]
GO
ALTER TABLE [ifc].[event]
	ADD
	CONSTRAINT [DF__event___type__7C5A637C]
	DEFAULT ((0)) FOR [_type]
GO
ALTER TABLE [ifc].[event]
	ADD
	CONSTRAINT [DF__event__insert_da__7B663F43]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [ifc].[event] SET (LOCK_ESCALATION = TABLE)
GO
