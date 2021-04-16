-- 字符串截取			
select  left('12345678',3)sub；
-- 字符串拼接
select  CONCAT('123','456') as ad;
-- 日期格式化字符串
select   date_format(CURRENT_DATE(),'%Y-%m-%d')date_str;
-- 获取年月
select   date_format(CURRENT_DATE(),'%Y%m');
 -- 获取年
 SELECT DATE_FORMAT(NOW(), '%Y'); 
 -- 获取天
 SELECT DATE_FORMAT(NOW(), '%d'); 
 
 -- day of MONTH:月的天 
 select  day(now());
 
 -- 获取当前月的天数
 select DATEDIFF(date_add(curdate()-day(curdate())+1,interval 1 month ),DATE_ADD(curdate(),interval -day(curdate())+1 day)) from dual  
 
 -- 当前日期
select curdate();

 -- 获取月初
 select  DATE_ADD(curdate(),interval -day(curdate())+1 day);   
 
-- 字符串转日期 STR_TO_DATE(字符串，日志格式)
SELECT STR_TO_DATE('2019-01-20', '%Y-%m-%d');
 	
				
		-- mysql 8支持 ROW_NUMBER()				
	select ROW_NUMBER() OVER (ORDER BY id DESC) row_num from t_crm_clue t;		
  -- 代替方案
	  set @row_num=0;
		select @row_num:=@row_num+1 row_num from t_crm_clue t;		
	-- 不支持 ORDER BY 1 ；sqlserver支持
  select ROW_NUMBER() OVER (ORDER BY 1) from t_crm_clue t;		

		
	-- 查看mysql版本
	select version();
	
	-- 使用 字段->'$.json属性'进行查询条件
-- 使用json_extract函数查询，json_extract(字段,"$.json属性")
-- 根据json数组查询，用JSON_CONTAINS(字段,JSON_OBJECT('json属性', "内容"))
-- '$[*].productPrice'  所有  '$[0].productPrice'  第一个


	select  id ,liveProList->'$[*].productPrice' productPriceAray from (	
		select  Id,    
		                     cast(   JSON_EXTRACT(package_content,'$.liveProList')  as json) liveProList
																						  from (
	select co.id,  cast(package_content as json)package_content 
	       from 		`online`.t_crm_order co 
					join 	`online`.t_crm_order_detail cod 	on co.order_number=cod.order_number							
				 where cod.ispackage=2             	
				order by co.id  desc			
		
		)t1
		) t2
		
		
						

	





		

		
		
		
		
	


		
		
		

		
						
 