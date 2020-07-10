

-- 开启1222跟踪，死锁log会打印在日中中

-- 启用1222跟踪
  DBCC TRACEON(1222,-1) ;
  DBCC TRACEOFF (1222,-1) ;

-- 查看启用跟踪状态
  DBCC TRACESTATUS (1222, -1) ;




-- 死锁情况1：互相拥有并请求新的排它锁。

  -- SET LOCK_TIMEOUT timeout_period(单位为毫秒)来设定锁请求超时。默认情况下，数据库没有超时期限(timeout_period值为-1，可以用SELECT @@LOCK_TIMEOUT来查看该值，即无限期等待)。

  SELECT @@LOCK_TIMEOUT;


--进程1：

begin tran Process1
use Test
go
		update [dbo].[Person] set name='Process1' where id=2;
		waitfor delay '00:00:20';
		update [dbo].[Job] set name='Process1' where id=2;
commit tran Process1



--进程2：

begin tran Process2
use Test
go
		update [dbo].[Job] set name='Process2' where id=2;
		waitfor delay '00:00:20';
		update [dbo].[Person] set name='Process2' where id=2
commit tran Process2


--  执行结果：Process1 牺牲了，Process2执行成功了
-- Process1报下面错误

--(1 行受影响)
--消息 1205，级别 13，状态 51，第 4 行
--事务(进程 ID 60)与另一个进程被死锁在 锁 资源上，并且已被选作死锁牺牲品。请重新运行该事务。



-- 查询发现 Process1 虽然执行失败，但是事务没有回滚，执行了更新了[Person]表



select *  from [dbo].[Person];

select *  from [dbo].[Job];

--进程1

use Test
go
begin try
    begin  tran Process11
		update [dbo].[Person] set name='Process11' where id=2;
		waitfor delay '00:00:20';
		update [dbo].[Job] set name='Process11' where id=2;
   commit tran Process11
end try
begin catch
 ROLLBACK TRAN Process11
end catch

--进程2
use Test
go
begin try
    begin  tran Process22
		update [dbo].[Job] set name='Process22' where id=2;
		waitfor delay '00:00:20';
		update [dbo].[Person] set name='Process22' where id=2
   commit tran Process22
end try
begin catch
 ROLLBACK TRAN Process22
end catch












-- 死锁情况2:锁的转换时出现僵持情况造成

-- 多个进程同时执行下面脚本

use Test
go
begin tran Process3
select * from [dbo].[Person] where id=2;
waitfor delay '00:00:15';
update  [dbo].[Person] set name=name+'Process3' where id=2;
commit tran Process3

-- 但是测试并未发现死锁




