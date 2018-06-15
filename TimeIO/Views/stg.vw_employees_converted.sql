SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



CREATE view [stg].[vw_employees_converted]
	as select 
		--@op [insert_operator_id],
		 P.[NUMERO] AS [_alter_id] 
		,P.[FIRST_NAME] AS [_nombres]
		,P.[LAST_NAME] AS [_apellido_paterno]
		,P.[SECOND_LAST_NAME] AS [_apellido_materno]
		,CASE WHEN P.[EMPL_STATUS] = 'A' THEN 1 ELSE 0 END AS [_status]
		,P.[EMPLCLASS] AS [_clase] 
		,l.[locacion_id]
		,d.[id_departamento] AS [departamento_id]
		,n.[posicion_id]
		,P.[NATIONAL_ID] AS [_legal_id]
		,P.[ORIG_HIRE_DT] AS [_hire_date]
		,CASE WHEN P.[EMPL_STATUS] = 'A' THEN null ELSE P.EFFDT END AS [_fecha_baja]
		,case when e._alter_id is null then 0 else 1 end _existe
	from [stg].[employees] P
		inner join [cat].[locacion] l on P.[LOCATION] collate SQL_Latin1_General_CP1_CI_AS = l.[_alter_code]
		inner join [cat].[departamentos] d on P.[DEPTID] collate SQL_Latin1_General_CP1_CI_AS = d.[_departamento_code]
		inner join [cat].[posicion] n on P.[POSITION_NBR] collate SQL_Latin1_General_CP1_CI_AS = n.[_posicion_code]
		left join cat.employees e on P.NUMERO = convert(int,e._alter_id)
	where e._alter_id is not null or e._alter_id is null and l.active = 1;


GO
