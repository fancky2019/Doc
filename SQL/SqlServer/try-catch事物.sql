begin try
    begin  tran tr
		declare @parentID int =0;
		select  @parentID=ParentID  from [dbo].[Menus]  where id=1
		if(@parentID!=0)--�ӽڵ�
			begin
			  delete  from [dbo].[RoleMenus] where MenuID=10 and RoleID=10
			end
		else--Ҫɾ�����Ǹ��ڵ�
		   begin
			--ɾ�������ӽڵ�͸ýڵ�
			delete  from [dbo].[RoleMenus] where MenuID in (select ID  from [dbo].[Menus] where ParentID=1 or ID=1  )and RoleID=10;
		   end
   commit tran tr
end try
begin catch
 ROLLBACK TRAN tr 
end catch