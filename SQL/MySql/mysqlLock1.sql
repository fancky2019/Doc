-- 共享锁（Ｓ）：
SELECT * FROM table_name WHERE ... LOCK IN SHARE MODE
-- 排他锁（X）：
SELECT * FROM table_name WHERE ... FOR UPDATE

-- 共享锁（Ｓ）：
-- 事务运行期间：其他事务不可以增删改，可以查
START TRANSACTION ;
-- SELECT * FROM  wms.`product` WHERE ID=7 LOCK IN SHARE MODE;
SELECT * FROM  wms.`product`  LOCK IN SHARE MODE;
SELECT SLEEP(10);
COMMIT ;


-- 排他锁（X）：
-- 事务运行期间：其他事务不可以增删改，可以查
START TRANSACTION ;
-- SELECT * FROM  wms.`product` WHERE ID=7 FOR UPDATE;
SELECT * FROM  wms.`product`  FOR UPDATE;
SELECT SLEEP(10);
COMMIT ;





-- 事务
-- 默认的时候autocommit=1 开启
-- set autocommit=0



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



-- SET [GLOBAL | SESSION] TRANSACTION ISOLATION LEVEL <ISOLATION-LEVEL>
  -- '其中的<isolation-level>可以是：
    -- READ UNCOMMITTED
    -- READ COMMITTED
    -- REPEATABLE READ
    -- SERIALIZABLE
    -- 全局级：对所有的会话有效 
-- 会话级：只对当前的会话有效 

-- READ UNCOMMITTED
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







