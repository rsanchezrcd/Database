SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc cat.proc_sync_prestaciones_from_old
as begin
	set nocount on

	begin try
		begin transaction
			update p
				set  p._horas_extras = v._horas_extras
					,p._festivos = v._festivos
					,p._horas_nocturnas = v._horas_nocturnas
					,p._prima_dominical = v._prima_dominical
			from cat.vw_posicion_prestacion_from_va v
			inner join cat.posicion p with(nolock) on p._posicion_code = v._posicion_code 
		commit transaction
	end try
	begin catch
		print 'Error: ' + error_message();
		rollback transaction
	end catch
end
 
GO
