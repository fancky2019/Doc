if exists(select * from sysobjects where name='unique_OrderHeadIdEosOrderId')
alter table [NewClassesAdmin].[dbo].[RelativeOrder] drop constraint unique_OrderHeadIdEosOrderId;
go
alter table [NewClassesAdmin].[dbo].[RelativeOrder] add constraint unique_OrderHeadIdEosOrderId unique(OrderHeadId,[OrderProductId],EosOrderId,[EosOrderProductId]);
go


if exists(select * from sysobjects where name='unique_UserInfoIdEosStudentId')
alter table [NewClassesAdmin].[dbo].[RelativeStudent] drop constraint unique_UserInfoIdEosStudentId;
go
alter table [NewClassesAdmin].[dbo].[RelativeStudent] add constraint unique_UserInfoIdEosStudentId unique(UserInfoId,EosStudentId);
go

