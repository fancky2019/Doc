
exec NewClassesAdmin.dbo.BackUpOrderTablesProc ;

--exec NewClassesAdmin.dbo.DropBackUpOrderTablesByDayProc @dateStr='20210831';

drop table NewClassesAdmin.dbo.OrderHead;
drop table NewClassesAdmin.dbo.OrderMoney;
drop table NewClassesAdmin.dbo.OrderCourse;
drop table NewClassesAdmin.dbo.OrderCourseDetail;
drop table NewClasses.dbo.OrderHead;
drop table NewClasses.dbo.OrderMoney;
drop table NewClasses.dbo.OrderCourse;
drop table NewClasses.dbo.OrderCourseDetail;

-- SQL Server中用来表示事物结束，提交并确认结果。
--系统存储过程： sp_rename 不能带库和架构.
use NewClassesAdmin
go
exec sp_rename OrderHead_20210831,OrderHead;
go
exec sp_rename OrderMoney_20210831,OrderMoney;
go
exec sp_rename OrderCourse_20210831,OrderCourse;
go
exec sp_rename OrderCourseDetail_20210831,OrderCourseDetail;
go


use NewClasses
go
exec sp_rename OrderHead_20210831,OrderHead;
go
exec sp_rename OrderMoney_20210831,OrderMoney;
go
exec sp_rename OrderCourse_20210831,OrderCourse;
go
exec sp_rename OrderCourseDetail_20210831,OrderCourseDetail;
go


