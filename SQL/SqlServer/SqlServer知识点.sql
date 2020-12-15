 -- �����ĵ� https://docs.microsoft.com/zh-cn/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15

 -- DML��data manipulation language���� SELECT��UPDATE��INSERT��DELETE
-- DDL��data definition language���� CREATE��ALTER��DROP�ȣ�DDL��Ҫ�����ڶ����ı��TABLE���Ľṹ
-- DCL��Data Control Language����  ���û�������ݿ��û����ɫȨ�޵���䣬������grant,deny,revoke�ȣ����

-- varchar(n)�����У�n���8000�����洢Ӣ�ģ���ռһ���ֽڣ��洢���֣���ռ�����ֽڡ�
-- nvarchar(n)�����У�n���4000�����۴洢Ӣ�Ļ��Ǻ��֣���ռ�������ֽڡ�

--  waitfor time '11:12:12'
-- ʱ�����ָ��������ʱ��1970��01��01��00ʱ00��00��(����ʱ��1970��01��01��08ʱ00��00��)�������ڵ������� 
-- ��������
-- Decimal(n,m)��ʾ��ֵ�й���nλ������������n-mλ��С��mλ
-- NUMERIC��DECIMALû������
-- float ��double ���ڲ��ܾ�ȷ��ʾ���ᶪʧ����decimal

-- DateTime�ֶ�����Ҫ�� GETDATE() ��DateTime2�ֶ�����Ҫ�� SYSDATETIME() ��
--datetime:��ȷ������ 2020-12-15 14:13:46.507 yyyy-MM-dd HH:mm:ss.fff 
select GETDATE();
-- datetime2:��ȷ��΢�� 2020-12-15 14:13:17.7543695  yyyy-MM-dd HH:mm:ss.fffffff ��7��f����ȷ��0.1΢��(��s)��
select SYSDATETIME();

--��ͨʱ��ת����ʱ���
SELECT DATEDIFF(S,'1970-01-01 00:00:00', GETDATE()) 
--ʱ���ת������ͨʱ��
SELECT DATEADD(S,1557493321,'1970-01-01 00:00:00')  
select GETDATE();

select CONVERT(varchar(10),GETDATE(),120);


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
 SELECT * FROM WMS.dbo.Product WHERE  [ProductName]  LIKE '%\_%'ESCAPE '\';

  -- ����ת��
  select convert(int,'1')+1;

  select cast(1 as varchar)+'12';

  -- ��ȡ����
   select   GetDate()

 select  DateName(YEAR,GETDATE())
 select  DateName(MONTH,GETDATE())
 SELECT year(GETDATE()), month(GETDATE()), day(GETDATE())


 select        count(case when YEAR(CreateDate)= YEAR(GETDATE()) and 
                               Month(CreateDate)= Month(GETDATE()) then CreateDate 
                         else null
                         end
                   ) MonthAddCustomerSum,
              count(case when  YEAR(CreateDate)= YEAR(GETDATE()) and 
                               Month(DATEADD(Month,3, CreateDate))>= Month(GETDATE()) then CreateDate 
                          else null
                          end
                   ) ThreeMonthCustomerSum,
              count(case when YEAR(CreateDate)= YEAR(GETDATE())  then CreateDate 
                         else null
                         end
                   ) YearAddCustomerSum
    from [CustomerRelationship_AH].[dbo].[SellerSubject]