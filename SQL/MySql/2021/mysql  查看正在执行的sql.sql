-- 1、使用processlist，但是有个弊端，就是只能查看正在执行的sql语句，对应历史记录，查看不到。好处是不用设置，不会保存。

-- use information_schema;
-- show processlist;
-- 或者：
-- select * from information_schema.`PROCESSLIST` where info is not null;



-- 2、开启日志模式

-- 1、设置
-- SET GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'ON';
-- SET GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'OFF';

-- 2、查询
SELECT * FROM mysql.general_log ORDER BY    event_time DESC

-- 3、清空表（delete对于这个表，不允许使用，只能用truncate）
-- truncate table mysql.general_log;