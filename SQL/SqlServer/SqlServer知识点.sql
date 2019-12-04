 -- �����ĵ� https://docs.microsoft.com/zh-cn/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15



--  waitfor time '11:12:12'


SELECT *  FROM  wms.dbo.product;
waitfor  delay '00:00:10' --����Thread.Sleep
SELECT  COUNT(id)[Count] FROM wms.dbo.product;


SELECT *  FROM  wms.dbo.product;
 waitfor time '22:20' --��22:20ִ��
SELECT  COUNT(id)[Count] FROM wms.dbo.product;

--��������,��ֵ
declare @count int;
-- select @count=COUNT(ID) from WMS.dbo.Product;
set @count=30;
select @count 'Count';

 select concat('asss','ddd');

 select  'asss'+'ddd';

 -- ν�ʣ�ͨ����˵�Ǻ�����һ�֣�����Ҫ�����ض������ĺ��������������ǡ�����ֵ����ֵ���������ص�ֵ����ΪTRUE/FALSE/UNKNOWN��

 -- ȡֵΪ TRUE��FALSE �� UNKNOWN �ı��ʽ�� 
 --ν������ WHERE �Ӿ�� HAVING �Ӿ�����������У������� FROM�Ӿ�����������Լ���Ҫ����ֵ����������(����)�С�

 --ʹ�ò����������AND��OR �� NOT����

 -- ��ʾ���Ƶ�ִ�мƻ�(P) ��ݼ�:Ctrl + L


USE [WMSData]
GO
-- �������Լ��
ALTER TABLE [dbo].[Check]  WITH NOCHECK ADD  CONSTRAINT [FK_Check_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO

-- ɾ�����Լ��
ALTER TABLE [dbo].[Check]   DROP CONSTRAINT  [FK_Check_Product]  

-- �������Լ��
ALTER TABLE [dbo].[Check] NOCHECK CONSTRAINT [FK_Check_Product]
-- �������Լ��
ALTER TABLE [dbo].[Check] CHECK CONSTRAINT [FK_Check_Product]

GO


-- ��������õı���TRUNCATR,ֻ��DELETE, ����ɾ�����Լ��.


--�޷��ضϱ� 'WMSData.dbo.Product'����Ϊ�ñ����� FOREIGN KEY Լ�����á�
select fk.name,fk.object_id,OBJECT_NAME(fk.parent_object_id) as referenceTableName
from sys.foreign_keys as fk
join sys.objects as o on fk.referenced_object_id=o.object_id
where o.name='Product'
go



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



  --LIKE���ݺ���ͨ���
 SELECT *
  FROM WMS.dbo.Product
  WHERE  [ProductName]  LIKE '%\_%'ESCAPE '\';