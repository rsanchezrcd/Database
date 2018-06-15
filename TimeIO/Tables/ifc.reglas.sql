SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[reglas] (
		[id_regla]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[fecha_insert]     [datetime] NOT NULL,
		[activo]           [bit] NOT NULL,
		[id_interface]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_code]            [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_descripcion]     [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_valor]           [int] NOT NULL,
		[_unidad]          [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ifc].[reglas]
	ADD
	CONSTRAINT [PK__reglas__46D1C1924921EB1D]
	PRIMARY KEY
	CLUSTERED
	([id_regla])
	ON [PRIMARY]
GO
ALTER TABLE [ifc].[reglas]
	ADD
	CONSTRAINT [DF__reglas__activo__6C8E1007]
	DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [ifc].[reglas]
	ADD
	CONSTRAINT [DF__reglas__fecha_in__6B99EBCE]
	DEFAULT (getdate()) FOR [fecha_insert]
GO
ALTER TABLE [ifc].[reglas]
	ADD
	CONSTRAINT [DF__reglas__id_regla__6AA5C795]
	DEFAULT (newid()) FOR [id_regla]
GO
ALTER TABLE [ifc].[reglas] SET (LOCK_ESCALATION = TABLE)
GO
