SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [adm].[proc_create_fechas_year_location]
	@year int 
	,@id_locacion char(36)
	,@operator_id char(36)
	
as begin
	set language spanish;
	set nocount on;
	declare @ini datetime;
	declare @cur datetime, @las datetime;
	declare @per int, @cn nvarchar(3);
	select @cur = min(ini_date),@las = max(end_date) from cat.periodos where _year = @year and id_locacion = id_locacion;
	--select @cur, @las;

	while @cur < @las begin
		set @per = (select _per from cat.periodos where @cur between ini_date and end_date);
		set @cn = ( select case when datediff(day,ini_date, @cur)+1 < 10 then 'c0'+ convert(nvarchar,(datediff(day,ini_date, @cur)+1)) else 'c'+(convert(nvarchar,datediff(day,ini_date, @cur)+1)) end
						from cat.periodos where @cur between ini_date and end_date )
		if @per is null begin 
			set @per = -1;
			set @cn = '-1';
		end;
		insert into adm.fechas (fecha_int,fecha_nat, id_locacion ,_year,_month,_day, _day_week, _day_txt,_per, _cN, insert_operator_id)
			values
		(	cast(convert(varchar(8)
			, @cur,112) as int)
			, @cur
			,@id_locacion
			, year(@cur)
			, month(@cur)
			, day(@cur)
			, datepart(dw,@cur)
			, datename(dw,@cur)
			, @per
			, @cn
			, @operator_id)
		set @cur = (select dateadd(day,1, @cur));
	end

	 

	  update  [adm].[fechas] 
		set [_day_txt] = datename(weekday, fecha_nat) 
		, _etiqueta = LEFT([_day_txt], 1) + format(_day, 'd2')
		, _month_txt = datename(MONTH, fecha_nat) 
		, id_periodo = cat.func_get_id_periodo(fecha_nat)
	  where _year = @year
end;
GO
