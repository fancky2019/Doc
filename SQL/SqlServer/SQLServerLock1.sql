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
