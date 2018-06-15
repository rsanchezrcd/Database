SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [cat].[years] (
		[_year]           [int] NOT NULL,
		[active]          [bit] NOT NULL,
		[insert_date]     [datetime] NOT NULL
)
GO
ALTER TABLE [cat].[years] SET (LOCK_ESCALATION = TABLE)
GO
