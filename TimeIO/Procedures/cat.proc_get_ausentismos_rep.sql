SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_get_ausentismos_rep]

as begin 
	set nocount on;
	select 
		 a.id_ausentismo
		,rtrim(a._letra) _letra
		,upper(rtrim(a._descripcion)) _descripcion		
	from cat.ausentismos a
	where a._reportes = 1 and active = 1
	order by _letra asc;
	
end
GO
