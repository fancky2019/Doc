

-- 自动提交事务、显示事务、隐式事务。
-- 一般单个执行的语句就是自动提交事务。


--隔离级别	            解决并发问题	        存在的并发问题	            说明
--READ UNCOMMITED　　	不适用于并发场合	 脏读、不可重复读、幻读	    隔离级别最低，允许一个事务读取其他事务修改但未提交的数据
--READ COMMITED(default)　　	脏读	   丢失更新、不可重复读、幻读	 这是Sql Server的默认隔离级别，一个事务不允许读取另一个事务未提交的数据
--REPEATABLE READ	          不可重复读	   幻读、死锁 	              一个事务读取的数据在未结束之前，不能被其他事务修改
--SERIALIZABLE	               幻读　　	    数据可用性降低、死锁	     这是最高级别的隔离，它会锁定一个范围的数据，从而阻止其他事务修改或新增这个范围的数据 
--SNAPSHOT          	上述所有并发问题　　	 事务访问的是虚拟快照，其他事务Commited的数据对当前事务仍然不可见，也不允许Update被其他事务Update的数据	快照事务隔离级别默认是不启用的，是基于行版本的事务控制
-- READ COMMITTED SNAPSHOT　　	 上述所有并发问题	 无	 它可以读取被其他事务提交的数据，也可以修改数据


 
--隔离级别               允许脏读   允许不可重复读     允许丢失更新    允许幻读  检测更新冲突  使用行版本控制
--READ UNCOMMITTED          是	         是	                 是          	是	     否	          否
--READ COMMITTED	        否	         是	                 是	            是	     否	          否
--REPEATABLE READ        	否	         否	                 否	            是	     否	          否
--SERIALIZABLE	            否	         否                  否	            否	     否	          否
--SNAPSHOT	                否	         否	                 否     	    否	     是	          是
--READ COMMITTED SNAPSHOT	否	         是                  是      	    是	     否	          是






USE WMS
GO
-- READ UNCOMMITTED;相当于nolock 可以select、update、delete、Insert
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 GO
 BEGIN tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --锁定整个表
  SELECT *  FROM  [WMS].[dbo].[Product]
  --select COUNT(ID) FROM  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  COMMIT tran lockTest
  go





USE WMS
GO
--READ COMMITTED(默认):解决 脏读， 事务期间其他事务可以增删改查
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
 GO
 BEGIN tran lockTest
  select *  FROM  [WMS].[dbo].[Product] WHERE ID=1069
--  SELECT *  FROM  [WMS].[dbo].[Product]
  --select COUNT(ID) FROM  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep

  -- 不能解决不能重复读取的问题
 --  select *  FROM  [WMS].[dbo].[Product] WHERE ID=1056
  COMMIT tran lockTest
  go




USE WMS
GO
--REPEATABLE READ:解决 脏读,可重复读取， 事务期间其他事务不能update、delete,可以select、insert
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
 GO
 BEGIN tran lockTest
 -- 锁定ID=50这一??
  select *  from  [WMS].[dbo].[Product] where ID=1056
 --锁定整个表
 -- select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) FROM  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  select *  from  [WMS].[dbo].[Product] where ID=50
  COMMIT tran lockTest
  go


USE WMS
GO
--SERIALIZABLE（相当于holdlock）:解决 脏读,可重复读取、幻读， 事务期间其他事务不能update、delete、insert,可以select
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
 GO
 BEGIN tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --锁定整个表
  SELECT *  FROM  [WMS].[dbo].[Product]
  select COUNT(ID) FROM  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  SELECT *  FROM  [WMS].[dbo].[Product]
  select COUNT(ID) FROM  [WMS].[dbo].[Product]
  COMMIT tran lockTest
  go


USE WMS
GO
 --需将 READ_COMMITTED_SNAPSHOT 设置为 ON，其默认为OFF
--SNAPSHOT（相当于holdlock）:解决 脏读,可重复读取、幻读， 事务期间其他事务不能update、delete、insert,可以select
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
 GO
 BEGIN tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --锁定整个表
  SELECT *  FROM  [WMS].[dbo].[Product]
  --select COUNT(ID) FROM  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  COMMIT tran lockTest
  go
  
  
  
  
