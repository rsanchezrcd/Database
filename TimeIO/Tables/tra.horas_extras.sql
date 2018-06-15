SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[horas_extras] (
		[id_horas_extras]     [char](36) NOT NULL,
		[id_employee]         [char](36) NOT NULL,
		[id_periodo]          [char](36) NOT NULL,
		[_horas]              [smallint] NOT NULL,
		[_c01]                [smallint] NOT NULL,
		[_c02]                [smallint] NOT NULL,
		[_c03]                [smallint] NOT NULL,
		[_c04]                [smallint] NOT NULL,
		[_c05]                [smallint] NOT NULL,
		[_c06]                [smallint] NOT NULL,
		[_c07]                [smallint] NOT NULL,
		[_c08]                [smallint] NOT NULL,
		[_c09]                [smallint] NOT NULL,
		[_c10]                [smallint] NOT NULL,
		[_c11]                [smallint] NOT NULL,
		[_c12]                [smallint] NOT NULL,
		[_c13]                [smallint] NOT NULL,
		[_c14]                [smallint] NOT NULL,
		[_c15]                [smallint] NOT NULL,
		[_c16]                [smallint] NULL,
		[active]              [bit] NOT NULL,
		[insert_date]         [datetime] NOT NULL,
		[update_date]         [datetime] NULL,
		[_p01]                [smallint] NULL,
		[_p02]                [smallint] NULL,
		[_p03]                [smallint] NULL,
		[_p04]                [smallint] NULL,
		[_p05]                [smallint] NULL,
		[_p06]                [smallint] NULL,
		[_p07]                [smallint] NULL,
		[_p08]                [smallint] NULL,
		[_p09]                [smallint] NULL,
		[_p10]                [smallint] NULL,
		[_p11]                [smallint] NULL,
		[_p12]                [smallint] NULL,
		[_p13]                [smallint] NULL,
		[_p14]                [smallint] NULL,
		[_p15]                [smallint] NULL,
		[_p16]                [smallint] NULL,
		[_pagadas]            [int] NULL
)
GO
ALTER TABLE [tra].[horas_extras] SET (LOCK_ESCALATION = TABLE)
GO
