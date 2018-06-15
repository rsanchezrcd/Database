SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc cat.proc_get_permiso_letra_by_count
	@per char(36), @emp char(36), @letra char(1), @result bit OUTPUT
as begin 
	set nocount on;
	declare @c int, @m int

	select  @c = _count, @m = a._max_periodo from
	
	(select id_employee, _letra, count(*) _count from
	(select id_employee,_c01,	_c02,	_c03,	_c04,	_c05,	_c06,	_c07,	_c08,	_c09,	_c10,	_c11,	_c12,	_c13,	_c14,	_c15,	_c16
	 from tra.lista where id_periodo = @per and id_employee = @emp ) dias
	unpivot
	(_letra FOR AusenNUM IN (_c01,	_c02,	_c03,	_c04,	_c05,	_c06,	_c07,	_c08,	_c09,	_c10,	_c11,	_c12,	_c13,	_c14,	_c15,	_c16)
	) AS c	
	group by id_employee, _letra) cc

	right join cat.ausentismos a on cc._letra = a._letra
	where a._letra = @letra and a._letra is not null;

	--print 'Count:' + rtrim(@c);
	--print 'Max:' + rtrim(@m);
	
	if @c < @m or (@c is null  and @m > 0)begin
		set @result = 1;
	end else begin
		set @result = 0;
	end
	
end
GO
