

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[killspid]    Script Date: 2021/8/3 15:51:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--��һ���洢���̣��Ͽ������û����ӡ�   
  CREATE   proc   [dbo].[killspid]   (@dbname   varchar(20))   
  as   
  begin   
  declare   @sql   nvarchar(500)   
  declare   @spid   int   
  -- ע��������ת��--->����������
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

-- ����������Ÿ���
--exec dbo.killspid @dbname='NewClassesAdmin'



