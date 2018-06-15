SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc tra.proc_recalc_tra_lista
	@per char(36)
	,@emp char(36)
as begin
	set nocount on;
	declare  @cerrado bit
			,@fec_ini datetime
			,@query nvarchar(max)
			,@cn char(4)
			,@jor int
			,@let char(1)
			,@id char(36)
			,@aus char(1)
			,@id_tra_aus int
	declare @c table (id char(36),_cN char(4), _jor int,_let char(1),_sync bit, _ins datetime, _aus char(1), id_tra_aus int )
	
	select @cerrado = _cerrado from cat.periodos 
	where id_periodo = @per; 

	if @cerrado = 0 begin
	
		exec cat.proc_get_fecha_ini_periodo @per ,@fec_ini OUTPUT

		insert into @c(id,_cN, _jor, _let ,_sync, _ins, _aus, id_tra_aus)
		select 
			 NEWID()
			,j._cN
			,j._jornada
			,case when j._jornada is null then '/' else '.' end
			,0
			,j.insert_date
			,(select top 1 cat.func_get_letra(a.id_ausentismo) 
				from tra.ausentismos a with(nolock)
				where a.active = 1 and a._cN = j._cN and a.id_periodo = j.id_periodo and a.employee_id = j.employee_id
				order by a.insert_date desc)
			,(select top 1 id_tra_ausentismo
				from tra.ausentismos a with(nolock)
				where a.active = 1 and a._cN = j._cN and a.id_periodo = j.id_periodo and a.employee_id = j.employee_id
				order by a.insert_date desc)
		from tra.jornadas j with(nolock)
		where 
				j.id_periodo = @per
			and j.employee_id = @emp;			

		select 
			id
			,_cN
			,_jor
			,_let
			,_sync
			,_ins
			,_aus
			,id_tra_aus
		from @c order by _ins asc

		while (exists(select _sync from @c where _sync = 0)) begin
			select top 1 
				@id = id
				,@cn = _cn 
				,@let = _let
				,@aus = _aus
				,@id_tra_aus = id_tra_aus
			from @c 
			where _sync = 0
			order by _ins asc;
			select @query = 'update tra.lista	
				set _'+ @cn + ' = (case isnull(_'+ @cn + ' ,''nul'')
									when ''.'' then ''/'' 
									when ''F'' then ''/'' 
									when ''nul'' then ''/'' 
									else LEFT(_'+ @cn + ', 1) + ''/'' end)								  			
				where id_employee = '''+ @emp+''' and id_periodo = ''' + @per +''' ';		
			--select (@query);
			update @c
				set _sync = 1
			where id = id
		end
	end else begin
		return;
	end
end

GO
