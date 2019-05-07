  SELECT rma.[ID] ,rma.[AuthorityID] ,rma.[RoleID],rma.[MenuID],a.Name AuthorityName,m.FormName MenuName,r.Name RoleName
  FROM [RABC].[dbo].[RoleMenuAuthorities] rma
  join [RABC].[dbo].[Authorities] a on rma.AuthorityID=a.ID
  join [RABC].[dbo].[Menus] m on rma.MenuID=m.ID
  join [RABC].[dbo].[Roles] r on rma.RoleID=r.ID
  --别名不能用在过滤条件内
  where a.Name like '%d%' and m.FormName  like '%面%' and r.Name like '%g5%'