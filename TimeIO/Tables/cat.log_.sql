SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[log_] (
		[id_log]                     [int] IDENTITY(1, 1) NOT NULL,
		[fecha_insert]               [datetime] NOT NULL,
		[id_operator]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_tabla]                     [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_delete]                    [bit] NULL,
		[_insert]                    [bit] NULL,
		[_update]                    [bit] NULL,
		[_affected_operator]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_affected_column]           [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_affected_column_value]     [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[log_]
	ADD
	CONSTRAINT [PK__log___6CC851FE39C57C53]
	PRIMARY KEY
	CLUSTERED
	([id_log])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[log_]
	ADD
	CONSTRAINT [DF__log____delete__2744C181]
	DEFAULT ((0)) FOR [_delete]
GO
ALTER TABLE [cat].[log_]
	ADD
	CONSTRAINT [DF__log____insert__2838E5BA]
	DEFAULT ((0)) FOR [_insert]
GO
ALTER TABLE [cat].[log_]
	ADD
	CONSTRAINT [DF__log____update__292D09F3]
	DEFAULT ((0)) FOR [_update]
GO
ALTER TABLE [cat].[log_]
	ADD
	CONSTRAINT [DF__log___fecha_inse__26509D48]
	DEFAULT (getdate()) FOR [fecha_insert]
GO
ALTER TABLE [cat].[log_] SET (LOCK_ESCALATION = TABLE)
GO
