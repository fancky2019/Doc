
	
	-- gtid  要指定主服务时候多了选项  master_auto_position=1;    其他都和主从配置一样
	-- 具体配置参见主从配置
	
	
	
	
	
	
	
	
	
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
 
 
 
 CHANGE MASTER TO MASTER_HOST='localhost',MASTER_USER='masteraccount',MASTER_PASSWORD='123456',MASTER_PORT=3307,MASTER_LOG_FILE='mysql-bin.000004',MASTER_LOG_POS=1910;
 

-- 	Slave_IO_Running: no  Slave_SQL_Running: no  解决
-- 	准备：从库丢失的主库ddl 要手动在从库执行。丢失的数据，开始数据同步一直以后在同步数据。
-- 因为设置MASTER_LOG_POS 会丢失之前信息
-- 	1、从库 stop slave; 
-- 	2、主库 show master status 找到 MASTER_LOG_FILE 和 MASTER_LOG_POS
-- 	3、从库执行脚本同步  MASTER_LOG_FILE 和 MASTER_LOG_POS
-- 		 change master to
--      master_host='127.0.0.1',
-- 		 MASTER_PORT=3307,
--      master_user='masteraccount',
--      master_password='123456',
--      master_auto_position=0;
-- 		 
--  CHANGE MASTER TO MASTER_HOST='localhost',MASTER_USER='masteraccount',MASTER_PASSWORD='123456',MASTER_PORT=3307,MASTER_LOG_FILE='mysqlbinlog.000037',MASTER_LOG_POS=7365; 
--  4、启动从库  start slave;
--  5、show slave status ：Slave_IO_Running: YES  Slave_SQL_Running: YES


 
 -- - 1、主 创建用户
 	   SHOW MASTER STATUS; 
   show slave status;
	 
 --  2、从 执行

	 -- 此句制定 gtid  要指定  master_auto_position=1; 
	 change master to
     master_host='127.0.0.1',
		 MASTER_PORT=3307,
     master_user='masteraccount',
     master_password='123456',
     master_auto_position=1;
		 
		 
		 
--  建立主从连接、启用gtid状况下：
-- 如果使用master_auto_position，就无需指定master_log_file和master_log_pos，
-- 如果通过file和pos指定主从的起始位置，就需带上master_auto_position=0
--  
 CHANGE MASTER TO MASTER_HOST='localhost',MASTER_USER='masteraccount',MASTER_PASSWORD='123456',MASTER_PORT=3307,MASTER_LOG_FILE='mysql-bin.000006',MASTER_LOG_POS=7935;



		START SLAVE;

    STOP SLAVE;

-- stop replica;
STOP SLAVE;
-- change master to master_auto_position=0;

-- 主从同步  查看报错原因
select * from performance_schema.replication_applier_status_by_worker;






-- root 账户下创建
-- 创建只读账户

CREATE USER 'fanckyread'@'%' IDENTIFIED BY '123456';

-- 1227 - Access denied; you need (at least one of) the SUPER, REPLICATION CLIENT privilege(s) for this operation
-- 只读权限
GRANT SELECT,REPLICATION SLAVE ,REPLICATION CLIENT ,REPLICATION_SLAVE_ADMIN ON *.* TO 'fanckyread'@'%'


 ALTER USER 'fanckyread'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
 
 
 FLUSH PRIVILEGES;









	 