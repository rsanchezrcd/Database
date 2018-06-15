SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stg].[employees] (
		[EMPLID]               [char](11) COLLATE Latin1_General_BIN NOT NULL,
		[EMPL_RCD]             [smallint] NOT NULL,
		[FIRST_NAME]           [char](30) COLLATE Latin1_General_BIN NOT NULL,
		[LAST_NAME]            [char](30) COLLATE Latin1_General_BIN NOT NULL,
		[SECOND_LAST_NAME]     [char](30) COLLATE Latin1_General_BIN NOT NULL,
		[DEPTID]               [char](10) COLLATE Latin1_General_BIN NOT NULL,
		[DESCR]                [char](30) COLLATE Latin1_General_BIN NOT NULL,
		[ORIG_HIRE_DT]         [datetime] NOT NULL,
		[JOBCODE]              [char](6) COLLATE Latin1_General_BIN NOT NULL,
		[JOBDESCR]             [char](30) COLLATE Latin1_General_BIN NOT NULL,
		[NUMERO]               [int] NULL,
		[EMPLCLASS]            [char](3) COLLATE Latin1_General_BIN NOT NULL,
		[EMPL_STATUS]          [char](1) COLLATE Latin1_General_BIN NOT NULL,
		[COMPANY]              [char](3) COLLATE Latin1_General_BIN NOT NULL,
		[LOCATION]             [char](10) COLLATE Latin1_General_BIN NOT NULL,
		[VACACIONES]           [int] NOT NULL,
		[HOTEL]                [int] NULL,
		[NATIONAL_ID]          [char](20) COLLATE Latin1_General_BIN NOT NULL,
		[EFFDT]                [datetime] NOT NULL,
		[TERMINATION_DT]       [datetime] NOT NULL,
		[POSITION_NBR]         [char](8) COLLATE Latin1_General_BIN NOT NULL,
		[POSITION_DESCR]       [nchar](56) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [ci_numero]
	ON [stg].[employees] ([NUMERO])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [nci_deptid]
	ON [stg].[employees] ([DEPTID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [nci_jobcode]
	ON [stg].[employees] ([JOBCODE])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [nci_location]
	ON [stg].[employees] ([LOCATION])
	ON [PRIMARY]
GO
ALTER TABLE [stg].[employees] SET (LOCK_ESCALATION = TABLE)
GO
