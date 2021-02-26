 -- 在线文档 https://docs.microsoft.com/zh-cn/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15
 

 -- 创建了索引将影响插入、修改、删除的性能。因为要维护索引花费大量时间

 -- 大于号小于号 无法命中索引,等于号可以.可以用BETWEEN AND 代替 >  <


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
IF EXISTS (SELECT name from sys.indexes WHERE name = N'ProductIndex_ProductName')
    DROP INDEX ProductIndex_ProductName ON   WMSData.[dbo].[Product];
GO
CREATE INDEX ProductIndex_ProductName ON  WMSData.[dbo].[Product]
(
  [ProductName]
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