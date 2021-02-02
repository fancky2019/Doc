
use NewClassesAdmin
go
truncate table NewClassesAdmin.dbo.TeacherSubject;
--声明列
declare @TeacherGuid uniqueidentifier ;
--声明游标
declare TeacherGuid_cursor cursor
for  select  su.SysUserGuid  from  NewClassesAdmin.dbo.SysUser su
                join NewClassesAdmin.dbo.SysUserRoleRelationship  ro on su.SysUserGuid=ro.SysUserGuid
             join  NewClassesAdmin.dbo.SysDept  sd on ro.DeptID=sd.DeptID
			 where sd.DeptID=2 and su.IsDelete=0
open TeacherGuid_cursor
--从游标里先读取
 FETCH NEXT FROM TeacherGuid_cursor INTO @TeacherGuid
  WHILE (@@FETCH_STATUS = 0)--判断是否读取完
  begin
  ---------------------

   --select @TeacherGuid
      --嵌套游标
      declare @SubjectGuid uniqueidentifier ;
		   --声明游标
		declare SubjectGuid_cursor cursor
		for  select  SubjectGuid from studyDBNewAdmin.dbo.tblSubject
		open SubjectGuid_cursor
		--从游标里先读取
		 FETCH NEXT FROM SubjectGuid_cursor INTO @SubjectGuid
		  WHILE (@@FETCH_STATUS = 0)--判断是否读取完
		  begin

				INSERT INTO [dbo].[TeacherSubject]
						   ([TeacherGUID] ,[SubjectGUID]  )
					 VALUES (@TeacherGuid,@SubjectGuid)
	 
	          --select @SubjectGuid;
		
			 FETCH NEXT FROM SubjectGuid_cursor INTO @SubjectGuid
		  end
	close  SubjectGuid_cursor
	--释放游标
	DEALLOCATE SubjectGuid_cursor

   ---------------------
       FETCH NEXT FROM TeacherGuid_cursor INTO @TeacherGuid
  end

close  TeacherGuid_cursor
--释放游标
DEALLOCATE TeacherGuid_cursor