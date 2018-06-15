SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[columnas] (
		[id_columna]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_navigator]           [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_tabla]                 [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_columna]               [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_label]                 [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_width]                 [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_title]                 [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_input_type]            [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_special_class]         [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_required]              [bit] NOT NULL,
		[_prefix]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_order]                 [int] NOT NULL,
		[_align]                 [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_has_options]           [bit] NULL,
		[_options_source]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_options_id]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_options_show]          [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_needed]                [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [PK__columnas__A7A6DC69E5B0ABCC]
	PRIMARY KEY
	CLUSTERED
	([id_columna])
	ON [PRIMARY]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF__columnas___align__5F691F13]
	DEFAULT ('left') FOR [_align]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF__columnas___requi__5E74FADA]
	DEFAULT ((0)) FOR [_required]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF__columnas___width__5D80D6A1]
	DEFAULT ((0)) FOR [_width]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF__columnas__active__605D434C]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF__columnas__id_col__5C8CB268]
	DEFAULT (newid()) FOR [id_columna]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF__columnas__insert__61516785]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF__columnas__update__62458BBE]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF_columnas__has_options]
	DEFAULT ((0)) FOR [_has_options]
GO
ALTER TABLE [adm].[columnas]
	ADD
	CONSTRAINT [DF_columnas__needed]
	DEFAULT ((1)) FOR [_needed]
GO
ALTER TABLE [adm].[columnas] SET (LOCK_ESCALATION = TABLE)
GO
