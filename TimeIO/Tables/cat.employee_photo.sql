SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[employee_photo] (
		[id_employee]         [char](36) NOT NULL,
		[insert_date]         [datetime] NULL,
		[activo]              [bit] NOT NULL,
		[_employee_photo]     [image] NULL
)
GO
ALTER TABLE [cat].[employee_photo] SET (LOCK_ESCALATION = TABLE)
GO
