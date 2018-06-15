SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc cat.[proc_set_aus_to_ope_by_bit]
	@ope char(36)
	,@aus char(36)
	,@bit bit
	,@do_ope char(36)
as begin
	if @bit = 0 begin
		begin try
			begin transaction			
				
				delete from cat.ausentismos_operator 
				where id_ausentismo = @aus and id_operator = @ope;
			commit transaction
		end try
		begin catch
			rollback transaction
		end catch
		
	end else begin
		insert into cat.ausentismos_operator(id_ausentismo, id_operator, insert_operator_id)
		values(@aus, @ope, @do_ope);
	end;
end;
GO
