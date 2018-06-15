SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [adm].[proc_set_per_to_nav_by_bit]
	@ope char(36)
	,@nav char(36)
	,@field nvarchar(64)
	,@bit bit
	,@do_ope char(36)
as begin
	declare @query nvarchar(max);
	/*if @field ='_full' and @bit = 1 begin
		set @query = 'update adm.nav_by_ope set 
		 _full = 1, _read = 1, _write = 1 ,_special = 1
		 ,update_operator_id = '''+@do_ope+'''
		 ,update_date = getdate()
		 where id_navigator = '''+@nav+'''
				and id_operator ='''+ @ope+'''';
	end else begin*/	
		set @query = 'update adm.nav_by_ope set 
		 '+ @field + ' = '+ convert(char(1),@bit) + '
		 ,update_operator_id = '''+@do_ope+'''
		 ,update_date = getdate()
		 where id_navigator = '''+@nav+'''
				and id_operator ='''+ @ope+'''';
	--end;
	exec (@query);
end;
GO
