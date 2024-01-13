-- 查询执行sql
SELECT TOP 100 creation_time,text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
where 1=1
and creation_time >='2023-10-21 10:00:16.133'
and  text like '%ApplyShipOrder%'
and text not like '%TOP 100%'
ORDER BY last_execution_time DESC;

-- and text not like '%TOP 100%'

SELECT TOP 100
    qs.last_execution_time,
    DB_NAME(st.dbid) AS database_name,
    OBJECT_NAME(st.objectid, st.dbid) AS object_name,
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1,
        ((CASE qs.statement_end_offset
          WHEN -1 THEN DATALENGTH(st.text)
          ELSE qs.statement_end_offset
         END - qs.statement_start_offset)/2)+1) AS executed_sql
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
where 1=1
and creation_time >='2023-10-21 10:00:16.133'
and  text like '%ApplyShipOrder%'
and text not like '%TOP 100%'
ORDER BY qs.last_execution_time DESC;