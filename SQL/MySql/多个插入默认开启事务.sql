
INSERT INTO `demo`.`user` (`ID`, `Account`, `Password`)
VALUES
  ('ID', 'Account', 'Password');




SELECT * FROM`demo`.`user` LIMIT 0, 1000;


SELECT *  FROM test.`Job` LIMIT 0, 1000;

SELECT *  FROM wms.`product`
-- 解释SQL 语句
EXPLAIN SELECT * FROM `wms`.`product`  WHERE  ProductName LIKE 'cnndfyns%'; 

-- 创建索引
CREATE  INDEX index_Count ON `wms`.`product` (`Count`);
-- 删除索引
DROP INDEX index_Count ON `wms`.`product`

CREATE INDEX PRODUCT_INDEX_PRICE ON WMS.`product`(PRICE ASC)

EXPLAIN SELECT PRICE FROM `wms`.`product` 

EXPLAIN SELECT PRICE FROM `wms`.`product`  WHERE PRICE>1

EXPLAIN SELECT PRICE FROM `wms`.`product`  WHERE PRICE>=1


CREATE INDEX PRODUCT_INDEX_PRODUCTMULTIPLE ON WMS.`product`
(
PRODUCTNAME,
PRODUCTSTYLE,
CREATETIME DESC,
PRICE ASC
);


-- possible_keys：指出MySQL能使用哪个索引在该表中找到行。如果是空的，没有相关的索引。这时要提高性能，可通过检验WHERE子句，看是否引用某些字段，或者检查字段不是适合索引。

-- key：显示MySQL实际决定使用的键。如果没有索引被选择，键是NULL。

-- mysql 只会使用一个索引。最左原则：使用最左侧的索引。

-- 命中索引 index_ProductName 
EXPLAIN SELECT * FROM `wms`.`product`  WHERE productname LIKE 'dd%';

-- 有坐通配符无法命中索引
EXPLAIN SELECT * FROM `wms`.`product`  WHERE productname LIKE '%dd%' ;

-- 如果有 单列索引 则命中单列索引index_ProductName
-- 删除单列索引 命中复合索引
EXPLAIN SELECT * FROM `wms`.`product`  WHERE  productstyle LIKE 'd%' AND productname LIKE 'pro%'  AND PRICE>=1;


DROP INDEX index_ProductName ON product;

SELECT * FROM `wms`.`barcode`  ;

SELECT * FROM `wms`.`product` ;

EXPLAIN SELECT * FROM `wms`.`product`  WHERE   productname LIKE 'd%'  AND productstyle LIKE 'pro%'  AND PRICE>=1;


SELECT * FROM `wms`.`product`  WHERE   productname LIKE 'd%'  AND productstyle LIKE 'pro%'  AND PRICE>=1;







SELECT  *  FROM wms.`sku`

-- 其中一行出错，其他行没有插入成功。
INSERT INTO `wms`.`sku` ( `uuid`, `Unit`)
VALUES
  (UUID(), '包'), (UUID(), '跟'), (UUID(), 'ddddddddddddddddddd'), (UUID(), '头');

-- 都插入成功
INSERT INTO `wms`.`sku` ( `uuid`, `Unit`)
VALUES
  (UUID(), '包'), (UUID(), '跟'), (UUID(), '位'), (UUID(), '头');
  
  
SELECT UUID();






