
--�ڴ洢�����������return  ����ֵ

declare @result int =1;
 begin try
    begin  tran tr 
  DELETE FROM [dbo].[RoleMenuAuthorities] WHERE RoleID  in (10,11 ) ;
  DELETE FROM [dbo].[RoleMenus]  WHERE [RoleID] in (10,11 ) ;
  DELETE FROM  [dbo].[UserRoles] WHERE [RoleID] in (10,11 ) ;
 DELETE FROM [dbo].[Roles] WHERE ID  in (  10,11 );
   commit tran tr
 select  @result
  -- return 1;
end try
begin catch
 set @result=-1
 select @result
 ROLLBACK TRAN tr 
end catch