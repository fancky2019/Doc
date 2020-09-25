begin try
    begin  tran tr
		declare @parentID int =0;
		select  @parentID=ParentID  from [dbo].[Menus]  where id=1
		if(@parentID!=0)--子节点
			begin
			  delete  from [dbo].[RoleMenus] where MenuID=10 and RoleID=10
			end
		else--要删除的是父节点
		   begin
			--删除所有子节点和该节点
			delete  from [dbo].[RoleMenus] where MenuID in (select ID  from [dbo].[Menus] where ParentID=1 or ID=1  )and RoleID=10;
		   end
   commit tran tr
end try
begin catch
 ROLLBACK TRAN tr 
end catch



go


-- commit tran 和 ROLLBACK TRAN 不能同时出现在语句中执行。

--commit tran之后事务点被删除之后无法回滚，报错。 mysql 不会错，不会回滚。


select *  from Test.dbo.Person ;



 begin  tran tr
 update Test.dbo.Person  set Name='tes1t' where ID=1;

 --  commit tran tr; --commit 事务点被删除

 ROLLBACK TRAN tr ;

begin  tran 
 update Test.dbo.Person  set Name='tes1t' where ID=1;
 commit tran ;--commit 事务点被删除
 ROLLBACK TRAN ;-- 事务点被删除之后无法回滚，报错。 mysql 不会错，不会回滚。