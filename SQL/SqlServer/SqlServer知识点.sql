 -- 在线文档 https://docs.microsoft.com/zh-cn/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15



--  waitfor time '11:12:12'


SELECT *  FROM  wms.dbo.product;
waitfor  delay '00:00:10' --类似Thread.Sleep
SELECT  COUNT(id)[Count] FROM wms.dbo.product;


SELECT *  FROM  wms.dbo.product;
 waitfor time '22:20' --在22:20执行
SELECT  COUNT(id)[Count] FROM wms.dbo.product;

--变量声明,赋值
declare @count int;
-- select @count=COUNT(ID) from WMS.dbo.Product;
set @count=30;
select @count 'Count';

 select concat('asss','ddd');

 select  'asss'+'ddd';

 -- 谓词，通常来说是函数的一种，是需要满足特定条件的函数。该条件就是“返回值是真值”，即返回的值必须为TRUE/FALSE/UNKNOWN。

 -- 取值为 TRUE、FALSE 或 UNKNOWN 的表达式。 
 --谓词用于 WHERE 子句和 HAVING 子句的搜索条件中，还用于 FROM子句的联接条件以及需要布尔值的其他构造(函数)中。

 --使用布尔运算符（AND、OR 和 NOT）。

 -- 显示估计的执行计划(P) 快捷键:Ctrl + L


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



  --LIKE内容含有通配符
 SELECT *
  FROM WMS.dbo.Product
  WHERE  [ProductName]  LIKE '%\_%'ESCAPE '\';