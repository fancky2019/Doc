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

SELECT UUID()


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

TRUNCATE TABLE wms.`product`
INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `CreateTime`,`Status`,`Count`, `ModifyTime`
)
VALUES
  (
    
   UUID(),   1,1, 1,  'ProductName1', 'ProductStyle1',
    3, NOW(3),  3,  3,  NOW(3)
  );
  
  INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `Status`,`Count`
)
VALUES
  (
    
   UUID(),   1,1, 1,  'ddfarrrr', 'ProductStyle1',
    3,   3,  3
  );
  
  
UPDATE wms.`product` SET ProductName='苹果22' WHERE id=2
  
  SELECT  *  FROM wms.`product`;
  
  
SELECT  *  FROM wms.`BarCode`;
SELECT  *  FROM wms.`Sku`;
SELECT  *  FROM wms.`Stock`;

SELECT *  FROM information_schema.`TABLES`


SELECT  *  FROM wms.`product` p  
JOIN wms.`sku` s ON p.`SkuID`=s.`ID`
WHERE  p.`ProductName` LIKE '苹果%';


ALTER  TABLE wms.`product` ADD INDEX index_ProductName(ProductName)

CREATE INDEX index_ProductName ON  wms.`product` (ProductName) ;
-- create INDEX index_name ON table_name (column_list) ;


DROP INDEX index_ProductName ON wms.`product` ;
ALTER TABLE table_name DROP INDEX index_name ;


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
           
           
-- 时间相减
SELECT  DATEDIFF('2021-05-27' ,'2021-05-26');   

 SELECT TIMEDIFF(time1,time2)      
           
SELECT DATE_ADD(NOW(), INTERVAL 1 MONTH);    -- 加1月

       
           
           
           
           

