SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  create proc [tra].[proc_get_nocturnas_by_ope_toexcel]
	 @ope char(36)		
	,@per char(36) = null
	
  as begin
	set nocount on
	declare @emp char(36)
	

	------------------------------------------------------------
	-- Determinamos el Periodo actual cuando se entrega en null
	-- Recibimos pagesize y pagenum
	------------------------------------------------------------
	if @per is null begin 
		select @per =id_periodo 
		from cat.periodos where _actual = 1;
	end;	
	
	------------------------------------------------------------
	-- Obtenemos lista de asistencia de empleados
	------------------------------------------------------------
	select 
	  --[id_lista]
      --,[id_employee]
       [_alter_id] Codigo
      ,[_nombres] Nombre
      ,[_apellido_paterno] ApellidoPaterno
      ,[_apellido_materno] ApellidoMaterno
      ,cat.[func_get_periodo](id_periodo) Periodo
      --,[_per]
      --,[locacion_id]
      ,[_locacion_code] CodigoLocacion
      ,[_locacion_name] Locacion
      --,[id_departamento]
      ,[_departamento_code] CodigoDepto
      ,[_departamento_name] Departamento
      --,[posicion_id]
      ,[_posicion_code] CodigoPosicion
      ,[_posicion_name] Posicion
      --,[_days]
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
      ,[_c16]
      --,[_year]
      --,[_excluido]
      --,[_cerrado] 
	from tra.vw_nocturnas_joins with(nolock)
	where 
			id_periodo = @per
		and id_departamento in (select id_departamento 
								from cat.departamento_operator with(nolock)
								where id_operator = @ope)
	order by 
		
		 _alter_id asc --ya viene en int desde la vista
		
	
  end 


GO
