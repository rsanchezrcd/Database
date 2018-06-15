SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[checadas_manuales] (
		[id]               [uniqueidentifier] NOT NULL,
		[_codigo_src]      [int] NULL,
		[_checada_src]     [datetime] NULL,
		[_access]          [int] NOT NULL,
		[_dispositivo]     [nvarchar](50) NOT NULL,
		[_dn]              [nvarchar](20) NULL,
		[_per]             [varchar](14) NULL
)
GO
ALTER TABLE [tra].[checadas_manuales] SET (LOCK_ESCALATION = TABLE)
GO
