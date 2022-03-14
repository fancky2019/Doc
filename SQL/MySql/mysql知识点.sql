
select VERSION();
select @@VERSION;
-- DML（data manipulation language）： SELECT、UPDATE、INSERT、DELETE
-- DDL（data definition language）： CREATE、ALTER、DROP等，DDL主要是用在定义或改变表（TABLE）的结构
-- DCL（Data Control Language）：  设置或更改数据库用户或角色权限的语句，包括（grant,deny,revoke等）语句

-- 语法已不能用
-- -- % 表示所有的IP都能访问，也可以修改为专属的
-- GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
-- -- 阿里云
-- GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Li5rui31987.' WITH GRANT OPTION;
-- 
-- 
-- UPDATE MySQL.user SET authentication_string=PASSWORD('12345678') WHERE USER='root';
-- -- mypassword 为连接密码 需要修改为你自己的
-- FLUSH PRIVILEGES;








-- mysql8 创建用户分三步 1、创建账号 二、授权  三、刷新权限
--  grant 权限 on 数据库对象　to 用户@主机
-- 查看mysql用户
-- % 表示所有的IP都能访问，也可以修改为专属的
SELECT  *  FROM mysql.user ;
-- 创建账号all权限(除了grant权限),授权只能是root用户
 CREATE USER 'fancky'@'%' IDENTIFIED BY '123456'; -- 创建用户
 GRANT ALL ON *.* TO 'fancky'@'%'; -- 分配所有权限，除了grant权限
 FLUSH PRIVILEGES;   #刷新权限


-- 查看表存储引擎
SHOW TABLE STATUS FROM wms WHERE NAME='product';


SHOW VARIABLES LIKE 'ft%';
SHOW VARIABLES LIKE 'innodb_ft_min_token_size%';
-- 配置
　-- my.ini配置文件中添加
　-- # MySQL全文索引查询关键词最小长度限制
　-- [mysqld]
　-- ft_min_word_len = 1
　-- 保存后重启MYSQL，执行SQL语句

-- 在MyISAM数据库引擎中使用的是ft_min_word_len，而InnoDB中使用的是innodb_ft_min_token_size

-- 每个语句后必须加分号(;)
--

SELECT IFNULL(ProductStyle,'空')ProductStyle  FROM wms.`product`

-- 数据类型
-- DECIMAL(P，D)表示列可以存储D位小数的P位数。十进制列的实际范围取决于精度和刻度。
-- P是表示有效数字数的精度 P范围为1~65。
-- D是表示小数点后的位数。 D的范围是0~30。MySQL要求D小于或等于(<=)P。

-- NUMERIC和DECIMAL没有区别
-- float 、double 由于不能精确表示，会丢失，用decimal
-- boolean在MySQL里的类型为tinyint(1),bit(1)。bit(1)是tinyint(1)的同义词
-- datetime	'1000-01-01 00:00:00.000000' to '9999-12-31 23:59:59.999999'
-- timestamp	'1970-01-01 00:00:01.000000' to '2038-01-19 03:14:07.999999'

-- blob ：mssql 里的timestamp对应mysql里的blob。mysql插入不需要插叙此列，会自动生成。
--        但是更新行数据，不会更新blob值。不想mssql会更新timestamp值。
--  tinyint ：1个字节，
--  smallint ：2个字节，
--  mediumint ：3个字节，
--  int ：4个字节，
--  bigint ：8个字节。

-- F5刷新库树结构
-- Del删除选定项
SELECT UUID()；
SELECT SYSDATE();-- 没有毫秒
SELECT  NOW();-- 没有毫秒
SELECT  NOW(3); -- 有毫秒
SELECT LOCALTIME(); -- 没有毫秒
SELECT CURDATE(); -- 日期

SELECT CONCAT('1','e');

-- CURRENT_TIMESTAMP 等同now()
-- now()（current_timestamp()）函数获得的是语句开始执行时的时间，而sysdate()函数是这个函数执行时候的时间。
-- 毫秒
SELECT CURRENT_TIMESTAMP(3); SELECT NOW(3);SELECT SYSDATE(3);
-- 微秒
SELECT CURRENT_TIMESTAMP(6);SELECT NOW(6);
--
SELECT UNIX_TIMESTAMP()*1000;

SELECT UUID();
-- 获取时间戳 UNIX_TIMESTAMP(date) 
-- 时间戳是指格林威治时间1970年01月01日00时00分00秒(北京时间1970年01月01日08时00分00秒)起至现在的总秒数
SELECT UNIX_TIMESTAMP(NOW());
-- mysql采用utf-8编码,而传统的数据库采用unicode,一个汉字要用两个unicode的char,而在mysql中由于使用了utf-8,
-- 所以无论汉字还是字母,都是一个长度的char,所以就不用分nvarhcar和varchar了,一律作varchar
-- 等待10秒
SELECT SLEEP(10);


-- 类型说明    存储需求
-- tinyint[(m)]    1字节 8位
-- smallint[(m)]   2字节
-- mediumint[(m)]  3字节
-- int[(m)]    4字节
-- bigint[(m)] 8字节
-- float[(m, d)]   4字节
-- double[(m, d)]  8字节
-- decimal (m, d)  m字节（mysql < 3.23），m+2字节（mysql > 3.23 ）


-- timestamp '1970-01-01 00:00:00'到2037年的某时
-- 时间 datetime '1000-01-01 00:00:00'到'9999-12-31 23:59:59'
-- 金额  decimal(18,6)
-- 字符  varchar(50)
-- 状态  tinyint
-- 长整数 bigint
-- bool  tinyint(1)





-- 类型转换
-- cast(values as type) -- convert(values,type)
-- 支持的转换类型如下
-- 二进制，同带binary前缀的效果 : BINARY 
-- 字符型，可带参数 : CHAR()   
-- 日期 : DATE   
--  时间: TIME   
-- 日期时间型 : DATETIME  
-- 浮点数 : DECIMAL 
-- 整数 : SIGNED   --  无符号整数 : UNSIGNED


-- 创建指定ZEROFILL
-- `forward_status` tinyint ZEROFILL DEFAULT '0' COMMENT '0 未预约试听'

-- TINYINT[(M)] [UNSIGNED] [ZEROFILL]  M默认为4
-- TINYINT(1)：tinyint(1) 和 tinyint(4) 中的1和4并不表示存储长度，只有字段指定zerofill是有用， 如tinyint(4)，如果实际值是2，如果列指定了zerofill，查询结果就是0002，左边用0来填充。
-- BOOL，BOOLEAN：是TINYINT(1)的同义词。zero值被视为假。非zero值视为真。

-- int(1)和int（4）
-- 注意数字类型后面括号中的数字，不表示长度，表示的是显示宽度，这点与 varchar、char 后面的数字含义是不同的。
-- 1.规定类型之后，存储是定长的，int(1)和int（4）从本身长度还是存储方式上都是一样的。mysql里，int（1）和int(4)的区别就是显示的长度，但是要设置一个参数：
-- 如果列制定了zerofill 就会用0填充显示，如2 int(3)指定后就会显示为002

SELECT  NOW(3);


-- 不带毫秒
select DATE_FORMAT(NOW(3),'%Y-%m-%d %H:%i:%s');
-- 带微秒
select DATE_FORMAT(NOW(3),'%Y-%m-%d %T:%f');


SELECT CONVERT('1',SIGNED)+1;
SELECT CAST(1 AS CHAR);  -- +'12';

SELECT CAST('2021-08-03' AS DATETIME);  -- 

SELECT CAST('2021-08-03 08:21:32' AS DATETIME);  -- 

SELECT CAST(NOW() AS CHAR);  -- 
SELECT CONVERT(NOW() , CHAR);  -- 
  
    
SELECT IFNULL(NULL,0);


SELECT CONCAT(2,'test');

-- ALTER TABLE product ALTER COLUMN UUID SET DEFAULT UUID();

-- 分页第一个参数偏移量 offset，第二个pageSize
SELECT @rownum := @rownum +1 AS rownum,product.* FROM  product  LIMIT 5,3;


-- F5 刷新sqlyog库树结构

DROP TABLE   wms.`TEST`
-- 枚举
-- `sex` ENUM ('男', '女'),

-- 查询表结构
USE wms; -- 切换数据库
DESCRIBE product;
  
-- rownumber
SELECT @rownum := @rownum +1 AS rownum,product.* FROM (SELECT 
    @rownum := 0) r,  product 
    
SELECT CURRENT_TIMESTAMP(3)
SELECT CURTIME(3)

SELECT UUID()

-- 笛卡尔积之后过滤
-- 交叉连接
SELECT  *  FROM wms.`product` ,wms.`sku` ;
SELECT    * FROM wms.`product` p
         CROSS  JOIN wms.`sku` s ON p.`SkuID`=s.`ID`

-- 隐士内连接会造成笛卡尔积
SELECT  *  FROM wms.`product` ,wms.`sku` WHERE wms.`product`.`SkuID`=wms.`sku`.`ID`;

-- 内连接
SELECT *  FROM wms.`product` p
           JOIN wms.`sku` s ON p.`SkuID`=s.`ID`
           
           
           
  -- DECLARE  只能用在函数或存储过程中    Mysql 不支持 匿名语句块！ 意思就自能写成函数或者存储过程!     
 -- declare @number=100;   


-- 带外键约束的数据删除
SET FOREIGN_KEY_CHECKS=0; 
TRUNCATE TABLE `wms`.`sku` ;
 SET FOREIGN_KEY_CHECKS=1;



-- 查询缓存
SHOW VARIABLES LIKE '%query_cache%';

-- 解释SQL 语句
EXPLAIN SELECT * FROM `wms`.`product`  WHERE  ProductName LIKE 'cnndfyns%'; 


-- 列名和关键字冲突
-- 给字段名加上 ` 号 (键盘数字键1左边的那个键)
EXPLAIN SELECT * FROM `wms`.`product`  WHERE `Count`>500 AND ProductName LIKE '%nndfyns%'; -- 5.014s

-- 创建索引
CREATE  INDEX index_Count ON `wms`.`product` (`Count`);

CREATE  INDEX index_ProductName ON `wms`.`product` (ProductName);

CREATE UNIQUE INDEX Index_Timestamp ON `wms`.`product` (`ModifyTime`);
-- 删除索引
DROP INDEX index_ProductName ON `wms`.`product` ;
CREATE UNIQUE INDEX Index_id ON `wms`.`product` (`StockID` ,`BarCodeID`, `SkuID`);

-- 创建约束：创建约束默认创建唯一索引索引，删除约束通过删除索引。
-- ALTER TABLE <数据表名> ADD CONSTRAINT <唯一约束名> UNIQUE<列名>；

ALTER TABLE `wms`.`product` ADD CONSTRAINT Index_ids UNIQUE  (`StockID` ,`BarCodeID`, `SkuID`);
 -- 删除约束
DROP INDEX Index_ids ON `wms`.`product` ;

-- 查看索引
SHOW INDEX FROM `wms`.`product`;



-- 字符串包含 :字段名必须以","隔开
FIND_IN_SET('字符', 字段名);

-- IN肯定会走索引，但是当IN的取值范围较大时会导致索引失效，走全表扫描。

-- 如果使用了 not in，则不走索引。

-- 当查询过滤精度越接近要过滤的字段值时候索引优势越大，mysql  设定索引长度原理可能因如此吧。
-- 当查询得到条数越多索引作用很小，和全表扫描差不多。

-- 单列索引： 
         --  主键索引：是一种特殊的唯一索引，一个表只能有一个主键，不允许有空值
         --  唯一索引：值必须唯一，但允许有空值
         --  普通索引：
         --  全文索引： 
-- 组合索引
-- 连接查询：如果关联字段字段类型、字符类型不一样将不走索引。join tableNameB po on convert (tr.columC using utf8) = po.columC 
-- 注：创建组合索引根据最左原则，不用再创建单列索引。联合索引（a,b,c）相当于建立了索引：（a）,(a,b)，(a,b,c)

--  UNIQUE KEY 和 PRIMARY KEY
-- 注：UNIQUE 和 PRIMARY KEY 的区别：一个表可以有多个字段声明为 UNIQUE，但只能有一个 PRIMARY KEY 
--     声明；声明为 PRIMAY KEY 的列不允许有空值，但是声明为 UNIQUE 的字段允许空值（只允许一个空置）的存在。
SELECT * FROM `wms`.`product`
LIMIT 0, 1000;
-- 1、使用processlist，但是有个弊端，就是只能查看正在执行的sql语句，对应历史记录，查看不到。好处是不用设置，不会保存。

USE information_schema;
SHOW PROCESSLIST;
   
-- 2、开启日志模式

-- 1、设置日志开启，默认是关闭的
-- SET GLOBAL log_output = 'TABLE';SET GLOBAL general_log = 'ON';  -- //日志开启
-- SET GLOBAL log_output = 'TABLE'; SET GLOBAL general_log = 'OFF'; -- //日志关闭
-- 查看执行的日志
SELECT * FROM mysql.general_log ORDER BY event_time DESC;

EXPLAIN SELECT  *  FROM demo.`test`;

-- 查看注释
-- DDL 建表语句
SHOW CREATE TABLE demo.`Test`;

SHOW FULL COLUMNS FROM demo.`Test`;

-- 查询表的所有列名并用逗号拼接
SELECT GROUP_CONCAT(COLUMN_NAME SEPARATOR ",") FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'NewClassesAdmin' AND TABLE_NAME = 'UserInfo';

SELECT CONCAT('1','2');

-- 字符串长度
SELECT DISTINCT LENGTH(  IFNULL(studentid,'')) len
      FROM demo.`orderhead`
      GROUP BY studentid
      
 
 
--  Ctrl+Shift+C 注释 SQL 窗口选择内容
--  Ctrl+Shift+R 从选择内容删除注释
--  F12 格式化当前行所在的SQL
--  Ctrl+F12    格式化选中的SQL --格式化不太理想

 -- mysql 不支持表变量
 -- mysql 不支持top n
 
 
 
 
 
-- 变量
-- 一、局部变量:mysql局部变量，只能用在begin/end语句块中，比如存储过程中的begin/end语句块。
--  declare关键字声明的变量，只能在存储过程中使用，称为存储过程变量

DECLARE age INT DEFAULT 0;

-- 局部变量的赋值方式一
SET age=18;

SELECT 1 INTO age;


-- 有错，begin end 一般begin-end、流程控制语句、局部变量只能用于函数、存储过程内部、游标、触发器的定义内部
BEGIN
DECLARE @age INT DEFAULT 0;

-- 局部变量的赋值方式一
SET @age=18;
SELECT @age;
END


BEGIN
-- 局部变量的赋值方式一
SET @age=18;
SELECT @age;
END


START TRANSACTION;

-- DECLARE age INT DEFAULT 0;

-- 局部变量的赋值方式一
SET @age=18;
SELECT @age;
 
COMMIT;


-- uuid mysql  无法指定默认值，通过触发器；插入之后更新uuid 值
SELECT UUID();


-- 局部变量的赋值方式二
-- select StuAge 
-- into age
-- from demo.student 
-- where StuNo='A001';


-- 二、用户变量：mysql用户变量，mysql中用户变量不用提前申明，在用的时候直接用“@变量名”使用就可以了。
-- 第一种用法，使用set时可以用“=”或“:=”两种赋值符号赋值
SET @age=19;
SET @age:=20;
-- 第二种用法，使用select时必须用“:=”赋值符号赋值
SELECT @age:=22 ;

-- 三、会话变量
-- mysql会话变量，服务器为每个连接的客户端维护一系列会话变量。
-- 其作用域仅限于当前连接，即每个连接中的会话变量是独立的。

-- 四、全局变量:
		-- mysql全局变量，全局变量影响服务器整体操作，当服务启动时，它将所有全局变量初始化为默认值。要想更改全局变量，必须具有super权限。
		-- 其作用域为server的整个生命周期。
-- if函数
SELECT  IF(500<1000, 5, 10) result;
SELECT  IF(500<1, 5, 10) result;
-- case when
-- mysql 不支持top n
SELECT top 1 sex FROM demo.`userinfo` WHERE sex IS NOT NULL;

SELECT CASE sex WHEN '男' THEN 'Man'
                 ELSE  '女'
                 END sex1  FROM demo.`userinfo` WHERE sex IS NOT NULL AND sex <>'' LIMIT  0,1;
                 
SELECT CASE  WHEN sex='男' THEN 'Man1'
                 ELSE  '女'
                 END sex1  
            FROM demo.`userinfo` WHERE sex IS NOT NULL AND sex <>'' LIMIT  0,1;
                 
SELECT @Test:=1;                                  
SELECT @Test+1 Test;       
SELECT CONCAT (CAST( @Test AS CHAR ),"23abc") Test;          
-- SELECT  CONCAT (cast( @Test as nvarchar ),"abc" ) Test;                 
SELECT CONVERT('1',SIGNED)+1;
SELECT CAST(@Test AS CHAR);  -- +'12';
--   不支持+              
--     select "a"+"b" ;   


-- 临时表、 内存表
-- 临时表  数据库不显示表名称
-- 创建方式一
CREATE TEMPORARY TABLE tmp_ProductNamePrice 
 SELECT  
  `ProductName`,
  `Price`
FROM
  `demo`.`product`

-- 使用
SELECT *  FROM tmp_ProductNamePrice;
-- 记得删除
DROP TABLE tmp_ProductNamePrice;
DROP TABLE IF EXISTS tmp_ProductNamePrice;


-- 创建方式二
CREATE TEMPORARY TABLE tmp_ProductNamePrice (
ProductName VARCHAR(50) NOT NULL,
Price DECIMAL(18,2) NOT NULL
) 

INSERT INTO  tmp_ProductNamePrice    SELECT  
  `ProductName`,
  `Price`
FROM
  `demo`.`product`    
 -- 使用
SELECT *  FROM tmp_ProductNamePrice;
INSERT INTO tmp_ProductNamePrice( `ProductName`, `Price`) VALUES ('ProductName',90.90);
-- 记得删除
DROP TABLE tmp_ProductNamePrice;     

-- 创建临时表
CREATE TEMPORARY  TABLE person_temp_table (
SELECT  
  `name`,
  age
FROM `demo`.`person`
   ) ; 


DROP  TABLE IF EXISTS person_temp_table;


SHOW CREATE TABLE demo.`person`;

-- 默认 engine=innodb
-- 内存表 ：指定  ENGINE = MEMORY。左侧数据库会显示表名称

CREATE TABLE [IF NOT EXISTS]  内存表名
(
	...
) ENGINE = MEMORY

-- mysql 不支持select  * into table_target  from table_source（前提表不存在） ,支持insert into select(前提表存在).
CREATE TABLE person_memory_table (
   `name` VARCHAR(50) NOT NULL,
  `age` INT DEFAULT NULL
   ) ENGINE = MEMORY; 



-- select  生成表
CREATE TABLE person_memory_table (
SELECT  
  `name`,
  age
FROM `demo`.`person` 
   ) 
   
DROP TABLE IF EXISTS person_memory_table;  
-- 插入 
  
-- 方法1：CREATE TABLE bk(SELECT * FROM USER);
-- 此种表不存在，创建一个。相当于sqlserver的  insert *  into select *  from table
CREATE TABLE demo.`product_20210701` (SELECT * FROM demo.`product`);

-- 方法2：INSERT INTO bk SELECT * FROM  user 
-- 注：此种要求表存在
INSERT INTO demo.`product_20210701`  SELECT * FROM demo.`product`;






--  SELECT * FROM table LIMIT [offset,] rows | rows OFFSET offset
-- limit 两种写法 ：一和二参数对调;逗号前偏移，offset后偏移
  
SELECT  * FROM  demo.`orderhead` LIMIT 3,5;
  
SELECT  * FROM  demo.`orderhead` LIMIT 5 OFFSET 3;
  
-- limit top 

SELECT *  FROM demo.`orderhead` LIMIT 5
  
SELECT *  FROM demo.`orderhead` LIMIT 0,5      



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
-- 用此种代替
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1)) FROM t_crm_clue t;
		
-- 查看mysql版本
SELECT VERSION();

	
-- 使用 字段->'$.json属性'进行查询条件
-- 使用json_extract函数查询，json_extract(字段,"$.json属性")
-- 根据json数组查询，用JSON_CONTAINS(字段,JSON_OBJECT('json属性', "内容"))
-- '$[*].productPrice'  所有  '$[0].productPrice'  第一个

SELECT  id ,liveProList->'$[*].productPrice' productPriceAray 
FROM (	
	SELECT  Id,    
		 CAST(   JSON_EXTRACT(package_content,'$.liveProList')  AS JSON) liveProList
		 FROM (
			SELECT co.id,  CAST(package_content AS JSON)package_content 
			FROM `online`.t_crm_order co 
			JOIN `online`.t_crm_order_detail cod ON co.order_number=cod.order_number							
			WHERE cod.ispackage=2             	
		        ORDER BY co.id  DESC			
	             )t1
    ) t2
		
		
						

	
--  FIND_IN_SET(str,strlist)  strlist 如果为null 返回null,
--  不为null 返回str在strlist中的索引。索引从1开始，不包含返回0



-- null  统计
-- MySQL 中 sum 函数没统计到任何记录时，会返回 null 而不是 0，可以使用 IFNULL(null,0) 函数把 null 转换为 0；
-- 在MySQL中使用count（字段），不会统计 null 值，COUNT(*) 才能统计所有行；
-- MySQL 中使用诸如 =、<、> 这样的算数比较操作符比较 NULL 的结果总是 NULL，这种比较就显得没有任何意义，需要使用 IS NULL、IS NOT NULL 或 ISNULL() 函数来比较      
                 
    
  
    
 -- 主从同步方式： 异步复制（默认）、半同步复制（需安装插件semisync_master.so）、并行复制 （需配置）  
 
 
 -- 并行复制 配置： MySQL 5.7开启Enhanced Multi-Threaded Slave配置：
# slave
-- slave-parallel-type=LOGICAL_CLOCK
-- slave-parallel-workers=16
-- master_info_repository=TABLE
-- relay_log_info_repository=TABLE
-- relay_log_recovery=ON  
    

-- PREPARE 语句     
SET @selectCommand='select *  from person';
-- 注：拼接 where 前加空格；单引号转义
SET @selectCommand :=CONCAT( @selectCommand , ' where id = ? and name like \'%na%\' ');
-- select  @selectCommand; 
PREPARE stmt1 FROM @selectCommand ;
SET @a=3;
EXECUTE stmt1 USING @a;
DEALLOCATE PREPARE stmt1;  
    


-- 批量插入
-- bulk_insert_buffer_size=100M
-- insert  into ('col1','col2')value (),()
                 


-- 1添加表字段

ALTER TABLE table1 ADD transactor VARCHAR(10) NOT NULL;

ALTER TABLE   table1 ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY


-- 修改列
-- alter table tablename change old_column new_column int(11) not null
ALTER TABLE `online`.t_sales_target CHANGE data_permission_id dept_data_permission_id BIGINT  NOT NULL
ALTER TABLE `online`.t_crm_order CHANGE buy_user_id buy_user_id BIGINT  NOT NULL DEFAULT 0;
-- FORCE INDEX
SELECT  * FROM `online`.t_crm_order FORCE INDEX(adviser)


EXPLAIN
SELECT   dp.dept_name,d.dept_name group_name,u.major_dept_id,
SUM(	( IFNULL(co.deal_amount,0)+IFNULL( co.refund_amount,0)*-1 ) * ROUND(1-IFNULL(co.profit_percent,0),2) ) actual_sale_amount ,
co.buy_user_id ,st.sales_amount,st.person_num
FROM `online`.t_user  u
JOIN `online`.t_dept d ON u.major_dept_id =d.id
LEFT JOIN `online`.t_dept dp ON d.parent_id=dp.id					
LEFT JOIN `online`.t_crm_order co FORCE INDEX(adviser) ON co.adviser=u.Id    AND co.pay_time>='2021-01-21' AND co.pay_time<='2021-04-12'
JOIN `online`.t_sales_target st	ON st.salesman_id =u.Id	  AND  st.effective_time  BETWEEN '202101' AND '202104'
GROUP BY dp.dept_name,d.dept_name ,u.major_dept_id,co.buy_user_id ,st.sales_amount,st.person_num


-- 查看表中列定义
SELECT * FROM 	information_schema.`COLUMNS` 
WHERE (table_schema='online' AND  table_name='t_crm_order' AND column_name='buy_user_id')
OR (table_schema='online' AND  table_name='t_clues' AND column_name='id')



-- 连接查询	A JOIN B JOIN C	
-- JOIN ON AND and 右表条件
-- A表条件放在where

-- JOIN ON AND  先过滤后连接
-- where 先on笛卡尔积后过滤



	
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


-- utf8的是隐式的，等价于utf8mb3，
-- utf8 应该设置utf8mb4


-- character_set_system 存储元数据的数据格式  不用设置

-- 查看默认存储引擎 InnoDB
SHOW VARIABLES LIKE '%engine%'

SHOW ENGINES;




-- mysql  limit offset 数据过大会有性能问题，sqlserver rownum() over() 用between and 没有性能问题
-- limit 优化	:前提id自增
--  join id :先查询出id 然后用待查询表join  id	
SELECT id,NAME,balance 
FROM account 
WHERE  
id >= (
         SELECT a.id FROM account a WHERE a.update_time >= '2020-09-19' LIMIT 100000, 1
       )
 AND update_time >= '2020-09-19'
LIMIT 10; 

-- 建议采用此种
-- 用连接查询代替嵌套查询
SELECT  acct1.id,acct1.name,acct1.balance
 FROM account acct1
 INNER JOIN (
                SELECT a.id FROM account a WHERE a.update_time >= '2020-09-19' ORDER BY a.update_time LIMIT 500000, 10
               ) AS  acct2 ON acct1.id= acct2.id

SELECT a.*  
FROM demo.`userinfo` a
JOIN (
	SELECT id
	FROM demo.`userinfo`
	-- WHERE AddedTime>'2015-09-01'
	LIMIT 600000,10
)b ON a.id=b.id
-- 以下借助rownum()
-- 标签
SELECT  id,NAME,balance FROM account WHERE id > 100000 ORDER BY id LIMIT 10;

-- between ...and 
SELECT  id,NAME,balance FROM account WHERE id BETWEEN 500000 AND 500010 ORDER BY id;


-- 查看索引
SHOW INDEX FROM demo.`userinfo`;

SHOW KEYS  FROM demo.`userinfo`;

-- 新建数据库，设置字符集
-- 字符集
-- utf8mb4
-- 排序规则
-- utf8mb4_general_ci
-- 表的字符集默认为库的字符集



-- id 自增达到最大值，报异常
-- Duplicate entry '2147483647' for key 'PRIMARY'
-- 解决办法：设置id类型为bigint (8byte) `id` bigint unsigned NOT NULL,


-- 用于记录mysql的数据更新或者潜在更新(比如DELETE语句执行删除而实际并没有符合条件的数据)，在mysql主从复制中就是依靠的binlog
SHOW VARIABLES LIKE 'binlog_format'

-- mysql 如果字段值为null 则该字段不能使用 <> !=进行比较



-- 开启事务就自动加锁。

-- 事务一般分为两种：隐式事务和显示事务。在Mysql中，事务默认是自动提交的，所以说每个DML语句实际上就是一次事务的过程。
-- 隐式事务：没有开启和结束的标志，默认执行完SQL语句就自动提交，比如我们经常使用的INSERT、UPDATE、DELETE语句就属于隐式事务。
-- 显示事务：需要显示的开启关闭，然后执行一系列操作，最后如果全部操作都成功执行，则提交事务释放连接，如果操作有异常，则回滚事务中的所有操作。




-- 数据库遵循的是两段锁协议，将事务分成两个阶段，加锁阶段和解锁阶段（所以叫两段锁）
-- 【1】加锁阶段：在该阶段可以进行加锁操作。在对任何数据进行读操作之前要申请并获得S锁（共享锁，其它事务可以继续加共享锁，但不能加排它锁），
--                 在进行写操作之前要申请并获得X锁（排它锁，其它事务不能再获得任何锁）。加锁不成功，则事务进入等待状态，直到加锁成功才继续执行。
-- 【2】解锁阶段：当事务释放了一个封锁以后，事务进入解锁阶段，在该阶段只能进行解锁操作不能再进行加锁操作。



-- 1、创建账号 二、授权  三、刷新权限

-- 创建账号

-- 查看mysql用户
SELECT  *  FROM mysql.user 
 
  -- 删除用户
 DROP USER 'masteraccount'@'%';
 
-- 创建账户用于主从同步
 CREATE USER 'masteraccount'@'%' IDENTIFIED BY '123456'; -- 创建用户
 -- 修改登录方式  sqlyog无法登录
 ALTER USER 'masteraccount'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
  
-- 命令:GRANT privileges ON databasename.tablename TO 'username'@'host'
  GRANT REPLICATION SLAVE ON *.* TO 'masteraccount'@'%' ;#分配主从权限 
 
 
 GRANT ALL PRIVILEGES ON *.* TO 'masteraccount'@'%' ;-- 分配所有权限
 
 GRANT ALL ON *.* TO 'masteraccount'@'%'; -- 分配所有权限
 
 FLUSH PRIVILEGES;   #刷新权限
 
 

-- 创建账号all权限(除了grant权限),授权只能是root用户
 CREATE USER 'fancky'@'%' IDENTIFIED BY '123456'; -- 创建用户
 GRANT ALL ON *.* TO 'fancky'@'%'; -- 分配所有权限，除了grant权限
 FLUSH PRIVILEGES;   #刷新权限

 
 -- 创建只读账号
 
 -- *.*：表示所有数据库中的所有表。
 -- testdb.* 表示testdb库中的所有表
 
 -- ‘%’ 通配符 @‘%’ 表示任何主机
 
  DROP USER 'canal'@'%';
 # 创建用户canalMysql
create user 'canal' identified by 'canal';
# 给canal1授权访问  SELECT, INSERT, UPDATE, DELETE
GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'canal'@'%';
# 刷新权限
flush privileges;

-- 测试只能查询，不能删除
select  *  from demo.demo_product;
delete from demo.demo_product where id=2;
 
 
 
 
 --  grant 权限 on 数据库对象　to 用户@主机
grant select,insert,update,delete on testdb.* to 'canalMysql'@'%';-- 'canalMysql' 用户增删改查权限 
FLUSH PRIVILEGES;   #刷新权限


 -- 单库权限
 grant select on testdb.* to 'canalMysql'@localhost; -- 'canalMysql' 可以查询 testdb 中的表。
 flush privileges;
 
 -- 查看当前用户权限
 show grants;
 
 


 







