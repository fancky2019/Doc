USE [WMSData]
GO
-- 创建外键约束
ALTER TABLE [dbo].[Check]  WITH NOCHECK ADD  CONSTRAINT [FK_Check_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO

-- 删除外键约束
ALTER TABLE [dbo].[Check]   DROP CONSTRAINT  [FK_Check_Product]  

-- 禁用外键约束
ALTER TABLE [dbo].[Check] NOCHECK CONSTRAINT [FK_Check_Product]
-- 启用外键约束
ALTER TABLE [dbo].[Check] CHECK CONSTRAINT [FK_Check_Product]

GO


-- 有外键引用的表不能TRUNCATR,只能DELETE, 除非删除外键约束.


--无法截断表 'WMSData.dbo.Product'，因为该表正由 FOREIGN KEY 约束引用。
select fk.name,fk.object_id,OBJECT_NAME(fk.parent_object_id) as referenceTableName
from sys.foreign_keys as fk
join sys.objects as o on fk.referenced_object_id=o.object_id
where o.name='Product'
go

USE [WMSData]
GO
-- 创建外键约束
ALTER TABLE [dbo].InOutStock  WITH NOCHECK ADD  CONSTRAINT FK_InOutStock_Product FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ALTER TABLE [dbo].OrderDetail  WITH NOCHECK ADD  CONSTRAINT FK_OrderDetail_Product FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ALTER TABLE [dbo].[Check]  WITH NOCHECK ADD  CONSTRAINT [FK_Check_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO

-- 删除外键约束
ALTER TABLE [dbo].[Check]   DROP CONSTRAINT  [FK_Check_Product]  
ALTER TABLE [dbo].InOutStock   DROP CONSTRAINT  FK_InOutStock_Product  
ALTER TABLE [dbo].OrderDetail   DROP CONSTRAINT  FK_OrderDetail_Product  

-- TRUNCATE 前先删除所有的外键约束
TRUNCATE TABLE  WMSData.dbo.Product