SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure rep.proc_ausentismo_byope
	@ope char(36)
	,@aus char(36)= '*'
	,@dep char(36) = '*'
	,@emp char(36) = '*'
	,@ini date = null
	,@fin date = null
as begin
	
	set nocount on;
	declare @query nvarchar(max)
	set @query = 'select 
		a.id_tra_ausentismo [IDTraAusentismo]
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
		--,a.id_ausentismo
		,convert(nvarchar(10),a._ausentismo_date,120) [FechaAusentismo]
		,u._letra [Letra]
		,upper(u._descripcion) [DescripcionAusentismo] 
		,(case 
			when _viejo = 1 then isnull(a._comentarios_viejo,''-'') 
			else cat.func_get_causa(ac.id_causa) end) [Causa]
		,convert(nvarchar(19),a.insert_date,120) [FechaCaptura]
		,upper(cat.func_get_operator(a.insert_operator_id)) [UsuarioCaptura]
		,isnull(_comentarios,''-'') [Comentarios]
		,isnull(convert(nvarchar(10),_fecha_pasada,120),''-'') [FechaTomada]
		--,a._deleted , a._sync
	from tra.ausentismos a
	inner join cat.employees e on a.employee_id = e.employee_id
	inner join cat.ausentismos u on a.id_ausentismo = u.id_ausentismo
	inner join cat.departamentos d on e.departamento_id = d.id_departamento 
	inner join cat.posicion p on e.posicion_id = p.posicion_id
	left join tra.ausentismo_causa ac on a.id_tra_ausentismo = ac.id_tra_ausentismo
	where a.id_tra_ausentismo is not null  and a.active = 1 and isnull(a._deleted, 0) = 0 and a._sync = 1 and u._reportes = 1';

	if @aus <> '*' begin
		set @query = @query + ' and a.id_ausentismo = ''' + @aus+ '''';
	end;
	if @ini is not null and @fin is null set @fin = @ini;
	if @ini is null and @fin is not null set @ini = @fin;
	if @ini is null and @fin is null begin
		--declare @per char(36)
		exec cat.proc_get_fecha_ini_periodo_actual @ini output
		exec cat.proc_get_fecha_fin_periodo_actual @fin output
	end;
	set @query = @query + ' and a._ausentismo_date between  ''' + rtrim(@ini) + ''' and '''+ rtrim(@fin) + '''';
	if @emp <> '*' begin
		set @query = @query + ' and e.employee_id = ''' + @emp+ '''';
	end;
	if @dep <> '*' begin
		set @query = @query + ' and e.departamento_id = ''' + @dep+ '''';
	end;

	set @query = @query + ' and e.departamento_id in (select id_departamento from cat.departamento_operator where id_operator = ''' + @ope+ ''')
	 order by [Codigo] asc, [FechaAusentismo] asc ';

	exec( @query)
end;

GO
