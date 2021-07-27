

#3307主库   SHOW MASTER STATUS;  MASTER_LOG_FILE:file  MASTER_LOG_POS:position

-- localhost   
CHANGE MASTER TO MASTER_HOST='localhost',MASTER_USER='masteraccount',MASTER_PASSWORD='123456',MASTER_PORT=3307,MASTER_LOG_FILE='mysql-bin.000006',MASTER_LOG_POS=14718;


-- Slave_IO_Running 是connecting不是    Slave_IO_Running: Yes 
-- 解决：
--               masteraccount账号权限密码
--              MASTER_LOG_POS 不对
-- 启动slave同步进程：
START SLAVE;

STOP SLAVE;

-- 查从服务器的slave状态  
SHOW SLAVE STATUS;

-- 加\G报错，控制台执行没问题
SHOW SLAVE STATUS\G


SELECT * FROM demo.person;




