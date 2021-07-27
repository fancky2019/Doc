
 SELECT  *  FROM mysql.user 
 
  -- 删除用户
 DROP USER 'masteraccount'@'%';
 
-- 创建账户用于主从同步
 CREATE USER 'masteraccount'@'%' IDENTIFIED BY '123456'; -- 创建用户
 -- 修改登录方式  sqlyog无法登录
 ALTER USER 'masteraccount'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
  
-- 命令:GRANT privileges ON databasename.tablename TO 'username'@'host'
  GRANT REPLICATION SLAVE ON *.* TO 'masteraccount'@'%' ;#分配主从权限 
 
 
 GRANT ALL PRIVILEGES ON *.* TO 'masteraccount'@'%' ;-- 分配所有权限
 
 GRANT ALL ON *.* TO 'masteraccount'@'%'; -- 分配所有权限
 
  #root 为你数据库要连接用户的用户名，后面为密码
 

 
 FLUSH PRIVILEGES;   #刷新权限

SHOW MASTER STATUS;








SELECT * FROM `person`


INSERT INTO `demo`.`person` ( `name`)
VALUES ('name8');
  
  
  

-- 1、使用processlist，但是有个弊端，就是只能查看正在执行的sql语句，对应历史记录，查看不到。好处是不用设置，不会保存。

-- use information_schema;
-- show processlist;
-- 或者：
-- select * from information_schema.`PROCESSLIST` where info is not null;



-- 2、开启日志模式

-- 1、设置
 SET GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'ON';
 SET GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'OFF';

-- 2、查询
SELECT * FROM mysql.general_log ORDER BY    event_time DESC

-- 3、清空表（delete对于这个表，不允许使用，只能用truncate）
 TRUNCATE TABLE mysql.general_log;

 
 
 