SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [tra].[checadas] (
		[id_checada]            [char](36) NOT NULL,
		[insert_date]           [datetime] NOT NULL,
		[update_date]           [datetime] NOT NULL,
		[employee_id]           [char](36) NOT NULL,
		[_checada]              [datetime] NOT NULL,
		[_checada_fecha]        [date] NOT NULL,
		[_checada_hora]         [time](7) NOT NULL,
		[_dispositivo_code]     [nvarchar](64) NOT NULL,
		[_tipo]                 [bit] NOT NULL,
		[_sync]                 [bit] NOT NULL
)
GO
ALTER TABLE [tra].[checadas] SET (LOCK_ESCALATION = TABLE)
GO
