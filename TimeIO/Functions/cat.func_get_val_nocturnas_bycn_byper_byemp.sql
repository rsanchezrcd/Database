SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create function [cat].[func_get_val_nocturnas_bycn_byper_byemp](
  @cn char(4)
 ,@per char(36)
 ,@emp char(36))

returns char(1) as
begin
	declare @val char(1)


	if @cn = 'c01' begin
		select @val = _c01 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end

	if @cn = 'c02' begin
		select @val = _c02 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c03' begin
		select @val = _c03 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c04' begin
		select @val = _c04 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c05' begin
		select @val = _c05 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c06' begin
		select @val = _c06 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c07' begin
		select @val = _c07 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c08' begin
		select @val = _c08 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c09' begin
		select @val = _c09 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c10' begin
		select @val = _c10 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c11' begin
		select @val = _c11 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c12' begin
		select @val = _c12 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c13' begin
		select @val = _c13 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c14' begin
		select @val = _c14 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c15' begin
		select @val = _c15 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	if @cn = 'c16' begin
		select @val = _c16 from 
		tra.horas_nocturnas with (nolock) 
		where id_periodo = @per and id_employee = @emp;
	end
	return @val;

end

GO
