SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [cat].[years] (
		[_year]           [int] NOT NULL,
		[active]          [bit] NOT NULL,
		[insert_date]     [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[years]
	ADD
	CONSTRAINT [PK__years__F805CC01645DB36F]
	PRIMARY KEY
	CLUSTERED
	([_year])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[years]
	ADD
	CONSTRAINT [DF__years__active__302F0D3D]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[years]
	ADD
	CONSTRAINT [DF__years__insert_da__31233176]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[years] SET (LOCK_ESCALATION = TABLE)
GO
