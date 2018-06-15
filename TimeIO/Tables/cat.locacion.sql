SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[locacion] (
		[locacion_id]            [char](36) NOT NULL,
		[_locacion_name]         [varchar](128) NOT NULL,
		[_locacion_code]         [varchar](32) NULL,
		[_father_source]         [varchar](32) NULL,
		[_father_id]             [char](36) NULL,
		[_alter_code]            [varchar](32) NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_soporte_mail]          [nvarchar](128) NULL,
		[_sabado]                [bit] NULL,
		[_domingo]               [bit] NULL
)
GO
ALTER TABLE [cat].[locacion] SET (LOCK_ESCALATION = TABLE)
GO
