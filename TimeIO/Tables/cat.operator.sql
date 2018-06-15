SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[operator] (
		[operator_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[employee_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_username]              [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_password]              [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_salt]                  [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_ad_user]               [tinyint] NOT NULL,
		[_domain]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_name]                  [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_lastname]              [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_email]                 [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_is_admin]              [bit] NOT NULL,
		[active]                 [tinyint] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[id_role]                [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[id_departamento]        [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [UQ__operator__C52E0BA9B09B5D82]
		UNIQUE
		NONCLUSTERED
		([employee_id])
		ON [PRIMARY],
		CONSTRAINT [UQ__operator__C758EF9D9CD243FD]
		UNIQUE
		NONCLUSTERED
		([_username])
		ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [PK__operator__9D9A890145D0FF00]
	PRIMARY KEY
	CLUSTERED
	([operator_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [DF__operator___ad_us__70099B30]
	DEFAULT ((0)) FOR [_ad_user]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [DF__operator___is_ad__70FDBF69]
	DEFAULT ((0)) FOR [_is_admin]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [DF__operator__active__71F1E3A2]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [DF__operator__insert__72E607DB]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [DF__operator__insert__73DA2C14]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [DF__operator__operat__6F1576F7]
	DEFAULT (newid()) FOR [operator_id]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [DF__operator__update__74CE504D]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[operator]
	ADD
	CONSTRAINT [DF_operator__email]
	DEFAULT ('') FOR [_email]
GO
ALTER TABLE [cat].[operator] SET (LOCK_ESCALATION = TABLE)
GO
