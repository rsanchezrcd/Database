SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[operator] (
		[operator_id]            [char](36) NOT NULL,
		[employee_id]            [char](36) NOT NULL,
		[_username]              [nvarchar](64) NOT NULL,
		[_password]              [varchar](max) NULL,
		[_salt]                  [char](36) NULL,
		[_ad_user]               [tinyint] NOT NULL,
		[_domain]                [nvarchar](64) NULL,
		[_name]                  [nvarchar](64) NOT NULL,
		[_lastname]              [nvarchar](64) NOT NULL,
		[_email]                 [nvarchar](128) NOT NULL,
		[_is_admin]              [bit] NOT NULL,
		[active]                 [tinyint] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[id_role]                [char](36) NULL,
		[id_departamento]        [char](36) NULL
)
GO
ALTER TABLE [cat].[operator] SET (LOCK_ESCALATION = TABLE)
GO
