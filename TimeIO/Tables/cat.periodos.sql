SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[periodos] (
		[id_periodo]             [char](36) NOT NULL,
		[id_locacion]            [char](36) NOT NULL,
		[_per]                   [int] NOT NULL,
		[_days]                  [tinyint] NOT NULL,
		[ini_date]               [datetime] NOT NULL,
		[end_date]               [datetime] NOT NULL,
		[ini_nat_date]           [datetime] NOT NULL,
		[end_nat_date]           [datetime] NOT NULL,
		[_year]                  [smallint] NOT NULL,
		[_cerrado]               [bit] NOT NULL,
		[_dia_cierre]            [datetime] NULL,
		[active]                 [int] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[_actual]                [bit] NULL
)
GO
ALTER TABLE [cat].[periodos] SET (LOCK_ESCALATION = TABLE)
GO
