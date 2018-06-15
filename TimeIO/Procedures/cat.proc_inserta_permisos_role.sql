SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc cat.proc_inserta_permisos_role
	 @ope char(36)
	,@rol char(36)
	,@do_ope char(36)
	,@result bit OUTPUT
as begin
	set nocount on;

	-- insertamos permisos de rol
	declare @qt table (_id char(36), _query nvarchar(1014), _sync bit)
	insert into @qt (_id ,_query, _sync)
	select 
		 newid()
		,case r._table		
			when 'cat.ausentismos' then 'insert into '+ r._table_destino + ' (insert_operator_id, id_operator, '+ r._id_column_name +')
											values ('''+@do_ope+''','''+@ope+''', ''' + r._id_elemento +''')'
			when 'adm.navigator' then 'insert into '+ r._table_destino + '(insert_operator_id, id_operator, '+ r._id_column_name +', _full, _read, _write, _special)
											values ('''+@do_ope+''','''+@ope+''', ''' + r._id_elemento +''', '+ rtrim(isnull(r._full,0))+', '+ rtrim(isnull(r._read,0))+', '+ rtrim(isnull(r._write,0))+', '+ rtrim(isnull(r._special,0))+')'
		end	[_query]
		,0 [_sync]
	from cat.role_elemento as r
	where r.id_role = @rol

	declare @id char(36), @q nvarchar(1024)
	while(exists(select _sync from @qt where _sync = 0)) begin
		-------------------------------------------
		select top 1 
			@id = _id  
			,@q = _query
		from @qt where _sync = 0;
		-------------------------------------------
		exec (@q);
		-------------------------------------------
		update @qt
			set _sync = 1
		where _id = @id;
	end;
	set @result = 1
end;

GO
