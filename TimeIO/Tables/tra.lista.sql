SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[lista] (
		[id_lista]               [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_employee]            [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[id_periodo]             [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_days]                  [tinyint] NOT NULL,
		[_c01]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c02]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c03]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c04]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c05]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c06]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c07]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c08]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c09]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c10]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c11]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c12]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c13]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c14]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c15]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_c16]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[_year]                  [int] NOT NULL,
		[_excluido]              [bit] NOT NULL,
		[_cerrado]               [bit] NOT NULL,
		[active]                 [bit] NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[update_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[update_operator_id]     [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [PK__lista__C100E2E58F7ACFCF]
	PRIMARY KEY
	CLUSTERED
	([id_lista])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c01__4A38F803]
	DEFAULT ('F') FOR [_c01]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c02__4B2D1C3C]
	DEFAULT ('F') FOR [_c02]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c03__4C214075]
	DEFAULT ('F') FOR [_c03]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c04__4D1564AE]
	DEFAULT ('F') FOR [_c04]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c05__4E0988E7]
	DEFAULT ('F') FOR [_c05]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c06__4EFDAD20]
	DEFAULT ('F') FOR [_c06]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c07__4FF1D159]
	DEFAULT ('F') FOR [_c07]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c08__50E5F592]
	DEFAULT ('F') FOR [_c08]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c09__51DA19CB]
	DEFAULT ('F') FOR [_c09]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c10__52CE3E04]
	DEFAULT ('F') FOR [_c10]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c11__53C2623D]
	DEFAULT ('F') FOR [_c11]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c12__54B68676]
	DEFAULT ('F') FOR [_c12]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c13__55AAAAAF]
	DEFAULT ('F') FOR [_c13]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c14__569ECEE8]
	DEFAULT ('F') FOR [_c14]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c15__5792F321]
	DEFAULT ('F') FOR [_c15]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___c16__61915EA7]
	DEFAULT ('F') FOR [_c16]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___cerrado__5B638405]
	DEFAULT ((0)) FOR [_cerrado]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___days__4944D3CA]
	DEFAULT ((0)) FOR [_days]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___excluido__5A6F5FCC]
	DEFAULT ((0)) FOR [_excluido]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista___year__597B3B93]
	DEFAULT (datepart(year,getdate())) FOR [_year]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista__active__5C57A83E]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista__id_lista__4850AF91]
	DEFAULT (newid()) FOR [id_lista]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista__insert_da__5D4BCC77]
	DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [tra].[lista]
	ADD
	CONSTRAINT [DF__lista__update_da__5E3FF0B0]
	DEFAULT (getdate()) FOR [update_date]
GO
CREATE NONCLUSTERED INDEX [nci_id_employee]
	ON [tra].[lista] ([id_employee])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [nci_id_periodo]
	ON [tra].[lista] ([id_periodo])
	ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [unique_employee_periodo]
	ON [tra].[lista] ([id_employee], [id_periodo])
	ON [PRIMARY]
GO
ALTER TABLE [tra].[lista] SET (LOCK_ESCALATION = TABLE)
GO
