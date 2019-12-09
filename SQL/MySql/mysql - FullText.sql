SELECT  *  FROM wms.`product`
LIMIT 0,1000;

SELECT  *  FROM wms.`product`
LIMIT 999000,2000

INSERT INTO `wms`.`product` (
   `GUID`,
  `StockID`,
  `BarCodeID`,
  `SkuID`,
  `ProductName`,
  `ProductStyle`,
  `Price`,
  `CreateTime`,
  `Status`,
  `Count`,
  `ModifyTime`
)
VALUES
  (
UUID(),NULL,NULL,1,
    'ProductName',
    'ProductStyle',
    1, CURRENT_TIMESTAMP(3),
    1, 1,CURRENT_TIMESTAMP(3)
  );


SHOW VARIABLES LIKE 'ft%';
SHOW VARIABLES LIKE 'innodb_ft_min_token_size%';
-- 配置
　-- my.ini配置文件中添加
　-- # MySQL全文索引查询关键词最小长度限制
　-- [mysqld]
　-- ft_min_word_len = 1
　-- 保存后重启MYSQL，执行SQL语句

-- 在MyISAM数据库引擎中使用的是ft_min_word_len，而InnoDB中使用的是innodb_ft_min_token_size
-- 一张表只能创建一个FULLTEXT索引
-- 创建
CREATE FULLTEXT INDEX fulltext_index ON  wms.`product`
(
 productname,productstyle
)

CREATE FULLTEXT INDEX fulltext_index ON  wms.`product`
(
 productname
)

DROP INDEX fulltext_index ON  wms.`product`


--      使用全文索引的格式：  MATCH (columnName) AGAINST ('string')


SELECT  *  FROM wms.`product` WHERE MATCH(productname,productstyle) AGAINST('BRN1912' IN BOOLEAN MODE);
SELECT  *  FROM wms.`product` WHERE MATCH(productname,productstyle) AGAINST('BRN1912');
-- 查不到，基本单位是词
SELECT  *  FROM wms.`product` WHERE MATCH(productname,productstyle) AGAINST('1912');
SELECT  *  FROM wms.`product` WHERE MATCH(productname,productstyle) AGAINST('BRN');

-- 查不到，基本单位是词
SELECT  *  FROM wms.`product` WHERE MATCH(productname,productstyle) AGAINST('1912' IN BOOLEAN MODE);
SELECT  *  FROM wms.`product` WHERE MATCH(productname,productstyle) AGAINST('BRN' IN BOOLEAN MODE);

SELECT  *  FROM wms.`product` WHERE MATCH(productname,productstyle) AGAINST('batchInsert' IN BOOLEAN MODE);

-- 只能查到词
SELECT  *  FROM wms.`product` WHERE MATCH(productname,productstyle) AGAINST('NAME');

-- 
SELECT  *  FROM wms.`product` WHERE MATCH(productname) AGAINST('batchInsert' IN BOOLEAN MODE);

SELECT  *  FROM wms.`product` WHERE MATCH(productname) AGAINST('batchInsert');
LIMIT 900000,2000





SELECT  *  FROM wms.`product` WHERE  productname LIKE 'BRN1912%';


