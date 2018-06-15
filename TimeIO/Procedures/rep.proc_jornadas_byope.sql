SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure rep.proc_jornadas_byope
	@ope char(36)
	,@dep char(36) = '*'
	,@emp char(36) = '*'
	,@ini date = null
	,@fin date = null
as begin
	
	set nocount on;
	declare @query nvarchar(max)
	set @query = 'select 
		a.id_jornada [IDJornada]
		,rtrim(e._alter_id) [Codigo]
		,rtrim(e._nombres) [Nombres] 
		,rtrim(e._apellido_paterno) [ApellidoPaterno]
		,rtrim(e._apellido_materno) [ApellidoMaterno]
		,e._clase [Clase]
		,d._departamento_code [IDDepartamento]
		,d._departamento_name [Departamento]
		,p._posicion_code [IDPosicion]
		,p._posicion_name [Posicion]
		,cat.func_get_periodo(a.id_periodo) [Periodo]
		-------------------
		,convert(nvarchar(10),a._fecha_ent,120) [FechaInicio]
		,convert(nvarchar(19),a._entrada,120) [Entrada]
		,convert(nvarchar(19),a._salida,120) [Salida]
		,a._jornada [Jornada]
		,a.[_dispositivo_code_ent] [DispositivoEnt]
		,a.[_dispositivo_code_sal] [DispositivoSal]
		-------------------
		
		
	from tra.jornadas a
	inner join cat.employees e on a.employee_id = e.employee_id
	inner join cat.departamentos d on e.departamento_id = d.id_departamento 
	inner join cat.posicion p on e.posicion_id = p.posicion_id
	
	where  1=1  ';

	
	if @ini is not null and @fin is null set @fin = @ini;
	if @ini is null and @fin is not null set @ini = @fin;
	if @ini is null and @fin is null begin
		--declare @per char(36)
		exec cat.proc_get_fecha_ini_periodo_actual @ini output
		exec cat.proc_get_fecha_fin_periodo_actual @fin output
	end;
	set @query = @query + ' and a._fecha_ent between  ''' + rtrim(@ini) + ''' and '''+ rtrim(@fin) + '''';
	if @emp <> '*' begin
		set @query = @query + ' and e.employee_id = ''' + @emp+ '''';
	end;
	if @dep <> '*' begin
		set @query = @query + ' and e.departamento_id = ''' + @dep+ '''';
	end;

	set @query = @query + ' and e.departamento_id in (select id_departamento from cat.departamento_operator where id_operator = ''' + @ope+ ''')
	 order by [Codigo] asc, [FechaInicio] asc ';

	exec( @query)
end;

GO
