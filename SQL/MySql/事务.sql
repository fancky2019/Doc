
-- InnoDB 加锁方法：
-- 
-- 意向锁是 InnoDB 自动加的， 不需用户干预。
-- 对于 UPDATE、 DELETE 和 INSERT 语句， InnoDB会自动给涉及数据集加排他锁（X)；
-- 对于普通 SELECT 语句，InnoDB 不会加任何锁；事务可以通过以下语句显式给记录集加共享锁或排他锁：
-- 共享锁（S）：SELECT * FROM table_name WHERE ... LOCK IN SHARE MODE。 其他 session 仍然可以查询记录，并也可以对该记录加 share mode 的共享锁。但是如果当前事务需要对该记录进行更新操作，则很有可能造成死锁。
-- 排他锁（X)：SELECT * FROM table_name WHERE ... FOR UPDATE。其他 session 可以查询该记录，但是不能对该记录加共享锁或排他锁，而是等待获得锁


-- 开启事务隐式加锁，两阶段加锁：start tran  加锁， commit rollback 解锁。锁的类型看是当前度还是快照度。


-- 当前读：select lock in share mode (共享锁), select for update; update; insert; delete (排他锁)

-- 快照读(非阻塞读)：普通select语句。，不包括select ... lock in share mode, select ... for update。　　　　

								-- 　　Read Committed隔离级别：每次select都生成一个快照读。
								-- 
								-- 　　Read Repeatable隔离级别：开启事务后第一个select语句才是快照读的地方，而不是一开启事务就快照读。
-- 

-- 两阶段协议：事务加锁、解锁

-- 加锁：start  TRANSACTION 之后在需要加锁的时候加锁，并不是开启事务时候就加所有的锁，不然不会产生死锁。 锁占用行顺序a--b 和占用行b--a。
-- COMMIT 和ROLLBACK：解锁



show engines;

--  mysql事务支持的引擎是InnoDB，autocommit默认值为1
START TRANSACTION;
-- DML
-- commit;
ROLLBACK; -- 已经提交无法回滚。 若未提交可回滚。


-- COMMIT 和ROLLBACK 可使用在隐式事务中。autocommit 只在隐式事务中有效，因为显式事务要显式执行COMMIT或ROLLBACK。


-- SET autocommit=0; 只在当前会话有效，

-- 修改配置文件永久有效
-- [mysqld]
-- autocommit=0

-- 事务隔离级别
show VARIABLES like '%iso%';

select @@autocommit;


show VARIABLES like '%autocommit%';



START TRANSACTION;
UPDATE job SET jobname='ts12' WHERE id=1;
-- commit;
ROLLBACK; -- 已经提交无法回滚。 若未提交可回滚。


--  mssql 
-- commit tran 和 ROLLBACK TRAN 不能同时出现在语句中执行。

-- commit tran之后事务点被删除之后无法回滚，报错。 mysql 不会错，不会回滚。



--  autocommit 只针对隐式事务有效，对显式事务无效。
-- COMMIT; -- 报错语句没有插成功，
-- ROLLBACK;-- 不管成功与否，回滚
show VARIABLES like '%autocommit%';

-- 不自动提交事务。
SET autocommit=0;

-- 测试事务要在两个会话中测试


-- 开启事务，mysql 默认隔离级别RR。

-- 事务一般分为两种：隐式事务和显示事务。在Mysql中，事务默认是自动提交的，所以说每个DML语句实际上就是一次事务的过程。
-- 隐式事务：没有开启和结束的标志，默认执行完SQL语句就自动提交，比如我们经常使用的INSERT、UPDATE、DELETE语句就属于隐式事务。
-- 显示事务：需要显示的开启关闭，然后执行一系列操作，最后如果全部操作都成功执行，则提交事务释放连接，如果操作有异常，则回滚事务中的所有操作。




-- 数据库遵循的是两段锁协议，将事务分成两个阶段，加锁阶段和解锁阶段（所以叫两段锁）
-- 【1】加锁阶段：在该阶段可以进行加锁操作。在对任何数据进行读操作之前要申请并获得S锁（共享锁，其它事务可以继续加共享锁，但不能加排它锁），
--                 在进行写操作之前要申请并获得X锁（排它锁，其它事务不能再获得任何锁）。加锁不成功，则事务进入等待状态，直到加锁成功才继续执行。
-- 【2】解锁阶段：当事务释放了一个封锁以后，事务进入解锁阶段，在该阶段只能进行解锁操作不能再进行加锁操作。






show VARIABLES like '%autocommit%';
-- 不自动提交事务
SET autocommit=0;
-- 隐式事务：多个语句有一个错误，事务回滚
INSERT INTO `person` VALUES ( 'shiwu', 27, '2022-03-09 19:54:11', '2022-03-01 10:36:48')
                     VALUES ( 'shiwu2', 'sd', '2022-03-08 19:54:29', '2022-03-02 10:36:54');

-- COMMIT; -- 报错语句没有插成功，
ROLLBACK;-- 不管成功与否，回滚



-- 设置当前会话隐式事务不自动提交，当前查询窗口执行插入语句可以执行成功，也能查询到。但是在另一个查询窗口却查询不到新插入的语句
--  关闭当前会话，事务没有提交，再打开会话，查询不到刚才插入的数据
SET autocommit=0;

INSERT INTO `person` (name,age,person.birthday,person.update_time) VALUES ( 'shiwu_COMMIT', 27, '2022-03-09 19:54:11', '2022-03-01 10:36:48');


-- COMMIT; 

select  *  from demo.person;



-- 设置事务自动提交。在另一个会话中可以查询到新增数据
SET autocommit=1;

INSERT INTO `person` (name,age,person.birthday,person.update_time) VALUES ( 'shiwu1', 27, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
-- ROLLBACK;  -- 设置回滚，数据没有新增成功




-- 设置当前会话隐式事务不自动提交，当前查询窗口执行插入语句可以执行成功，也能查询到。但是在另一个查询窗口却查询不到新插入的语句
--  关闭当前会话，事务没有提交，再打开会话，查询不到刚才插入的数据
SET autocommit=0;

INSERT INTO `person` (name,age,person.birthday,person.update_time) VALUES ( 'shiwu_COMMIT', 27, '2022-03-09 19:54:11', '2022-03-01 10:36:48');


 COMMIT; -- 提交当前事务操作，保存数据操作，另一个会话可以查询到数据。

select  *  from demo.person;





show VARIABLES like '%autocommit%';



-- 显式开启事务，如果不提交，虽然当前会话能查询到新增数据，其他会话查询不到，断开会话数据丢失。

START TRANSACTION;
INSERT INTO `person` (name,age,person.birthday,person.update_time) VALUES ( 'START TRANSACTIO1', 27, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
-- commit;
-- ROLLBACK; -- 已经提交无法回滚。 若未提交可回滚。


-- 显式事务，显式提交数据可以保存
START TRANSACTION;
INSERT INTO `person` (name,age,person.birthday,person.update_time) VALUES ( 'START TRANSACTIO2', 27, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
commit;
-- ROLLBACK; -- 已经提交无法回滚。 若未提交可回滚。


-- 显式事务，模拟异常回滚，数据没保存
START TRANSACTION;
INSERT INTO `person` (name,age,person.birthday,person.update_time) VALUES ( 'START TRANSACTIO3', 27, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
-- commit;
ROLLBACK; -- 已经提交无法回滚。 若未提交可回滚。

select  *  from demo.person;
















-- 查看系统默认事务隔离级别
SHOW VARIABLES LIKE '%transaction_isolation%';

-- 1.查看当前会话隔离级别
SELECT @@transaction_isolation;
-- 2.查看系统当前隔离级别
SELECT @@global.transaction_isolation;

-- SET [GLOBAL | SESSION] TRANSACTION ISOLATION LEVEL <ISOLATION-LEVEL>
  -- '其中的<isolation-level>可以是：
    -- READ UNCOMMITTED 
    -- READ COMMITTED -- sqlserver oracle 默认隔离级别
    -- REPEATABLE READ   --   mysql默认隔离级别
    -- SERIALIZABLE
    -- 全局级：对所有的会话有效 
-- 会话级：只对当前的会话有效 

-- READ UNCOMMITTED  -- sqlserver 、oracle 默认隔离级别
-- 其他事务可以增删改查
-- 设置事务的隔离级别
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION ;
SELECT *  FROM wms.`product` WHERE ID=7;
SELECT SLEEP(10);
COMMIT ;

-- 'READ COMMITTED
--  解决：脏读
-- 其他事务可以增删改查
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION ;
SELECT *  FROM wms.`product`  WHERE ID=7;
SELECT SLEEP(10);
COMMIT ;

-- --'REPEATABLE READ  
--  解决：脏读、重复读取
-- 其他事务可以增删改查
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION ;
SELECT *  FROM wms.`product` WHERE ID=7;
SELECT SLEEP(10);
SELECT *  FROM wms.`product` WHERE ID=7;
COMMIT ;

--'SERIALIZABLE
--  解决：脏读、重复读取、幻读
-- 其他事务可以查
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION ;
SELECT *  FROM wms.`product` ;
SELECT COUNT(id) FROM wms.`product` ;
SELECT SLEEP(10);
SELECT *  FROM wms.`product` ;
SELECT COUNT(id) FROM wms.`product` ;
COMMIT ;




show VARIABLES like '%iso%';

select @@autocommit;

SET autocommit=0;



-- RR 快照度

START TRANSACTION ;
select  *  from   demo.person where id=5;
-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值
select  *  from   demo.person where id=5;
COMMIT ;



-- RR 当前度.加了s锁

START TRANSACTION ;
select  *  from   demo.person where id=5 lock in share mode;
-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值
select  *  from   demo.person where id=5  lock in share mode;
COMMIT ;




