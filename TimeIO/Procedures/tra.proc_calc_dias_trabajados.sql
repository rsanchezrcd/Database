SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc tra.proc_calc_dias_trabajados
	@id_periodo char(36)
	,@employee_id char(36)
	,@days tinyint OUTPUT

as begin
	set nocount on;

	declare @items table (_letra char(2))
	declare @fecha_ini date, @fecha_fin date, @q nvarchar(1024)
	
	exec [cat].[proc_get_fecha_ini_periodo_actual] @fecha_ini OUTPUT
	exec [cat].[proc_get_fecha_fin_periodo_actual] @fecha_fin OUTPUT
	while (@fecha_ini <= @fecha_fin) begin
	
		select
			 @q = 'select left(rtrim(_' + _cn + '),1) from tra.lista where id_employee = ''' + @employee_id+'''
				and id_periodo = '''+ @id_periodo + '''' 
		from adm.fechas where fecha_nat = @fecha_ini  

		insert into @items (_letra)
		exec(@q) 	

		set @fecha_ini = DATEADD(DAY, 1, @fecha_ini);
	end;

	select 
		--i._letra	
		@days = sum(case when a._asistencia = 1 then 1 else 0 end)	  
	from @items i
	inner join cat.ausentismos a on a.id_ausentismo = cat.func_get_id_ausentismo(i._letra)

end
 

GO
