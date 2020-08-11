-- 表名加单引号
-- 每条语句后最好加分号“；”
-- BLOB 二进制数据类型;
-- GUID VARCHAR(36) 和mysql 设计一样
insert into 'ClientOrderID' (CliOrderID) values ("123");

-- SQLite 没有truncate  用Delete
DELETE FROM 'ClientOrderID';
select * from sqlite_sequence;    
-- 删除递增
DELETE FROM sqlite_sequence WHERE name = 'ClientOrderID';


-- 获取建表语句
SELECT sql FROM sqlite_master WHERE type="table" AND name = "查询的表名";
SELECT sql FROM sqlite_master WHERE type="table" AND name = "ClientOrderID";

-- 
CREATE TABLE "Order" (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, OrderBytes BLOB NOT NULL);
CREATE TABLE ClientOrderID (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, CliOrderID STRING NOT NULL);




--当前时间
select datetime('now');

select datetime();
-- 日期
select date();

-- 本地时间
select datetime(CURRENT_TIMESTAMP,'localtime');

select CURRENT_TIMESTAMP;
--   时间戳是指格林威治时间自1970年1月1日（00:00:00 GMT）至当前时间的总秒数。它也被称为Unix时间戳（Unix Timestamp）。
-- 时间戳
SELECT strftime('%s','now');

-- 2020-08-11 02:37:52.224
select strftime('%Y-%m-%d %H:%M:%f','now');
--解决时差问题
select strftime('%Y-%m-%d %H:%M:%f','now','localtime');

-- guid:sqlite 没有guid 函数
select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ;


select *  from 'ClientOrderID';

update 'ClientOrderID' set ClientOrderID ='456';

Insert into 'Order' (OrderBytes) values ('dd');



select *  from 'ClientOrderID';

select *  from 'Order';

select  * from 'Product';


