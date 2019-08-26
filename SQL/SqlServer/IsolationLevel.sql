
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
  
  
  
  
