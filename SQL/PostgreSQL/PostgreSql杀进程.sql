
drop function if exists kill_connected_progress;

CREATE OR REPLACE FUNCTION kill_connected_progress()
--   RETURNS text AS $$ 
RETURNS void AS $$
-- 声明变量、游标
DECLARE 
--  titles TEXT DEFAULT '';
--  rec_film   RECORD;
  temp_connected_progress_cursor CURSOR  FOR
	select pid from pg_catalog.pg_stat_activity where application_name !='Navicat' or "state"='idle';

 DECLARE  pid int; 
 DECLARE v_errinfo     varchar(1000);
 DECLARE v_errcode      varchar(100);
 
 
 
BEGIN
   -- 打开游标
   OPEN temp_connected_progress_cursor;
 
   LOOP
    -- 获取记录放入
    -- 	fetch curs into uId,uName,uAge;
      FETCH temp_connected_progress_cursor INTO pid;
        -- exit when no more row to fetch
     EXIT WHEN NOT FOUND;
		 
		 -- 执行右边循环语句
		 
		 -- 制造类型转换异常
		  -- select cast('999e' as NUMERIC);
		 perform  pg_terminate_backend(pid);
		 
-- 		   if found then  --任意的逻辑
-- 			 -- SELECT pid;
--           perform   pg_terminate_backend(pid);
--         else 
--             exit; 
--         end if; 


   END LOOP;
  
   -- 关闭游标
   CLOSE temp_connected_progress_cursor;
 
 
 -- 异常处理
 exception
  when others then ----------异常处理
      v_errcode := SQLSTATE;---错误编码
      v_errinfo := SQLERRM;----详细信息

-- 打印控制台信息  %占位符
-- raise notice 'errcod= %, errinfo= % .', v_errcode, v_errinfo;
raise  'errcod= %, errinfo= % .', v_errcode, v_errinfo;


 -- 没有返回值
 -- RETURN '';
END; $$
 
LANGUAGE plpgsql;






-- 执行函数存储过程
select kill_connected_progress();











