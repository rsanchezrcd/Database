SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[handpunch] (
		[id_source]        [char](36) NOT NULL,
		[fecha_insert]     [datetime] NOT NULL,
		[_codigo_src]      [int] NULL,
		[_codigo_des]      [char](36) NULL,
		[_checada]         [datetime] NULL,
		[id_regla]         [char](36) NOT NULL,
		[_subio]           [bit] NOT NULL,
		[id_destino]       [char](36) NULL,
		[_comentarios]     [nvarchar](128) NULL,
		[_tipo]            [char](1) NULL,
		[_jornada]         [float] NULL,
		[_SE]              [datetime] NULL,
		[_ES]              [datetime] NULL,
		[_EE]              [datetime] NULL,
		[_dispositivo]     [nvarchar](32) NULL,
		[_dn]              [char](2) NULL
)
GO
ALTER TABLE [ifc].[handpunch] SET (LOCK_ESCALATION = TABLE)
GO
