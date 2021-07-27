
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








SELECT * FROM demo.person;


INSERT INTO `demo`.`person` ( `name`)
VALUES ('name8');
  
  
  



 
 
 