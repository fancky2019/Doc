use NewClassesAdmin
go
--���������
declare @StudentParticipateCount table
(
StudentID uniqueidentifier ,
ParticipateCount int
);
--������
declare @ParticipateCount int;
declare @StudentID uniqueidentifier ;
--�����α�
declare StudentParticipateCount_cursor cursor
for select distinct StudentId from NewClassesAdmin.dbo.UserAppointment ua
                      join NewClassesAdmin.dbo.Active a on ua.ActiveId=a.ActiveId
            	         where 1=1 
							   and isnull(ua.flag,0) =1
							   and ua.IsDelete=0
							   and a.IsDelete=0
							  -- and a.ActiveTheme in ('����һģ������ʦ������','�߿�200�쵹��ʱ ��ʦ��ѧ����' )  
open StudentParticipateCount_cursor
--���α����ȶ�ȡ
 FETCH NEXT FROM StudentParticipateCount_cursor INTO @StudentID
  WHILE (@@FETCH_STATUS = 0)--�ж��Ƿ��ȡ��
  begin

 select @ParticipateCount= (  
                             select  sum(flag) flag  from (
						                                    select top 20 StudentId, CAST( isnull(flag,0) as smallint) flag 
									                          from NewClassesAdmin.dbo.UserAppointment ua
                                                              join NewClassesAdmin.dbo.Active a on ua.ActiveId=a.ActiveId
            													 where 1=1 
																	   and isnull(ua.flag,0) =1
																	   and ua.IsDelete=0
																	   and a.IsDelete=0
																	   and StudentId= @StudentID
						                                   ) t
						    );
 insert into @StudentParticipateCount values (@StudentID,@ParticipateCount)
     FETCH NEXT FROM StudentParticipateCount_cursor INTO @StudentID
  end

-- select *  from @StudentParticipateCount  where StudentID='8C899406-88C8-4FEB-A0E9-7AA8EFA58D18'

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
left join @StudentParticipateCount  tt on UserAppointment.StudentId=tt.StudentId
,SysUser as sysuser2
where  1=1
 and UserAppointment.IsDelete = 0  
 and  Active.ActiveTheme in ('����һģ������ʦ������','�߿�200�쵹��ʱ ��ʦ��ѧ����' )  
 and Active.StartTime >= '2020-12-5' 
 and active.starttime < '2020-12-30'
 and active.IsDelete = 0
 and userinfoassign.ddlAdmin = sysuser2.sysuserguid
-- and tt.ParticipateCount>1
-- and ui1.UserName ='���'
-- and UserAppointment.StudentId='8C899406-88C8-4FEB-A0E9-7AA8EFA58D18'
 order by ActiveTheme 



close  StudentParticipateCount_cursor
--�ͷ��α�
DEALLOCATE StudentParticipateCount_cursor







