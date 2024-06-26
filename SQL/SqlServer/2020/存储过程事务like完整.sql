
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
	select [ID]
      ,[GUID]
      ,[StockID]
      ,[BarCodeID]
      ,[SkuID]
      ,[ProductName]
      ,[ProductStyle]
      ,[Price]
      ,[CreateTime]
      ,[Status]
      ,[Count]
      ,[ModifyTime]
	  ,[TimeStamp]  from [dbo].[Product] where ProductName like '%'+ @productName+'%' and Price>@price
	 commit tran 
	end try
	begin catch
		ROLLBACK  Tran
		--DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT
  --      SELECT @ErrMsg = ERROR_MESSAGE(),
  --             @ErrSeverity = ERROR_SEVERITY()
		--RAISERROR (@ErrMsg, @ErrSeverity, 1)


	end catch
   SET NOCOUNT OFF;
end


--exec GetProductProc @productName='jdbc',@price=13
exec GetProductProc  13,'jdbc'







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
		 commit tran 
		 --注意return 提交事务之后
		 return 1
	end try
	begin catch
		ROLLBACK  Tran
		--DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT
  --      SELECT @ErrMsg = ERROR_MESSAGE(),
  --             @ErrSeverity = ERROR_SEVERITY()
		--RAISERROR (@ErrMsg, @ErrSeverity, 1)

		return 0


	end catch
 SET NOCOUNT OFF;
end

--exec UpdateProductProc @productName='fancky123',@id=49
exec UpdateProductProc 'fancky123',49

declare  @re int
exec @re=UpdateProductProc 'fancky123',49
select @re


update [dbo].[Product] set ProductName='fancky1122' where ID=49









go

--output参数
USE [WMS]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'UpdateProductOutParamProc') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure UpdateProductOutParamProc
GO
create proc UpdateProductOutParamProc
(
@productName nvarchar(100),
@id int,
@result int =0 OUTPUT         
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
			 commit tran 
		SET @result=1
	end try
	begin catch
		ROLLBACK  Tran
		SET @result=0
	end catch
	SET NOCOUNT OFF;
end


go
DECLARE @result INT
--exec UpdateProductOutParamProc @productName='fancky123',@id=49 ,@result output
exec UpdateProductOutParamProc 'fancky123',49 ,@result OUTPUT
SELECT @result










declare @age int
declare @name varchar(20)
exec @age=up_user 2,@name output
select @age,@name








--分页查询
USE [WMS]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'pageData') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure pageData
GO
create proc pageData
(
@pageIndex int,
@pageSize int,
@totalCount int =0 OUTPUT         
)                              
as
BEGIN
	begin try 
		begin Tran  
              SELECT @totalCount = COUNT(ID)   from [dbo].[Product];
			  --select @totalCount TotalCount;
			  SELECT [ID] ,[GUID] ,[StockID] ,[BarCodeID] ,[SkuID] ,[ProductName],[ProductStyle]
                    ,[Price] ,[CreateTime],[Status] ,[Count],[ModifyTime] ,[TimeStamp]
              FROM [WMS].[dbo].[Product]
			       --order  by 1
				   order  by ID
				   OFFSET (@pageIndex-1)*@pageSize ROWS
				   FETCH NEXT @pageSize ROWS ONLY
		commit tran 
	end try
	begin catch
		ROLLBACK  Tran
	end catch
end


go
DECLARE @pageIndex INT;
DECLARE @pageSize INT;
DECLARE @totalCount INT;
set @pageIndex=1;
set @pageSize=25;
--exec pageData @pageIndex=1,@pageSize=25 ,@totalCount output
--exec pageData 1,25 ,@totalCount OUTPUT
exec pageData @pageIndex,@pageSize ,@totalCount OUTPUT
SELECT @totalCount TotalCount





declare @i int;
SELECT  @i= COUNT(ID)   from [dbo].[Product]
select @i [count];

select  *  from [dbo].[Product]
order  by 1
OFFSET 1 ROWS
FETCH NEXT 30 ROWS ONLY













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




















--查看死锁
select * from master..SysProcesses where db_Name(dbID) = 'wms' and spId <> @@SpId
                                         and dbID <> 0 and blocked >0;


