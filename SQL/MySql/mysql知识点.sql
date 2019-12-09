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


-- F5刷新库树结构
-- Del删除选定项
SELECT UUID()
SELECT SYSDATE()

SELECT LOCALTIME() ；
-- 毫秒
SELECT CURRENT_TIMESTAMP(3)  ;SELECT NOW(3)
-- 微秒
SELECT CURRENT_TIMESTAMP(6)
--
SELECT UNIX_TIMESTAMP()*1000;

SELECT UUID();
-- 等待10秒
SELECT SLEEP(10);


-- ALTER TABLE product ALTER COLUMN UUID SET DEFAULT UUID();

-- 分页第一个参数偏移量 offset，第二个pageSize
SELECT @rownum := @rownum +1 AS rownum,product.* FROM  product  LIMIT 5,3;


-- F5刷新库树结构
DROP TABLE   wms.`TEST`
-- 枚举
-- `sex` ENUM ('男', '女'),

  -- 查询表结构
  USE wms;
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

