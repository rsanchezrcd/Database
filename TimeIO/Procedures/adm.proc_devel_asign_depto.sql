SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc adm.proc_devel_asign_depto
	@id int
as begin
	declare @depto char(36)
	select @depto = v.departamento_id from (select top 1
											departamento_id
											,count(*) _c 
										from 
											cat.employees
										group by departamento_id 
										order by _c desc) V


	update cat.employees
		set departamento_id = @depto
	where _alter_id = @id

end
GO
