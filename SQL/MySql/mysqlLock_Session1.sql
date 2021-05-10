
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

-- update 命中主键索引 锁行。锁id=2的这行
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





