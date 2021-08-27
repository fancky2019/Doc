
-- ������ر�

USE NewClassesAdmin
GO
if exists (select * from dbo.sysobjects where id = object_id(N'BackUpOrderTablesProc') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure BackUpOrderTablesProc
GO
create proc BackUpOrderTablesProc
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



	
	-- �滻����
	declare @dateStr nvarchar(8) ;

	declare @orderHeaderDateStr nvarchar(100) ;
	declare @orderMoneyDateStr nvarchar(100) ;
	declare @ordeCourseDateStr nvarchar(100) ;
	declare @ordeCourseDetailDateStr nvarchar(100);

	declare @new_orderHeaderDateStr nvarchar(100) ;
	declare @new_orderMoneyDateStr nvarchar(100) ;
	declare @new_ordeCourseDateStr nvarchar(100) ;
	declare @new_ordeCourseDetailDateStr nvarchar(100);

	Select @dateStr= CONVERT(varchar(100), GETDATE(), 112); -- 20210823
	set @orderHeaderDateStr='NewClassesAdmin.dbo.OrderHead_'+@dateStr;
	set @orderMoneyDateStr='NewClassesAdmin.dbo.OrderMoney_'+@dateStr;
	set @ordeCourseDateStr='NewClassesAdmin.dbo.OrderCourse_'+@dateStr;
	set @ordeCourseDetailDateStr='NewClassesAdmin.dbo.OrderCourseDetail_'+@dateStr;

	set @new_orderHeaderDateStr='NewClasses.dbo.OrderHead_'+@dateStr;
	set @new_orderMoneyDateStr='NewClasses.dbo.OrderMoney_'+@dateStr;
	set @new_ordeCourseDateStr='NewClasses.dbo.OrderCourse_'+@dateStr;
	set @new_ordeCourseDetailDateStr='NewClasses.dbo.OrderCourseDetail_'+@dateStr;

	declare @orderHeadBackUpCommand nvarchar(300) ;
	declare @orderMoneyBackUpCommand nvarchar(300) ;
	declare @orderCourseBackUpCommand nvarchar(300) ;
	declare @orderCourseDetailBackUpCommand nvarchar(300) ;

	declare @new_orderHeadBackUpCommand nvarchar(300) ;
	declare @new_orderMoneyBackUpCommand nvarchar(300) ;
	declare @new_orderCourseBackUpCommand nvarchar(300) ;
	declare @new_orderCourseDetailBackUpCommand nvarchar(300) ;

	set @orderHeadBackUpCommand='select  * into '+@orderHeaderDateStr+'  from NewClassesAdmin.dbo.OrderHead';
	set @orderMoneyBackUpCommand='select  * into '+@orderMoneyDateStr+'  from NewClassesAdmin.dbo.OrderMoney';
	set @orderCourseBackUpCommand='select  * into '+@ordeCourseDateStr+'  from NewClassesAdmin.dbo.OrderCourse';
	set @orderCourseDetailBackUpCommand='select  * into '+@ordeCourseDetailDateStr+'  from NewClassesAdmin.dbo.OrderCourseDetail';

	set @new_orderHeadBackUpCommand='select  * into '+@new_orderHeaderDateStr+'  from NewClasses.dbo.OrderHead';
	set @new_orderMoneyBackUpCommand='select  * into '+@new_orderMoneyDateStr+'  from NewClasses.dbo.OrderMoney';
	set @new_orderCourseBackUpCommand='select  * into '+@new_ordeCourseDateStr+'  from NewClasses.dbo.OrderCourse';
	set @new_orderCourseDetailBackUpCommand='select  * into '+@new_ordeCourseDetailDateStr+'  from NewClasses.dbo.OrderCourseDetail';

	EXEC(@orderHeadBackUpCommand);
	EXEC(@orderMoneyBackUpCommand);
	EXEC(@orderCourseBackUpCommand);
	EXEC(@orderCourseDetailBackUpCommand);

	EXEC(@new_orderHeadBackUpCommand);
	EXEC(@new_orderMoneyBackUpCommand);
	EXEC(@new_orderCourseBackUpCommand);
	EXEC(@new_orderCourseDetailBackUpCommand);

		-- ���з� CHAR(10)
    declare @allCommands nvarchar(4000);
	set @allCommands=@orderHeadBackUpCommand+CHAR(10)+
	                 @orderMoneyBackUpCommand+CHAR(10)+
	                 @orderCourseBackUpCommand+CHAR(10)+
	                 @orderCourseDetailBackUpCommand+CHAR(10)+
					 @new_orderHeadBackUpCommand+CHAR(10)+
	                 @new_orderMoneyBackUpCommand+CHAR(10)+
	                 @new_orderCourseBackUpCommand+CHAR(10)+
					 @new_orderCourseDetailBackUpCommand+CHAR(10);

     -- ��ӡ
	print @allCommands;


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


--exec BackUpOrderTables ;