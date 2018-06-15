SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[paises] (
		[country_id]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_country_name]          [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_code]                  [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_region]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[lengua_id]              [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [cat].[paises]
	ADD
	CONSTRAINT [PK__paises__7E8CD05575D9608F]
	PRIMARY KEY
	CLUSTERED
	([country_id])
	ON [PRIMARY]
GO
ALTER TABLE [cat].[paises]
	ADD
	CONSTRAINT [DF__paises__active__5070F446]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [cat].[paises]
	ADD
	CONSTRAINT [DF__paises__country___4F7CD00D]
	DEFAULT (newid()) FOR [country_id]
GO
ALTER TABLE [cat].[paises]
	ADD
	CONSTRAINT [DF__paises__insert_d__52593CB8]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [cat].[paises]
	ADD
	CONSTRAINT [DF__paises__insert_o__5165187F]
	DEFAULT ((0)) FOR [insert_operator_id]
GO
ALTER TABLE [cat].[paises]
	ADD
	CONSTRAINT [DF__paises__update_d__534D60F1]
	DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [cat].[paises] SET (LOCK_ESCALATION = TABLE)
GO
