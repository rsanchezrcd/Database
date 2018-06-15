SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [tra].[proc_create_horas_by_dep]	
	 @pagenum int = 1	
	,@dep char(36)	
	,@per char(36)
	,@pagesize int = null
  as begin
	set nocount on
	declare @emp char(36), @pages int
	------------------------------------------------------------
	--Si el dep o per son nulos, salimos del proc.
	------------------------------------------------------------
	if @dep is null or @per is null begin
		return;
	end;	
	
	------------------------------------------------------------
	-- Obtenemos datos de paginación
	------------------------------------------------------------
	if @pagesize is null exec [adm].[proc_get_param_output] @parametro = 'lista_pagesize', @value = @pagesize OUTPUT 
	select 
		@pages = ceiling(count(*) / convert(float,@pagesize))
	from tra.vw_horas_joins with(nolock)
	where 
			id_periodo = @per
		and id_departamento = @dep		
	IF @pages = 0 or @pages is null set @pages =1;
	------------------------------------------------------------
	-- Obtenemos lista  de horas extras de empleados
	------------------------------------------------------------
	select 
		[id_horas_extras]
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
      ,_horas
	  ,isnull(_pagadas,0)_pagadas
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
      ,isnull([_c16],0) [_c16]
	  ,isnull([_p01],0) [_p01]
      ,isnull([_p02],0) [_p02]
      ,isnull([_p03],0) _p03
      ,isnull([_p04],0) _p04
      ,isnull([_p05],0) _p05
      ,isnull([_p06],0) _p06
      ,isnull([_p07],0) _p07
      ,isnull([_p08],0) _p08
      ,isnull([_p09],0) _p09
      ,isnull([_p10],0) _p10
      ,isnull([_p11],0) _p11
      ,isnull([_p12],0) _p12
      ,isnull([_p13],0) _p13
      ,isnull([_p14],0) _p14
      ,isnull([_p15],0) _p15
	  ,isnull([_p16],0) _p16
	  ,@pages [_pages]
	from tra.vw_horas_joins with(nolock)
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
