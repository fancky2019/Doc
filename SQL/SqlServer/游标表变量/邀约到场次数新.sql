use NewClassesAdmin
go
select Active.ActiveTheme 讲座名称,ACTIVE.StartTime 讲座开始时间, ui1.StudentId  学生ID,
ui1.UserId 用户ID,ui1.UserName 学生姓名, ui1.Tel 联系方式1,
ui1.MobilePhone 联系方式2,ui1.Grade 高考年份,UserAppointment.AppointmentNo 预约号,
UserAppointment.Flag 是否到场,UserAppointment.FlagType 到场类型,
sysuser1.AdminUserName 邀约人, sysuser2.AdminUserName 所属CC, 
UserAppointment.AddedTime 邀约时间 ,ISNULL(tt.ParticipateCount,0) 参加所有讲座次数 
from UserAppointment
left join Active on UserAppointment.ActiveId = Active.ActiveId 
left join SysUser as sysuser1 on UserAppointment.AddBy = sysuser1.AdminUserId
left join userinfoassign on UserAppointment.StudentId = userinfoassign.StudentId 
left join NewClassesAdmin.dbo.UserInfo ui1 on ui1.StudentId=UserAppointment.StudentId
left join (
		   select ui.StudentId ,t.ParticipateCount from NewClassesAdmin.dbo.UserInfo ui 
		             join (
					      -- 参加指定课程的学生的所有活动出席次数
						    select  StudentId, COUNT(StudentId)[ParticipateCount]  
						        from NewClassesAdmin.dbo.UserAppointment ua 
						        join NewClassesAdmin.dbo.Active a on ua.ActiveId=a.ActiveId
								where 1=1 
									  and isnull(ua.flag,0) =1
									  and ua.IsDelete=0
									  and a.IsDelete=0
									 -- and ua.StudentId='152D3497-2395-485E-99F3-83AEE81D0585'
									 group by  ua.StudentId
				         ) t on t.StudentId=ui.StudentId
			) tt on UserAppointment.StudentId=tt.StudentId
,SysUser as sysuser2
where  1=1
 and UserAppointment.IsDelete = 0  
 and  Active.ActiveTheme in ('生物一模备考名师公开课','高考200天倒计时 名师升学讲座' )  
 --and Active.StartTime >= '2020-12-5' 
 --and active.starttime < '2020-12-30'
 and active.IsDelete = 0
 and userinfoassign.ddlAdmin = sysuser2.sysuserguid
--and tt.ParticipateCount>1
-- and ui1.UserName ='王琛'
 and UserAppointment.StudentId='52F572A4-2367-4257-A2AF-04301199FD5E'
 order by ActiveTheme 





