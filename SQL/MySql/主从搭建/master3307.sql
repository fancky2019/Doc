
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
 
 

 
 
 -- 创建只读账号
 
 # 创建用户canalMysql
create user canalMysql identified by '123456';
# 给canal1授权访问
GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'canalMysql'@'%';
# 刷新权限
flush privileges;

-- 测试只能查询，不能删除
select  *  from demo.demo_product;
delete from demo.demo_product where id=2;
 
 
 
 

 -- ---------------------GTID------------------------
 
--  查看GTID模式状态
 show variables like "%GTID%";
 
 
 
 
 
 
 
 
 
 
 
 
 
 

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

 
 
 
 
 
 
 
 
 
 
--   MySQL从库的默认状态是只读
 
SET GLOBAL read_only = ON;
SET GLOBAL super_read_only = ON;
 
--  MySQL从库提升为主库：

-- 1. 停止复制进程
-- STOP SLAVE;
-- 2. 查看主从状态
-- SHOW SLAVE STATUS\G;
-- 3. 记录当前从库与主库的日志文件名和位置
-- 记录下Master_Log_File和Read_Master_Log_Pos的值，后面会用到。
-- 4. 断开与主库的连接
-- CHANGE MASTER TO MASTER_HOST='';
-- 5. 应用主库的日志文件和位置
-- CHANGE MASTER TO MASTER_LOG_FILE='xxxx', MASTER_LOG_POS=yyyy;
-- 6. 启动主从复制
-- START SLAVE;
-- 7. 验证主从状态
-- SHOW SLAVE STATUS\G;
 
--       MySQL主从复制默认异步复制进行同步。
--       MySQL主从复制的原理：同步复制、异步复制（默认）、半同步复制、并行复制
--       同步复制（组复制5.7支持）：数据库配置、	MGR组复制 安装插件		当master节点写数据的时候，会等待所有的slave节点完成数据的复制
-- 			 然后提交事务
--       异步复制：主库 提交不关心从库是否提交、默认
--       半同步复制：至少一个从库提交（内网环境，通信要求）、需要安装插件并启用
--       并行复制：数据库配置









-- mysql  默认异步复制
--   半同步复制
 -- 关闭io进程
--  stop slave io_thread;
-- 
--  主库的变量，半同步复制状态
--  SHOW STATUS LIKE '%rpl%';
--  
--   start slave io_thread;

-- 半同步复制 半同步复制失败后会自动切换成异步复制，从库进程起来之后会检测主从库数据是否同步；若不同步，将会采用异步复制的方式同步数据
 
 
 -- 组复制
--  #Group Replication 设置
-- #将 Group Replication 插件添加到服务器在启动时加载的插件列表中。这在生产部署中比手动安装插件更可取。
-- plugin_load_add='group_replication.so'
-- #组名称,必须是uuid，官方建议使用select uuid() 生成，其他方式也可。
-- group_replication_group_name="1adc90a8-1932-11ec-8156-5227ce957eb9"
-- #插件在系统启动时是否自动启动，它确保可以在手动启动插件之前配置服务器
-- group_replication_start_on_boot=off
-- #本服务通信地址
-- group_replication_local_address= "node3:33061"
-- #成员以及内部通信地址
-- group_replication_group_seeds= "node1:33061,node2:33061,node3:33061"
-- #指示插件是否引导group
-- group_replication_bootstrap_group=off
--  
 
 -- 集群mgr
 
 
 
 
 
 
 
 
 
 
 
 
 
 -- 改变主
 
stop slave;
change master to
    master_host='192.168.1.36',
    master_port=3308,
    master_user='repuser',
    master_password='repuser123',
    master_auto_position=1;
start slave;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 