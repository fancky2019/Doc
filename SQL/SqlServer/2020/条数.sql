/****** Script for SelectTopNRows command from SSMS  ******/
-- count(列) 不统计null行
-- 要查ID,在计算条数
SELECT count([ID]) FROM [WMSData].[dbo].[Product];

--  count( *)和 count(1)差不多
SELECT count( *) FROM [WMSData].[dbo].[Product];
  
SELECT count(1) FROM [WMSData].[dbo].[Product];

-- 和mysql 一样不能有左%，不然就不能走素银
select  *  from  [WMSData].[dbo].[Product] where ProductName like '%17%';

select  *  from  [WMSData].[dbo].[Product] where ProductName like '17%';

