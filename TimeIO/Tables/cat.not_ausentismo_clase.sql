SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[not_ausentismo_clase] (
		[id]                     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]            [datetime] NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[active]                 [bit] NOT NULL,
		[_clase]                 [nvarchar](6) NOT NULL,
		[id_ausentismo]          [char](36) NOT NULL
)
GO
ALTER TABLE [cat].[not_ausentismo_clase] SET (LOCK_ESCALATION = TABLE)
GO
