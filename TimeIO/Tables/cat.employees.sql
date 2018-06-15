SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[employees] (
		[employee_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_alter_id]              [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_nombres]               [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_apellido_paterno]      [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_apellido_materno]      [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_status]                [bit] NOT NULL,
		[_clase]                 [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[locacion_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[departamento_id]        [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[posicion_id]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_legal_id]              [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
		[_fecha_baja]            [datetime] NULL,
		CONSTRAINT [UQ__employee__19F3321671365274]
		UNIQUE
		NONCLUSTERED
		([_alter_id])
		ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [PK__employee__C52E0BA8DB4DDD6E]
	PRIMARY KEY
	CLUSTERED
	([employee_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___chec__2CA8951C]
	DEFAULT ((1)) FOR [_checa]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___d__29971E47]
	DEFAULT ((0)) FOR [_d]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___fest__2A8B4280]
	DEFAULT ((0)) FOR [_festivos]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___he_d__2C738AF2]
	DEFAULT ((0)) FOR [_he_dinero]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___he_n__2D67AF2B]
	DEFAULT ((0)) FOR [_he_nocturnas]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___he_t__2B7F66B9]
	DEFAULT ((0)) FOR [_he_txt]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___j__26BAB19C]
	DEFAULT ((0)) FOR [_j]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___l__23DE44F1]
	DEFAULT ((0)) FOR [_l]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___m__24D2692A]
	DEFAULT ((0)) FOR [_m]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___s__28A2FA0E]
	DEFAULT ((0)) FOR [_s]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___stat__2BB470E3]
	DEFAULT ((0)) FOR [_status]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___v__27AED5D5]
	DEFAULT ((0)) FOR [_v]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees___x__25C68D63]
	DEFAULT ((0)) FOR [_x]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees__activ__29CC2871]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees__emplo__28D80438]
	DEFAULT (newid()) FOR [employee_id]
GO
ALTER TABLE [cat].[employees]
	ADD
	CONSTRAINT [DF__employees__inser__2AC04CAA]
	DEFAULT (getdate()) FOR [insert_date]
GO
CREATE UNIQUE NONCLUSTERED INDEX [nci_employees_alter_id]
	ON [cat].[employees] ([_alter_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[employees] SET (LOCK_ESCALATION = TABLE)
GO
