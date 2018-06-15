SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_letra_need_causa]
	 @letra char(1)	
	,@per char(36)
	,@result bit = 0 OUTPUT
	
as begin
	SET NOCOUNT ON;
	declare @cerrado bit

	select @cerrado = _cerrado 
	from cat.periodos 
	where id_periodo = @per

	if (@cerrado = 0) begin
		select 
			@result = (case when count(*) > 0 then  1 else 0 end)
		from cat.causa with(nolock)
		where id_ausentismo = cat.func_get_id_ausentismo(@letra)
			and activo = 1;
	end else begin
		set @result = 0;
	end;
	
end; 
GO
