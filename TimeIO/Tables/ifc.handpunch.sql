SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[handpunch] (
		[id_source]        [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[fecha_insert]     [datetime] NOT NULL,
		[_codigo_src]      [int] NULL,
		[_codigo_des]      [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_checada]         [datetime] NULL,
		[id_regla]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_subio]           [bit] NOT NULL,
		[id_destino]       [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_comentarios]     [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_tipo]            [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_jornada]         [float] NULL,
		[_SE]              [datetime] NULL,
		[_ES]              [datetime] NULL,
		[_EE]              [datetime] NULL,
		[_dispositivo]     [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_dn]              [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [ifc].[handpunch]
	ADD
	CONSTRAINT [PK__handpunc__396BC6565DF70912]
	PRIMARY KEY
	CLUSTERED
	([id_source])
	ON [PRIMARY]
GO
ALTER TABLE [ifc].[handpunch]
	ADD
	CONSTRAINT [DF__handpunch__fecha__513AFB4D]
	DEFAULT (getdate()) FOR [fecha_insert]
GO
ALTER TABLE [ifc].[handpunch] SET (LOCK_ESCALATION = TABLE)
GO
