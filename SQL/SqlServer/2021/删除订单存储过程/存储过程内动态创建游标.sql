-- 备份相关表

USE NewClassesAdmin
GO
if exists (select * from dbo.sysobjects where id = object_id(N'DeleteOrdersByOrderNumbersProc') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure DeleteOrdersByOrderNumbersProc
GO
create proc DeleteOrdersByOrderNumbersProc 
(
 @orderNumbers nvarchar(4000)    
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

declare @orderNumberStr nvarchar(50);
declare @orderNumber nvarchar(50);
set @orderNumberStr='';
--声明游标
declare @createCursorCommand nvarchar(1000);
-- 注意' 转义--> ''
set @createCursorCommand='declare OrderNumber_cursor cursor
                           for  SELECT * FROM dbo.split( '''+@orderNumbers+''','','');';
print @createCursorCommand;
exec(@createCursorCommand);
open OrderNumber_cursor
--从游标里先读取
 FETCH NEXT FROM OrderNumber_cursor INTO @orderNumber
  WHILE (@@FETCH_STATUS = 0)--判断是否读取完
  begin
   print  @orderNumber;
    set  @orderNumberStr=@orderNumberStr+''''+@orderNumber+''''+',';
     --从游标里继续读取
     FETCH NEXT FROM OrderNumber_cursor INTO @orderNumber
  end
  set @orderNumberStr=LEFT(@orderNumberStr, LEN(@orderNumberStr)-1)
  print @orderNumberStr

close  OrderNumber_cursor
--释放游标
DEALLOCATE OrderNumber_cursor



	--上面是主体
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



--exec DeleteOrdersByOrderNumbersProc  @orderNumbers='1,2,3,4,5,6,7';











