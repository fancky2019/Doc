-- 测试事务要在两个会话中测试

-- 设置当前会话隐式事务不自动提交，当前查询窗口执行插入语句可以执行成功，也能查询到。但是在另一个查询窗口却查询不到新插入的语句
-- 另一个设置 autocommit=0;，当前会话却是 autocommit=1

SET autocommit=0;

show VARIABLES like '%autocommit%';

select  *  from demo.person;



update  demo.person set name='rr_update2' where id=5;







