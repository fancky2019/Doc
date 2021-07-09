	-- 使用 字段->'$.json属性'进行查询条件
-- 使用json_extract函数查询，json_extract(字段,"$.json属性")。 json 提取 获取json的属性
-- 根据json数组查询，用JSON_CONTAINS(字段,JSON_OBJECT('json属性', "内容"))
-- '$[*].productPrice'  所有  '$[0].productPrice'  第一个


	SELECT  id ,liveProList->'$[*].productPrice' productPriceAray FROM (	
		SELECT  Id,  CAST(JSON_EXTRACT(package_content,'$.liveProList')  AS JSON) liveProList
																						  FROM (
	SELECT co.id,  CAST(package_content AS JSON)package_content 
	       FROM 		`online`.t_crm_order co 
					JOIN 	`online`.t_crm_order_detail cod 	ON co.order_number=cod.order_number							
				 WHERE cod.ispackage=2             	
				ORDER BY co.id  DESC			
		
		)t1
		) t2
		
-- 	CONCAT(str1,str2,...)
-- 	channel_id->'$[2]'   索引下表查询    channel_id 为json 数组列名
-- JSON_CONTAINS  精确匹配
SELECT  JSON_LENGTH(channel_id) len,channel_id,channel_id->'$[2]'  FROM (		
SELECT   CAST(  channel_id  AS JSON) channel_id FROM  `online`.t_crm_order
WHERE 1=1
      AND channel_id IS NOT NULL
	) t
	-- 精确匹配： new 查询不到  --new市场营销 可以查到
	WHERE JSON_CONTAINS(channel_id,'"new市场营销"', '$')	
		
		
		
	-- 	,channel_id->CONCAT('$[',JSON_LENGTH(channel_id) ,']')
		
		
-- json_extract	
-- 	JSON_LENGTH(channel_id)-1  最后一个元素的索引。json_extract 获取指定json 的属性
SELECT  JSON_EXTRACT(channel_id,CONCAT('$[',JSON_LENGTH(channel_id)-1 ,']')) FROM (		
SELECT   CAST(  channel_id  AS JSON) channel_id FROM  `online`.t_crm_order
WHERE 1=1
      AND channel_id IS NOT NULL
	) t
	-- new 查询不到  --new市场营销 可以查到
	WHERE JSON_CONTAINS(channel_id,'"new市场营销"', '$')	
	
	
	
	
SELECT JSON_EXTRACT(`channel_id`,CONCAT("$[",JSON_LENGTH(`channel_id`)-1,"]")) 
FROM (		
SELECT   CAST(  channel_id  AS JSON) channel_id FROM  `online`.t_crm_order
WHERE 1=1
      AND channel_id IS NOT NULL
	) t
	-- new 查询不到  --new市场营销 可以查到
	WHERE JSON_CONTAINS(channel_id,'"new市场营销"', '$')	
	
	
	
	
	
	-- json 最后一个数组元素查询匹配
	SELECT  *  FROM  (
			SELECT  JSON_EXTRACT(channel_id,CONCAT('$[',JSON_LENGTH(channel_id)-1 ,']')) channel_id_tail 
			FROM (		
						SELECT   CAST(  channel_id  AS JSON) channel_id FROM  `online`.t_crm_order
						WHERE 1=1
									AND channel_id IS NOT NULL
	    ) t
	-- new 查询不到  --new市场营销 可以查到
	) t1
	WHERE channel_id_tail='new地铁'
	




-- TRIM ( [ [位置] [要移除的字串] FROM ] 字串): [位置] 的可能值为 LEADING (起头), TRAILING (结尾), or BOTH (起头及结尾)。 
   --        这个函数将把 [要移除的字串] 从字串的起头、结尾，或是起头及结尾移除。如果我们没有列出 [要移除的字串] 是什么的话，那空白就会被移除。
-- LTRIM(字串): 将所有字串起头的空白移除。
--  RTRIM(字串): 将所有字串结尾的空白移除。	
SELECT  TRIM(BOTH ' ' FROM  '    1   DSSDSD                                         ') Col_Trim ;


	

	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	