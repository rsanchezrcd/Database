SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create view adm.vw_arbol_departamentos as 
with q as (
	select  		
		CAST(ROW_NUMBER() OVER (ORDER BY A._departamento_code) AS VARCHAR(MAX)) COLLATE Latin1_General_BIN AS BC
		,A.id_departamento
		,A._departamento_code
		,A._departamento_name 
		,A._father_id 
	from cat.departamentos A
	where A._father_id is null
	union all
	select  		
		q.bc + '.' + CAST(ROW_NUMBER() OVER (ORDER BY A._departamento_code) AS VARCHAR(MAX)) COLLATE Latin1_General_BIN
		,A.id_departamento
		,A._departamento_code
		,A._departamento_name 
		,A._father_id 
	from cat.departamentos A
	 JOIN    q
        ON  A._father_id  = q.id_departamento
)
select * from q

GO
