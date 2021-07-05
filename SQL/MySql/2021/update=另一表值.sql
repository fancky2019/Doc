 
 -- 表已存在
 update `online`.t_crm_clue_copy1 co, 
         ( select id, 
								 case when ifnull(FIND_IN_SET('tg020',tag_id),-1) >0 then 1
									when ifnull(FIND_IN_SET('tg021',tag_id),-1) >0 then 0
									when ifnull(FIND_IN_SET('tg022',tag_id),-1) >0 then 2
									else 2
								 end tag_valid
						from `online`.t_crm_clue_copy1 
						where  tag_id is not null
									) t  set co.valid = t.tag_valid
	where co.id=t.id
	
	
	
	
	
	
	
	-- mysql 不支持select  * into table_target  from table_source（前提表不存在） ,支持insert into select(前提表存在).
CREATE TABLE ProductNamePrice ( SELECT  
  `ProductName`,
  `Price`
FROM
  `demo`.`product`    ); 
-- 插入 
  
-- 方法1：CREATE TABLE bk(SELECT * FROM USER);
-- 此种表不存在，创建一个。相当于sqlserver的  insert *  into select *  from table
CREATE TABLE demo.`product_20210701` (SELECT * FROM demo.`product`);

-- 方法2：INSERT INTO bk SELECT * FROM  user 
-- 注：此种要求表存在
INSERT INTO demo.`product_20210701`  SELECT * FROM demo.`product`;