use NewClassesAdmin
go
select Active.ActiveTheme ��������,ACTIVE.StartTime ������ʼʱ��, ui1.StudentId  ѧ��ID,
ui1.UserId �û�ID,ui1.UserName ѧ������, ui1.Tel ��ϵ��ʽ1,
ui1.MobilePhone ��ϵ��ʽ2,ui1.Grade �߿����,UserAppointment.AppointmentNo ԤԼ��,
UserAppointment.Flag �Ƿ񵽳�,UserAppointment.FlagType ��������,
sysuser1.AdminUserName ��Լ��, sysuser2.AdminUserName ����CC, 
UserAppointment.AddedTime ��Լʱ�� ,ISNULL(tt.ParticipateCount,0) �μ����н������� 
from UserAppointment
left join Active on UserAppointment.ActiveId = Active.ActiveId 
left join SysUser as sysuser1 on UserAppointment.AddBy = sysuser1.AdminUserId
left join userinfoassign on UserAppointment.StudentId = userinfoassign.StudentId 
left join NewClassesAdmin.dbo.UserInfo ui1 on ui1.StudentId=UserAppointment.StudentId
left join (
		   select ui.StudentId ,t.ParticipateCount from NewClassesAdmin.dbo.UserInfo ui 
		             join (
					      -- �μ�ָ���γ̵�ѧ�������л��ϯ����
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
 and  Active.ActiveTheme in ('����һģ������ʦ������','�߿�200�쵹��ʱ ��ʦ��ѧ����' )  
 --and Active.StartTime >= '2020-12-5' 
 --and active.starttime < '2020-12-30'
 and active.IsDelete = 0
 and userinfoassign.ddlAdmin = sysuser2.sysuserguid
--and tt.ParticipateCount>1
-- and ui1.UserName ='���'
 and UserAppointment.StudentId='52F572A4-2367-4257-A2AF-04301199FD5E'
 order by ActiveTheme 





