-- limit 优化	:前提id自增	
SELECT id,NAME,balance 
FROM account 
WHERE  
id >= (
         SELECT a.id FROM account a WHERE a.update_time >= '2020-09-19' LIMIT 100000, 1
       )
 AND update_time >= '2020-09-19'
LIMIT 10; 

-- 建议采用此种
-- 用连接查询代替嵌套查询
SELECT  acct1.id,acct1.name,acct1.balance
 FROM account acct1
 INNER JOIN (
                SELECT a.id FROM account a WHERE a.update_time >= '2020-09-19' ORDER BY a.update_time LIMIT 100000, 10
               ) AS  acct2 ON acct1.id= acct2.id


-- 以下借助rownum()
-- 标签
SELECT  id,NAME,balance FROM account WHERE id > 100000 ORDER BY id LIMIT 10;

-- between ...and 
SELECT  id,NAME,balance FROM account WHERE id BETWEEN 100000 AND 100010 ORDER BY id;

-- 生成ROW_NUMBER会耗时
SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,id 
FROM demo.`userinfo`
LIMIT 500000,10;


-- 前提是有自增主键
SELECT id 
FROM demo.`userinfo`
LIMIT 500000,10;


SELECT * 
FROM demo.`userinfo`
WHERE AddedTime>'2021-09-01'
LIMIT 10;


SELECT * 
FROM demo.`userinfo`
WHERE id>10
LIMIT 500000,10;


