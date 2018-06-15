SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[accesos] (
		[id_acceso]          [int] IDENTITY(1, 1) NOT NULL,
		[id_operator]        [char](36) NOT NULL,
		[_fecha_acceso]      [datetime] NOT NULL,
		[_from_ip]           [nvarchar](15) NOT NULL,
		[_from_hostname]     [nvarchar](32) NOT NULL
)
GO
ALTER TABLE [log].[accesos] SET (LOCK_ESCALATION = TABLE)
GO
