


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

	declare @orderNumberStr nvarchar(1000);
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
	   --  print  @orderNumber;
		set  @orderNumberStr=@orderNumberStr+''''+@orderNumber+''''+',';
		 --���α��������ȡ
		 FETCH NEXT FROM OrderNumber_cursor INTO @orderNumber
	  end
	  set @orderNumberStr=LEFT(@orderNumberStr, LEN(@orderNumberStr)-1)
	  print '@orderNumberStr= '+@orderNumberStr

	close  OrderNumber_cursor
	--�ͷ��α�
	DEALLOCATE OrderNumber_cursor



	
-- �滻����

-- ɾ��������Ϣ
-- ����
	declare @orderHeaderDateStr nvarchar(3000) ;
	declare @orderMoneyDateStr nvarchar(3000) ;
	declare @ordeCourseDateStr nvarchar(3000) ;
	declare @ordeCourseDetailDateStr nvarchar(3000);

	declare @new_orderHeadBackUpCommand nvarchar(3000) ;
	declare @new_orderMoneyBackUpCommand nvarchar(3000) ;
	declare @new_orderCourseBackUpCommand nvarchar(3000) ;
	declare @new_orderCourseDetailBackUpCommand nvarchar(3000) ;

	set @orderHeaderDateStr='
delete from  NewClassesAdmin.dbo.OrderHead 
where Id in (
  select  oh.Id
  from  NewClassesAdmin.dbo.OrderHead oh
  where oh.OrderNo in ( '+@orderNumberStr+')
  );';

-- �������
   set @orderMoneyDateStr='
delete from  NewClassesAdmin.dbo.OrderMoney 
where Id in (
  select  om.Id
  from  NewClassesAdmin.dbo.OrderHead oh
  join NewClassesAdmin.dbo.OrderMoney  om on oh.OrderNo=om.OrderNo
  where oh.OrderNo in ( '+@orderNumberStr+')
  );';

-- �����γ�
set @ordeCourseDateStr ='
delete from  NewClassesAdmin.dbo.OrderCourse 
where Id in (
  select  oc.Id
            from  NewClassesAdmin.dbo.OrderHead oh
			join NewClassesAdmin.dbo.OrderCourse oc on oh.OrderNo=oc.OrderNo
  where oh.OrderNo in ( '+@orderNumberStr+')
  );';


-- �����γ̳���ϸ
set @ordeCourseDetailDateStr ='
delete from  NewClassesAdmin.dbo.OrderCourseDetail 
where Id in (
select ocd.Id
            from  NewClassesAdmin.dbo.OrderHead oh
			join NewClassesAdmin.dbo.OrderCourse oc on oh.OrderNo=oc.OrderNo
			join NewClassesAdmin.dbo.OrderCourseDetail ocd on oc.Id=ocd.OrderCourseId
  where oh.OrderNo in ( '+@orderNumberStr+')
 );';


 --- [NewClasses]

 	set @new_orderHeadBackUpCommand='
delete from  NewClasses.dbo.OrderHead 
where Id in (
  select  oh.Id
  from  NewClasses.dbo.OrderHead oh
  where oh.OrderNo in ( '+@orderNumberStr+')
  );';

-- �������
   set @new_orderMoneyBackUpCommand='
delete from  NewClasses.dbo.OrderMoney 
where Id in (
  select  om.Id
  from  NewClasses.dbo.OrderHead oh
  join NewClasses.dbo.OrderMoney  om on oh.OrderNo=om.OrderNo
  where oh.OrderNo in ( '+@orderNumberStr+')
  );';

-- �����γ�
set @new_orderCourseBackUpCommand ='
delete from  NewClasses.dbo.OrderCourse 
where Id in (
  select  oc.Id
            from  NewClasses.dbo.OrderHead oh
			join NewClasses.dbo.OrderCourse oc on oh.OrderNo=oc.OrderNo
  where oh.OrderNo in ( '+@orderNumberStr+')
  );';


-- �����γ̳���ϸ
set @new_orderCourseDetailBackUpCommand ='
delete from  NewClasses.dbo.OrderCourseDetail 
where Id in (
select ocd.Id
            from  NewClasses.dbo.OrderHead oh
			join NewClasses.dbo.OrderCourse oc on oh.OrderNo=oc.OrderNo
			join NewClasses.dbo.OrderCourseDetail ocd on oc.Id=ocd.OrderCourseId
  where oh.OrderNo in ( '+@orderNumberStr+')
 );';

 	print @orderHeaderDateStr  ;
	print @orderMoneyDateStr  ;
	print @ordeCourseDateStr  ;
	print @ordeCourseDetailDateStr  ;

	print @new_orderHeadBackUpCommand  ;
	print @new_orderMoneyBackUpCommand  ;
	print @new_orderCourseBackUpCommand  ;
	print @new_orderCourseDetailBackUpCommand  ;


	-- ��ɾ���������ɾ������
	EXEC(@ordeCourseDetailDateStr);
	EXEC(@ordeCourseDateStr);
	EXEC(@orderMoneyDateStr);
	EXEC(@orderHeaderDateStr);




	EXEC(@new_orderCourseDetailBackUpCommand);
	EXEC(@new_orderCourseBackUpCommand);
	EXEC(@new_orderMoneyBackUpCommand);
	EXEC(@new_orderHeadBackUpCommand);


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








--declare @OrderNumbers  nvarchar(4000)    ;
--set @OrderNumbers='S202100167462,S202100167463';
--SELECT * FROM dbo.split( 'S202100167462,S202100167463',',');
--select @createCursorCommand;

--exec [NewClassesAdmin].dbo.DeleteOrdersByOrderNumbersProc  @orderNumbers='S202100167462,S202100167463';










