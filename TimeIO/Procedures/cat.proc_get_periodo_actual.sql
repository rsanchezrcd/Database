SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc [cat].[proc_get_periodo_actual]		
		@id_per char(36) OUTPUT
	as begin
		SET NOCOUNT ON;
		select top 1 @id_per = p.id_periodo from cat.periodos p
		where p._actual = 1
		order by p.ini_date;
	end;
GO
