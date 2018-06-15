SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/

CREATE proc [cat].[proc_cerrar_periodo]
	 @year int
	,@per int
	,@result bit OUTPUT
as begin
	set nocount on;
	begin try 
		begin transaction
			update cat.periodos
				set  _cerrado = 1
					,_actual = 0
			where _year = @year and _per = @per;


			declare @fec_ini_per datetime
			if @per = 24 begin
				update cat.periodos
					set _actual = 1
				where _year = (@year + 1) and _per = (@per + 1);

				----------------------------------------
				-- Eliminamos del periodo a las bajas
				----------------------------------------
				exec cat.proc_get_fecha_ini_periodo_actual @fec_ini_per OUTPUT
				delete from tra.lista 
				where cat.func_isactive_bydt(@fec_ini_per, id_employee) = 0
				and id_periodo = cat.func_get_id_periodo_by_datos(@year, @per+1);
			end else begin
				update cat.periodos
					set _actual = 1
				where _year = @year and _per = (@per + 1);


				----------------------------------------
				-- Eliminamos del periodo a las bajas
				----------------------------------------
				exec cat.proc_get_fecha_ini_periodo_actual @fec_ini_per OUTPUT
				delete from tra.lista 
				where cat.func_isactive_bydt(@fec_ini_per, id_employee) = 0
				and id_periodo = cat.func_get_id_periodo_by_datos(@year, @per+1);
			end

			set @result = 1;
		commit transaction
	end try 
	begin catch
		rollback transaction
		set @result = 0;
		print 'Error: ' + error_message();
		
	end catch
	
end 

GO
