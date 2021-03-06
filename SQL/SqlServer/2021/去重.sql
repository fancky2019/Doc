
select  *  from [crm_clue_temp].[dbo].[cc_student_20210331]  ;

--插入的时候ID自增
select identity(int,1,1) as autoID


select identity(int,1,1) as autoID, * into #Tmp from [crm_clue_temp].[dbo].[t_user] 

select  *  from #Tmp

drop  table  #Tmp



delete from [crm_clue_temp].[dbo].[cc_student_20210331]  
where [studentId] in 
      (
	    select [studentId] from [crm_clue_temp].[dbo].[cc_student_20210331]  group by [studentId] having count([studentId]) >1
	   ) 
 and id not in (select min(id) from [crm_clue_temp].[dbo].[cc_student_20210331]  group by [studentId] having count(*)>1)

 -- 分组得到最大的id，删除保留最大id
 delete from [crm_clue_temp].[dbo].[cc_student_20210331] 
 where id not in
 (
   select max(id) from [crm_clue_temp].[dbo].[cc_student_20210331]  group by [studentId]
  )



