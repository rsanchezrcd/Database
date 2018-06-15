SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc cat.proc_get_lista_by_emp_unpivot 
	@per char(36), @emp char(36)
as begin 
	select id_employee, _letra, count(*) _count from
	(select id_employee,_c01,	_c02,	_c03,	_c04,	_c05,	_c06,	_c07,	_c08,	_c09,	_c10,	_c11,	_c12,	_c13,	_c14,	_c15,	_c16
	 from tra.lista where id_periodo = @per and id_employee = @emp ) dias
	unpivot
	(_letra FOR AusenNUM IN (_c01,	_c02,	_c03,	_c04,	_c05,	_c06,	_c07,	_c08,	_c09,	_c10,	_c11,	_c12,	_c13,	_c14,	_c15,	_c16)
	) AS dias_cont
	group by id_employee, _letra;

end
GO
