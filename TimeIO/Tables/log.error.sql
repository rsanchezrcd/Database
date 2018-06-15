SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[error] (
		[id_error]             [int] IDENTITY(1, 1) NOT NULL,
		[fecha_insert]         [datetime] NOT NULL,
		[id_operator]          [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_error_number]        [int] NULL,
		[_error_severity]      [int] NULL,
		[_error_state]         [int] NULL,
		[_error_procedure]     [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_error_line]          [int] NOT NULL,
		[_error_message]       [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [log].[error]
	ADD
	CONSTRAINT [PK__error__F2369A8AA4EAF8BB]
	PRIMARY KEY
	CLUSTERED
	([id_error])
	ON [PRIMARY]
GO
ALTER TABLE [log].[error]
	ADD
	CONSTRAINT [DF__error__fecha_ins__2C09769E]
	DEFAULT (getdate()) FOR [fecha_insert]
GO
CREATE NONCLUSTERED INDEX [nci_fecha_insert]
	ON [log].[error] ([fecha_insert] DESC)
	ON [PRIMARY]
GO
ALTER TABLE [log].[error] SET (LOCK_ESCALATION = TABLE)
GO
