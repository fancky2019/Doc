DROP PROCEDURE IF EXISTS pro_loop_insert; 
DELIMITER $$
CREATE PROCEDURE pro_loop_insert
(
-- IN pageSize INT,
-- IN pageIndex INT,
-- OUT TotalCount INT
)
BEGIN



 DECLARE channel_id_var VARCHAR(45) ;
 DECLARE channel_name_var VARCHAR(45);
 DECLARE start_time_var DATETIME;
 DECLARE end_time_var DATETIME;
 DECLARE amount_var DECIMAL(20,2);
 DECLARE create_user_var VARCHAR(45);
 DECLARE dept_id_var VARCHAR(45);
 -- 游标结束的标志
 DECLARE done INT DEFAULT 0; 
 DECLARE result_code INTEGER DEFAULT 0;  -- 定义返回结果并赋初值0
 -- 声明游标
 DECLARE channel_consume_cursor CURSOR FOR  SELECT channel_id ,channel_name,start_time ,end_time,amount,create_user,dept_id FROM  `online`.t_crm_channel_consume; 
 -- 指定游标循环结束时的返回值 
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done =1;

 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET result_code=1;  -- 在执行过程中出任何异常设置result_code为1
--  DECLARE CONTINUE HANDLER FOR NOT FOUND SET result_code = 2;  -- 如果表中没有下一条数据则置为2
  
 -- SET @pageSize = pageSize;
 
 
 	-- 开启事务
	START TRANSACTION;
	
	TRUNCATE TABLE t_crm_channel_consume_item;
	
 -- 打开游标
 OPEN channel_consume_cursor;
	
  -- loop 循环取游标里数据
  inner_loop:LOOP
	-- 从游标里取一条数据
  FETCH channel_consume_cursor INTO channel_id_var,channel_name_var,start_time_var,end_time_var,amount_var,create_user_var,dept_id_var;
	
	-- 当 游标的返回值为 1 时 退出 loop循环 
	IF done = 1 THEN
			LEAVE inner_loop;
	END IF;
	
	SET @start_date:=DATE_FORMAT(start_time_var,'%y-%m-%d');
	SET @end_date:=DATE_FORMAT(end_time_var,'%y-%m-%d');
	SET @diff:=DATEDIFF(@end_date,@start_date);
	SET @day_amount=amount_var/(@diff+1);
	SET @i=0;
	WHILE @i<=@diff DO
	
	 SET @date:=DATE_ADD(@start_date,INTERVAL @i DAY);
	 SET @i:= @i+1;
	 
	 INSERT INTO `online`.`t_crm_channel_consume_item` (
  `channel_id`,
  `channel_name`,
  `date`,
  `amount`,
  `create_time`,
  `create_user`,
  `dept_id`
	)
	VALUES
		(
			channel_id_var,
			channel_name_var,
			@date,
-- 			'dddddd',-- 制造插入异常
			@day_amount,
			NOW(3),
		 create_user_var,
		 dept_id_var
		);
	
END WHILE;`demo`
-- 结束游标循环							
END LOOP inner_loop;
-- 关闭游标
CLOSE channel_consume_cursor;

-- 异常回滚
IF result_code = 1 THEN -- 可以根据不同的业务逻辑错误返回不同的result_code，这里只定义了1和0
    SELECT  'rallback'; 
    ROLLBACK; 
ELSE 
   SELECT  CONCAT('result_code:',result_code); -- mysql  没有print 只能select
   COMMIT; 
END IF;
	 
		 
END $$

DELIMITER ;



-- 调用
CALL pro_loop_insert();


SELECT  *  FROM t_crm_channel_consume_item; 

-- truncate table t_crm_channel_consume_item;








