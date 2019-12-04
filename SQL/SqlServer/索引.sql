 -- �����ĵ� https://docs.microsoft.com/zh-cn/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15
 

 -- ������������Ӱ����롢�޸ġ�ɾ�������ܡ���ΪҪά���������Ѵ���ʱ��

 -- ���ں�С�ں� �޷���������,���ںſ���.������BETWEEN AND ���� >  <


  --��ѯ��ʱʹ��������ʹ����Щ�������������ݿ����ϵͳ���ݵ�ǰ�����ݷֲ�����Լ���̨�㷨�����ģ��û���������
 --Ĭ�ϷǼ�Ⱥ���� Create a nonclustered
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