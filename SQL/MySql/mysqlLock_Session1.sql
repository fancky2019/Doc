
-- 查看锁记录等待时间：
SHOW VARIABLES LIKE 'innodb_lock_wait_timeout';
-- mysql  解决死锁
-- 等待，直到超时（innodb_lock_wait_timeout=50s），自动回滚事务。回滚开销小的

-- 发起死锁检测，主动回滚一条事务，让其他事务继续执行（innodb_deadlock_detect=on）。


--  mysql InnoDb引擎中update,delete,insert语句自动加排他锁
-- select是不加任何行锁的~事务可以通过以下语句显示给记录集加共享锁或排他锁。

-- 共享锁(S)：SELECT * FROM table_name WHERE ... LOCK IN SHARE MODE
-- 排他锁(X)：SELECT * FROM table_name WHERE ... FOR UPDATE


-- 意向锁 （表锁）：在获取共享锁，排他锁之前系统自动获取，不需要手动干预。为了不全表扫描行是否有锁。
-- 行锁、页锁、表锁
-- 如果精确到行行锁，否则表锁
-- 表锁加锁块、行锁加锁慢。行锁并发性能高

-- InnerDB 默认采用行级锁,普通SELECT语句，InnoDB不会加任何锁


-- 排他锁：事务之间不允许其他排它锁或者共享锁读取，
-- 共享锁：允许其他事物也增加共享锁读取，不允许其他事物增加排它锁 （for update）

-- 共享锁（Ｓ）：
SELECT * FROM table_name WHERE ... LOCK IN SHARE MODE
-- 排他锁（X）：
SELECT * FROM table_name WHERE ... FOR UPDATE

LOCK TABLES demo.`product` READ, demo.`orderhead` WRITE;

UNLOCK TABLES ;


 SELECT *  FROM  demo.`orderhead`;
 
 

-- 测试开启两个SQLYog客户端，一个执行带锁事务，另一个进行增删改查测试。

-- 共享锁（Ｓ）：
-- 事务运行期间：其他事务不可以增删改，可以查
START TRANSACTION ;
-- SELECT * FROM  wms.`product` WHERE ID=7 LOCK IN SHARE MODE;
SELECT * FROM  wms.`product`  LOCK IN SHARE MODE;
SELECT SLEEP(10);
COMMIT ;

-- 测试开启两个SQLYog客户端，一个执行带锁事务，另一个进行增删改查测试。
-- 排他锁（X）：
-- 事务运行期间：其他事务不可以增删改，可以查
START TRANSACTION ;
-- 锁当前行ID=7
 SELECT * FROM  wms.`product` WHERE ID=7 FOR UPDATE;
-- 锁整个表
-- SELECT * FROM  wms.`product`  FOR UPDATE;
SELECT SLEEP(10);
COMMIT ;


SELECT  *  FROM WMS.`product`;

SELECT  *  FROM WMS.`product` WHERID=2;

SELECT  *  FROM WMS.`product` WHERE ID=7;




-- 事务

-- 默认的时候autocommit=1 开启,每次重启SQLyog客户端autocommit=1
-- set autocommit=0
  SHOW VARIABLES LIKE 'autocommit';
-- MySQL默认的存储引擎
 
SHOW ENGINES;
SHOW TABLE STATUS FROM wms WHERE NAME='product'
-- 更改存储引擎
ALTER TABLE wms.product ENGINE = INNODB;



START TRANSACTION ;
UPDATE wms.`product` SET productname='tran111111' WHERE ID=7;
COMMIT ;


START TRANSACTION ;
UPDATE wms.`product` SET productname='tran12' WHERE ID=7;
ROLLBACK ;


-- 不自动提交事务
SET autocommit=0;
UPDATE wms.`product` SET productname='tran12' WHERE ID=7;
COMMIT;


SET autocommit=0;
START TRANSACTION ;
BEGIN;
-- 正常
  INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `Status`,`Count`
)
VALUES
  ( UUID(),   1,1, 1,  'succ166100000', NULL, 3,   3,  3 );
  
-- 报错，Count不有插入
INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `Status`,`Count`
)
VALUES
  ( UUID(),   1,1, 1,  'no count', NULL, 3,   3);
  
  
 COMMIT; --  手动提交了 报错语句没有插成功，但是第一句成功插入数据库，没有回滚
-- ROLLBACK ;-- 手动回滚 不管成功与否，回滚

 -- DELIMITER MYSQL的默认结束符为";". 
DROP PROCEDURE IF EXISTS PRO2; 
DELIMITER ;;

CREATE PROCEDURE PRO2()
BEGIN
    DECLARE t_error INTEGER;
    DECLARE    CONTINUE HANDLER FOR SQLEXCEPTION SET t_error = 1;

    START TRANSACTION;
  -- 正常
  INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `Status`,`Count`
)
VALUES
  ( UUID(),   1,1, 1,  'successPROCEDURE', NULL, 3,   3,  3 );
  
-- 报错，Count不有插入
INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `Status`,`Count`
)
VALUES
  ( UUID(),   1,1, 1,  'no count', NULL, 3,   3,3);
        
IF t_error = 1 THEN
      ROLLBACK;
ELSE
     COMMIT;
 END IF;
END;;
DELIMITER ;
-- delimiter $$　　#将语句的结束符号从分号;临时改为两个$$(可以是自定义)
-- delimiter ;　　#将语句的结束符号恢复为分号
-- 调用存储过程：call sp_name[(传参)];
CALL PRO2();

SELECT *  FROM wms.`product`;





-- 不自动提交事务
SET autocommit=0;
-- 正常
  INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `Status`,`Count`
)
VALUES
  ( UUID(),   1,1, 1,  'successROLLBAC', NULL, 3,   3,  3 );
  
  -- 报错，Count不有插入
    INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `Status`,`Count`
)
VALUES
  ( UUID(),   1,1, 1,  'no count', NULL, 3,   3 );
-- COMMIT; -- 报错语句没有插成功，但是第一句成功插入数据库，没有回滚
ROLLBACK;-- 不管成功与否，回滚




SELECT *  FROM wms.`product`;









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


SELECT *  FROM  wms.`product`;











-- 锁

-- 查看进程
SHOW PROCESSLIST;

SHOW VARIABLES LIKE 'performance_schema';
-- 配置文件设置
SET performance_schema=ON;
-- 查看死锁进程
SELECT blocking_pid FROM sys.schema_table_lock_waits
-- 杀死锁进程：杀sleep的进程16
KILL 16;


-- MyISAM：只支持表锁
-- InnoDb: 表锁、页面、行锁
-- 行锁算法：Record Lock、Gap Lock 和 Next-key Lock。

-- InnoDB的行锁是针对索引加的锁。只有在通过where检索条件使用索引时，才使用行级锁，否则使用表锁！


-- S X  共享排他

-- 意向锁是有数据引擎自己维护的，用户无法手动操作意向锁，在为数据行加共享 / 排他锁之前，InooDB 会先获取该数据行所在在数据表的对应意向锁。

-- IX，IS是表级锁，不会和行级的X，S锁发生冲突。只会和表级的X，S发生冲突
-- 意向共享锁与排他锁冲突 IS
-- 意向排他锁与排他锁和共享锁都冲突 IX
-- 意向锁与意向锁兼容  IS IX 相互兼容



-- mysql InnoDb引擎中update,delete,insert语句自动加排他锁
-- INSERT 锁表
-- DELETE 命中索引锁行，否则锁表
-- UPDATE 命中索引锁行，否则锁表



-- 要开启两个sqlyog 客户端

-- X 没有命中所用 (没有where ),锁整个表
START TRANSACTION ;
UPDATE  test.`t_product` SET product_name='product_2ee' ;
SELECT SLEEP(10);
COMMIT ;

-- X update 命中主键索引 锁行。锁id=2的这行
START TRANSACTION ;
UPDATE  test.`t_product` SET product_name='product_2ee' WHERE id=2;
SELECT SLEEP(10);
COMMIT ;


-- X INSERT 锁表
START TRANSACTION ;
INSERT INTO `test`.`t_product` ( `product_name`) VALUES( 'product_name');
SELECT SLEEP(10);
COMMIT ;


-- X DELETE 锁行
START TRANSACTION ;
DELETE FROM  `test`.`t_product` WHERE id=5;
SELECT SLEEP(10);
COMMIT ;

-- X DELETE 锁表
START TRANSACTION ;
DELETE FROM  `test`.`t_product`;
SELECT SLEEP(10);
COMMIT ;



SELECT  *  FROM test.`t_product`;


TRUNCATE TABLE test.`t_product`;

-- 开两个客户端
-- read :当前会话连接只能读
LOCK TABLES test.`t_product` READ;
-- WRITE;当前会话连接可以写，其他不能增删改查。当前连接客户端可读写，其他客户端不能读写。
LOCK TABLES test.`t_product` WRITE;

UNLOCK TABLES ;


SELECT  *  FROM test.`t_product`;
 
 INSERT INTO `test`.`t_product` ( `product_name`) VALUES( 'product_name');

 DELETE FROM  `test`.`t_product` WHERE id=5;
 
 UPDATE  test.`t_product` SET product_name='product_2ee' WHERE id=2;


-- 写操作的时候，默认都是加排他锁
-- 事务的隔离级别是通过锁来实现

-- 隔离级别与锁的关系
-- 在Read Uncommitted级别下，读取数据不需要加共享锁，这样就不会跟被修改的数据上的排他锁冲突

-- 在Read Committed级别下，读操作需要加共享锁，但是在语句执行完以后释放共享锁；

-- 在Repeatable Read级别下，读操作需要加共享锁，但是在事务提交之前并不释放共享锁，也就是必须等待事务执行完毕以后才释放共享锁。

-- SERIALIZABLE 是限制性最强的隔离级别，因为该级别锁定整个范围的键，并一直持有锁，直到事务完成。读加共享锁，写加排他锁，读写互斥




-- 不可重复读重点在于update和delete，而幻读的重点在于insert,条数变化。

-- 事务日志;undo log、redo log

-- 原子性(A)：undo log就是回滚日志
                -- 如：
                -- (1)当你delete一条数据的时候，就需要记录这条数据的信息，回滚的时候，insert这条旧数据
		-- (2)当你update一条数据的时候，就需要记录之前的旧值，回滚的时候，根据旧值执行update操作
		-- (3)当年insert一条数据的时候，就需要这条记录的主键，回滚的时候，根据主键执行delete操
-- 隔离性(I)：通过设置事务隔离级别--内部通过锁机制和MVCC来保证的，保证了最终数据的一致性了。
-- 持久性(D)：Mysql是通过redo log就是重做日志来实现的
-- 一致性(C)：数据库必须要实现AID三大特性，才有可能实现一致性



-- 事务一般分为两种：隐式事务和显示事务。在Mysql中，事务默认是自动提交的，所以说每个DML语句实际上就是一次事务的过程。
-- 隐式事务：没有开启和结束的标志，默认执行完SQL语句就自动提交，比如我们经常使用的INSERT、UPDATE、DELETE语句就属于隐式事务。
-- 显示事务：需要显示的开启关闭，然后执行一系列操作，最后如果全部操作都成功执行，则提交事务释放连接，如果操作有异常，则回滚事务中的所有操作。


-- 开启事务就自动加锁。

-- 数据库遵循的是两段锁协议，将事务分成两个阶段，加锁阶段和解锁阶段（所以叫两段锁）
-- 【1】加锁阶段：在该阶段可以进行加锁操作。在对任何数据进行读操作之前要申请并获得S锁（共享锁，其它事务可以继续加共享锁，但不能加排它锁），
--                 在进行写操作之前要申请并获得X锁（排它锁，其它事务不能再获得任何锁）。加锁不成功，则事务进入等待状态，直到加锁成功才继续执行。
-- 【2】解锁阶段：当事务释放了一个封锁以后，事务进入解锁阶段，在该阶段只能进行解锁操作不能再进行加锁操作。










