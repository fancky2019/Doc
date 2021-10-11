-- 字符串截取			
SELECT  LEFT('12345678',3)sub；
-- 字符串拼接
SELECT  CONCAT('123','456') AS ad;
-- 日期格式化字符串
SELECT   DATE_FORMAT(CURRENT_DATE(),'%Y-%m-%d')date_str;
-- 获取年月
SELECT   DATE_FORMAT(CURRENT_DATE(),'%Y%m');
 -- 获取年
 SELECT DATE_FORMAT(NOW(), '%Y'); 
 -- 获取天
 SELECT DATE_FORMAT(NOW(), '%d'); 
 
 -- day of MONTH:月的天 
 SELECT  DAY(NOW());
 
 -- 获取当前月的天数
 SELECT DATEDIFF(DATE_ADD(CURDATE()-DAY(CURDATE())+1,INTERVAL 1 MONTH ),DATE_ADD(CURDATE(),INTERVAL -DAY(CURDATE())+1 DAY)) FROM DUAL  
 
 -- 当前日期
SELECT CURDATE();

 -- 获取月初
 SELECT  DATE_ADD(CURDATE(),INTERVAL -DAY(CURDATE())+1 DAY);   
 
-- 字符串转日期 STR_TO_DATE(字符串，日志格式)
SELECT STR_TO_DATE('2019-01-20', '%Y-%m-%d');
 	
				
		-- mysql 8支持 ROW_NUMBER()				
	SELECT ROW_NUMBER() OVER (ORDER BY id DESC) row_num FROM t_crm_clue t;		
  -- 代替方案
	  SET @row_num=0;
		SELECT @row_num:=@row_num+1 row_num FROM t_crm_clue t;		
	-- 不支持 ORDER BY 1 ；sqlserver支持
  SELECT ROW_NUMBER() OVER (ORDER BY 1) FROM t_crm_clue t;		

		
	-- 查看mysql版本
	SELECT VERSION();
	
	-- 使用 字段->'$.json属性'进行查询条件
-- 使用json_extract函数查询，json_extract(字段,"$.json属性")
-- 根据json数组查询，用JSON_CONTAINS(字段,JSON_OBJECT('json属性', "内容"))
-- '$[*].productPrice'  所有  '$[0].productPrice'  第一个


	SELECT  id ,liveProList->'$[*].productPrice' productPriceAray FROM (	
		SELECT  Id,    
		                     CAST(   JSON_EXTRACT(package_content,'$.liveProList')  AS JSON) liveProList
																						  FROM (
	SELECT co.id,  CAST(package_content AS JSON)package_content 
	       FROM 		`online`.t_crm_order co 
					JOIN 	`online`.t_crm_order_detail cod 	ON co.order_number=cod.order_number							
				 WHERE cod.ispackage=2             	
				ORDER BY co.id  DESC			
		
		)t1
		) t2
		
		
						
SELECT VERSION();
--  FIND_IN_SET(str,strlist)  strlist 如果为null 返回null,
--         不为null 返回str在strlist中的索引。索引从1开始，不包含返回0

 SHOW VARIABLES LIKE 'datadir';
 
 
SHOW VARIABLES WHERE Variable_name LIKE 'character_set_%' OR Variable_name LIKE 'collation%';

SHOW VARIABLES LIKE'%char%';

SHOW VARIABLES LIKE 'log_%';

-- 开启二进制日志 log_bin=on;默认开启
SHOW VARIABLES LIKE 'log_bin%';
SHOW MASTER LOGS;
SHOW MASTER STATUS;


-- 　　MySQL 5.7.7 之前，binlog 的默认格式都是 STATEMENT，在 5.7.7 及更高版本中，binlog_format 的默认值才是 ROW
--   binlog_format=statement
SHOW VARIABLES LIKE 'binlog_format%';



-- 修改列		
ALTER TABLE `online`.t_sales_target CHANGE data_permission_id dept_data_permission_id BIGINT  NOT NULL


-- ALTER TABLE <数据表名> CHANGE COLUMN <字段名> <数据类型> DEFAULT <默认值>;
ALTER TABLE `online`.t_sales_target CHANGE dept_data_permission_id BIGINT  NOT NULL DEFAULT 1;


-- limit 优化	:前提id自增	
SELECT id,NAME,balance 
FROM account 
WHERE  
id >= (
         SELECT a.id FROM account a WHERE a.update_time >= '2020-09-19' LIMIT 100000, 1
       )
 AND update_time >= '2020-09-19'
LIMIT 10; -- 写漏了，可以补下时间条件在外面		
		
		
	


		
		
		

		
						
 