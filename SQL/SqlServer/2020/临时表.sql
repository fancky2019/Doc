select  * into #Record from (
select sdg.GroupName,sd.DeptName, su.AdminUserName ,ui.StudentId ,ui.Grade 
       from NewClassesAdmin.dbo.UserInfo ui 
       join NewClassesAdmin.dbo.UserInfoAssign uia on ui.StudentId=uia.StudentId
	   join NewClassesAdmin.dbo.SysUser su on uia.ddlAdmin=su.SysUserGuid
	   join NewClassesAdmin.[dbo].[SysUserRoleRelationship] srr on  srr.AdminUserId=su.AdminUserId
	   join NewClassesAdmin.dbo.SysDept sd on sd.DeptID=srr.DeptID
	   join NewClassesAdmin.dbo.SysDeptGroup sdg on sdg.GroupID=srr.GroupID
where ui.IsDelete=0
) t

select  *  from #Record
drop table #Record;

