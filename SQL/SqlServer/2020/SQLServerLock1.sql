--        脏读：事务1读取事务2修改的数据后，事务2回滚。
--不可重复读取：事务1两次读取的数据不一样，两次读取中间被事务2修改了。
--        幻读：事务1两次查询的条数不一样，被事务2增加删除了。


--      脏读：A事务读取B事务未提交的更改，结果B回滚。
--非重复读取：A事务两次读取的数据不一样，两次读取期间被事务B改了。
--      幻读：两次执行的查询结果不一样，期间事务B插入或删除数据了。
--  丢失更新：A事务更新的数据被B事务的更新给冲掉了。




-- 如果能精确到行就锁行，否则锁整个表






--UPDLOCK来读取记录时可以对取到的记录加上更新锁，从而加上锁的记录在其它的线程中是不能更改的只能等本线程的事务结束后才能更改.
--更新锁
--updlock锁在事务运行期间,其他事务不能update、delete,但是可以插入,产生幻读。其他事务可以读取
  go
  begin tran lockTest
 -- 锁定ID=50这一行
  select *  from  [WMS].[dbo].[Product] with(updlock) where ID=50
 --锁定整个表
  --select *  from  [WMS].[dbo].[Product] with(updlock)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(updlock)
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go

  --holdlock 表锁 共享锁
  --holdlock锁在事务运行期间,其他事务不能insert、update、delete。其他事务可以读取
    begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] with(holdlock) where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product] with(holdlock)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(holdlock)
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go



--TABLOCKX 表锁 排它锁
--TABLOCKX :锁在事务运行期间,其他事务不能select、insert、update、delete。
    begin tran lockTest
 -- 锁定ID=50这一行
  select *  from  [WMS].[dbo].[Product] with(TABLOCKX) where ID=50
 --锁定整个表
  --select *  from  [WMS].[dbo].[Product] with(TABLOCKX)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(TABLOCKX)
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go

 -- XLOCK 指定采用排他锁并保持到事务完成。
--XLOCK :锁在事务运行期间,其他事务不能update、删除。可以select、insert
    begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] with(XLOCK) where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product] with(tablock,XLOCK)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(XLOCK)
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go




 --tablock 表锁 共享锁
 --tablock:SQL Server 将在整个表上置共享锁直至该"命令结束"。 这个选项保证其他进程只能读取而不能修改数据。
    begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] with(tablock) where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product] with(tablock,XLOCK)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(tablock)
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go

 -- NOLOCK :不加锁,其他事务增删改查
begin tran lockTest
 -- 锁定ID=50这一行
  select *  from  [WMS].[dbo].[Product] with(NOLOCK) where ID=50
 --锁定整个表
  --select *  from  [WMS].[dbo].[Product] with(NOLOCK)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(NOLOCK)
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go



  --PAGLOCK :SQLServer 默认锁
 begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] with(PAGLOCK) where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product] with(PAGLOCK,holdlock)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(PAGLOCK)
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go



 --ROWLOCK  
 begin tran lockTest
 -- 锁定ID=50这一行
 -- select *  from  [WMS].[dbo].[Product] with(ROWLOCK ) where ID=50
 --锁定整个表
  select *  from  [WMS].[dbo].[Product] with(ROWLOCK,holdlock )
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(ROWLOCK )
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go






 --丢失更新:一个事务覆盖另一个事务个更新,解决:版本号(version字段、timestamp)
 --更新加锁
 begin tran lockTest
 --锁定整个表
  update [WMS].[dbo].[Product] with(updlock) set ProductName='updlock1' where ID=50
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go


  --删除加锁
  begin tran lockTest
 --锁定整个表
  delete  from [WMS].[dbo].[Product]  with(updlock)  where ID=2118
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran lockTest
  go


use wms
go
begin tran tranTest
--执行成功
INSERT INTO [dbo].[Product] ([GUID] ,[StockID]  ,[BarCodeID]
           ,[SkuID]  ,[ProductName] ,[ProductStyle],[Price] ,[CreateTime]
           ,[Status] ,[Count] ,[ModifyTime])
     VALUES
           (NEWID() ,1 ,null ,1   ,'ProductNameSuccess' ,null ,11  ,GETDATE() ,1 ,1 ,GETDATE())
--执行失败,整个事务失败,自动回滚
--执行成功,事务提交
INSERT INTO [dbo].[Product] ([GUID] ,[StockID]  ,[BarCodeID]
           ,[SkuID]  ,[ProductName] ,[ProductStyle],[Price] ,[CreateTime]
           ,[Status] ,[Count] ,[ModifyTime])
     VALUES
           (NEWID() ,1 ,null ,1   ,'ProductNameFail' ,null ,11  ,GETDATE() ,1 )
commit tran tranTest
go


  select *  from  [WMS].[dbo].[Product] 



use Test
go
begin try
    begin  tran Process11
		update [dbo].[Person] set name='李四' where id=2;
		 waitfor delay '00:00:20';
   commit tran Process11
end try
begin catch
 ROLLBACK TRAN Process11
end catch



-- 
select request_session_id spid,OBJECT_NAME(resource_associated_entity_id) tableName
from sys.dm_tran_locks where resource_type='OBJECT'


-- 查看锁的类型信息  
-- request_mode 字段 IX锁
-- request_type 字段 LOCK
select *  from sys.dm_tran_locks where resource_type='OBJECT'



  DBCC TRACEON(1222,-1) ;
  DBCC TRACESTATUS (1222, -1) ;
  DBCC TRACEOFF (1222,-1) ;





  -- SET LOCK_TIMEOUT timeout_period(单位为毫秒)来设定锁请求超时。默认情况下，数据库没有超时期限(timeout_period值为-1，可以用SELECT @@LOCK_TIMEOUT来查看该值，即无限期等待)。

  SELECT @@LOCK_TIMEOUT;


use Test
go
update [dbo].[Job] set name='Process2' where id=2;

