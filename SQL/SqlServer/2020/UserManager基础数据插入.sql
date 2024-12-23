
--插入 RoleMenus表数据

--声明游标
declare Menus_cursor cursor
for  select  ID  from Menus;
declare @MenuID int ;

open Menus_cursor
--从游标里先读取
 FETCH NEXT FROM Menus_cursor INTO @MenuID
  WHILE (@@FETCH_STATUS = 0)--判断是否读取完
  begin

     declare Roles_cursor cursor
     for  select  ID  from Roles
     declare @RoleID int =1;
     open Roles_cursor
     FETCH NEXT FROM Roles_cursor INTO @RoleID
      WHILE (@@FETCH_STATUS = 0)--判断是否读取完
        begin
           insert into RoleMenus(RoleID,MenuID) values (@RoleID,@MenuID)
           FETCH NEXT FROM Roles_cursor INTO @RoleID
	     end

        close  Roles_cursor
        DEALLOCATE Roles_cursor
    --从游标里继续读取
    FETCH NEXT FROM Menus_cursor INTO @MenuID
   end

close  Menus_cursor
--释放游标
DEALLOCATE Menus_cursor

go

delete  from [dbo].[RoleMenus] 

DBCC CHECKIDENT ('[dbo].[RoleMenus]', RESEED, 0) ;

delete  from [dbo].[RoleMenus]  where RoleID<>2








--插入[dbo].[RoleMenuAuthorities]表数据

--声明游标
declare RoleMenus_cursor cursor
for  select  ID  from [dbo].[RoleMenus];
declare @RoleMenusID int ;

open RoleMenus_cursor
--从游标里先读取
 FETCH NEXT FROM RoleMenus_cursor INTO @RoleMenusID
  WHILE (@@FETCH_STATUS = 0)--判断是否读取完
  begin

     declare Authorities_cursor cursor
     for  select  ID  from [dbo].[Authorities]
     declare @AuthorityID int =1;
     open Authorities_cursor
     FETCH NEXT FROM Authorities_cursor INTO @AuthorityID
      WHILE (@@FETCH_STATUS = 0)--判断是否读取完
        begin
           insert into RoleMenuAuthorities([AuthorityID],[RoleMenuID]) values (@AuthorityID,@RoleMenusID)
           FETCH NEXT FROM Authorities_cursor INTO @AuthorityID
	     end

        close  Authorities_cursor
        DEALLOCATE Authorities_cursor
    --从游标里继续读取
    FETCH NEXT FROM RoleMenus_cursor INTO @RoleMenusID
   end

close  RoleMenus_cursor
--释放游标
DEALLOCATE RoleMenus_cursor



delete  from  [dbo].[RoleMenuAuthorities]

DBCC CHECKIDENT ('[dbo].[RoleMenuAuthorities]', RESEED, 0) ;


go

--查询用户的菜单
select m.[ParentID],m.[FormName] ,m.[TabHeaderText]  from  Users u
     join UserRoles  ur  on  u.ID=ur.UserID
	 join RoleMenus rm on ur.RoleID=rm.RoleID
	 join Menus m on rm.MenuID=m.ID
where u.Account='fancky' and  TabHeaderText like '%Risk Monitoring%'
order  by m.SortCode



select m.ID, m.[ParentID],m.[FormName] ,m.[TabHeaderText]  from  Users u
     join UserRoles  ur  on  u.ID=ur.UserID
	 join RoleMenus rm on ur.RoleID=rm.RoleID
	 join Menus m on rm.MenuID=m.ID
where u.Account='admin'
order  by m.SortCode



--查询用户的菜单权限
select u.ID,u.Account,a.Name AuthorityName,m.FormName  from  Users u
     join UserRoles  ur  on  u.ID=ur.UserID
	 join RoleMenus rm on ur.RoleID=rm.RoleID
	 join Menus m on rm.MenuID=m.ID
	 join RoleMenuAuthorities rma on m.ID=rma.MenuID and rma.RoleID=ur.RoleID
	 join Authorities a on rma.AuthorityID=a.ID
	 where   m.FormName='Form1'
--where u.Account='admin' and  m.FormName='Form1'

--去除\r\n
update Menus  set FormName=REPLACE(FormName, CHAR(13)+CHAR(10), '') 







go

--not  exists
  SELECT m.[ID] ,[ParentID] ,[FormName] ,[TabHeaderText],[SortCode] ,[Remark]
  FROM [ClearAPEXDB].[dbo].[Menus]  m
  where not exists
  (
  select rm.ID from [dbo].[RoleMenus] rm  where rm.MenuID=m.ID and rm.RoleID=10
  )

  --not  in 
  SELECT m.[ID] ,[ParentID] ,[FormName] ,[TabHeaderText],[SortCode] ,[Remark]
  FROM [ClearAPEXDB].[dbo].[Menus]  m
  where  m.id not in 
  (
   select rm.MenuID from [dbo].[RoleMenus] rm  where rm.RoleID=10
  )


delete  from [dbo].[RoleMenus]   where RoleID=10


alter table  [ClearAPEXDB].[dbo].[UserRoles]
add constraint Constraint_UserRoles unique ( [UserID],[RoleID]);
 
alter table [ClearAPEXDB].[dbo].[UserRoles] drop constraint Constraint_UserRoles


select  [ID] ,[Name] ,[CreateTime],[Remark] from  [dbo].[Roles] r
where not exists
  (
  select ur.ID from [dbo].[UserRoles] ur  where ur.RoleID=r.ID and ur.UserID=23
  )





select * into #NoParents from (
	  SELECT m.[ID] ,[ParentID] ,[FormName] ,[TabHeaderText],[SortCode] ,[Remark]
	  FROM [ClearAPEXDB].[dbo].[Menus]  m
	  where not exists
	  (
	    select rm.ID from [dbo].[RoleMenus] rm  where rm.MenuID=m.ID and rm.RoleID=10
	  )
  ) t

select * into #parents  from
                (
				select  *  from  Menus  where ID  in 
					(
					    --查找所有有孩子的父节点
						select ParentID  from  #NoParents 
						where  ParentID<>0 
						group  by ParentID
					)
				)t1

select *  from #NoParents
union
select  *  from #parents

drop  table #NoParents
drop  table #parents


--约束
alter table  [ClearAPEXDB].[dbo].[Authorities]
add constraint Constraint_MenuIDName unique ( [MenuID],[Name]);
 
alter table [ClearAPEXDB].[dbo].[Authorities] drop constraint Constraint_MenuIDName

delete  from [dbo].[Authorities]

DBCC CHECKIDENT ('[dbo].[Authorities]', RESEED, 0) ;

select  a.ID,a.Name,m.TabHeaderText MenuName  from [dbo].[Authorities] a
join [dbo].[Menus] m on a.[MenuID]=m.ID
go

select  rma.ID,m.TabHeaderText MenuName,r.Name RoleName ,a.Name AuthorityName 
from [dbo].[RoleMenuAuthorities] rma
 join [dbo].[Menus] m on rma.[MenuID]=m.ID
 join [dbo].[Roles] r on rma.RoleID=r.ID
 join [dbo].[Authorities] a on a.ID=rma.AuthorityID

[dbo].[RoleMenuAuthorities]

RoleIDMenuIDAuthorityID
alter table  [ClearAPEXDB].[dbo].[RoleMenuAuthorities]
add constraint Constraint_RoleIDMenuIDAuthorityID unique ( [AuthorityID],[RoleID],[MenuID])
 
alter table [ClearAPEXDB].[dbo].[Authorities] drop constraint Constraint_MenuIDName




--插入子节点
begin try
    begin  tran tr
		declare @maxSortCode int =0;
		select  @maxSortCode=MAX([SortCode])  from [dbo].[Menus]  where [ParentID]=37
	set	@maxSortCode+=1;
	select @maxSortCode;
		 INSERT INTO [dbo].[Menus]
           ([ParentID] ,[FormName] ,[TabHeaderText],[SortCode],[Status])
     VALUES
           (38,'FormName','@TabHeaderText',@maxSortCode,1)
		
   commit tran tr
end try
begin catch
 ROLLBACK TRAN tr 
end catch


--插入父节点
begin try
    begin  tran tr
		declare @currentInsertID int =0;
		 INSERT INTO [dbo].[Menus]
           ([ParentID] ,[FormName] ,[TabHeaderText],[SortCode],[Status])
     VALUES
           (0,'Test2','test21',0,1)
	select	@currentInsertID= ident_current('[ClearAPEXDB].[dbo].[Menus]');
	update  [dbo].[Menus] set [SortCode]=@currentInsertID*100 where ID=@currentInsertID;
   commit tran tr
end try
begin catch
 ROLLBACK TRAN tr 
end catch



-- 删除菜单
use [ClearAPEXDB]
go
delete   from  [dbo].[RoleMenuAuthorities] where MenuID=21
delete   from   [dbo].[RoleMenus] where MenuID=21

delete   from [dbo].[Menus]  where ID=21



delete  from [dbo].[Menus] 

DBCC CHECKIDENT ('[dbo].[Menus]', RESEED, 0) ;

update   [dbo].[Menus]  set Status=1





begin try
    begin  tran tr
	INSERT INTO [dbo].[RoleMenuAuthorities]
           ([AuthorityID],[RoleID],[MenuID])
     VALUES
           (25 ,1,1);
		   INSERT INTO [dbo].[RoleMenuAuthorities]
           ([AuthorityID] ,[RoleID],[MenuID])
     VALUES
           (5 ,1,1);
   commit tran tr
end try
begin catch
 ROLLBACK TRAN tr 
end catch

  exec sp_executesql N'
 begin try
    begin  tran tr 
  DELETE FROM [dbo].[RoleMenuAuthorities]
      WHERE RoleID  in (@ID0,@ID1 );
  DELETE FROM [dbo].[RoleMenus]
      WHERE [RoleID] in (@ID0,@ID1 );
DELETE FROM [dbo].[Roles] WHERE ID  in (  @ID0,@ID1 );

   commit tran tr
end try
begin catch
 ROLLBACK TRAN tr 
end catch
',N'@ID0 int,@ID1 int',@ID0=10,@ID1=11

--	IF @@ERROR<>0 ROLLBACK TRAN  tr 




declare @result int =1;
 begin try
    begin  tran tr 
  DELETE FROM [dbo].[RoleMenuAuthorities] WHERE RoleID  in (10,11 ) ;
  DELETE FROM [dbo].[RoleMenus]  WHERE [RoleID] in (10,11 ) ;

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



go

--删除角色
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



select  *  from [dbo].[Roles]   

go

--删除菜单
declare @result int =1;
 begin try
    begin  tran tr 
  DELETE FROM [dbo].[RoleMenuAuthorities] WHERE [MenuID]  in (37,38) ;
  DELETE FROM [dbo].[Authorities] WHERE [MenuID] in (37,38) ;
 DELETE FROM  [dbo].[RoleMenus] WHERE [MenuID] in(37,38) ;
 DELETE FROM  [dbo].[Menus] WHERE ID  in (37,38) ;
   commit tran tr
 select  @result
end try
begin catch
 set @result=-1
 select @result
 ROLLBACK TRAN tr 
end catch



select  *  from  [dbo].[Menus]

go
--删除用户
declare @result int =1;
 begin try
    begin  tran tr 
  DELETE FROM [dbo].[UserRoles] WHERE [UserID] =1 ;
  DELETE FROM  [dbo].[Users] WHERE ID  =1 ;
   commit tran tr
 select  @result
end try
begin catch
 set @result=-1
 select @result
 ROLLBACK TRAN tr 
end catch



select  *  from  [dbo].[Menus]