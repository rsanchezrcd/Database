SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_validar_fecha_tomada]
	@emp char(36) 
	,@fec date
	,@isfestivo bit = 0
	,@res bit OUTPUT
as begin 
	set nocount on;

	declare @cn char(4), @per char(36), @val char(1), @loc char(36)
	
	select @cn = _cn , @per = id_periodo from adm.fechas where fecha_nat = @fec;
	set @cn = replace(@cn, '_', '');
	select @val = left(cat.func_get_val_lista_bycn_byper_byemp(@cn, @per, @emp),1);
	select @loc = locacion_id from cat.employees where employee_id = @emp;
	if @fec >= convert(date, getdate()) begin 
		set @res = 0;
		return;
	end

	if (not exists (	select ac.id_ausentismo_causa from tra.ausentismo_causa  ac
						inner join tra.ausentismos a on  ac.id_tra_ausentismo = a.id_tra_ausentismo
						where _fecha_pasada = @fec and a.employee_id = @emp and a.active = 1) 
		and @val in ('A','.', 'T')) begin

		if @isfestivo = 1 begin
			if (exists(select id_festivo from cat.festivo where _festivo_date = @fec and active = 1 and id_locacion = @loc)) begin
				set @res = 1;
			end else begin 
				set @res = 0;
			end;
		end else begin
			set @res = 1;
		end;
	end else begin
		set @res = 0;
	end;
end; 


GO
