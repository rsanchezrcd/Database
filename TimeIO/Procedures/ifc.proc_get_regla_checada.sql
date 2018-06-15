SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [ifc].[proc_get_regla_checada]
	@code nvarchar(2)
	,@checada_in datetime
	,@result datetime OUTPUT
as begin	
	--Variables
	declare @valor int
			,@unidad nvarchar(64)
			,@q nvarchar(512);
	declare @tabla as table (result datetime);
	--Minamos Variables
	select @valor= _valor, @unidad = _unidad 
	from ifc.reglas with(nolock)
	where _code = @code;	

	--Calculo
	set @q =  'select DATEADD('+@unidad+','+convert(varchar,@valor)+','''+convert(varchar,@checada_in)+''') result';
	--print @q

	insert into @tabla (result)
	exec (@q);	
	--select * from  @tabla
	select top 1  @result = result from @tabla;
end
GO
