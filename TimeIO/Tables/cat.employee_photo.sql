SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[employee_photo] (
		[id_employee]         [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[insert_date]         [datetime] NULL,
		[activo]              [bit] NOT NULL,
		[_employee_photo]     [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [cat].[employee_photo]
	ADD
	CONSTRAINT [PK__employee__F807679C6C8C2965]
	PRIMARY KEY
	CLUSTERED
	([id_employee])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[employee_photo]
	ADD
	CONSTRAINT [DF__employee___activ__0307610B]
	DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [cat].[employee_photo]
	ADD
	CONSTRAINT [DF__employee___inser__02133CD2]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[employee_photo] SET (LOCK_ESCALATION = TABLE)
GO
