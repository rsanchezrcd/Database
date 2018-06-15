SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [adm].[fechas] (
		[id_fecha]               [char](36) NOT NULL,
		[fecha_int]              [int] NOT NULL,
		[fecha_nat]              [datetime] NOT NULL,
		[id_locacion]            [char](36) NOT NULL,
		[_year]                  [int] NOT NULL,
		[_month]                 [int] NOT NULL,
		[_day]                   [int] NOT NULL,
		[_per]                   [int] NOT NULL,
		[_day_week]              [int] NOT NULL,
		[_day_txt]               [nvarchar](12) NOT NULL,
		[_cN]                    [nvarchar](3) NOT NULL,
		[_festivo]               [int] NOT NULL,
		[_dia_corte]             [int] NOT NULL,
		[_cerrado]               [int] NOT NULL,
		[active]                 [int] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[_etiqueta]              [char](3) NULL,
		[_month_txt]             [nvarchar](15) NULL,
		[id_periodo]             [char](36) NULL
)
GO
ALTER TABLE [adm].[fechas] SET (LOCK_ESCALATION = TABLE)
GO
