SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc adm.[proc_set_nav_to_ope_by_bit]
	@ope char(36)
	,@nav char(36)
	,@bit bit
	,@do_ope char(36)
as begin
	if @bit = 0 begin
		begin try
			begin transaction
				declare @is_father bit
						,@clave int;
				select 
					@is_father = _is_father 
					,@clave = _clave
				from adm.navigator where id_navigator = @nav;
				
				if @is_father = 1 begin
					delete from adm.nav_by_ope 
					where id_navigator in ( select id_navigator 
											from adm.navigator
											where _is_child = 1 
												and _father = @clave)
						and id_operator = @ope
				end;
				
				delete from adm.nav_by_ope 
				where id_navigator = @nav and id_operator = @ope;
			commit transaction
		end try
		begin catch
			rollback transaction
		end catch
		
	end else begin
		insert into adm.nav_by_ope (id_navigator, id_operator,  _full,_read, _write,_special, insert_operator_id)
		values(@nav, @ope, 0, 1,0,0, @do_ope);
	end;
end;
GO
