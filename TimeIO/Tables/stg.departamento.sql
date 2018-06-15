SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stg].[departamento] (
		[DEPTID]               [char](10) COLLATE Latin1_General_BIN NOT NULL,
		[DESCR_DEPT]           [char](30) COLLATE Latin1_General_BIN NOT NULL,
		[PARENT_NODE_NAME]     [char](20) COLLATE Latin1_General_BIN NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [stg].[departamento] SET (LOCK_ESCALATION = TABLE)
GO
