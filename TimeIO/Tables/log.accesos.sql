SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[accesos] (
		[id_acceso]          [int] IDENTITY(1, 1) NOT NULL,
		[id_operator]        [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_fecha_acceso]      [datetime] NOT NULL,
		[_from_ip]           [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_from_hostname]     [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [log].[accesos]
	ADD
	CONSTRAINT [PK__accesos__F2593D4A4280A257]
	PRIMARY KEY
	CLUSTERED
	([id_acceso])
	ON [PRIMARY]
GO
ALTER TABLE [log].[accesos]
	ADD
	CONSTRAINT [DF__accesos___fecha___0DCF0841]
	DEFAULT (getdate()) FOR [_fecha_acceso]
GO
ALTER TABLE [log].[accesos]
	ADD
	CONSTRAINT [DF__accesos___from_h__0FB750B3]
	DEFAULT ('undefined') FOR [_from_hostname]
GO
ALTER TABLE [log].[accesos]
	ADD
	CONSTRAINT [DF__accesos___from_i__0EC32C7A]
	DEFAULT ('255.255.255.255') FOR [_from_ip]
GO
ALTER TABLE [log].[accesos] SET (LOCK_ESCALATION = TABLE)
GO
