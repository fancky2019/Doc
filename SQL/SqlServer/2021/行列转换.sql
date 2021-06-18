
--select year(getdate()),month(getdate()),day(getdate())
--��ȡ�꣺select datepart(yy,getdate()) as year

--��ȡ�£�select datepart(mm,getdate()) as month

--��ȡ�գ�select datepart(dd,getdate()) as day

--��ȡ���ȣ�select datepart(quarter,getdate())


--����ת��һ
USE [Evaluations]
GO
SELECT SellerId, SellerName, TradingCenterId, TradingCenterName, --avg(FD_00_003) AS 'FD_00_003', avg(FD_00_004) AS 'FD_00_004', avg(FD_00_005) AS 'FD_00_005'
MAX(case FactorCode when 'SD_01_004'  then SampleValue end ) as 'SD_01_004',
MAX(case FactorCode when 'SD_01_010'  then SampleValue end ) as 'SD_01_010'
FROM [SPowerSellers].[dbo].[SellerRatingValues]
WHERE SellerName='�㶫��������Դ�������޹�˾' 
GROUP BY SellerId, SellerName, TradingCenterId, TradingCenterName


select  AddBy,AdminUserName,
MAX(case [Month] when '1'  then RemarkCount else 0 end ) as '1', 
MAX(case [Month] when '2'  then RemarkCount else 0 end ) as '2', 
MAX(case [Month] when '3'  then RemarkCount else 0 end ) as '3', 
MAX(case [Month] when '4'  then RemarkCount else 0 end ) as '4', 
MAX(case [Month] when '5'  then RemarkCount else 0 end ) as '5', 
MAX(case [Month] when '6'  then RemarkCount else 0 end ) as '6', 
MAX(case [Month] when '7'  then RemarkCount else 0 end ) as '7', 
MAX(case [Month] when '8'  then RemarkCount else 0 end ) as '8', 
MAX(case [Month] when '9'  then RemarkCount else 0 end ) as '9', 
MAX(case [Month] when '10'  then RemarkCount else 0 end ) as '10', 
MAX(case [Month] when '11'  then RemarkCount else 0 end ) as '11', 
MAX(case [Month] when '12'  then RemarkCount else 0 end ) as '12'
from (
select  AddBy,AdminUserName, [Year],[Month],COUNT(Id) RemarkCount  from (
				select ur.id,ur.AddBy,su.AdminUserName, YEAR( ur.AddedTime ) [Year],MONTH( ur.AddedTime )[Month] 
				from  NewClassesAdmin.dbo.UserRemarks  ur
				join  NewClassesAdmin.dbo.SysUser su on ur.AddBy = su.AdminUserId
				where 1=1
						and ur.IsDelete=0
						and su.IsDelete=0
		        ) t
where t.[Year]=2021
group by AddBy,AdminUserName, [Year],[Month]
) t1
where 1=1
      and AdminUserName='������-2����'
GROUP BY AddBy,AdminUserName














--����ת����  ���ô˷���
select  *
from (
select  AddBy,AdminUserName,[Year],[Month],COUNT(Id) RemarkCount  from (
				select ur.id,ur.AddBy,su.AdminUserName, YEAR( ur.AddedTime ) [Year],MONTH( ur.AddedTime )[Month] 
				from  NewClassesAdmin.dbo.UserRemarks  ur
				join  NewClassesAdmin.dbo.SysUser su on ur.AddBy = su.AdminUserId
				where 1=1
						and ur.IsDelete=0
						and su.IsDelete=0
		        ) t
-- ����д�ڴ˴������ֻ������ת��
where 1=1
      AND t.[Year]=2021
      AND AdminUserName='������-2����'
group by AddBy,AdminUserName, [Year],[Month]
) t1
pivot(
		 avg(RemarkCount) for [Month] 
		-- ע��������  �������ֵ����[]
		in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
     )as NewRemarkCount















select  AddBy,AdminUserName,[Year],
		ISNULL([1],0)[1],
		ISNULL([2],0)[2],
		ISNULL([3],0)[3],
		ISNULL([4],0)[4],
		ISNULL([5],0)[5],
		ISNULL([6],0)[6],
		ISNULL([7],0)[7],
		ISNULL([8],0)[8],
		ISNULL([9],0)[9],
		ISNULL([10],0)[10],
		ISNULL([11],0)[11],
		ISNULL([12],0)[12]
from (
select  AddBy,AdminUserName,[Year],[Month],COUNT(Id) RemarkCount  from (
				select ur.id,ur.AddBy,su.AdminUserName, YEAR( ur.AddedTime ) [Year],MONTH( ur.AddedTime )[Month] 
				from  NewClassesAdmin.dbo.UserRemarks  ur
				join  NewClassesAdmin.dbo.SysUser su on ur.AddBy = su.AdminUserId
				where 1=1
						and ur.IsDelete=0
						and su.IsDelete=0
		        ) t
-- ����д�ڴ˴������ֻ������ת��
where  1=1
      -- AND t.[Year]=2021
       AND AdminUserName='������-2����'
group by AddBy,AdminUserName, [Year],[Month]
) t1
pivot(
		avg(RemarkCount) for [Month] 
		-- ע��������  �������ֵ����[]
		in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
     )as NewRemarkCount
ORDER BY  [Year]


























