


select *  from  [WMS].[dbo].[Product]  where ID=50
go

update [WMS].[dbo].[Product] set ProductName='uplockTest' where ID=50
go
update [WMS].[dbo].[Product] set ProductName='uplockTest' where ID=59
go



--事务回滚
use WMS
GO
 begin tran  tran1
  update [WMS].[dbo].[Product] set ProductName='up' where ID=50
  waitfor  delay '00:00:23' --类似Thread.Sleep
   rollback tran tran1

  go



 use WMS
GO
 begin tran  tran1
  update [WMS].[dbo].[Product] set ProductName='uplockTest11' where ID=2018
  waitfor  delay '00:00:10' --类似Thread.Sleep
  commit tran tran1

  go


  select *  from  [WMS].[dbo].[Product]  where ID=50



delete  from [WMS].[dbo].[Product]  where ID=2117
go



INSERT INTO [dbo].[Product] ([GUID] ,[StockID]  ,[BarCodeID]
           ,[SkuID]  ,[ProductName] ,[ProductStyle],[Price] ,[CreateTime]
           ,[Status] ,[Count] ,[ModifyTime])
     VALUES
           (NEWID() ,1 ,null ,1   ,'ProductName' ,null ,11  ,GETDATE() ,1 ,1 ,GETDATE())
GO

select max(id)  from  [WMS].[dbo].[Product] 
