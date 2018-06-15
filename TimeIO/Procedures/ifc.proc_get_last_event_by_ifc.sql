SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc ifc.proc_get_last_event_by_ifc
	@ifc char(36)
as begin
	select top 1
		 id_event [event]	
		,convert(nvarchar(23),insert_date, 121)	[insert_date]
		,id_interface 	[ifc]
		,_type	[type]
		,_message	[message]
		,_flag	[flag]
		,_inserted [inserted]	
		,_updated [updated]	
		,convert(nvarchar(23),_ini, 121) [ini]	
		,convert(nvarchar(23),_fin, 121) [fin]	
		,_dif [dif]
	from ifc.event where id_interface = @ifc
	order by insert_date desc
end
GO
