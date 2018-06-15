SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stg].[employees] (
		[EMPLID]               [char](11) NOT NULL,
		[EMPL_RCD]             [smallint] NOT NULL,
		[FIRST_NAME]           [char](30) NOT NULL,
		[LAST_NAME]            [char](30) NOT NULL,
		[SECOND_LAST_NAME]     [char](30) NOT NULL,
		[DEPTID]               [char](10) NOT NULL,
		[DESCR]                [char](30) NOT NULL,
		[ORIG_HIRE_DT]         [datetime] NOT NULL,
		[JOBCODE]              [char](6) NOT NULL,
		[JOBDESCR]             [char](30) NOT NULL,
		[NUMERO]               [int] NULL,
		[EMPLCLASS]            [char](3) NOT NULL,
		[EMPL_STATUS]          [char](1) NOT NULL,
		[COMPANY]              [char](3) NOT NULL,
		[LOCATION]             [char](10) NOT NULL,
		[VACACIONES]           [int] NOT NULL,
		[HOTEL]                [int] NULL,
		[NATIONAL_ID]          [char](20) NOT NULL,
		[EFFDT]                [datetime] NOT NULL,
		[TERMINATION_DT]       [datetime] NOT NULL,
		[POSITION_NBR]         [char](8) NOT NULL,
		[POSITION_DESCR]       [nchar](56) NULL
)
GO
ALTER TABLE [stg].[employees] SET (LOCK_ESCALATION = TABLE)
GO
