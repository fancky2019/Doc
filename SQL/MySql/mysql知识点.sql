-- 开启一个新连接：再开一个SQLyog客户端
-- 每个语句后必须加分号(;)
--

SELECT IFNULL(ProductStyle,'空')ProductStyle  FROM wms.`product`


-- F5刷新库树结构
-- Del删除选定项
SELECT UUID()
SELECT SYSDATE()

SELECT LOCALTIME() 
-- 毫秒
SELECT CURRENT_TIMESTAMP(3)  ;SELECT NOW(3)
-- 微秒
SELECT CURRENT_TIMESTAMP(6)
--
SELECT UNIX_TIMESTAMP()*1000;

SELECT UUID();
-- 等待10秒
SELECT SLEEP(10);


--ALTER TABLE product ALTER COLUMN UUID SET DEFAULT UUID();

-- 分页第一个参数偏移量 offset，第二个pageSize
SELECT @rownum := @rownum +1 AS rownum,product.* FROM  product  LIMIT 5,3;


-- F5刷新库树结构
DROP TABLE   wms.`TEST`
-- 枚举
-- `sex` ENUM ('男', '女'),

  -- 查询表结构
  USE wms;
  DESCRIBE product;
--rownumber
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