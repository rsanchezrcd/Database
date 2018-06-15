SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

create proc tra.proc_completa_asistencia
	@do_ope char(36)
	,@emp char(36)
	,@isentrada bit = 0
	,@checada datetime
as begin
	select getdate()

end;

GO
