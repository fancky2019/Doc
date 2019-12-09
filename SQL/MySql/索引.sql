-- 创建索引
CREATE  INDEX index_Count ON `wms`.`product` (`Count`);
-- 删除索引
DROP INDEX index_Count ON `wms`.`product`;


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

