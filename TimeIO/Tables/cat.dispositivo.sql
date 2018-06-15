SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[dispositivo] (
		[id_dispositivo]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[activo]                 [bit] NULL,
		[id_locacion]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_name]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_hostname]              [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_port]                  [smallint] NULL,
		[_ischecador]            [bit] NULL,
		[_iscomedor]             [bit] NULL,
		[_istest]                [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[dispositivo]
	ADD
	CONSTRAINT [PK__disposit__FD7B94E5532025B1]
	PRIMARY KEY
	CLUSTERED
	([id_dispositivo])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[dispositivo]
	ADD
	CONSTRAINT [DF__dispositi___isch__61716316]
	DEFAULT ((1)) FOR [_ischecador]
GO
ALTER TABLE [cat].[dispositivo]
	ADD
	CONSTRAINT [DF__dispositi___isco__6265874F]
	DEFAULT ((0)) FOR [_iscomedor]
GO
ALTER TABLE [cat].[dispositivo]
	ADD
	CONSTRAINT [DF__dispositi___iste__6359AB88]
	DEFAULT ((0)) FOR [_istest]
GO
ALTER TABLE [cat].[dispositivo]
	ADD
	CONSTRAINT [DF__dispositi__activ__607D3EDD]
	DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [cat].[dispositivo]
	ADD
	CONSTRAINT [DF__dispositi__inser__5E94F66B]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[dispositivo]
	ADD
	CONSTRAINT [DF__dispositi__updat__5F891AA4]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[dispositivo] SET (LOCK_ESCALATION = TABLE)
GO
