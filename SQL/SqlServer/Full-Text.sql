-- -- �����ĵ� https://docs.microsoft.com/zh-cn/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15

 -- ν�ʣ�ͨ����˵�Ǻ�����һ�֣�����Ҫ�����ض������ĺ��������������ǡ�����ֵ����ֵ���������ص�ֵ����ΪTRUE/FALSE/UNKNOWN��

 -- ȡֵΪ TRUE��FALSE �� UNKNOWN �ı��ʽ�� 
 -- ν������ WHERE �Ӿ�� HAVING �Ӿ�����������У������� FROM�Ӿ�����������Լ���Ҫ����ֵ����������(����)�С�


 -- �����������AND��OR �� NOT����

 -- ��ʾ���Ƶ�ִ�мƻ�(P) ��ݼ�:Ctrl + L


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




 -- like �������� ProductIndex_ProductName
 select  *  from WMSData.dbo.Product where [ProductName] like '%ddd%';

  -- like �������� ProductIndex_ProductName_ModifyTime
 select  *  from WMSData.dbo.Product where [ProductName] like 'ddd%';

   -- like ��������
  select  *  from WMSData.dbo.Product where [ProductName] = 'ddd';

  -- δ��������
  select  *  from WMSData.dbo.Product where ModifyTime > '2018-12-03 01:26:31.707';

  -- ��������
  select  *  from WMSData.dbo.Product where ModifyTime between  '2018-12-03 01:26:31.707' and  '2018-12-03 01:26:31.707';


  select  *  from WMSData.dbo.Product where [ProductName] like 'uplockTest%' and ModifyTime between  '2018-12-03 01:26:31.707' and  '2018-12-03 01:26:31.707';

  -- ֻ��������
  select  *  from WMSData.dbo.Product where   ModifyTime between  '1970-12-03 01:26:31.707' and  '2018-12-03 01:26:31.707' and [ProductName] like 'pppv%';

  select  *  from WMSData.dbo.Product where [ProductName] like 'vnn%' and  ModifyTime between  '1970-12-03 01:26:31.707' and  '2018-12-03 01:26:31.707' ;

  select  *  from WMSData.dbo.Product where [ProductName] like '%vnn%'  and [Count]>10


  select  *  from WMSData.dbo.Product where  [Count]>10

    select  *  from WMSData.dbo.Product where  [Count]>=10

  select  *  from WMSData.dbo.Product where  [Count]=10
	    
  select  distinct([COUNT]) from  WMSData.dbo.Product order by [COUNT]

  --������û����������
  select  *  from WMSData.dbo.Product where [Count] between 10 and 99999999999

  --LIKE���ݺ���ͨ���
 SELECT * FROM WMS.dbo.Product WHERE  [ProductName]  LIKE '%\_%'ESCAPE '\';


 select  *  from WMSData.dbo.Product Where ID=-1;

 select  *  from WMSData.dbo.Sku



  



  select  CreateTime, Count(CreateTime)  from WMSData.dbo.Product group by CreateTime

  select  CreateTime  from WMSData.dbo.Product group by CreateTime

  --�޷��ضϱ� 'WMSData.dbo.Product'����Ϊ�ñ����� FOREIGN KEY Լ�����á�
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
-- �������Լ��
ALTER TABLE [dbo].InOutStock  WITH NOCHECK ADD  CONSTRAINT FK_InOutStock_Product FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ALTER TABLE [dbo].OrderDetail  WITH NOCHECK ADD  CONSTRAINT FK_OrderDetail_Product FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ALTER TABLE [dbo].[Check]  WITH NOCHECK ADD  CONSTRAINT [FK_Check_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO

-- ɾ�����Լ��
ALTER TABLE [dbo].[Check]   DROP CONSTRAINT  [FK_Check_Product]  
ALTER TABLE [dbo].InOutStock   DROP CONSTRAINT  FK_InOutStock_Product  
ALTER TABLE [dbo].OrderDetail   DROP CONSTRAINT  FK_OrderDetail_Product  

-- TRUNCATE ǰ��ɾ�����е����Լ��
TRUNCATE TABLE  WMSData.dbo.Product

 select  *  from WMSData.dbo.Product

 -- �һ���--ȫ������--���� �鿴ȫ����������ϸ��Ϣ

 select * from sys.fulltext_indexes
 --

drop fulltext index on WMSData.dbo.Product;

-- ȫ�ļ��������ã��鲻ȫ����
-- ȫ�ļ������ҵĽ��û�� like ģ��ƥ�������Ķ�
-- ���ҵ�
 select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '�й�');
  select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '�й�*');
 select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '��');
 select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '��');
  select  *  from WMSData.dbo.Product where CONTAINS([ProductName], '����');

 select  *  from WMSData.dbo.Product where FREETEXT([ProductName], '�й�');
 select  *  from WMSData.dbo.Product where FREETEXT([ProductName], '��');
  select  *  from WMSData.dbo.Product where FREETEXT([ProductName], '��');
 