-- 测试事务要在两个会话中测试

-- 设置当前会话隐式事务不自动提交，当前查询窗口执行插入语句可以执行成功，也能查询到。但是在另一个查询窗口却查询不到新插入的语句
-- 另一个设置 autocommit=0;，当前会话却是 autocommit=1

SET autocommit=0;

show VARIABLES like '%autocommit%';

show VARIABLES like '%iso%';

select  *  from demo.person;



SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION ;
UPDATE demo_product set version=1 where id=1;
COMMIT ;

SELECT version,product_name FROM demo_product WHERE ID=1;



update  demo.person set name='rr_update2' where id=5;

select  *  from   demo.person where id=5;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION ;
update  demo.person  set NAME='fancky1' where id=5;
-- SELECT SLEEP(10);
-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值

COMMIT ;
-- ROLLBACK;

select  *  from  demo.person  where id=5;
-- 写写 mysql 默认加锁了，必须等待一个事务执行完另外一个事务才能执行
-- 1、类丢失更新，回滚
START TRANSACTION ;
-- 局部变量直接使用不需要声明
update  demo.person  set  age=2 where id=5;
-- SELECT SLEEP(15);

-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值
-- rr 解决回滚丢失更新，没有解决2类丢失更新（更新覆盖）问题。
-- COMMIT ;
ROLLBACK;

select  *   from  demo.person where id=5;

-- 2、更新覆盖
START TRANSACTION ;

-- 局部变量直接使用不需要声明
select @age:=age from   demo.person where id=5;
select @age;
update  demo.person  set age=@age+2 where id=5;
-- SELECT SLEEP(10);

-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值

COMMIT ;
-- ROLLBACK;








-- SERIALIZABLE： 串化解决事务并发问题，事务一个一个排队执行，读加S锁，写加X锁
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION ;

-- 局部变量直接使用不需要声明
select @age:=age from   demo.person where id=5;
select @age;
update  demo.person  set age=@age+2 where id=5;
-- SELECT SLEEP(10);

-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值

COMMIT ;
-- ROLLBACK;










