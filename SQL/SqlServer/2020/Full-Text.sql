-- -- 在线文档 https://docs.microsoft.com/zh-cn/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15

 -- 谓词，通常来说是函数的一种，是需要满足特定条件的函数。该条件就是“返回值是真值”，即返回的值必须为TRUE/FALSE/UNKNOWN。

 -- 取值为 TRUE、FALSE 或 UNKNOWN 的表达式。 
 -- 谓词用于 WHERE 子句和 HAVING 子句的搜索条件中，还用于 FROM子句的联接条件以及需要布尔值的其他构造(函数)中。


 -- 布尔运算符（AND、OR 和 NOT）。

 -- 显示估计的执行计划(P) 快捷键:Ctrl + L


 --查询何时使用索引、使用哪些索引，是由数据库管理系统根据当前的数据分布情况以及后台算法决定的，用户决定不了
 --默认非集群索引 Create a nonclustered


USE WMSData;
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'ProductIndex_ProductName_ModifyTime')
    DROP INDEX ProductIndex_ProductName_ModifyTime ON   WMSData.[dbo].[Product];
GO
CREATE INDEX ProductIndex_ProductName_ModifyTime ON  WMSData.[dbo].[Product]
(
  [ProductName],
  [ModifyTime] desc
 )
 GO

 USE WMSData;
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'ProductIndex_ProductName_Count_ModifyTime')
    DROP INDEX ProductIndex_ProductName_Count_ModifyTime ON   WMSData.[dbo].[Product];
GO
CREATE INDEX ProductIndex_ProductName_Count_ModifyTime ON  WMSData.[dbo].[Product]
(
  [ProductName],
  [Count] asc,
  [ModifyTime] desc
 )
 GO


USE WMSData;
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'ProductIndex_Count')
    DROP INDEX ProductIndex_Count ON   WMSData.[dbo].[Product];
GO
CREATE INDEX ProductIndex_Count ON  WMSData.[dbo].[Product]
(
  [Count] asc
 )
 GO


USE WMSData;
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'ProductIndex_ProductName')
    DROP INDEX ProductIndex_ProductName ON   WMSData.[dbo].[Product];
GO
CREATE INDEX ProductIndex_ProductName ON  WMSData.[dbo].[Product]
(
  [ProductName]
 )
 GO


 USE WMSData;
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'ProductIndex_ModifyTime')
    DROP INDEX ProductIndex_ModifyTime ON   WMSData.[dbo].[Product];
GO
CREATE INDEX ProductIndex_ModifyTime ON  WMSData.[dbo].[Product]
(
   [ModifyTime] desc
 )
 GO
--  CREATE [ UNIQUE ] [ CLUSTERED | NONCLUSTERED ] INDEX index_name
--    ON <object> ( column [ ASC | DESC ] [ ,...n ] )
--    [ INCLUDE ( column_name [ ,...n ] ) ]
--    [ WHERE <filter_predicate> ]
--    [ WITH ( <relational_index_option> [ ,...n ] ) ]
--    [ ON { partition_scheme_name ( column_name )
--         | filegroup_name
--         | default
--         }
--    ]
--    [ FILESTREAM_ON { filestream_filegroup_name | partition_scheme_name | "NULL" } ]
  
--[ ; ]




 -- like 命中索引 ProductIndex_ProductName
 select  *  from WMSData.dbo.Product where [ProductName] like '%ddd%';

  -- like 命中索引 ProductIndex_ProductName_ModifyTime
 select  *  from WMSData.dbo.Product where [ProductName] like 'ddd%';

   -- like 命中索引
  select  *  from WMSData.dbo.Product where [ProductName] = 'ddd';

  -- 未命中索引
  select  *  from WMSData.dbo.Product where ModifyTime > '2018-12-03 01:26:31.707';

  -- 命中索引
  select  *  from WMSData.dbo.Product where ModifyTime between  '2018-12-03 01:26:31.707' and  '2018-12-03 01:26:31.707';


  select  *  from WMSData.dbo.Product where [ProductName] like 'uplockTest%' and ModifyTime between  '2018-12-03 01:26:31.707' and  '2018-12-03 01:26:31.707';

  -- 只命中索引
  select  *  from WMSData.dbo.Product where   ModifyTime between  '1970-12-03 01:26:31.707' and  '2018-12-03 01:26:31.707' and [ProductName] like 'pppv%';

  select  *  from WMSData.dbo.Product where [ProductName] like 'vnn%' and  ModifyTime between  '1970-12-03 01:26:31.707' and  '2018-12-03 01:26:31.707' ;

  select  *  from WMSData.dbo.Product where [ProductName] like '%vnn%'  and [Count]>10


  select  *  from WMSData.dbo.Product where  [Count]>10

    select  *  from WMSData.dbo.Product where  [Count]>=10

  select  *  from WMSData.dbo.Product where  [Count]=10
	    
  select  distinct([COUNT]) from  WMSData.dbo.Product order by [COUNT]

  --数字列没有命中索引
  select  *  from WMSData.dbo.Product where [Count] between 10 and 99999999999

  --LIKE内容含有通配符
 SELECT * FROM WMS.dbo.Product WHERE  [ProductName]  LIKE '%\_%'ESCAPE '\';


 select  *  from WMSData.dbo.Product Where ID=-1;

 select  *  from WMSData.dbo.Sku



  



  select  CreateTime, Count(CreateTime)  from WMSData.dbo.Product group by CreateTime

  select  CreateTime  from WMSData.dbo.Product group by CreateTime

  --无法截断表 'WMSData.dbo.Product'，因为该表正由 FOREIGN KEY 约束引用。
select fk.name,fk.object_id,OBJECT_NAME(fk.parent_object_id) as referenceTableName
from sys.foreign_keys as fk
join sys.objects as o on fk.referenced_object_id=o.object_id
where o.name='Product'
go

ALTER TABLE 	WMSData.[dbo].InOutStock NOCHECK CONSTRAINT FK_InOutStock_Product
ALTER TABLE 	WMSData.[dbo].OrderDetail NOCHECK CONSTRAINT FK_OrderDetail_Product
ALTER TABLE 	WMSData.[dbo].[Check] NOCHECK CONSTRAINT [FK_Check_Product]

ALTER TABLE 	WMSData.[dbo].InOutStock CHECK CONSTRAINT FK_InOutStock_Product
ALTER TABLE 	WMSData.[dbo].OrderDetail CHECK CONSTRAINT FK_OrderDetail_Product
ALTER TABLE 	WMSData.[dbo].[Check] CHECK CONSTRAINT [FK_Check_Product]

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

 select  *  from WMSData.dbo.Product

 -- 右击表--全文索引--属性 查看全文索引的详细信息

 select * from sys.fulltext_indexes
 --

drop fulltext index on WMSData.dbo.Product;

-- 全文检索不好用，查不全数据
-- 全文检索查找的结果没有 like 模糊匹配查出来的多
-- 查找的
 select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '中国');
  select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '中国*');
 select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '国');
 select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '中');
  select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '国中');

 select  *  from WMSData.dbo.Product where FREETEXT([ProductName], '中国');
 select  *  from WMSData.dbo.Product where FREETEXT([ProductName], '中');
  select  *  from WMSData.dbo.Product where FREETEXT([ProductName], '国');
 