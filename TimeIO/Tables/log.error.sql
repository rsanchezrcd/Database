SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[error] (
		[id_error]             [int] IDENTITY(1, 1) NOT NULL,
		[fecha_insert]         [datetime] NOT NULL,
		[id_operator]          [char](36) NOT NULL,
		[_error_number]        [int] NULL,
		[_error_severity]      [int] NULL,
		[_error_state]         [int] NULL,
		[_error_procedure]     [nvarchar](128) NOT NULL,
		[_error_line]          [int] NOT NULL,
		[_error_message]       [nvarchar](4000) NOT NULL
)
GO
ALTER TABLE [log].[error] SET (LOCK_ESCALATION = TABLE)
GO
