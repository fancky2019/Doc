-- record lock（记录锁，就是行锁）
-- gap lock（间隙锁）
-- next-key lock：record lock 和 gap lock

-- innodb  默认锁  next-key lock


-- innodb  默认锁  next-key lock
--  gap  锁住区间   普通索引 条件具体值：值的上一个值和下一个值这段区间和相等的值（值允许重复）。如27的锁定区间[<27>]。InnoDB会给数据加上行锁和间隙锁
--                           范围     ：锁定条件范围
--                  群集索引、唯一索引：值存在net_key lock降级为行锁，锁住当前行，行锁。不存在或范围，间隙锁。
--                  没有索引：锁表
 
 select VERSION();
 
show index  from  person;

create  index index_age on person (age);

drop index  index_age on person; 

select @@autocommit;


show VARIABLES like '%autocommit%';

-- 事务隔离级别
show VARIABLES like '%iso%';


-- 不自动提交事务。
SET autocommit=0;


-- 共享锁
START TRANSACTION;
UPDATE person SET name='ts12' WHERE id=15;
commit;
-- 
-- age
-- 
-- 2
-- 6
-- 7
-- 10
-- 13
-- 15
-- 16
-- 18
-- 20
-- 22
-- 27
-- 31


 
-- 当前读
START TRANSACTION;
SELECT * FROM `person` WHERE age>22 for update;
commit;					
-- 26、27、31 锁住,没有索引将锁表
START TRANSACTION;
-- UPDATE person SET name='gap_lock_test1' WHERE age>22;
UPDATE person SET name='gap_lock_test1' WHERE age=27;
commit;

--  快照度
START TRANSACTION;
SELECT * FROM `person` WHERE age>22;
commit;


-- 查看数据锁 https://dev.mysql.com/doc/mysql-perfschema-excerpt/8.0/en/performance-schema-data-locks-table.html
select * from performance_schema.data_locks;

-- LOCK_DATA  索引值,主键值



select * from performance_schema.data_lock_waits

delete  from person  where id>18;



SELECT * FROM `person`；

select  distinct age  from person;

select  distinct age,count(*) from person
GROUP BY age








