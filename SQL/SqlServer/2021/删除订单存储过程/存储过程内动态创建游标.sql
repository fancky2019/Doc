-- ������ر�

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

--��������Ӱ�������
    SET NOCOUNT ON;
 --SET XACT_ABORT ON����������ع��ģ�
--��ΪONʱ�������洢�е�ĳ���ط��������⣬���������е���䶼��ع�
--ΪOFFʱ��ֻ�ع�����ĵط�
	SET XACT_ABORT ON;

	begin try 
	begin Tran  

declare @orderNumberStr nvarchar(50);
declare @orderNumber nvarchar(50);
set @orderNumberStr='';
--�����α�
declare @createCursorCommand nvarchar(1000);
-- ע��' ת��--> ''
set @createCursorCommand='declare OrderNumber_cursor cursor
                           for  SELECT * FROM dbo.split( '''+@orderNumbers+''','','');';
print @createCursorCommand;
exec(@createCursorCommand);
open OrderNumber_cursor
--���α����ȶ�ȡ
 FETCH NEXT FROM OrderNumber_cursor INTO @orderNumber
  WHILE (@@FETCH_STATUS = 0)--�ж��Ƿ��ȡ��
  begin
   print  @orderNumber;
    set  @orderNumberStr=@orderNumberStr+''''+@orderNumber+''''+',';
     --���α��������ȡ
     FETCH NEXT FROM OrderNumber_cursor INTO @orderNumber
  end
  set @orderNumberStr=LEFT(@orderNumberStr, LEN(@orderNumberStr)-1)
  print @orderNumberStr

close  OrderNumber_cursor
--�ͷ��α�
DEALLOCATE OrderNumber_cursor



	--����������
	commit tran 
	end try
	begin catch
		ROLLBACK  Tran
		-- �׳��쳣����Ȼ����
		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT
        SELECT @ErrMsg = ERROR_MESSAGE(),
               @ErrSeverity = ERROR_SEVERITY()
		RAISERROR (@ErrMsg, @ErrSeverity, 1)


	end catch

end



--exec DeleteOrdersByOrderNumbersProc  @orderNumbers='1,2,3,4,5,6,7';











