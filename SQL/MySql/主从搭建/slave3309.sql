-- localhost   
CHANGE MASTER TO MASTER_HOST='localhost',MASTER_USER='masteraccount',MASTER_PASSWORD='123456',MASTER_PORT=3307,MASTER_LOG_FILE='mysql-bin.000006',MASTER_LOG_POS=14718;

-- 启动slave同步进程：
START SLAVE;

STOP SLAVE;

-- 查从服务器的slave状态  
SHOW SLAVE STATUS;

-- 加\G报错，控制台执行没问题
SHOW SLAVE STATUS\G

SELECT * FROM demo.person;


-- shardingsphere 读写分离校验 读只会执行在slave连接，robbin默认负载均衡

-- 2、开启日志模式

-- 1、设置
 SET GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'ON';
 SET GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'OFF';

-- 2、查询
SELECT * FROM mysql.general_log ORDER BY    event_time DESC

-- 3、清空表（delete对于这个表，不允许使用，只能用truncate）
 TRUNCATE TABLE mysql.general_log;