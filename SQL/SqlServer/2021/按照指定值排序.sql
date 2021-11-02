select G.GradeName,S.SubjectName, QusetionType,COUNT(Que_title)����
--select  QusetionType,S.SubjectName,G.GradeName,COUNT(Que_title)����
from [TestOnLine].[dbo].[Sys_Question]
left join [TestOnLine].[dbo].[Sys_QusetionType] on [TestOnLine].[dbo].[Sys_QusetionType].Id = [TestOnLine].[dbo].[Sys_Question].Que_type
left join [TestOnLine].[dbo].[Sys_Configuration] a on a.ID=[TestOnLine].[dbo].[Sys_Question].Que_status
left join [TestOnLine].[dbo].[Sys_Configuration] b on b.ID=[TestOnLine].[dbo].[Sys_Question].Que_Ctype
left join [TestOnLine].[dbo].[Sys_Configuration] c on c.ID=[TestOnLine].[dbo].[Sys_Question].Que_Model
left join studyDBNew.dbo.tblGrade G on G.GradeGuid= [TestOnLine].[dbo].[Sys_Question].Que_Grade
left join studyDBNew.dbo.tblSubject S on S.SubjectGuid=[TestOnLine].[dbo].[Sys_Question].Que_Subject
left join TestOnLine.dbo.Sys_Admin U on U.LoginUserId=[TestOnLine].[dbo].[Sys_Question].Que_Checker 
left join TestOnLine.dbo.Sys_Admin N on N.LoginUserId=[TestOnLine].[dbo].[Sys_Question].Que_AddedBy 
left join TestOnLine.dbo.Sys_Type ty on ty.ID=[TestOnLine].[dbo].[Sys_Question].Que_Model
left join TestOnLine.dbo.Sys_QuestionLore as x on x.QuestionId=TestOnLine.dbo.Sys_Question.Que_No 
where [TestOnLine].[dbo].[Sys_Question].Que_IsDelete = 0 and Que_FID='0'
group by  G.GradeName,QusetionType, S.SubjectName
Order By  
case GradeName when 'Ԥ��' then 1
                 when '��һ' then 2 
				 when '����' then 3 
                 when '����' then 4 
				 when '��һ' then 5 
                 when '�߶�' then 6 
				 when '����' then 7 
                 else 99 end