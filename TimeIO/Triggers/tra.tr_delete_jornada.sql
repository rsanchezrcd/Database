SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez	
-- Create date: 20170929
-- Description:	Elimina los datos de tra.lista
-- =============================================
CREATE TRIGGER [tra].[tr_delete_jornada]
   ON  [tra].[jornadas]
   AFTER DELETE
AS 
BEGIN
	
	SET NOCOUNT ON;
	declare @t table(_id char(36),_q varchar(max),_sync bit)
	declare @q varchar(max), @id char(36), @ini datetime

	exec cat.proc_get_fecha_ini_periodo_actual @ini OUTPUT

	insert into @t (_id, _q, _sync)
	select
		newid() _id
		,'update tra.lista
			set _'+rtrim(i._cN)+' = (case when LEN(rtrim(_'+rtrim(i._cN)+')) > 1 then LEFT(rtrim(_'+rtrim(i._cN)+'),1)
					when rtrim(_'+rtrim(i._cN)+') =  ''/'' then ''F'' 
					when rtrim(_'+rtrim(i._cN)+') =  ''.'' then ''/'' end) 
		where id_employee ='''+rtrim(i.employee_id)+''' and id_periodo = cat.func_get_id_periodo('''+rtrim(i._entrada)+''')' _q
		,0 _sync
	from deleted i where i._entrada >= @ini and i._salida is null

	while (exists( select top 1 _id from @t where _sync = 0)) begin
		select top 1 
			@q = _q  
			,@id = _id
		from @t where _sync = 0
		print @q
		exec (@q)

		update @t set _sync = 1
		where _id = @id;
	end;
				

END
GO
DISABLE TRIGGER [tra].[tr_delete_jornada]
	ON [tra].[jornadas]
GO
