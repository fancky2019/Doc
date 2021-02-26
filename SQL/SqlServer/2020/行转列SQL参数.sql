  

  select  * into #RecordStatistics from (
	select DeptName,GroupName, AdminUserName ,Grade ,COUNT(*)[Count]
		  from (
					select sd.DeptName,sdg.GroupName, su.AdminUserName ,ui.Grade 
						   from NewClassesAdmin.dbo.UserInfo ui 
						   join NewClassesAdmin.dbo.UserInfoAssign uia on ui.StudentId=uia.StudentId
						   join NewClassesAdmin.dbo.SysUser su on uia.ddlAdmin=su.SysUserGuid
						   join NewClassesAdmin.[dbo].[SysUserRoleRelationship] srr on  srr.AdminUserId=su.AdminUserId
						   join NewClassesAdmin.dbo.SysDept sd on sd.DeptID=srr.DeptID
						   join NewClassesAdmin.dbo.SysDeptGroup sdg on sdg.GroupID=srr.GroupID
					where ui.IsDelete=0
			   )t1
	group by DeptName,GroupName, AdminUserName ,Grade 
	) t2

  select  * into #RecordStatisticsGrade from   (  
   select DeptName,GroupName,AdminUserName,        
   ISNULL([2021],0)Col2021,    
   ISNULL([2022],0)Col2022,     
   ISNULL([2023],0)Col2023,  
   ISNULL([2024],0)Col2024, 
   ISNULL([2025],0)Col2025, 
   ISNULL([2026],0)Col2026,  
   ISNULL([2027],0)Col2027, 
   ISNULL([2028],0)Col2028 
   from (  
		   select * from #RecordStatistics             
					pivot    
					(
		    			max([Count]) for Grade in ([2021],[2022],[2023],[2024],[2025],[2026],[2027],[2028]) 
					)t                       
			
		) tt 
)ttt  

select  t1.*,t2.TotalCount from #RecordStatisticsGrade t1
          join 
		  (
			  select  DeptName,GroupName, AdminUserName ,
			  sum(Col2021)+sum(Col2022)+sum(Col2023)+sum(Col2024)+sum(Col2025)+sum(Col2026)+sum(Col2027)+sum(Col2028) TotalCount
			  from #RecordStatisticsGrade 
			  group by DeptName,GroupName, AdminUserName
		  )t2 on t1.DeptName=t2.DeptName and t1.GroupName=t2.GroupName and t1.AdminUserName=t2.AdminUserName

drop table #RecordStatisticsGrade;

drop table #RecordStatistics;
