SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [ifc].[proc_sync_festivos] 
	@loc char(36) = null
as begin
	set nocount on;	
	declare @fecha date;
	select @fecha = dateadd(day,-1,GETDATE())

	if (exists( select id_festivo from cat.festivo where [_festivo_date] = @fecha and [id_locacion] = @loc)) begin
		declare @cn char(4),@per char(36)
		select @cn = _cN , @per= id_periodo from adm.fechas where fecha_nat = @fecha;
		declare @query nvarchar(max);
		set @query = N'update l 
			set _'+rtrim(@cn)+' = ''D''
		from tra.lista l with(nolock)
		inner join cat.employees e with(nolock)	on (l.id_employee = e.employee_id)			
		where l.id_periodo = '''+rtrim(@per)+''' and e.locacion_id = '''+rtrim(@loc)+'''
			and LEFT(ltrim(rtrim(l._'+rtrim(@cn)+')), 1) = ''F''
			and LEFT(ltrim(rtrim(l._'+rtrim(@cn)+')), 1) not in (select _letra from cat.ausentismos where _reescribible = 0)';
		exec(@query);

		IF OBJECT_ID('tempdb..#tmpFestivos') IS NOT NULL
			DROP TABLE #tmpFestivos;
		create table #tmpFestivos ( _emp char(36), _per char(36), _fec date, _cn char(4));
		set @query = N'select e.employee_id , l.id_periodo, '''+rtrim(@fecha)+''' , '''+rtrim(@cn)+'''
	
		from tra.lista l with(nolock)
		inner join cat.employees e with(nolock)	on (l.id_employee = e.employee_id)			
		where l.id_periodo = '''+rtrim(@per)+'''  and e.locacion_id = '''+rtrim(@loc)+'''
			and LEFT(ltrim(rtrim(l._'+rtrim(@cn)+')), 1) = ''F''
			and LEFT(ltrim(rtrim(l._'+rtrim(@cn)+')), 1) not in (select _letra from cat.ausentismos where _reescribible = 0)';
		insert into #tmpFestivos exec(@query);

		insert into tra.ausentismos (insert_operator_id, employee_id, id_ausentismo, id_periodo, _ausentismo_date,_cN, _sync, active)
		select 'INTERFACE-FESTIVOS00-000000000-00000', _emp, cat.func_get_id_ausentismo('D'), _per,_fec,_cn, 1, 1 from #tmpFestivos
	end;
		
end;

GO
