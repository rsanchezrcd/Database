SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[empresas] (
		[empresa_id]             [char](36) NOT NULL,
		[country_id]             [char](36) NULL,
		[_empresa_name]          [nvarchar](64) NOT NULL,
		[_empresa_code]          [nvarchar](32) NULL,
		[_rfc]                   [nvarchar](64) NOT NULL,
		[_phone]                 [nvarchar](64) NULL,
		[_domain]                [nvarchar](64) NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
)
GO
ALTER TABLE [cat].[empresas] SET (LOCK_ESCALATION = TABLE)
GO
