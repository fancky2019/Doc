-- 多版本并发控制（Multi-Version Concurrency Control，MVCC）是一种用于实现事务隔离性的并发控制机制，
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
-- Read View 快照读操作的时候生产的 读视图 (Read View)

-- mysql 事务隔离级别之可能出现的问题：同一事务中无法查询已插入但未提交的数据
-- 若要实现查询事务中已插入但是未提交的数据则需要设置MySQL事务隔离级别为 read-uncommitted



-- 两阶段协议：事务加锁、解锁

-- 加锁：start  TRANSACTION 之后在需要加锁的时候加锁，并不是开启事务时候就加所有的锁，不然不会产生死锁。 锁占用行顺序a--b 和占用行b--a。
-- COMMIT 和ROLLBACK：解锁

-- 事务并发问题
-- 脏读                     A读取了B回滚的数据
-- 不可重复读取             A两次读取期间数据被B修改了
-- 幻读                     A两次读取期间B新增、删除，mvcc 解决快照读幻读，当前读幻读 通过 select ** lock in share  mdoel  ,select ** for update
-- 丢失更新                 1类更新：A先更新被后更新B回滚   2类更新：A先更新被B覆盖了更新 
-- （rr 解决1类回滚丢失更新，没有解决2类更新覆盖）             
-- 写写 mysql 默认加锁了，必须等待一个事务执行完另外一个事务才能执行

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
-- 【2】解锁阶段：当事务释放了一个锁以后，事务进入解锁阶段，在该阶段只能进行解锁操作不能再进行加锁操作。






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

-- A
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION ;
SELECT *  FROM wms.`product` WHERE ID=7;
SELECT SLEEP(10);
ROLLBACK;  

-- B 脏读了A修改的数据
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION ;
SELECT *  FROM wms.`product` WHERE ID=7;
COMMIT ;




-- 'READ COMMITTED
--  解决：脏读
-- 其他事务可以增删改查
-- A 两次读取的数据不一致
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION ;
SELECT *  FROM wms.`product`  WHERE ID=7;
SELECT SLEEP(10);
SELECT *  FROM wms.`product`  WHERE ID=7;
COMMIT ;

-- B 修改了A事务要读取的数值
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION ;
UPDATE  wms.`product` SET product_name='fanc'  WHERE ID=7;
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



--  Read View 快照读操作的时候生产的 读视图 (Read View)
-- SERIALIZABLE，事务串行执行，一个一个执行，读加共享锁，写加排它锁
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


-- 解决了幻读  其他 事务可以插入 age《57 的数据，但是查不到最新插入的数据
-- 快照读  没有幻读
START TRANSACTION ;
select count(*) from   person WHERE age<57 ;
SELECT SLEEP(10);
select count(*) from   person WHERE age<57 ;
COMMIT ;

-- 第二次使用当前读 产生幻读
START TRANSACTION ;
select count(*) from   person WHERE age<57 ;
SELECT SLEEP(10);
select count(*) from   person WHERE age<57 for UPDATE;
COMMIT ;

-- 第一次读采用当前读加锁（临间锁）其他事务不能插入数据
START TRANSACTION ;
select count(*) from   person WHERE age<57 for UPDATE;
SELECT SLEEP(10);
select count(*) from   person WHERE age<57 ;
COMMIT ;

show VARIABLES like '%iso%';

select @@autocommit;

SET autocommit=0;



-- RR 快照度

START TRANSACTION ;
select  name  from   demo.person where id=5;
-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值
SELECT SLEEP(10);
select  name  from   demo.person where id=5;
COMMIT ;



-- RR 当前度.加了s锁

START TRANSACTION ;
select  *  from   demo.person where id=5 lock in share mode;
-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值
select  *  from   demo.person where id=5  lock in share mode;
COMMIT ;


-- 两个事务写同一条数据，mysql 内部会加锁（默认临间锁），只有第一个事务完成释放锁。
-- 第二个事务才能获得锁执行，这样就解决回滚丢失更新问题

-- 1、类丢失更新，回滚
START TRANSACTION ;
-- 局部变量直接使用不需要声明
update  demo.person  set name='fancky2223' where id=5;
SELECT SLEEP(10);

-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值
-- rr 解决回滚丢失更新，没有解决2类丢失更新（更新覆盖）问题。
COMMIT ;



-- 丢失更新：1、A事务回滚，造成B事务的修改丢失。2、B事务覆盖A事务的修改。至于不是并发造成的覆盖只能用乐观锁解决（版本号 时间戳）。
START TRANSACTION ;
-- 局部变量直接使用不需要声明
select @age:=age from   demo.person where id=5;
select @age;

-- update  demo.person  set age=@age+2 where id=5;
update  demo.person  set age=27 where id=5;
SELECT SLEEP(10);
-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值
-- rr mysql自己解决回滚丢失更新，没有解决2类丢失更新（更新覆盖）问题--因为更新覆盖是两个事务写，而MVCC作用与两个读写事务
--    不加锁，即不能作用于写写事务(不是线程安全的操作)，写写事务通过加锁来实现（乐观锁、悲观锁)。
-- 写写 mysql 默认加锁了，必须等待一个事务执行完另外一个事务才能执行
COMMIT ;


-- SERIALIZABLE 解决1、2类事务并发的丢失更新问题，至于前后事务的更新覆盖只能用乐观锁解决。
-- SERIALIZABLE： 串化解决事务并发问题，事务一个一个排队执行，读加S锁，写加X锁。
-- SERIALIZABLE 容易造成死锁，同一个事务内先读后改。
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION ;
-- 局部变量直接使用不需要声明
select @age:=age from   demo.person where id=5;
select @age;
SELECT SLEEP(10);
update  demo.person  set age=@age+2 where id=5;
-- RR 解决了不能重复读取问题，但是在两次读取中间如果另一个事务进行修改，提交则无法读取到最新修改的值
-- rr 解决回滚丢失更新，没有解决2类丢失更新（更新覆盖）问题。
-- 
COMMIT ;


-- 事务间的可见性：
-- read_view 时候当前活跃的事务(ids): 未提交的事务ids [min_trx_id,max_trx_id)
-- （1）trx_id < min_trx_id；说明该记录在创建 read_view 之前已提交，所以对当前事务可见。
-- 
-- （2）trx_id >= max_trx_id；说明该记录是在创建 read_view 之后启动事务生成的，所以对当前事务不可见。
-- 
-- （3）min_trx_id <= trx_id < max_trx_id；此时需要判断是否在 m_ids 列表中：
--      a:在列表中。生成该版本记录的事务仍处于活跃状态，该版本记录对当前事务不可见。
--      b:不在列表中。生成该版本记录的事务已经提交，该版本记录对当前事务可见。







