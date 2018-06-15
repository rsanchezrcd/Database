SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20170914
-- Description:	obtiene el numero de paginas
-- =============================================
CREATE PROCEDURE [tra].[proc_get_pages_lista_bydep]
	 @ope char(36)
	,@pages int OUTPUT	
	,@dep char(36) = null
	,@pagesize INT = null
	,@per char(36) = null	
AS
BEGIN
	SET NOCOUNT ON;
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
		exec cat.proc_get_periodo_actual @per OUTPUT
	end;
	declare @fecha_ini_per date
	exec cat.proc_get_fecha_ini_periodo_actual @fecha_ini_per OUTPUT
	------------------------------------------------------------
	-- Obtenemos el numero de empleados
	------------------------------------------------------------
	declare @employees int;
	select @employees = count(*) from cat.employees with(nolock)
	where departamento_id = @dep and cat.func_isactive_bydt(@fecha_ini_per, employee_id) =1
	------------------------------------------------------------
	-- Obtenemos parametro pagesize de la lista
	------------------------------------------------------------
	if @pagesize is null exec [adm].[proc_get_param_output] @parametro = 'lista_pagesize', @value = @pagesize OUTPUT 
	
	------------------------------------------------------------
	-- Calculos
	------------------------------------------------------------
	
	set @pages = ceiling(@employees / convert(float,@pagesize));		
	IF @pages = 0 or @pages is null set @pages =1;
END


GO
