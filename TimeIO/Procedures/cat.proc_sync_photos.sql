SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_sync_photos]
as begin
	set nocount on;
	---------------------------------------------------------------
	declare @ids table(_alter_id nvarchar(6))
	declare @fec datetime
	---------------------------------------------------------------
	-- Obtenemos ids de col. que no tienen photo
	---------------------------------------------------------------
	insert into @ids(_alter_id)
	select  
		REPLICATE('0',6-LEN(RTRIM(e._alter_id))) + RTRIM(e._alter_id) [_alter_id]
	from cat.employees e with (nolock)
	left join cat.employee_photo p with (nolock) on (p.id_employee = e.employee_id)
	where p.id_employee is null and e._status = 1;

	---------------------------------------------------------------
	-- Si hay registros en tabla variable
	-- insertamos las fotos.
	---------------------------------------------------------------
	if(@@ROWCOUNT > 0) begin
		insert into cat.employee_photo (id_employee, _employee_photo)
		select 
			cat.func_get_id_employee(convert(int, EMPLID)) [id_employee]
			,EMPLOYEE_PHOTO [_employee_photo]
		from PS.HRSYS.[dbo].[PS_EMPL_PHOTO] with(nolock)
		where EMPLID collate SQL_Latin1_General_CP1_CI_AS in (select _alter_id from @ids);
	end;


	update t set 
		t._employee_photo = p.EMPLOYEE_PHOTO
	from cat.employee_photo t with(nolock)
	inner join PS.HRSYS.[dbo].[PS_EMPL_PHOTO] p with(nolock) on convert(int, EMPLID) = cat.func_get_employee_alter( t.id_employee)
	where cast(p.EMPLOYEE_PHOTO as varbinary(max)) <> cast(t._employee_photo as varbinary(max)) 
		
	---------------------------------------------------------------
	-- Obtengo fecha de inicio de periodo
	---------------------------------------------------------------
	execute cat.proc_get_fecha_ini_periodo_actual @fecha_ini = @fec OUTPUT
	---------------------------------------------------------------
	-- Eliminamos fotos de colaboradores de baja
	-- solo si en el periodo no estuvieron activos.
	---------------------------------------------------------------	
	delete from cat.employee_photo 
	where cat.func_isactive_bydt(@fec, id_employee) = 0
end
GO
