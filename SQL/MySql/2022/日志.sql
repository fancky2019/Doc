-- mysql 5.6 默认数据库引擎innodb

-- 事务日志：redo（持久性）  undo（原子性）。是innodb特有的
-- 查看reddo 设置数量。
show  VARIABLES like 'innodb_log_files_in_group';

-- redo日志：mysql  data 路径下名称ib_logfile：ib_logfile0、ib_logfile1
-- undo 日志：undo_001


-- 缓冲池（Buffer Pool）
-- Redo Log Buffer 机制
 
--  sync_binlog ：0 os  cache,1 事务提交时候写盘
 
 

-- redo log buffer： innodb_flush_log_at_trx_commit:0,1,2 . 1最安全
 
 -- mysql5.7之前默认statement,5.7之后默认  binlog_format	ROW
 
 -- 查看所有变量
 show variables ;
 -- 查看binlog是否开启
show variables like 'log_bin';
 
-- 查询binlog日志
show binlog EVENTS;

 show variables like 'bin_format';
 
#慢查询配置
#开启慢查询
#slow_query_log =1
#慢查询阈值1s默认10s
#long_query_time =1
#慢查询日志
#slow_query_log_file=D:\mysql\data\mysql_slow.log
 
 