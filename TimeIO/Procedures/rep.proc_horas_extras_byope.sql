SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [rep].[proc_horas_extras_byope]
	@ope char(36)
	,@dep char(36) = '*'
	,@emp char(36) = '*'
	,@ini date = null
	,@fin date = null
as begin
	
	set nocount on;
	declare @query nvarchar(max)
	set @query = 'select distinct
		a.id_he_log [IDHorasExtrasLog]
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
		,convert(nvarchar(19),cat.func_get_fecha_bycn_byper(a._cn,a.id_periodo),120) [FechaJornada]
		,a._pagadas [Horas]
		
		,convert(nvarchar(19),a.insert_date,120) [FechaCaptura]
		,upper(cat.func_get_operator(a.insert_operator_id)) [UsuarioCaptura]
		
	from tra.horas_extras_log a
	inner join cat.employees e on a.id_employee = e.employee_id
	inner join cat.departamentos d on e.departamento_id = d.id_departamento 
	inner join cat.posicion p on e.posicion_id = p.posicion_id
	
	where  a.active = 1 and a._pagadas > 0 ';

	
	if @ini is not null and @fin is null set @fin = @ini;
	if @ini is null and @fin is not null set @ini = @fin;
	if @ini is null and @fin is null begin
		--declare @per char(36)
		exec cat.proc_get_fecha_ini_periodo_actual @ini output
		exec cat.proc_get_fecha_fin_periodo_actual @fin output
	end;
	set @query = @query + ' and cat.func_get_fecha_bycn_byper(a._cn,a.id_periodo) between  ''' + rtrim(@ini) + ''' and '''+ rtrim(@fin) + '''';
	if @emp <> '*' begin
		set @query = @query + ' and e.employee_id = ''' + @emp+ '''';
	end;
	if @dep <> '*' begin
		set @query = @query + ' and e.departamento_id = ''' + @dep+ '''';
	end;

	set @query = @query + ' and e.departamento_id in (select id_departamento from cat.departamento_operator where id_operator = ''' + @ope+ ''')
	 order by [Codigo] asc, [FechaJornada] asc ';

	exec( @query)
end;

GO
