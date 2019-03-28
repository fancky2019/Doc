
use WMS
GO
-- READ UNCOMMITTED;相当于nolock 可以select、update、delete、Insert
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 GO
 begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go





use WMS
GO
--READ COMMITTED(默认):解决 脏读，可以增删改查
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
 GO
 begin tran lockTest
 -- 锁定ID=50这一行
  --select *  from  [WMS].[dbo].[Product] where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go




use WMS
GO
--REPEATABLE READ:解决 脏读,可重复读取，不能update、delete,可以select、insert
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
 GO
 begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --锁定整个表
 -- select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go


use WMS
GO
--SERIALIZABLE（相当于holdlock）:解决 脏读,可重复读取、幻读，不能update、delete、insert,可以select
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
 GO
 begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go


use WMS
GO
 --需将 READ_COMMITTED_SNAPSHOT 设置为 ON，其默认为OFF
--SNAPSHOT（相当于holdlock）:解决 脏读,可重复读取、幻读，不能update、delete、insert,可以select
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
 GO
 begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go