
-- 聚集索引和非聚集索引的区别及优缺点：
-- 区别： 
  --   1).聚集索引一个表只能有一个，而非聚集索引一个表可以存在多个 
   --   2).聚集索引存储记录是物理上连续存在，而非聚集索引是逻辑上的连续，物理存储并不连续 
　-- 3).聚集索引:物理存储按照索引排序；聚集索引是一种索引组织形式，索引的键值逻辑顺序决定了表数据行的物理存储顺序 
　-- 　非聚集索引:物理存储不按照索引排序；非聚集索引则就是普通索引了，仅仅只是对数据列创建相应的索引，不影响整个表的物理存储顺序. 
  --   4).索引是通过二叉树的数据结构来描述的，我们可以这么理解聚簇索引：索引的叶节点就是数据节点。而非聚簇索引的叶节点仍然是索引节点，只不过有一个指针指向对应的数据块。 
--  优势与缺点: 
   --   聚集索引插入数据时速度要慢（时间花费在“物理存储的排序”上，也就是首先要找到位置然后插入）,查询数据比非聚集数据的速度快 


-- key 、index区别：
-- key 是数据库的物理结构，它包含两层意义，一是约束（偏重于约束和规范数据库的结构完整性），二是索引（辅助查询用的）相当于index。包括primary key, unique key, foreign key 等。

-- InnerDB MYISAM 区别：
-- 一、InnerDB支持事务 ，MYISAM不支持 二、InnerDB支持外键 ， ，MYISAM不支持 
-- 三、InnderDB主索引是数据，MYISAM是数据地址 四、MYISAM会保存行数



-- 主索引：叶子节点保存完整行数据。
-- 辅助索引：叶子节点包含Key值和主索引。覆盖索引就是找到Key值才不用二次查询。

-- 回表查询：根据值查询到辅助索引的Key值和主键索引，然后根据主键索引再去查询完整行数据。

-- MyISAM 索引存的是数据地址

-- innerdb
-- 主索引==群集索引（只能有一个）:叶子节点保存的是数据.因为记录所在地址并不能保证一定不会变，但主键可以保证。
-- id 自增：不自增需不断地调整数据的物理地址、分页，它只需要一页一页地写，索引结构相对紧凑，磁盘碎片少，效率也高。



-- 覆盖索引：概念：需要查询的字段在索引中，不需要再回到表中查询。如 select col1,col2都在索引中就不需要回表查询，如果col1在索引中，col2不在，就要回到表中差col2。
    --       设计：将被查询的字段，建立到联合索引里去。
    --       场景：分页查询

-- 创建索引
CREATE  INDEX index_Count ON `wms`.`product` (`Count`);
-- 删除索引
DROP INDEX index_Count ON `wms`.`product`;


-- unique CONSTRAINT ，唯一索引：确保唯一，唯一索引还是使用了 唯一约束。

CREATE INDEX PRODUCT_INDEX_PRODUCTMULTIPLE ON WMS.`product`
(
	PRODUCTNAME,
	PRODUCTSTYLE,
	CREATETIME DESC,
	PRICE ASC
);

-- explain 查看key使用索引情况，key :null 未命中

-- possible_keys：指出MySQL能使用哪个索引在该表中找到行。如果是空的，没有相关的索引。这时要提高性能，可通过检验WHERE子句，看是否引用某些字段，或者检查字段不是适合索引。

-- key：显示MySQL实际决定使用的键。如果没有索引被选择，键是NULL。

-- mysql 只会使用一个索引。最左原则：使用最左侧的索引。


-- EXTRA:
-- using index ：使用覆盖索引的时候就会出现

-- using where：在查找使用索引的情况下，需要回表去查询所需的数据

-- using index condition：查找使用了索引，但是需要回表查询数据


-- 命中索引 index_ProductName 
EXPLAIN SELECT * FROM `wms`.`product`  WHERE productname LIKE 'dd%';

-- 有左通配符无法命中索引
EXPLAIN SELECT * FROM `wms`.`product`  WHERE productname LIKE '%dd%' ;

  SELECT * FROM `wms`.`product`  ;
-- 如果有 单列索引 则命中单列索引index_ProductName
-- 删除单列索引 命中复合索引
EXPLAIN SELECT * FROM `wms`.`product`  WHERE  productstyle LIKE 'd%' AND productname LIKE 'pro%'  AND PRICE>=1;

EXPLAIN SELECT  productstyle, productname ,PRICE FROM `wms`.`product`  WHERE  productstyle LIKE 'pro%' AND productname LIKE 'pro%'  AND PRICE>=1;

EXPLAIN SELECT  productstyle, productname ,PRICE FROM `wms`.`product`  WHERE   productname LIKE 'pro%' AND productstyle LIKE 'pro%'   AND PRICE>=1;
-- Using where; Using index
EXPLAIN SELECT  productname ,productstyle  FROM `wms`.`product`  WHERE   productname LIKE 'pro%' AND productstyle LIKE 'pro%' ;
-- Using index: 覆盖索引
EXPLAIN SELECT  productstyle, productname  FROM `wms`.`product` ;

-- Using where; Using index: where筛选条件是索引列之一但是不是索引的不是前导列。
EXPLAIN SELECT  productstyle, productname  FROM `wms`.`product`  WHERE productstyle= 'ProductStyle6';

-- Using index: 覆盖索引
EXPLAIN SELECT  productstyle, productname  FROM `wms`.`product`  WHERE productname= 'aaaclnwjga';

EXPLAIN SELECT  productstyle, productname  FROM `wms`.`product`  WHERE productname= 'a%' AND productstyle LIKE 'pro%' ;



