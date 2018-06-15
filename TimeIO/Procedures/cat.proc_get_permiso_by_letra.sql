SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc cat.proc_get_permiso_by_letra
	@letra char(1)
	,@ope char(36)
	,@result bit OUTPUT
as begin
	declare @aus char(36);
	select @aus = id_ausentismo from cat.ausentismos 
	where _letra = @letra and active = 1;

	if @aus is not null begin
		if (exists(select id_ausentismos_operator 
					from cat.ausentismos_operator
					where id_operator = @ope and id_ausentismo = @aus)) begin
			set @result = 1;
		end else begin
			set @result = 0;
		end; 
	end else begin
		set @result = 0;
	end;
end
GO
