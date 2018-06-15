SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[ausentismo_causa] (
		[id_ausentismo_causa]     [int] IDENTITY(1, 1) NOT NULL,
		[insert_date]             [datetime] NOT NULL,
		[insert_operator_id]      [char](36) NOT NULL,
		[activo]                  [bit] NOT NULL,
		[id_tra_ausentismo]       [int] NOT NULL,
		[id_causa]                [char](36) NOT NULL,
		[_comentarios]            [text] NULL,
		[_fecha_pasada]           [date] NULL
)
GO
ALTER TABLE [tra].[ausentismo_causa] SET (LOCK_ESCALATION = TABLE)
GO
