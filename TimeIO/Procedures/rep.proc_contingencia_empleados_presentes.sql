SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [rep].[proc_contingencia_empleados_presentes]
	@ope char(36)
	,@fec date = null
	,@loc char(36) = null
as begin
	set nocount on;
	declare @cn char(3)
			, @per char(36)
			, @per2 char(36)
			, @fec2 date
			, @cn2 char(3);
	--------------------------
	if @fec is null begin
		set @fec = getdate();
	end;
	--------------------------
	select @fec2 = dateadd(day,-1,@fec);
	--------------------------
	select @cn  = _cn from adm.fechas where fecha_nat = @fec;
	select @cn2 = _cn from adm.fechas where fecha_nat = @fec2;
	--------------------------
	if @loc is null begin
		select @loc = cat.func_get_loc_by_ope(@ope)
	end;
	--------------------------
	select   @per  = cat.func_get_id_periodo(@fec)
			,@per2 = cat.func_get_id_periodo(@fec2)

	select c._checada, c.employee_id , datediff(MINUTE, c._checada , GETDATE()) _horas 
	into #checadas
	from tra.checadas c
	where _checada = (select max(_checada) from tra.checadas where employee_id = c.employee_id);

	--------------------------
	declare @query nvarchar(max)
	set @query = N'select 
						convert(nvarchar(19),c._checada,120) [Checada]
						,c._horas [Horas]
						,e._alter_id [Codigo]
						,e._nombres [Nombre] 
						,e._apellido_paterno [ApellidoPaterno]
						,e._apellido_materno [ApellidoMaterno]
						,e._clase [Clase]
						,o._locacion_code [Locacion] 
						,d._departamento_code [DeptoID] 
						,d._departamento_name [Depto] 
						,p._posicion_code [PosicionID]
						,p._posicion_name [Posicion]
						,convert(nvarchar(16), getdate(),120) [FechaReporte]
					from tra.lista l
					inner join cat.employees e on l.id_employee = e.employee_id
					inner join cat.locacion o on e.locacion_id = o.locacion_id
					inner join cat.departamentos d on e.departamento_id = d.id_departamento
					inner join cat.posicion p on e.posicion_id = p.posicion_id
					inner join #checadas c on l.id_employee = c.employee_id
				   where 
						e.locacion_id = ''' + rtrim(@loc) +'''
					and id_periodo = ''' + rtrim(@per) +''' and _'+rtrim(@cn)+ ' = ''/''
				union all 
				select 
					 	convert(nvarchar(19),c._checada,120) [Checada]
						,c._horas [Horas] 
						,e._alter_id [Codigo]
						,e._nombres [Nombre] 
						,e._apellido_paterno [ApellidoPaterno]
						,e._apellido_materno [ApellidoMaterno]
						,e._clase [Clase]
						,o._locacion_code [Locacion] 
						,d._departamento_code [DeptoID] 
						,d._departamento_name [Depto] 
						,p._posicion_code [PosicionID]
						,p._posicion_name [Posicion]
						,convert(nvarchar(16), getdate(),120)
					from tra.lista l
					inner join cat.employees e on l.id_employee = e.employee_id
					inner join cat.locacion o on e.locacion_id = o.locacion_id
					inner join cat.departamentos d on e.departamento_id = d.id_departamento
					inner join cat.posicion p on e.posicion_id = p.posicion_id
					inner join #checadas c on l.id_employee = c.employee_id
				   where 
						e.locacion_id = ''' + rtrim(@loc) +'''
					and id_periodo = ''' + rtrim(@per2) +''' and _'+rtrim(@cn2)+ ' = ''/'' and _'+rtrim(@cn)+ ' = ''F''  ' ;
	--select @query
	exec( @query);
	drop table #checadas;
end;

GO
