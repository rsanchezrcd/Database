SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [tra].[proc_get_horas_by_ope_toexcel]
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
      ,isnull([_p01],0) _c01
      ,isnull([_p02],0) _c02
      ,isnull([_p03],0) _c03
      ,isnull([_p04],0) _c04
      ,isnull([_p05],0) _c05
      ,isnull([_p06],0) _c06
      ,isnull([_p07],0) _c07
      ,isnull([_p08],0) _c08
      ,isnull([_p09],0) _c09
      ,isnull([_p10],0) _c10
      ,isnull([_p11],0) _c11
      ,isnull([_p12],0) _c12
      ,isnull([_p13],0) _c13
      ,isnull([_p14],0) _c14
      ,isnull([_p15],0) _c15
      ,isnull([_p16],0) _c16
      --,[_year]
      --,[_excluido]
      --,[_cerrado] 
	from tra.vw_horas_joins with(nolock)
	where 
			id_periodo = @per
		and id_departamento in (select id_departamento 
								from cat.departamento_operator with(nolock)
								where id_operator = @ope)
	order by 
		 _alter_id asc --ya viene en int desde la vista
  end 


GO
