-- 表名加单引号
-- 每条语句后最好加分号“；”
-- BLOB 二进制数据类型;
-- GUID VARCHAR(36) 和mysql 设计一样
INSERT INTO 'ClientOrderID' (CliOrderID) VALUES ("123");

-- SQLite 没有truncate  用Delete
DELETE FROM 'ClientOrderID';
SELECT * FROM sqlite_sequence;    
-- 删除递增
DELETE FROM sqlite_sequence WHERE NAME = 'ClientOrderID';


-- 获取建表语句
SELECT SQL FROM sqlite_master WHERE TYPE="table" AND NAME = "查询的表名";
SELECT SQL FROM sqlite_master WHERE TYPE="table" AND NAME = "ClientOrderID";

-- 
CREATE TABLE "Order" (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, OrderBytes BLOB NOT NULL);
CREATE TABLE ClientOrderID (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, CliOrderID STRING NOT NULL);




-- 当前时间
SELECT DATETIME('now');

SELECT DATETIME();
-- 日期
SELECT DATE();

-- 本地时间
SELECT DATETIME(CURRENT_TIMESTAMP,'localtime');

SELECT CURRENT_TIMESTAMP;
--   时间戳是指格林威治时间自1970年1月1日（00:00:00 GMT）至当前时间的总秒数。它也被称为Unix时间戳（Unix Timestamp）。
-- 时间戳
SELECT strftime('%s','now');

-- 2020-08-11 02:37:52.224
SELECT strftime('%Y-%m-%d %H:%M:%f','now');
-- 解决时差问题
SELECT strftime('%Y-%m-%d %H:%M:%f','now','localtime');

-- guid:sqlite 没有guid 函数
SELECT HEX( randomblob(4)) || '-' || HEX( randomblob(2))
             || '-' || '4' || SUBSTR( HEX( randomblob(2)), 2) || '-'
             || SUBSTR('AB89', 1 + (ABS(random()) % 4) , 1)  ||
             SUBSTR(HEX(randomblob(2)), 2) || '-' || HEX(randomblob(6)) ;


SELECT *  FROM 'ClientOrderID';

UPDATE 'ClientOrderID' SET ClientOrderID ='456';

INSERT INTO 'Order' (OrderBytes) VALUES ('dd');



SELECT *  FROM 'ClientOrderID';

select *  from 'Order';

select  * from 'Product';


