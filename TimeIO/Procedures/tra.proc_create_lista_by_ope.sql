SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [tra].[proc_create_lista_by_ope]
	@ope char(36)
	,@pagenum INT = 1	
	,@dep char(36) = null		
	,@per char(36) = null
	,@pagesize INT = null
  as begin
	set nocount on
	declare @emp char(36)
	------------------------------------------------------------
	--Determinamos el departamento cuando se entrega en null
	------------------------------------------------------------
	if @dep is null begin
		------------------------------------------------------------
		-- Obtenemos departamento favorito
		------------------------------------------------------------
		select @dep = id_departamento 
		from cat.departamento_operator
		where id_operator = @ope and _favorite = 1;
		------------------------------------------------------------
		--Cuando no tiene Favorito asignamos el depto al que pertenece
		------------------------------------------------------------
		if @dep is null begin
			select @emp = employee_id from cat.operator with(nolock) where operator_id = @ope;
			select @dep = departamento_id from cat.employees with(nolock) where employee_id = @emp;
		end;
	end;

	------------------------------------------------------------
	-- Determinamos el Periodo actual cuando se entrega en null
	-- Recibimos pagesize y pagenum
	------------------------------------------------------------
	if @per is null begin 
		select @per =id_periodo 
		from cat.periodos where _actual = 1;
	end;	

	if @pagesize is null exec [adm].[proc_get_param_output] @parametro = 'lista_pagesize', @value = @pagesize OUTPUT 
	------------------------------------------------------------
	-- Obtenemos lista de asistencia de empleados
	------------------------------------------------------------
	select 
		[id_lista]
      ,[id_employee]
      ,[_alter_id]
      ,[_nombres]
      ,[_apellido_paterno]
      ,[_apellido_materno]
      ,[id_periodo]
      ,[_per]
      ,[locacion_id]
      ,[_locacion_code]
      ,[_locacion_name]
      ,[id_departamento]
      ,[_departamento_code]
      ,[_departamento_name]
      ,[posicion_id]
      ,[_posicion_code]
      ,[_posicion_name]
      ,[_days]
      ,[_c01]
      ,[_c02]
      ,[_c03]
      ,[_c04]
      ,[_c05]
      ,[_c06]
      ,[_c07]
      ,[_c08]
      ,[_c09]
      ,[_c10]
      ,[_c11]
      ,[_c12]
      ,[_c13]
      ,[_c14]
      ,[_c15]
      ,case when [_c16] is null then 'F' else [_c16] end [_c16]
      ,[_year]
      ,[_excluido]
      ,[_cerrado] 
	from tra.vw_lista_joins with(nolock)
	where 
			id_periodo = @per
		and id_departamento = @dep
	order by 
		 --_posicion_name asc
		 _alter_id asc --ya viene en int desde la vista
		
	OFFSET (@pagenum - 1) * @pagesize ROWS 
	FETCH NEXT @pagesize ROWS ONLY;
  end 
GO
