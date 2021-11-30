DROP PROCEDURE IF EXISTS proc_error_print; 
DELIMITER $$
CREATE PROCEDURE proc_error_print
(
-- IN pageSize INT,
-- IN pageIndex INT,
-- OUT TotalCount INT
)
BEGIN

 DECLARE end_time_var DATETIME;
 DECLARE amount_var DECIMAL(20,2);
 DECLARE create_user_var VARCHAR(45);
 
 DECLARE result_code INTEGER DEFAULT 0;  -- 定义返回结果并赋初值0
 DECLARE page_size INTEGER DEFAULT 0; 
 DECLARE return_code CHAR(5) DEFAULT '00000';
 DECLARE msg TEXT;
 DECLARE printMsg TEXT;
 
--  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET result_code=1;  -- 在执行过程中出任何异常设置result_code为1
--  DECLARE CONTINUE HANDLER FOR NOT FOUND SET result_code = 2;  -- 如果表中没有下一条数据则置为2
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
     BEGIN
      -- 获取异常code,异常信息
       get diagnostics CONDITION 1 return_code = returned_sqlstate, msg = message_text;
       SET result_code=1;
    END;
 -- SET @pageSize = pageSize;
 
 
-- 开启事务
START TRANSACTION;
	

SET page_size:=CONVERT('sdsd',SIGNED);

-- 异常回滚
IF result_code = 1 THEN -- 可以根据不同的业务逻辑错误返回不同的result_code，这里只定义了1和0
   -- 复制异常code，异常信息
    SET printMsg := CONCAT('exception rallback, return_code = ',return_code,', message = ',msg);
    SELECT  printMsg; 
    ROLLBACK; 
ELSE 
   SELECT  CONCAT('result_code:',result_code); -- mysql  没有print 只能select
   COMMIT; 
END IF;
	 
		 
END $$

DELIMITER ;



-- 调用
-- CALL proc_error_print();









