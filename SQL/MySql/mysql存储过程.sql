

-- declare关键字声明的变量，只能在存储过程中使用，称为存储过程变量

BEGIN	
-- declare a int default 1;

DECLARE user_name VARCHAR(100);
-- select a;
SET user_name='test';
SELECT user_name;
END
-- 使用set或select直接赋值，变量名以@开头
SET @var=2; 
SELECT @var;


SELECT @var2:=3;
SELECT @var2;
SELECT @var2 v2;


SELECT * FROM wms.`product` LIMIT 0,5

 -- DELIMITER MYSQL的默认结束符为";". 
DROP PROCEDURE IF EXISTS Pro_PageData; 
DELIMITER$$
CREATE PROCEDURE Pro_PageData
(
IN pageSize INT,
IN pageIndex INT,
OUT TotalCount INT

 -- ,
-- inout fancky varchar(20)
)
BEGIN
    DECLARE t_error INTEGER;
    DECLARE tempCount INT ;-- 赋值用set
    
    -- 变量声明在异常处理声明签名
    DECLARE    CONTINUE HANDLER FOR SQLEXCEPTION SET t_error = 1;

START TRANSACTION;
-- 注意输出参数的赋值,最好用into
   SELECT COUNT(ID) INTO TotalCount FROM wms.`product`;
   -- set tempCount=(SELECT COUNT(ID)  FROM wms.`product`);
  --  set TotalCount=tempCount;
    -- select * from wms.`product` limit   0,5 ;              -- (pageIndex-1)*pageSize,pageIndex*pageSize;
    
    SET @pageSize = pageSize;
    SET @pageIndex = pageIndex;
   SET @strsql = CONCAT('SELECT * FROM wms.`product` LIMIT ', (@pageIndex-1)* @pageSize, ',' ,@pageIndex* @pageSize);
  --  set @strsql = CONCAT('SELECT * FROM wms.`product` LIMIT', 0, ',' ,5);
     PREPARE sqlCommand FROM @strsql;
     -- print  出SQL语句
     -- SELECT  @strsql ;
     EXECUTE sqlCommand;
     -- 释放资源
   DEALLOCATE PREPARE strsql;
IF t_error = 1 THEN
      ROLLBACK;
ELSE
      COMMIT;
 END IF;
END;
$$
DELIMITER ;

-- delimiter $$　　#将语句的结束符号从分号;临时改为两个$$(可以是自定义)
-- delimiter ;　　#将语句的结束符号恢复为分号
-- 调用存储过程：call sp_name[(传参)];
SET @totalCount=0;
-- 注意参数顺序
CALL Pro_PageData(5,1,@totalCount);
SELECT @totalCount;







DROP PROCEDURE IF EXISTS Pro_PageData_new; 
DELIMITER$$
CREATE PROCEDURE Pro_PageData_new
(
IN pageSize INT,
IN pageIndex INT,
OUT TotalCount INT ,
 INOUT fancky VARCHAR(200)
)
BEGIN
    DECLARE t_error INTEGER;
    DECLARE tempCount INT ;-- 赋值用set
    
 -- 变量声明在异常处理声明前面
DECLARE    CONTINUE HANDLER FOR SQLEXCEPTION SET t_error = 1;

START TRANSACTION;
-- 注意输出参数的赋值,最好用into
   SELECT COUNT(ID) INTO TotalCount FROM wms.`product`;
   -- set tempCount=(SELECT COUNT(ID)  FROM wms.`product`);
  --  set TotalCount=tempCount;
   SET @strsql = CONCAT('SELECT * FROM wms.`product` LIMIT ', (pageIndex-1)* pageSize, ',' ,pageIndex* pageSize);
  --  set @strsql = CONCAT('SELECT * FROM wms.`product` LIMIT', 0, ',' ,5);
     PREPARE sqlCommand FROM @strsql;
     -- print  出SQL语句
      SELECT  @strsql ;
     EXECUTE sqlCommand;
   DEALLOCATE PREPARE strsql;
   
   SET fancky=CONCAT(fancky,':xin test');
IF t_error = 1 THEN
      ROLLBACK;
ELSE
      COMMIT;
 END IF;
END;
$$
DELIMITER ;



-- 字符串拼接
-- select concat('asss','ddd');






-- 调用存储过程：call sp_name[(传参)];
SET @totalCount=0;
SET @fancky='huihui';
-- 注意参数顺序
CALL Pro_PageData_new(5,1,@totalCount,@fancky);
-- 输出参数要select
SELECT @totalCount;
SELECT @fancky;






DROP PROCEDURE IF EXISTS Pro_InsertSku; 
DELIMITER$$
CREATE PROCEDURE Pro_InsertSku
(
)
BEGIN
    DECLARE t_error INT;
    DECLARE number INT DEFAULT 1 ;
    -- 变量声明在异常处理声明签名
    DECLARE    CONTINUE HANDLER FOR SQLEXCEPTION SET t_error = 1;

START TRANSACTION;
    WHILE number <= 100000 DO    
      INSERT INTO `wms`.`sku` (`uuid`, `Unit`) VALUES( UUID(), '件');
       SET number:=number+1;
    END WHILE;
IF t_error = 1 THEN
      ROLLBACK;
ELSE
      COMMIT;
 END IF;
END;
 $$
DELIMITER ;



--  不带事务、参数的存储过程，没有事务插入好慢
DROP PROCEDURE IF EXISTS Pro_InsertSku; 
DELIMITER$$
CREATE PROCEDURE Pro_InsertSku
(
)
BEGIN
    DECLARE number INT DEFAULT 1 ;
    WHILE number <= 100000 DO    
      INSERT INTO `wms`.`sku` (`uuid`, `Unit`) VALUES( UUID(), '件');
       SET number:=number+1;
    END WHILE;
END;
$$
DELIMITER ;

CALL Pro_InsertSku();

-- 带外键约束的数据删除
SET FOREIGN_KEY_CHECKS=0; 
TRUNCATE TABLE `wms`.`sku` ;
SET FOREIGN_KEY_CHECKS=1;









