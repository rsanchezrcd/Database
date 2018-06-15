SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[lengua] (
		[lengua_id]              [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_lengua_code]           [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_lengua_txt]            [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[lengua]
	ADD
	CONSTRAINT [PK__lengua__F5867A8B3C8D8789]
	PRIMARY KEY
	CLUSTERED
	([lengua_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[lengua]
	ADD
	CONSTRAINT [DF__lengua__active__412EB0B6]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[lengua]
	ADD
	CONSTRAINT [DF__lengua__insert_d__4316F928]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[lengua]
	ADD
	CONSTRAINT [DF__lengua__insert_o__4222D4EF]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[lengua]
	ADD
	CONSTRAINT [DF__lengua__lengua_i__403A8C7D]
	DEFAULT (newid()) FOR [lengua_id]
GO
ALTER TABLE [cat].[lengua]
	ADD
	CONSTRAINT [DF__lengua__update_d__440B1D61]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[lengua] SET (LOCK_ESCALATION = TABLE)
GO
