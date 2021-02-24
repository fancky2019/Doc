--用sa账户登录，执行脚本
--数据库不能脱机，杀掉使用进程
-- 数据库不能独占访问，杀掉对应进程.不能杀background的进程。
EXEC sp_who2;

--59 62 71 89

KILL 59;
KILL 62;
KILL 71;
KILL 89;

CREATE TABLE #sp_who2
(
SPID INT,
Status VARCHAR(255),
      Login  VARCHAR(255),HostName  VARCHAR(255),
      BlkBy  VARCHAR(255),DBName  VARCHAR(255),
      Command VARCHAR(255),CPUTime INT,
      DiskIO INT,LastBatch VARCHAR(255),
      ProgramName VARCHAR(255),SPID2 INT,
      REQUESTID INT);

INSERT INTO #sp_who2 EXEC sp_who2

SELECT      * 
FROM        #sp_who2
-- Add any filtering of the results here :
WHERE       DBName = 'NewClassesAdmin'
-- Add any sorting of the results here :
ORDER BY    DBName ASC
 
DROP TABLE #sp_who2


declare @tempTable table (SPID INT,Status VARCHAR(255),
      Login  VARCHAR(255),HostName  VARCHAR(255),
      BlkBy  VARCHAR(255),DBName  VARCHAR(255),
      Command VARCHAR(255),CPUTime INT,
      DiskIO INT,LastBatch VARCHAR(255),
      ProgramName VARCHAR(255),SPID2 INT,
      REQUESTID INT);

INSERT INTO @tempTable 
EXEC sp_who2
select *
from @tempTable
where DBName = 'NewClassesAdmin'