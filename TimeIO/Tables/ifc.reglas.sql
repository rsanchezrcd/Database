SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ifc].[reglas] (
		[id_regla]         [char](36) NOT NULL,
		[fecha_insert]     [datetime] NOT NULL,
		[activo]           [bit] NOT NULL,
		[id_interface]     [char](36) NOT NULL,
		[_code]            [nvarchar](2) NULL,
		[_descripcion]     [nvarchar](128) NULL,
		[_valor]           [int] NOT NULL,
		[_unidad]          [nvarchar](64) NOT NULL
)
GO
ALTER TABLE [ifc].[reglas] SET (LOCK_ESCALATION = TABLE)
GO
