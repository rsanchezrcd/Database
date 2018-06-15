SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[paises] (
		[country_id]             [char](36) NOT NULL,
		[_country_name]          [nvarchar](64) NOT NULL,
		[_code]                  [nvarchar](2) NOT NULL,
		[_region]                [nvarchar](64) NULL,
		[lengua_id]              [char](36) NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL
)
GO
ALTER TABLE [cat].[paises] SET (LOCK_ESCALATION = TABLE)
GO
