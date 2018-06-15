SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_create_etiquetas_lista]
		@per char(36) = null
	as begin 
		declare @today nvarchar(8) = (select convert(varchar(8),GETDATE(),112))
				 ,@per_local char(36);
		if @per is null begin			
			exec cat.proc_get_periodo_bydate @date = @today, @id_per = @per_local OUTPUT;
			set @per = @per_local;
		end
		
		set nocount off
		select
			fecha_int,
			_etiqueta, 
			_day_txt, 
			_day, 
			_month_txt, 
			_year, 
			_day_txt +' '+ rtrim(_day) + ' de ' + _month_txt  + ' del ' + rtrim(_year) [_title]
		from adm.fechas 
		where id_periodo = @per
		order by fecha_int;
	end
GO
