SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[horas_extras_log] (
		[id_he_log]              [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[active]                 [bit] NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[id_horas_extras]        [char](36) NULL,
		[id_employee]            [char](36) NOT NULL,
		[id_periodo]             [char](36) NOT NULL,
		[_cn]                    [char](4) NOT NULL,
		[_pagadas]               [int] NOT NULL,
		[id_fecha]               [char](36) NOT NULL
)
GO
ALTER TABLE [tra].[horas_extras_log] SET (LOCK_ESCALATION = TABLE)
GO
