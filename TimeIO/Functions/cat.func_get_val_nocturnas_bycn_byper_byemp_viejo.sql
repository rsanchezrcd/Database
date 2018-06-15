SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create function [cat].[func_get_val_nocturnas_bycn_byper_byemp_viejo](
  @cn char(4)
 ,@per int
 ,@yea int
 ,@emp int)

returns char(1) as
begin
	declare @val char(1)


	if @cn = 'c01' begin
		select @val = h01 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end

	if @cn = 'c02' begin
		select @val = h02 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c03' begin
		select @val = h03 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c04' begin
		select @val = h04 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c05' begin
		select @val = h05 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c06' begin
		select @val = h06 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c07' begin
		select @val = h07 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c08' begin
		select @val = h08 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c09' begin
		select @val = h09 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c10' begin
		select @val = h10 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c11' begin
		select @val = h11 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c12' begin
		select @val = h12 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c13' begin
		select @val = h13 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c14' begin
		select @val = h14 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c15' begin
		select @val = h15 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	if @cn = 'c16' begin
		select @val = h16 from 
		va.asistenciasql.dbo.horasextnoc with (nolock) 
		where periodo = @per and numero = @emp and ano = @yea;
	end
	return @val;

end

GO
