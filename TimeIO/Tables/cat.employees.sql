SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[employees] (
		[employee_id]            [char](36) NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_alter_id]              [nvarchar](32) NOT NULL,
		[_nombres]               [nvarchar](64) NOT NULL,
		[_apellido_paterno]      [nvarchar](64) NOT NULL,
		[_apellido_materno]      [nvarchar](64) NULL,
		[_status]                [bit] NOT NULL,
		[_clase]                 [nvarchar](6) NOT NULL,
		[locacion_id]            [char](36) NOT NULL,
		[departamento_id]        [char](36) NOT NULL,
		[posicion_id]            [char](36) NOT NULL,
		[_legal_id]              [nvarchar](64) NULL,
		[_hire_date]             [datetime] NOT NULL,
		[_checa]                 [bit] NOT NULL,
		[_l]                     [bit] NULL,
		[_m]                     [bit] NULL,
		[_x]                     [bit] NULL,
		[_j]                     [bit] NULL,
		[_v]                     [bit] NULL,
		[_s]                     [bit] NULL,
		[_d]                     [bit] NULL,
		[_festivos]              [bit] NULL,
		[_he_txt]                [bit] NULL,
		[_he_dinero]             [bit] NULL,
		[_he_nocturnas]          [bit] NULL,
		[_fecha_baja]            [datetime] NULL
)
GO
ALTER TABLE [cat].[employees] SET (LOCK_ESCALATION = TABLE)
GO
