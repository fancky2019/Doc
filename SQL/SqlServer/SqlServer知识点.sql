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