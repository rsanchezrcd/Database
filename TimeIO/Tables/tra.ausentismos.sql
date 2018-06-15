SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[ausentismos] (
		[id_tra_ausentismo]      [int] IDENTITY(1, 1) NOT NULL,
		[insert_operator_id]     [char](36) NOT NULL,
		[update_operator_id]     [char](36) NULL,
		[insert_date]            [datetime] NULL,
		[update_date]            [datetime] NULL,
		[active]                 [bit] NOT NULL,
		[id_ausentismo]          [char](36) NOT NULL,
		[_ausentismo_date]       [datetime] NOT NULL,
		[employee_id]            [char](36) NOT NULL,
		[_cN]                    [nvarchar](3) NOT NULL,
		[id_periodo]             [char](36) NOT NULL,
		[_sync]                  [bit] NULL,
		[_deleted]               [bit] NULL,
		[_folio]                 [nvarchar](10) NULL,
		[_ps_type]               [char](1) NULL,
		[_comentarios_viejo]     [text] NULL,
		[_viejo]                 [bit] NULL
)
GO
EXEC sp_addextendedproperty N'MS_Description', N'Folio de Incapacidad', 'SCHEMA', N'tra', 'TABLE', N'ausentismos', 'COLUMN', N'_folio'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Tipo de Incapacidad PS', 'SCHEMA', N'tra', 'TABLE', N'ausentismos', 'COLUMN', N'_ps_type'
GO
ALTER TABLE [tra].[ausentismos] SET (LOCK_ESCALATION = TABLE)
GO
