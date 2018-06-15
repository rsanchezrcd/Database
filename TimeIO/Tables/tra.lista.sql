SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[lista] (
		[id_lista]               [char](36) NOT NULL,
		[id_employee]            [char](36) NOT NULL,
		[id_periodo]             [char](36) NOT NULL,
		[_days]                  [tinyint] NOT NULL,
		[_c01]                   [nvarchar](3) NOT NULL,
		[_c02]                   [nvarchar](3) NOT NULL,
		[_c03]                   [nvarchar](3) NOT NULL,
		[_c04]                   [nvarchar](3) NOT NULL,
		[_c05]                   [nvarchar](3) NOT NULL,
		[_c06]                   [nvarchar](3) NOT NULL,
		[_c07]                   [nvarchar](3) NOT NULL,
		[_c08]                   [nvarchar](3) NOT NULL,
		[_c09]                   [nvarchar](3) NOT NULL,
		[_c10]                   [nvarchar](3) NOT NULL,
		[_c11]                   [nvarchar](3) NOT NULL,
		[_c12]                   [nvarchar](3) NOT NULL,
		[_c13]                   [nvarchar](3) NOT NULL,
		[_c14]                   [nvarchar](3) NOT NULL,
		[_c15]                   [nvarchar](3) NOT NULL,
		[_c16]                   [nvarchar](3) NULL,
		[_year]                  [int] NOT NULL,
		[_excluido]              [bit] NOT NULL,
		[_cerrado]               [bit] NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL
)
GO
ALTER TABLE [tra].[lista] SET (LOCK_ESCALATION = TABLE)
GO
