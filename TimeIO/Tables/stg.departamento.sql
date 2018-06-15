SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stg].[departamento] (
		[DEPTID]               [char](10) NOT NULL,
		[DESCR_DEPT]           [char](30) NOT NULL,
		[PARENT_NODE_NAME]     [char](20) NOT NULL
)
GO
ALTER TABLE [stg].[departamento] SET (LOCK_ESCALATION = TABLE)
GO
