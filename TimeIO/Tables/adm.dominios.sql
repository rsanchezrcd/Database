SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[dominios] (
		[id_dominio]      [nvarchar](64) NOT NULL,
		[active]          [bit] NOT NULL,
		[insert_date]     [datetime] NOT NULL,
		[_ou_grupo]       [nvarchar](254) NOT NULL,
		[_base_dn]        [nvarchar](64) NOT NULL,
		[_host]           [nvarchar](64) NOT NULL,
		[_port]           [int] NOT NULL,
		[_grupo]          [nvarchar](54) NULL,
		[_bind_user]      [nvarchar](64) NULL,
		[_bind_pass]      [nvarchar](64) NULL
)
GO
ALTER TABLE [adm].[dominios] SET (LOCK_ESCALATION = TABLE)
GO
