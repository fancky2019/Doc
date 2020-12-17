use NewClassesAdmin
go
--声明表变量
declare @StudentParticipateCount table
(
StudentID uniqueidentifier ,
ParticipateCount int
);
--声明列
declare @ParticipateCount int;
declare @StudentID uniqueidentifier ;
--声明游标
declare StudentParticipateCount_cursor cursor
for select distinct StudentId from NewClassesAdmin.dbo.UserAppointment ua
                      join NewClassesAdmin.dbo.Active a on ua.ActiveId=a.ActiveId
            	         where 1=1 
							   and isnull(ua.flag,0) =1
							   and ua.IsDelete=0
							   and a.IsDelete=0
							  -- and a.ActiveTheme in ('生物一模备考名师公开课','高考200天倒计时 名师升学讲座' )  
open StudentParticipateCount_cursor
--从游标里先读取
 FETCH NEXT FROM StudentParticipateCount_cursor INTO @StudentID
  WHILE (@@FETCH_STATUS = 0)--判断是否读取完
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
left join @StudentParticipateCount  tt on UserAppointment.StudentId=tt.StudentId
,SysUser as sysuser2
where  1=1
 and UserAppointment.IsDelete = 0  
 and  Active.ActiveTheme in ('生物一模备考名师公开课','高考200天倒计时 名师升学讲座' )  
 and Active.StartTime >= '2020-12-5' 
 and active.starttime < '2020-12-30'
 and active.IsDelete = 0
 and userinfoassign.ddlAdmin = sysuser2.sysuserguid
-- and tt.ParticipateCount>1
-- and ui1.UserName ='王琛'
-- and UserAppointment.StudentId='8C899406-88C8-4FEB-A0E9-7AA8EFA58D18'
 order by ActiveTheme 



close  StudentParticipateCount_cursor
--释放游标
DEALLOCATE StudentParticipateCount_cursor







