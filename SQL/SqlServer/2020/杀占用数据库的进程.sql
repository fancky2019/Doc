
-- navicat 找不到master,可以单独在不是要删除进程的库建次存储过程，执行navicat也选中此库删除要删除的库
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[killspid]    Script Date: 2021/8/3 15:51:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--建一个存储过程，断开所有用户连接。   
  CREATE   proc   [dbo].[killspid]   (@dbname   varchar(20))   
  as   
  begin   
  declare   @sql   nvarchar(500)   
  declare   @spid   int   
  -- 注：单引号转义--->两个单引号
  set   @sql='declare   getspid   cursor   for     
                    select   spid   from   sysprocesses   where   dbid=db_id('''+@dbname+''')'   
  exec   (@sql)   
  open   getspid   
  fetch   next   from   getspid   into   @spid   
  while   @@fetch_status<>-1   
  begin   
  exec('kill   '+@spid)   
  fetch   next   from   getspid   into   @spid   
  end   
  close   getspid   
  deallocate   getspid   
  end
GO

--select   spid   from   sysprocesses   where   dbid=db_id('NewClassesAdmin')

-- 多个参数逗号隔开
--exec dbo.killspid @dbname='NewClassesAdmin'



exec dbo.killspid @dbname='wms_liku'

--
restore database liku with recovery




-- 还原
RESTORE DATABASE [wms_liku] 
FROM
  DISK = N'E:\db\dbback\liku\wms1027.bak'
WITH
  FILE = 1,
  MOVE N'GensongWms3DB' TO 'E:\db\wms_liku.mdf', 
  MOVE N'GensongWms3DB_log' TO 'E:\db\wms_liku.ldf', 
  REPLACE,
  RECOVERY,
  STATS = 5;