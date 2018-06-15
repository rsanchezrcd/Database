SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO











CREATE view [ifc].[vw_checadas_morpho]
as select	 --top 100
		a.id
		,convert(int,rtrim(replace(u.employeeid,char(9),''))) _codigo_src
		,dateadd(hour,-b._DESCUENTA,a.[LOGDATETIME]) _checada_src 
		,a.ACCESS _access
		,bb.NAME_ _dispositivo
		,bb.EXPORTVALUE _dn
		,RIGHT(p._year,2) + rtrim(p._per) _per
	--into tra.checadas_manuales
	from MorphoManager.dbo.AccessLog a  with (nolock)
		left join	MorphoManager.dbo.User_  u with (nolock) on (a.USERID = u.ID)
		inner join	MorphoManager.dbo.BiometricDevice_IFC  b with (nolock) on (a.MORPHOACCESSID = b.ID)
		inner join	MorphoManager.dbo.BiometricDevice bb with (nolock) on (a.MORPHOACCESSID = bb.ID)
		inner join (select top 1 ini_date, _year, _per from TimeIO.cat.periodos with (nolock)
				where _cerrado = 0 and _actual = 1
				order by ini_date asc) p on dateadd(hour,-b._DESCUENTA,a.[LOGDATETIME]) >= p.ini_date
	where 
			a.USERID is not null
		and u.employeeid is not null
		--and  1 = 0
	union all 

	select  id, _codigo_src, _checada_src ,_access, _dispositivo, _dn, _per from tra.checadas_manuales



GO
