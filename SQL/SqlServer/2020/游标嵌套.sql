
use NewClassesAdmin
go
truncate table NewClassesAdmin.dbo.TeacherSubject;
--������
declare @TeacherGuid uniqueidentifier ;
--�����α�
declare TeacherGuid_cursor cursor
for  select  su.SysUserGuid  from  NewClassesAdmin.dbo.SysUser su
                join NewClassesAdmin.dbo.SysUserRoleRelationship  ro on su.SysUserGuid=ro.SysUserGuid
             join  NewClassesAdmin.dbo.SysDept  sd on ro.DeptID=sd.DeptID
			 where sd.DeptID=2 and su.IsDelete=0
open TeacherGuid_cursor
--���α����ȶ�ȡ
 FETCH NEXT FROM TeacherGuid_cursor INTO @TeacherGuid
  WHILE (@@FETCH_STATUS = 0)--�ж��Ƿ��ȡ��
  begin
  ---------------------

   --select @TeacherGuid
      --Ƕ���α�
      declare @SubjectGuid uniqueidentifier ;
		   --�����α�
		declare SubjectGuid_cursor cursor
		for  select  SubjectGuid from studyDBNewAdmin.dbo.tblSubject
		open SubjectGuid_cursor
		--���α����ȶ�ȡ
		 FETCH NEXT FROM SubjectGuid_cursor INTO @SubjectGuid
		  WHILE (@@FETCH_STATUS = 0)--�ж��Ƿ��ȡ��
		  begin

				INSERT INTO [dbo].[TeacherSubject]
						   ([TeacherGUID] ,[SubjectGUID]  )
					 VALUES (@TeacherGuid,@SubjectGuid)
	 
	          --select @SubjectGuid;
		
			 FETCH NEXT FROM SubjectGuid_cursor INTO @SubjectGuid
		  end
	close  SubjectGuid_cursor
	--�ͷ��α�
	DEALLOCATE SubjectGuid_cursor

   ---------------------
       FETCH NEXT FROM TeacherGuid_cursor INTO @TeacherGuid
  end

close  TeacherGuid_cursor
--�ͷ��α�
DEALLOCATE TeacherGuid_cursor