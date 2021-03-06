SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [cat].[proc_get_list_periodos_byyear]
	@year int 
as begin
	set nocount on;
	select 

	id_periodo
	,_year
	,_per
	,_actual 
	,RIGHT(rtrim(_year),2) + rtrim((REPLICATE('0',2-LEN(_per))+ rtrim(_per))) _label
	,convert(nvarchar(10),ini_date,120) _ini
	,convert(nvarchar(10),end_date,120) _fin

	from cat.periodos with(nolock)
	where _year = @year --(select _year from cat.periodos with(nolock) where _actual = 1)
		and (_cerrado = 1 or _actual = 1)		
	order by _per desc;
end;
GO
