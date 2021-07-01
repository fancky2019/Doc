-- 方法1：CREATE TABLE bk(SELECT * FROM USER);
-- 此种表不存在，创建一个。相当于sqlserver的  insert *  into select *  from table
CREATE TABLE demo.`product_20210701` (SELECT * FROM demo.`product`);

-- 方法2：INSERT INTO bk SELECT * FROM  user 
-- 注：此种要求表存在
INSERT INTO demo.`product_20210701`  SELECT * FROM demo.`product`;