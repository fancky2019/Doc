
  select * from (
                    select ROW_NUMBER() over(order by (select 0) ) as RowNum,* 
					   from
					        -- 替换查询内容,查询内容不能有排序，排序应放在over()内
						   (
							 select  *  from   NewClassesAdmin.dbo.UserAppointment 
						   ) t1
			   )t2
	  where t2.RowNum BETWEEN  0  and 10


--DECLARE  @pageIndex INT =5
DECLARE  @pageIndex INT
SET @pageIndex=1
 select  *  from   NewClassesAdmin.dbo.UserAppointment 
 where 1=1
 ORDER BY 1
 OFFSET 10*(@pageIndex-1) ROWS FETCH NEXT 10 ROWS ONLY
GO