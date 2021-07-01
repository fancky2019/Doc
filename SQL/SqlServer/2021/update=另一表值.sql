 update `online`.t_crm_clue_copy1 co, 
         ( select id, 
								 case when ifnull(FIND_IN_SET('tg020',tag_id),-1) >0 then 1
									when ifnull(FIND_IN_SET('tg021',tag_id),-1) >0 then 0
									when ifnull(FIND_IN_SET('tg022',tag_id),-1) >0 then 2
									else 2
								 end tag_valid
						from `online`.t_crm_clue_copy1 
						where  tag_id is not null
									) t  set co.valid = t.tag_valid
	where co.id=t.id









	update A SET A.mc = b.mc FROM A ,B WHERE  A.bmbh = B.bmbh and A.xmbh = B.xmbh;


	-- 此中方法大数据量执行效率高
	 update  uia set uia.ddlAdmin=r.SeniorSaleGuid 
   from [NewClassesAdmin].[dbo].[UserInfoAssign] uia,[NewClassesAdmin].[dbo].[CC_Transfer_Relationship] r
   where uia.Id= @Id and r.JuniorSaleGuid=@JuniorSaleGuid;



 --drop table  [NewClassesAdmin].[dbo].UserInfoAssign_2024
 -- 1、根据条件查出要更改后的记录及要更改的值
SELECT  *  INTO [NewClassesAdmin].[dbo].UserInfoAssign_2024 FROM 
(
select uia.Id,tr.[SeniorSaleGuid]
from  NewClassesAdmin.dbo.UserInfo ui
join [NewClassesAdmin].[dbo].[UserInfoAssign] uia on uia.StudentId= ui.StudentId
join [NewClassesAdmin].[dbo].[CC_Transfer_Relationship] tr on uia.ddlAdmin=tr. [JuniorSaleGuid]
where ui.Grade=2024 and ui.IsDelete=0 and uia.ddlAdmin is not null
)t


-- 2、修改
    update  uia set uia.ddlAdmin=r.SeniorSaleGuid 
   from [NewClassesAdmin].[dbo].[UserInfoAssign] uia,
        [NewClassesAdmin].[dbo].UserInfoAssign_2024 r
   where uia.Id= r.Id


