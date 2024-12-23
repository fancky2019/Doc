
USE [WMS]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'GetProductProc') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure GetProductProc
GO
create proc GetProductProc
(
@price decimal,              
@productName nvarchar(50)    
)                              
as
BEGIN

--不返回受影响的行数
    SET NOCOUNT ON;
 --SET XACT_ABORT ON是设置事务回滚的！
--当为ON时，如果你存储中的某个地方出了问题，整个事务中的语句都会回滚
--为OFF时，只回滚错误的地方
	SET XACT_ABORT ON;

	begin try 
	begin Tran  
	select  *  from [dbo].[Product] where ProductName like '%'+ @productName+'%' and Price>@price
	 commit tran 
	end try
	begin catch
		ROLLBACK  Tran
		-- 抛出异常，不然吞噬
		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT
        SELECT @ErrMsg = ERROR_MESSAGE(),
               @ErrSeverity = ERROR_SEVERITY()
		RAISERROR (@ErrMsg, @ErrSeverity, 1)


	end catch

end


exec GetProductProc @productName='jdbc',@price=13








go

USE [WMS]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'UpdateProductProc') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure UpdateProductProc
GO
create proc UpdateProductProc
(
@productName nvarchar(100),
@id int          
)                              
as
BEGIN

--不返回受影响的行数
    SET NOCOUNT ON;
 --SET XACT_ABORT ON是设置事务回滚的！
--当为ON时，如果你存储中的某个地方出了问题，整个事务中的语句都会回滚
--为OFF时，只回滚错误的地方
	SET XACT_ABORT ON;

	begin try 
	begin Tran  
	update [dbo].[Product] set ProductName=@productName where ID=@id
	select 1

	 commit tran 
	end try
	begin catch
		ROLLBACK  Tran
		--DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT
  --      SELECT @ErrMsg = ERROR_MESSAGE(),
  --             @ErrSeverity = ERROR_SEVERITY()
		--RAISERROR (@ErrMsg, @ErrSeverity, 1)

		select 0


	end catch

end

exec UpdateProductProc @productName='fancky123',@id=49








select  *  from [dbo].[Product]

--不返回受影响的行数
 SET NOCOUNT  ON
  --查询重复的数据
    select  * into #temp from  (
          select [ProductName],[Price] from [dbo].[Product]
				   group  by  [ProductName],[Price]
				  having COUNT(*)>1
       ) t
    --查询Person表重复的完整信息并排序生成RowId,不排序over(order by  (select 0))
    select *  into #temp1 from (
    select  p.GUID, p.[ProductName],p.[Price],ROW_NUMBER() over(order by  (select 0)) RowId from [dbo].[Product] p
    join #temp t on p.[ProductName]=t.[ProductName] and p.[Price]=t.[Price]
    ) t1
   --根据GUID删除数据
 --delete  from [dbo].[Product]  where GUID  in (
	--					select  GUID  from #temp1  where Rowid  not  in
	--				   (
	--					select  MIN( RowId) from #temp1
	--					group  by [ProductName],[Price]
	--				   )
 --          )
 --注意delete 后有表别名,不用连接删除没有p
  delete p  from [dbo].[Product] p
            join (
						select  GUID  from #temp1  where Rowid  not  in
					   (
						select  MIN( RowId) from #temp1
						group  by [ProductName],[Price]
					   )
           ) n on p.GUID=n.GUID

     drop  table #temp
     drop  table #temp1
