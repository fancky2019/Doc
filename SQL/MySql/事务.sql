
SELECT *  FROM test.`job`

START TRANSACTION;
UPDATE job SET jobname='ts12' WHERE id=1;
-- commit;
ROLLBACK; -- 已经提交无法回滚。 若未提交可回滚。


--  mssql 
-- commit tran 和 ROLLBACK TRAN 不能同时出现在语句中执行。

-- commit tran之后事务点被删除之后无法回滚，报错。 mysql 不会错，不会回滚。

