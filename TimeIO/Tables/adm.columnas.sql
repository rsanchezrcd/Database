SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[columnas] (
		[id_columna]             [char](36) NOT NULL,
		[id_navigator]           [char](36) NOT NULL,
		[_tabla]                 [nvarchar](64) NOT NULL,
		[_columna]               [nvarchar](64) NOT NULL,
		[_label]                 [nvarchar](64) NOT NULL,
		[_width]                 [nvarchar](128) NOT NULL,
		[_title]                 [nvarchar](64) NULL,
		[_input_type]            [nvarchar](16) NULL,
		[_special_class]         [nvarchar](64) NULL,
		[_required]              [bit] NOT NULL,
		[_prefix]                [nvarchar](3) NULL,
		[_order]                 [int] NOT NULL,
		[_align]                 [nvarchar](10) NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[_has_options]           [bit] NULL,
		[_options_source]        [nvarchar](50) NULL,
		[_options_id]            [nvarchar](50) NULL,
		[_options_show]          [nvarchar](50) NULL,
		[_needed]                [bit] NULL
)
GO
ALTER TABLE [adm].[columnas] SET (LOCK_ESCALATION = TABLE)
GO
