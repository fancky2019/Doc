CREATE SEQUENCE person_id_seq START 1;
nextval('person_id_seq'::regclass);

-- 重置自增id
TRUNCATE TABLE "playerbag" RESTART IDENTITY;
TRUNCATE tableName RESTART IDENTITY;
-- "id" int8 NOT NULL GENERATED ALWAYS AS IDENTITY

-- 数据类型: 通常是整型的一种[ int2 | int4 | int8 | smallint | int | bigint ]
-- GENERATED ALWAYS: PostgreSQL 总会为列生成一个唯一的值，如果尝试以 INSERT 或者 UPDATE 在 GENERATED ALWAYS AS IDENTIFY 列上进行插入数据或者更新时， PostgreSQL 将会报错。
-- 
-- GENERATED BY DEFAULT: PostgreSQL 将会生成一个标识列，但是如果尝试以 INSERT 或者 UPDATE 对该列进行插入或者更新时，PostgreSQL 将会使用指定的值来替代系统生成的值。


INSERT into person (user_name) values('fancky2');

select  *  from test."public".person;


update person1 set name='sdsd' where id=1




select * from pg_stat_activity where state='idle';



-- 查看连接进程
select pid,
       datname as database_name,
       usename as user_name,
       application_name,
       client_addr,
       backend_start,
       state,
       state_change,
       wait_event_type,
       wait_event,
       query,
       backend_type
from pg_catalog.pg_stat_activity
where application_name !='Navicat' or "state"!='idle'
limit 0;
-- 杀进程 实际调用操作系统的 kill -9 23184
select pg_terminate_backend(23184)；

-- 创建临时表
-- CREATE TEMP TABLE temp_testbulkcopy as (select * from testbulkcopy limit 0);


-- 删除表、临时表
DROP TABLE  If  Exists temp_connected_progress





