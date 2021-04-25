SELECT pay_time FROM t_crm_order;

select  *  from t_user;


-- `online`.`t_user`  销售人员表  当前登录用户 token
--   `online`.`t_crm_order`  adviser-销售人员 *分成比例   是否销售分成 (1不分成，2分成)
--  订单状态4 审核状态6
-- pay_time


-- t_user` 主部门Id  t_dept ID   是否业务部门 1是,0否
-- t_role  ID 15  销售
--  s_
--  角色
SELECT u.id, u.nick_name,dp.dept_name,d.dept_name group_name ,r.role_name 
       , co.receipts_amount,   co.refund_amount, order_type
			
         from `online`.t_user  u
				 -- 角色
         JOIN `online`.t_dept d on u.major_dept_id =d.id
				left JOIN `online`.t_dept dp on d.parent_id=dp.id
				 join `online`.t_user_role ur on ur.user_id=u.id
				 join `online`.t_role r on r.id=ur.role_id
				 -- 销售
				join `online`.t_crm_order co on co.adviser=u.id
			  join  `online`.t_sales_target st on st.salesman_id=u.id
				where r.id=15 
				       and co.order_status=4 and co.check_status=6
				       and order_type in (1,3)
			
			
			

			select adviser, refund_amount  from 	  `online`.t_crm_order co  where co.refund_amount is not  null;
			
			
			select  * from 	`online`.t_dept;
			SELECT *  from `online`.t_sales_target ;
			
			
			select  adviser ,adviser_dept  from  `online`.t_crm_order;
			
			
			select  *  from `online`.t_user  where id=8;
			
				select  *  from  `online`.t_user_role;
				 
select  *  from  `online`.t_role;

select  *  from  `online`.t_sales_target ;

	select    profit_percent from `online`.t_crm_order;

select  left('12345678',3)sub；

select  CONCAT('123','456') as ad;

select  STR_TO_DATE('2013-03-09','%Y-%m-%d') da;

select   date_format(CURRENT_DATE(),'%Y%m')

 SELECT DATE_FORMAT(NOW(), '%Y'); 
  SELECT DATE_FORMAT(NOW(), '%d'); 
 
 select  day(now());
 -- 获取当前月的天数
 select DATEDIFF(date_add(curdate()-day(curdate())+1,interval 1 month ),DATE_ADD(curdate(),interval -day(curdate())+1 day)) from dual  
 
 
select curdate();
 -- 获取月初
 select  DATE_ADD(curdate(),interval -day(curdate())+1 day);   
 
-- STR_TO_DATE(字符串，日志格式)

SELECT STR_TO_DATE('2019-01-20', '%Y-%m-%d');
 
 select  STR_TO_DATE(CONCAT(st.effective_time,'01') ,'%Y%m%d') effective_time from `online`.t_sales_target st 
 
 		 where STR_TO_DATE(CONCAT(st.effective_time,'01') ,'%Y%m%d') BETWEEN '2019-12-01' and NOW()
 
 select   id, nick_name,dept_name ,
         sum(sales_amount) sales_amount,
         sum(receipts_amount)+sum(refund_amount) actual_amount,
				 -- 除以月天数*当前日期
			  	-- sum(receipts_amount)+sum(refund_amount) / DATEDIFF(date_add(curdate()-day(curdate())+1,interval 1 month ),DATE_ADD(curdate(),interval -day(curdate())+1 day)) *  day(now()) should_amout
					from (
 
								 SELECT u.id, u.nick_name,dp.dept_name , dp.id deptId ,
											 case is_profit
											 -- 1不分成，2分成
												when 1 then   1
												else 1-co.profit_percent 
												end percent	,
										-- 		cod.ispackage, cod.package_content ,cod.product_price,
											--   st.sales_amount
												 from `online`.t_user  u
												 -- 角色
												 JOIN `online`.t_dept d on u.major_dept_id =d.id
												left JOIN `online`.t_dept dp on d.parent_id=dp.id
											-- 	 join `online`.t_user_role ur on ur.user_id=u.id
											-- 	 join `online`.t_role r on r.id=ur.role_id
												 -- 销售
									-- 	  	join `online`.t_crm_order co on co.adviser=u.id
										-- 			join 	`online`.t_crm_order_detail cod 	on co.order_number=cod.order_number
											-- 	join  `online`.t_sales_target st on st.salesman_id=u.id
												where  1=1  -- r.id=15 
															 and co.order_status=4 and co.check_status=6
														   and co.order_type in (1,3)
																-- 月初到现在 代码动态
														-- and co.pay_time BETWEEN DATE_ADD(curdate(),interval -day(curdate())+1 day) and NOW()
															 -- 当月指标  代码动态
															-- and st.effective_time= date_format(CURRENT_DATE(),'%Y%m')
														-- and STR_TO_DATE(CONCAT(st.effective_time,'01') ,'%Y%m%d') BETWEEN '2019-12-01' and NOW()
		) t					 
 group  by  id, nick_name,dept_name
		
 
  SELECT count(*)
         from `online`.t_user  u
				 -- 角色
         JOIN `online`.t_dept d on u.major_dept_id =d.id
				left JOIN `online`.t_dept dp on d.parent_id=dp.id
				 join `online`.t_user_role ur on ur.user_id=u.id
				 join `online`.t_role r on r.id=ur.role_id
				 -- 销售
				join `online`.t_crm_order co on co.adviser=u.id
			  join  `online`.t_sales_target st on st.salesman_id=u.id
				where r.id=15 
 
 
 select   profit_percent from `online`.t_crm_order where is_profit=2 ORDER BY id DESC
 
 
 
 
 SELECT order_number,adviser, adviser_dept 
 FROM online.t_crm_order co
where  co.order_status=4 and co.check_status=6
														   and co.order_type in (1,3) and adviser_dept is not null
	order by id desc;
	
	
	
 
  SELECT  adviser ,id FROM online.t_crm_order order by id desc;
	
	
  SELECT r.*
         from `online`.t_user  u
				 -- 角色
         JOIN `online`.t_dept d on u.major_dept_id =d.id
				left JOIN `online`.t_dept dp on d.parent_id=dp.id
				 join `online`.t_user_role ur on ur.user_id=u.id
				 join `online`.t_role r on r.id=ur.role_id

			where 1=1
			       and r.id=15 
						 and co.adviser=3176
						 
	select  *  from `online`.t_user		where id in (3176) 	;		 
						 
				select  *  from  `online`.t_user_role 	;
 
 				select  *  from `online`.t_role 	;
				
				select  *  from `online`.t_dept 	;
				
				

 
 
 -- pageSize*(pageIndex-1),pageSize
 select  *  from `online`.t_crm_order LIMIT 0,6;
 
 
  select  *  from `online`.t_crm_order LIMIT 6,6;
 
   select  *  from `online`.t_crm_order LIMIT 12,6;
 
 
 
 
     select  nick_name,dept_name ,
                sum(receipts_amount)+sum(refund_amount) actual_amount
        from (

                 SELECT u.id, u.nick_name,dp.dept_name , dp.id deptId
                      ,case is_profit
                           when 1 then co.receipts_amount *  co.profit_percent
                           else co.receipts_amount
                     end receipts_amount
                      ,co.refund_amount*-1 refund_amount
                      ,st.sales_amount
                 from `online`.t_user  u
                        /*  -- 角色*/
                          JOIN `online`.t_dept d on u.major_dept_id =d.id
                          left JOIN `online`.t_dept dp on d.parent_id=dp.id
                           /* -- 销售*/
                          join `online`.t_crm_order co on co.adviser=u.id
													join 	`online`.t_crm_order_detail cod 	on co.order_number=cod.order_number
                          join  `online`.t_sales_target st on st.salesman_id=u.id
                 where 1=1
                   and co.order_status=4 and co.check_status=6
                   and co.order_type in (1,3)
               /*  -- 月初到现在 代码动态*/
                /* -- and co.pay_time BETWEEN DATE_ADD(curdate(),interval -day(curdate())+1 day) and NOW()*/

             ) t
        group  by  id, nick_name,dept_name
            limit 0,3
		
		
		-- 退款金额
		
				
						
	select ROW_NUMBER() OVER (ORDER BY id) row_num from t_crm_clue t;		
	
	
	   set @row_num=0;
		select @row_num:=@row_num+1 row_num from t_crm_clue t;		
	
	
		select co.*, cod.refund_amount,cod.refund_content from 		`online`.t_crm_order co 
					join 	`online`.t_crm_order_detail cod 	on co.order_number=cod.order_number
									
   where  cod.refund_amount is not null;   	
						
  -- 1:产品  2：产品包	
	select co.id, package_content  from 		`online`.t_crm_order co 
					join 	`online`.t_crm_order_detail cod 	on co.order_number=cod.order_number
									
   where cod.ispackage=2             
						
	order by co.id  desc			
						
		
		-- SELECT  JSON_EXTRACT(cast(b as json),'$."止咳药"') from b 
	select co.id,JSON_EXTRACT(cast(package_content as json),'$.productPrice')   from 		`online`.t_crm_order co 
					join 	`online`.t_crm_order_detail cod 	on co.order_number=cod.order_number
									
   where cod.ispackage=2             
						
	order by co.id  desc			
		
		
select id, 	row_number() over(PARTITION BY id, order by id) as rows	from `online`.t_crm_order co;
						
		select  *  from  `online`.t_crm_order co;
		
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
		
		
		select  *  from 		`online`.t_crm_order_detail		

						
SET @id =0;				
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('7654,7698,7782,7788',',',@id+1),',',-1) AS num ;
						
						
						
	select adviser, co.order_status,co.check_status, co.*
	        		from  `online`.t_crm_order co 
							
		where 1=1 
		 
					and co.order_status=4 and co.check_status=6
          and co.order_type in (1,3) 
					and co.adviser in (5,8,11,12,23654)		
				 -- and co.adviser=5 						
						
						
						
						
						
											
						
			select  co.adviser, 
			         ifnull(co.deal_amount,0)deal_amount,
							ifnull( co.refund_amount,0)*-1 refund_amount,
			         ROUND(1-ifnull(co.profit_percent,0),2) percent
	        from  `online`.t_crm_order co 
		where 1=1 
					and co.order_status=4 and co.check_status=6
          and co.order_type in (1,3) 
					and co.adviser in (5,8,11,12,23654)			
		
select  co.adviser, 
			         ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 refund_amount,
			         ROUND(1-ifnull(co.profit_percent,0),2) percent
	        from  `online`.t_crm_order co 
		where 1=1 
					and co.order_status=4 and co.check_status=6
          and co.order_type in (1,3) 
					and co.adviser in (5,8,11,12,23654)			
	
	
	explain
	
	select  *  from  (
										select  id, nick_name ,dept_name,dept_id,group_name,
														actual_sale_amount,sales_amount_goal,
														sales_amount_goal*40/50 should_sales_amount,
														case actual_sale_amount>=(sales_amount_goal*40/50)
														when true  then 1
														else 0
														end is_reach
										 from (					
														select   u.id, u.nick_name,ifnull(dp.dept_name,'')dept_name ,ifnull( dp.id ,'')dept_id , d.dept_name group_name,
																		 sum(
																				 (ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2) 
																			)	actual_sale_amount ,
																		sum(st.sales_amount) sales_amount_goal
																		from `online`.t_user  u
																		 --  /*  -- 角色*/
																		JOIN `online`.t_dept d on u.major_dept_id =d.id
																		left JOIN `online`.t_dept dp on d.parent_id=dp.id
																		left join `online`.t_crm_order co on co.adviser=u.Id    and co.pay_time>='2020-01-01' and co.pay_time<='2021-05-01'
																		join `online`.t_sales_target st	on st.salesman_id =u.Id	 and  st.effective_time  between '202003' and '202104'
														where 1=1 
																	and co.order_status=4 and co.check_status=6
																	and co.order_type in (1,3) 
														GROUP BY u.id, u.nick_name,dp.dept_name , d.dept_name 
											
											) t1
			)t2
		where 1=1
	       and	is_reach=0
		limit 0,20
	
		
		
		select  *  from `online`.t_sales_target st
		
						
			select  co.adviser,sum( (co.deal_amount+co.refund_amount*-1)*ROUND(1-co.profit_percent,2))sale_amount
	        from  `online`.t_crm_order co 
		where 1=1 
					and co.order_status=4 and co.check_status=6
          and co.order_type in (1,3) 
					and co.adviser in (5,8,11,12,23654)			
		GROUP BY co.adviser					
		
		
	select  u.id ,dp.dept_name,d.dept_name group_name
									from `online`.t_user  u
																		 --  /*  -- 角色*/
																		JOIN `online`.t_dept d on u.major_dept_id =d.id
																		left JOIN `online`.t_dept dp on d.parent_id=dp.id
																		left join `online`.t_crm_order co on co.adviser=u.Id    and co.pay_time>='2020-01-01' and co.pay_time<='2021-05-01'
																		join `online`.t_sales_target st	on st.salesman_id =u.Id	 and  st.effective_time  between '202003' and '202104'
						
						
					
					
					
	select  * from  `online`.t_dept d
						
						
						
		select t.id,t.clue_name, t.phone,ROW_NUMBER() OVER (ORDER BY t.phone DESC) from t_crm_clue t;		
		
						
	select ROW_NUMBER() OVER (ORDER BY id) row_num from t_crm_clue t;		
						
												
   select ROW_NUMBER() OVER (ORDER BY 1) from t_crm_clue t;		
						
	
	select dept_name, group_name ,major_dept_id from (
	
	select   dp.dept_name,d.dept_name group_name,d.id major_dept_id
									from `online`.t_user  u
									JOIN `online`.t_dept d on u.major_dept_id =d.id
									left JOIN `online`.t_dept dp on d.parent_id=dp.id
	group by dp.dept_name,d.dept_name ,major_dept_id
	) dept_group dg





select ROW_NUMBER() OVER (ORDER BY actual_sale_amount desc) as row_num,
       dept_name,group_name,major_dept_id,sales_amount_goal, 
			 sales_amount_goal*0.05 should_sales_amount,actual_sale_amount ,
			 person_num_goal,actual_student_count
from (
			select  ifnull(dept_name,'')dept_name,group_name,major_dept_id,
							sum(actual_sale_amount) actual_sale_amount,count(*) actual_student_count,
							sum(sales_amount) sales_amount_goal,sum(person_num) person_num_goal
			from (
					select   dp.dept_name,d.dept_name group_name,u.major_dept_id,
								sum(	( ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2) ) actual_sale_amount ,
									co.buy_user_id ,st.sales_amount,st.person_num
												from `online`.t_user  u
												JOIN `online`.t_dept d on u.major_dept_id =d.id
												left JOIN `online`.t_dept dp on d.parent_id=dp.id					
											left join `online`.t_crm_order co on co.adviser=u.Id    and co.pay_time>='2021-01-21' and co.pay_time<='2021-04-12'
											join `online`.t_sales_target st	on st.salesman_id =u.Id	  and  st.effective_time  between '202101' and '202104'
									group by dp.dept_name,d.dept_name ,u.major_dept_id,co.buy_user_id ,st.sales_amount,st.person_num
				)	t1		
	   group by  dept_name,group_name	,major_dept_id	

	)t2 
-- 	order by actual_sale_amount desc
						
		
		-- ROW_NUMBER() OVER (ORDER BY actual_sale_amount desc) as row_num,
	select   id, nick_name ,
					actual_sale_amount,sales_amount_goal,
					sales_amount_goal*40/50 should_sales_amount
					from (					
									select   u.id, u.nick_name,
														sum(
																(ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2) 
														  )	actual_sale_amount ,
																		sum(st.sales_amount) sales_amount_goal
																		from `online`.t_user  u
																		 --  /*  -- 角色*/
																		JOIN `online`.t_dept d on u.major_dept_id =d.id
																		left JOIN `online`.t_dept dp on d.parent_id=dp.id
																		left join `online`.t_crm_order co on co.adviser=u.Id    and co.pay_time>='2021-03-01' and co.pay_time<='2021-05-01'
																		join `online`.t_sales_target st	on st.salesman_id =u.Id	 and  st.effective_time  between '202103' and '202104'
														where 1=1 
																	and co.order_status=4 and co.check_status=6
																	and co.order_type in (1,3) 
																	and u.major_dept_id=9
														GROUP BY u.id, u.nick_name
     ) t1
		
		select  *  from t_dept where id=3
		

		
		
		
		
	


		
		
		
		-- 财务 15365478952
		-- 13040691917
		select  *  from t_user where id=8
		
		select  *  from t_user where mobile='13040691917'
		
		SELECT *  from `online`.t_dept;
		
			select  co.order_number, co.name,co.order_status,co.check_status,co.order_type
																		from `online`.t_user  u
																		 --  /*  -- 角色*/
																		JOIN `online`.t_dept d on u.major_dept_id =d.id
																		left JOIN `online`.t_dept dp on d.parent_id=dp.id
																		left join `online`.t_crm_order co on co.adviser=u.Id    and co.pay_time>='2020-01-01' and co.pay_time<='2021-05-01'
																		join `online`.t_sales_target st	on st.salesman_id =u.Id	 and  st.effective_time  between '202004' and '202104'
														where 1=1 
																-- 	and co.order_status=4 and co.check_status=6
																-- 	and co.order_type in (1,3) 
																	and u.major_dept_id=3
						
		
		
		select  * from `online`.t_user  u WHERE mobile='13956914411'
		
		
		
		
		
		
		select  *  from `online`.t_dept
		
		
		select dept_id from (
              select t1.dept_id,t1.parent_id,
              if(find_in_set(parent_id, @pids) > 0, @pids := concat(@pids, ',', dept_id), 0) as ischild
              from (
                   select id dept_id,parent_id from `online`.t_dept t order by parent_id, id
                  ) t1,
                  (select @pids := 要查询的节点id) t2
             ) t3 where ischild != 0;
		
		
			select dept_id from (
														select t1.dept_id,t1.parent_id,
														if(find_in_set(parent_id, 1) > 0, @pids := concat(@pids, ',', dept_id), 0) as ischild
														from (
																 select id dept_id,parent_id from `online`.t_dept t order by parent_id, id
																) t1
										
                         ) t3
						
						where ischild != 0;
		
		
		
		
		
select	id,dept_name,child_dept
from
	(
			select
				t1.id,t1.dept_name,
				if(find_in_set(parent_id,  @pids) > 0,
				@pids := concat(@pids, ',', id),
				0) as child_dept
			from
				(
						select id,	parent_id,dept_name
						from `online`.t_dept t
						order by
							parent_id,id 
				) t1,
				(select @pids :=  @pids) t2 
		) t3



-- set @pids=54;
select	id,dept_name,child_dept
from
	(
			select
				t1.id,t1.dept_name,
				if(find_in_set(parent_id,  @pids) > 0,
				@pids := concat(@pids, ',', id),
				0) as child_dept
			from
				(
						select id,	parent_id,dept_name
						from `online`.t_dept t
						order by
							parent_id,id 
				) t1
				,
				(select @pids :=  54) t2 
		) t3



		
		select  id  from `online`.t_dept     where parent_id in (
	select  id  from `online`.t_dept t where dept_name like '测试'
		
		) 
		
		
		select  id  from `online`.t_dept     where parent_id in (
		
		select  id  from `online`.t_dept     where parent_id in (
				select  id  from `online`.t_dept t where dept_name like '测试'
					
					) 
		)
		
		
		
	
select  t.*,ifnull(p.dept_name,'') parent_dept_name
 from (		
							select id,dept_name,parent_id
							from
								(
									select
										t1.id,t1.dept_name,parent_id,
										if(find_in_set(parent_id, @pids) > 0,
											 @pids := concat(@pids, ',', id),
										   0) as ischild
									from
										(
										select id,parent_id,dept_name
										from `online`.t_dept t
										order by parent_id,id 
										) t1,
									(select @pids := 54) t2  --                                                             此处设置要查询的部门@pids
					    ) t3
						where ischild != 0
						union 
						select id,dept_name,parent_id from `online`.t_dept where id=54
)	t
left join  `online`.t_dept p on p.id=t.parent_id
order by id	


select u.id ,u.nick_name,u.mobile,
       d.id dept_id,d.dept_name,d.parent_dept_id,d.parent_dept_name
	from `online`.t_user  u
	join (
	        -- 递归获取部门信息
					select  t.*,ifnull(p.dept_name,'') parent_dept_name
					 from (		
												select id,dept_name,parent_id parent_dept_id
												from
													(
														select
															t1.id,t1.dept_name,parent_id,
															if(find_in_set(parent_id, @pids) > 0,
																 @pids := concat(@pids, ',', id),
																 0) as ischild
														from
															(
															select id,parent_id,dept_name
															from `online`.t_dept t
															order by parent_id,id 
															) t1,
														(select @pids := 54) t2  --                                                             此处设置要查询的部门@pids
												) t3
											where ischild != 0
											union 
											select id,dept_name,parent_id from `online`.t_dept where id=54
					  )	t
					left join  `online`.t_dept p on p.id=t.parent_dept_id
					order by id	
	    )d on u.major_dept_id =d.id
	 where 1=1
	     	and u.on_job=1

select  u.* 
from `online`.t_user  u
JOIN `online`.t_dept d on u.major_dept_id =d.id
where 1=1
      and u.logic_delete=0 and u.user_status=1
			and u.on_job=1	
      and d.id in(54,60,62,64,137)

select  d.* 
from `online`.t_user  u
JOIN `online`.t_dept d on u.major_dept_id =d.id
where 1=1
      and u.logic_delete=0 and u.user_status=1
			and u.on_job=1	
      and d.id in(54,60,62,64,137)


	
	select  *  from 				 `online`.t_user 	u	where 1=1 and u.logic_delete=0 and u.user_status=1
		
			select  *  from 				 `online`.t_user 	u	where 1=1 and u.logic_delete=0 and u.user_status=1 and u.major_dept_id is null
		
				
				
	select  *  from 				 `online`.t_user 	u	where 1=1 and u.nick_name like '%0412助教回归%'
				
select  d.*  
			from `online`.t_user  u
			JOIN `online`.t_dept d on u.major_dept_id =d.id
		left	join `online`.t_sales_target st	on st.salesman_id=u.id
where 1=1
     --  and u.nick_name like '%0412助教回归%'
      and u.id=19

select  *	from `online`.t_user where id=19
	
	select  *  from `online`.t_dept d
	 where 1=1 
	     --  and d.dept_name like '%销售部%'
		 	and d.id=8
				-- and d.parent_id=8
	

select distinct st.salesman_id from  `online`.t_sales_target st	

select * from  `online`.t_sales_target st	 	
where  1=1
       and st.effective_time  between '202104' and '202104'
       and salesman_id=708

			select    distinct st.salesman_id ,
		               	sum(
												(ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2)
											)	actual_sale_amount
			from `online`.t_user  u
			JOIN `online`.t_dept d on u.major_dept_id =d.id
			join `online`.t_sales_target st	on st.salesman_id=u.id	
		  join `online`.t_crm_order co on co.adviser=u.Id  and co.order_status=4 and co.check_status=6  and  co.order_type in (1,3)    
				 
     group by  st.salesman_id 
				 
	
				
				
select  		sum(
												(ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2)
												)	actual_sale_amount 
		 from 	 `online`.t_crm_order co 
		 join 	`online`.t_user  u on co.adviser=u.id
where 1=1 and co.order_status=4 and co.check_status=4  and  co.order_type in (1,3)   
      and  co.pay_time>='2021-04-01' and co.pay_time<=DATE_ADD('2021-04-21',INTERVAL 1 DAY)
			and  u.nick_name LIKE CONCAT('%','%1005新增教师%','%')		
				
select  *  from 	`online`.t_user  u where 1=1	 and nick_name LIKE CONCAT('%','1005新增教师','%')	;

--  销售业绩				
	select  	ifnull(co.deal_amount,0) deal_amount ,ifnull( co.refund_amount,0)refund_amount,
	          ROUND(1-ifnull(co.profit_percent,0),2) percent, 
						co.pay_time,co.order_status,co.check_status, co.order_type
	 from 	 `online`.t_crm_order co 
where 1=1 
      -- and co.order_status=4 
			-- and co.check_status=6  
			and  co.order_type in (1,3)   
      and  co.pay_time>='2021-04-01' and co.pay_time<=DATE_ADD('2021-04-21',INTERVAL 1 DAY)
			and  co.adviser=70			
	order by pay_time desc
				
				
select  dept_name,group_name,major_dept_id, 
				ROUND(ifnull(sales_amount_goal,0),2) sales_amount_goal,
        ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount,
				actual_sale_amount ,
        ifnull(person_num_goal,0) person_num_goal, 
				actual_student_count
        from (
							select  ifnull(dept_name,'')dept_name,group_name,major_dept_id,
											sum(actual_sale_amount) actual_sale_amount,
											sum(sales_amount) sales_amount_goal,sum(person_num) person_num_goal,
											sum(if(actual_sale_amount<>0,1,0)) as actual_student_count
							from (
											select   dp.dept_name,d.dept_name group_name,u.major_dept_id,
															sum(( ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2)) actual_sale_amount ,
															co.buy_user_id ,st.sales_amount,st.person_num
											from `online`.t_user  u
											JOIN `online`.t_dept d on u.major_dept_id =d.id
											left JOIN `online`.t_dept dp on d.parent_id=dp.id
											left join `online`.t_crm_order co on co.adviser=u.Id  and co.order_status=4 and co.check_status in (4,6)  and  co.order_type in (1,3)    
											and  co.pay_time>='2020-04-10' and co.pay_time<=DATE_ADD('2021-04-15',INTERVAL 1 DAY)
											left join (
															select st.salesman_id , sum(st.sales_amount ) sales_amount ,sum(st.person_num ) person_num 
															from  `online`.t_sales_target st	
															GROUP BY salesman_id,person_num
												 ) st on st.salesman_id =u.Id 
	                    where 1=1 and u.logic_delete=0 and u.user_status=1
											group by dp.dept_name,d.dept_name ,u.major_dept_id,co.buy_user_id ,st.sales_amount,st.person_num
							)	t1
							group by  dept_name,group_name,major_dept_id

        )t2
group by dept_name,group_name,major_dept_id,sales_amount_goal,person_num_goal,actual_sale_amount
          
 ORDER BY actual_sale_amount desc					
				
				
				
						
 