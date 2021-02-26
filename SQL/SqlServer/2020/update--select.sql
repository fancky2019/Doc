select OrderNo,  [ShareUserId],  [ShareUserId2] ,AddedTime from NewClassesAdmin.dbo.OrderHead
where AddedTime>'2021-01-01'
order by AddedTime  desc

    select distinct ocd.Id,ocd.[ShareUser],  ocd.[ShareUser2]
            from  NewClassesAdmin.dbo.OrderHead oh
			join NewClassesAdmin.dbo.OrderMoney  om on oh.OrderNo=om.OrderNo
			join NewClassesAdmin.dbo.OrderCourse oc on oh.OrderNo=oc.OrderNo
            left join NewClassesAdmin.dbo.OrderCourseDetail  ocd on oc.Id=ocd.OrderCourseId
			join NewClassesAdmin.dbo.Product p on oc.ProductGuid=p.ProductGuid
			 join [studydbnewadmin].[dbo].[tblgrade] g on g.GradeGuid=p.GradeGuid
			join [studydbnewadmin].[dbo].[tblyear] y on y.YearGuid=p.YearGuid
  where oh.OrderNo= 'S202100153529L' 


  -- 修改销售人员
   update  NewClassesAdmin.dbo.OrderCourseDetail set [ShareUser]=t.ShareUserId+'test',[ShareUser2]=t.ShareUserId2
   from  NewClassesAdmin.dbo.OrderCourseDetail ocd,
   (
    select distinct ocd.Id,oh.[ShareUserId],  oh.[ShareUserId2]
            from  NewClassesAdmin.dbo.OrderHead oh
			join NewClassesAdmin.dbo.OrderMoney  om on oh.OrderNo=om.OrderNo
			join NewClassesAdmin.dbo.OrderCourse oc on oh.OrderNo=oc.OrderNo
            left join NewClassesAdmin.dbo.OrderCourseDetail  ocd on oc.Id=ocd.OrderCourseId
			join NewClassesAdmin.dbo.Product p on oc.ProductGuid=p.ProductGuid
			 join [studydbnewadmin].[dbo].[tblgrade] g on g.GradeGuid=p.GradeGuid
			join [studydbnewadmin].[dbo].[tblyear] y on y.YearGuid=p.YearGuid
  where oh.OrderNo= 'S202100153529L' 
   )t  where ocd.Id=t.Id
