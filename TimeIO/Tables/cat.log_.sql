SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [cat].[log_] (
		[id_log]                     [int] IDENTITY(1, 1) NOT NULL,
		[fecha_insert]               [datetime] NOT NULL,
		[id_operator]                [char](36) NOT NULL,
		[_tabla]                     [sysname] NOT NULL,
		[_delete]                    [bit] NULL,
		[_insert]                    [bit] NULL,
		[_update]                    [bit] NULL,
		[_affected_operator]         [char](36) NULL,
		[_affected_column]           [sysname] NULL,
		[_affected_column_value]     [nvarchar](128) NULL
)
GO
ALTER TABLE [cat].[log_] SET (LOCK_ESCALATION = TABLE)
GO
