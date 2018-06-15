SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO







CREATE view [ifc].[vw_ids_pendientes] as
select 
	a.id id_source 
	,dateadd(hour, -5, a.logdatetime) _checada
from [MorphoManager].[dbo].[AccessLog] a with (nolock)
left join TimeIO.ifc.handpunch h with(nolock) on (a.id = h.id_source)
left join TimeIO.ifc.handpunch_resync r with(nolock) on (a.id = r.id_source)
inner join TimeIO.cat.dispositivo b with(nolock) on a.MORPHOACCESSID = b.id_dispositivo
where 
		h.id_source is null and r.id_source is null
	and b._ischecador = 1
	and b._iscomedor = 0
	and b._istest = 0
	and a.USERID <> '00000000-0000-0000-0000-000000000000' -- Para evitar los accesos denegados en los dispotivos

union all

select  id , _checada_src  from tra.checadas_manuales a
left join TimeIO.ifc.handpunch h with(nolock) on (a.id = h.id_source)
where 
		h.id_source is null



GO
