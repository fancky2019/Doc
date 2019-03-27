select *  from  [WMS].[dbo].[Product]  where ID=50
go

update [WMS].[dbo].[Product] set ProductName='uplockTest' where ID=50
go
update [WMS].[dbo].[Product] set ProductName='uplockTest' where ID=59
go
delete  from [WMS].[dbo].[Product]  where ID=2104
go


INSERT INTO [dbo].[Product] ([GUID] ,[StockID]  ,[BarCodeID]
           ,[SkuID]  ,[ProductName] ,[ProductStyle],[Price] ,[CreateTime]
           ,[Status] ,[Count] ,[ModifyTime])
     VALUES
           (NEWID() ,1 ,null ,1   ,'ProductName' ,null ,11  ,GETDATE() ,1 ,1 ,GETDATE())
GO
