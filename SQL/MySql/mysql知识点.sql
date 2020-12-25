-- DML（data manipulation language）： SELECT、UPDATE、INSERT、DELETE
-- DDL（data definition language）： CREATE、ALTER、DROP等，DDL主要是用在定义或改变表（TABLE）的结构
-- DCL（Data Control Language）：  设置或更改数据库用户或角色权限的语句，包括（grant,deny,revoke等）语句

-- % 表示所有的IP都能访问，也可以修改为专属的
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
-- 阿里云
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Li5rui31987.' WITH GRANT OPTION;


UPDATE MySQL.user SET authentication_string=PASSWORD('12345678') WHERE USER='root';
-- mypassword 为连接密码 需要修改为你自己的
FLUSH PRIVILEGES;

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
-- boolean在MySQL里的类型为tinyint(1),
-- datetime	'1000-01-01 00:00:00.000000' to '9999-12-31 23:59:59.999999'
-- timestamp	'1970-01-01 00:00:01.000000' to '2038-01-19 03:14:07.999999'

-- blob ：mssql 里的timestamp对应mysql里的blob。mysql插入不需要插叙此列，会自动生成。
--        但是更新行数据，不会更新blob值。不想mssql会更新timestamp值。


-- F5刷新库树结构
-- Del删除选定项
SELECT UUID()；
SELECT SYSDATE();-- 没有毫秒
SELECT  NOW();-- 没有毫秒
SELECT LOCALTIME();
SELECT CURDATE();

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
  SELECT CONVERT('1',SIGNED)+1;
  SELECT CAST(1 AS CHAR);  -- +'12';


  
SELECT IFNULL(NULL,0);


 SELECT CONCAT(2,'test');

-- ALTER TABLE product ALTER COLUMN UUID SET DEFAULT UUID();

-- 分页第一个参数偏移量 offset，第二个pageSize
SELECT @rownum := @rownum +1 AS rownum,product.* FROM  product  LIMIT 5,3;


-- F5刷新库树结构
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

CREATE UNIQUE INDEX Index_Timestamp ON `wms`.`product` (`timestamp`);
-- 删除索引
DROP INDEX index_ProductName ON `wms`.`product` 

-- 字符串包含 :字段名必须以","隔开
FIND_IN_SET('字符', 字段名);



-- 当查询过滤精度越接近要过滤的字段值时候索引优势越大，mysql  设定索引长度原理可能因如此吧。
-- 当查询得到条数越多索引作用很小，和全表扫描差不多。

-- 单列索引： 
         --  主键索引：是一种特殊的唯一索引，一个表只能有一个主键，不允许有空值
         --  唯一索引：值必须唯一，但允许有空值
         --  普通索引：
         --  全文索引： 
-- 组合索引



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
-- DDL
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



