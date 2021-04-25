  -- `online`.`t_user`  销售人员表  当前登录用户 token
--   `online`.`t_crm_order`  adviser-销售人员 *分成比例   是否销售分成 (1不分成，2分成)
--  订单状态4 审核状态6
-- pay_time


-- t_user` 主部门Id  t_dept ID   是否业务部门 1是,0否
-- t_role  ID 15  销售
--  s_
--  角色
	-- 销售排行
	select  *  from  (
										select  	DENSE_RANK()over( ORDER BY actual_sale_amount desc	) line,
										        id, nick_name ,dept_name,dept_id,
														ifnull(actual_sale_amount,0) actual_sale_amount,
														ROUND(ifnull(sales_amount_goal,0),2)sales_amount_goal,
														ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount,
														case actual_sale_amount>=ifnull( sales_amount_goal*0.16666667,0)
														when true  then 1
														else 0
														end is_reach
										from (
														select  u.id, u.nick_name,ifnull(d.dept_name,'')dept_name ,u.major_dept_id dept_id , 
																		co.actual_sale_amount ,
																		st.sales_amount sales_amount_goal
																		from `online`.t_user  u
																		join (
																					select   id,dept_name  from (		
																										select id,dept_name
																										from
																											(
																												select
																													t1.id,t1.dept_name,
																													if(find_in_set(parent_id, @pids) > 0,
																														 @pids := concat(@pids, ',', id),
																														0) as ischild
																											from
																												(
																												select id,parent_id,dept_name
																												from `online`.t_dept t
																												order by parent_id,id 
																													) t1,
																												 (select @pids := 1) t2  -- 此处设置要查询的部门@pids
																												) t3
																										where ischild != 0
																										union 
																										select id,dept_name from `online`.t_dept where id=1
																							)	t
																							order by id
																			) d on u.major_dept_id =d.id
																	left join (
																							select  adviser,ROUND( sum(actual_deal_amount),2)actual_sale_amount
																							from (
																																-- 原单A 
																																select  co1.adviser,
																																				ifnull(co1.deal_amount,0)*(1-if(co1.is_profit=2,co1.profit_percent,0)) actual_deal_amount
																																from 	`online`.t_crm_order  co1
																																where 1=1
																																		 and co1.order_type=1
																																		 and co1.order_status=4
																																		 and co1.check_status in (4,6)
																																	   and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																																union all
																																-- 退单A --   
																																select rco.adviser,
																																			 ifnull(rco.refund_amount,0)*-1 *(1-if(sco.is_profit=2,sco.profit_percent,0)) actual_deal_amount
																																			 from `online`.t_crm_order  rco
																																			 join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
																																			 join `online`.t_crm_order sco on sco.order_number =cod.link_number
																																where 1=1
																																		 and rco.order_type=3
																																		 and rco.order_status=4
																																		 and rco.check_status in (4,6) and sco.check_status in (4,6)
																																	 	 and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																																union all
																																-- 原单B 
																																select  co1.adviser_other adviser,
																																				ifnull(co1.deal_amount,0)*if(co1.is_profit=2, co1.profit_percent,0) actual_deal_amount
																																from 	`online`.t_crm_order  co1
																																where 1=1
																																		 and co1.order_type=1
																																		 and co1.order_status=4
																																		 and co1.check_status in (4,6)
																																	 	 and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																																union all
																																-- 退单B --1800
																																select sco.adviser_other adviser,
																																			 ifnull(rco.refund_amount,0)*-1 *if(sco.is_profit=2,sco.profit_percent,0) actual_deal_amount
																																			 from `online`.t_crm_order  rco
																																			 join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
																																			 join `online`.t_crm_order sco on sco.order_number =cod.link_number
																																where 1=1
																																		 and rco.order_type=3
																																		 and sco.order_type=1
																																		 and rco.check_status in (4,6) and sco.check_status in (4,6)
																																		 and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																							)t	
																							group by 	adviser	
																							ORDER BY 	actual_sale_amount desc					
																				) co on co.adviser=u.Id
																		left join (
																								select st.salesman_id , sum(st.sales_amount ) sales_amount from  `online`.t_sales_target st	
																								where  st.effective_time  between '202104' and '202104'
																								GROUP BY salesman_id
																						 ) st on st.salesman_id =u.Id 
																		where 1=1 and u.logic_delete=0 and u.user_status=1
												) t1
												
        )t3
        where 1=1  
				limit 20,20
		
		
		
		
				
	-- 销售排行--cte			
with department_user_cte as(
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
							(select @pids := 1) t2  -- 此处设置要查询的部门@pids
					) t3
					where ischild != 0
					union 
					select id,dept_name,parent_id from `online`.t_dept where id=1
		    )	t
		left join  `online`.t_dept p on p.id=t.parent_id
		order by id	
),
sales_order_cte as(
    select  adviser,ROUND( sum(actual_deal_amount),2)actual_sale_amount
    from (
					-- 原单A 
					select  co1.adviser,
									ifnull(co1.deal_amount,0)*(1-if(co1.is_profit=2,co1.profit_percent,0)) actual_deal_amount
					from 	`online`.t_crm_order  co1
					where 1=1
					and co1.order_type=1
					and co1.order_status=4
					and co1.check_status in (4,6)
					and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
					union all
					-- 退单A --   
					select rco.adviser,
								 ifnull(rco.refund_amount,0)*-1 *(1-if(sco.is_profit=2,sco.profit_percent,0)) actual_deal_amount
				 from `online`.t_crm_order  rco
							  join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
							  join `online`.t_crm_order sco on sco.order_number =cod.link_number
				 where 1=1
							and rco.order_type=3
							and rco.order_status=4
							and rco.check_status in (4,6) and sco.check_status in (4,6)
							and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
							union all
				-- 原单B 
				select co1.adviser_other adviser,
							ifnull(co1.deal_amount,0)*if(co1.is_profit=2, co1.profit_percent,0) actual_deal_amount
				from 	`online`.t_crm_order  co1
				where 1=1
						  and co1.order_type=1
							and co1.order_status=4
							and co1.check_status in (4,6)
							and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
							union all
				-- 退单B --1800
				select sco.adviser_other adviser,
						   ifnull(rco.refund_amount,0)*-1 *if(sco.is_profit=2,sco.profit_percent,0) actual_deal_amount
				from `online`.t_crm_order  rco
				join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
				join `online`.t_crm_order sco on sco.order_number =cod.link_number
				where 1=1
				      and rco.order_type=3
						  and sco.order_type=1
							and rco.check_status in (4,6) and sco.check_status in (4,6)
							and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
		  	)t
			group by 	adviser	
			ORDER BY 	actual_sale_amount desc			
),
 sales_goal_cte as(
      select st.salesman_id , sum(st.sales_amount ) sales_amount from  `online`.t_sales_target st	
			where  st.effective_time  between '202104' and '202104'
			GROUP BY salesman_id
)
	
select  *  
from (
			select  line,t1.id, nick_name ,
							ifnull(d.dept_name,'')dept_name,dept_id,
							ifnull(actual_sale_amount,0) actual_sale_amount,
							ROUND(ifnull(sales_amount_goal,0),2)sales_amount_goal,
							ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount,
							if( actual_sale_amount>=ifnull( sales_amount_goal*0.16666667,0),1,0) is_reach
				from (
								select  DENSE_RANK()over( ORDER BY actual_sale_amount desc	) line,
												u.id, u.nick_name ,u.major_dept_id dept_id , 
												co.actual_sale_amount ,
												st.sales_amount sales_amount_goal
								from `online`.t_user  u
								left join sales_order_cte co on co.adviser=u.Id
								left join sales_goal_cte st on st.salesman_id =u.Id 
								where 1=1 and u.logic_delete=0 and u.user_status=1
						)t1
				join department_user_cte d on t1.dept_id =d.id							
        )t
where 1=1  
ORDER BY line asc
limit 0,20				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
	-- 小组排行  --old
select  dept_name,group_name,major_dept_id, 
				ROUND(sales_amount_goal,2) sales_amount_goal,
        ROUND(sales_amount_goal*0.16666667,2) should_sales_amount,
				ROUND(actual_sale_amount,2) actual_sale_amount,
        ifnull(person_num_goal,0) person_num_goal, 
				ifnull(actual_student_count,0) actual_student_count
        from (
							select  ifnull(dept_name,'')dept_name,group_name,major_dept_id,
											sum(actual_sale_amount) actual_sale_amount,
											sum(if(actual_sale_amount>0,1,0)) as actual_student_count,
											sum(sales_amount) sales_amount_goal,sum(person_num) person_num_goal
							from (
											select  dp.dept_name,d.dept_name group_name,u.major_dept_id,
															sum((ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2)) actual_sale_amount ,
															co.buy_user_id ,
															ifnull(st.sales_amount,0) sales_amount,
															ifnull(st.person_num,0)person_num
											from `online`.t_user  u
											JOIN `online`.t_dept d on u.major_dept_id =d.id
											left JOIN `online`.t_dept dp on d.parent_id=dp.id
											left join `online`.t_crm_order co on co.adviser=u.Id  and co.order_status=4 and co.check_status in (4,6)  and  co.order_type in (1,3)    
											          and  co.pay_time>='2020-04-10' and co.pay_time<=DATE_ADD('2021-04-15',INTERVAL 1 DAY)
											left join (
																	select st.salesman_id ,
																	       sum(st.sales_amount ) sales_amount ,
																				 sum(st.person_num ) person_num 
																	from  `online`.t_sales_target st
																	where  st.effective_time  between '202104' and '202104'	
																	GROUP BY salesman_id,person_num
																) st on st.salesman_id =u.Id 
	                    where 1=1 and u.logic_delete=0 and u.user_status=1
											group by dp.dept_name,d.dept_name ,u.major_dept_id,co.buy_user_id ,st.sales_amount,st.person_num
							)	t1
							group by  dept_name,group_name,major_dept_id

        )t2
 ORDER BY actual_sale_amount desc	
				
				
				
				
-- 小组排行 new 			
				
select  DENSE_RANK()over( ORDER BY actual_sale_amount desc	) line,
				dept_name,group_name,major_dept_id, 
				ROUND(sales_amount_goal,2) sales_amount_goal,
				ROUND(sales_amount_goal*25/30,2) should_sales_amount,
				ROUND(actual_sale_amount,2) actual_sale_amount,
				ifnull(person_num_goal,0) person_num_goal, 
				ifnull(actual_student_count,0) actual_student_count
from (
			select  ifnull(dept_name,'')dept_name,group_name,major_dept_id,
							sum(ifnull(actual_sale_amount,0)) actual_sale_amount,
							sum(if(actual_sale_amount>0,1,0)) as actual_student_count,
							sales_amount sales_amount_goal,
							person_num person_num_goal
			from (
							select  dp.dept_name,d.dept_name group_name,u.major_dept_id,
											sum(co.actual_sale_amount) actual_sale_amount,
											co.buy_user_id ,
											ifnull(st.sales_amount,0) sales_amount,
											ifnull(st.person_num,0)person_num
							from `online`.t_user  u
							JOIN `online`.t_dept d on u.major_dept_id =d.id
							left JOIN `online`.t_dept dp on d.parent_id=dp.id
							left join
											 (
													 select  adviser,buy_user_id,actual_deal_amount actual_sale_amount
													 from (
																							-- 原单A 21396
																							select  co1.adviser,co1.buy_user_id,
																											ifnull(co1.deal_amount,0)*(1-if(co1.is_profit=2,co1.profit_percent,0)) actual_deal_amount
																							from 	`online`.t_crm_order  co1
																							where 1=1
																									 and co1.order_type=1
																									 and co1.order_status=4
																									 and co1.check_status in (4,6)
																									 and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																							union all
																							-- 退单A --    -3000
																							select rco.adviser,rco.buy_user_id,
																										 ifnull(rco.refund_amount,0)*-1 *(1-if(sco.is_profit=2,sco.profit_percent,0)) actual_deal_amount
																										 from `online`.t_crm_order  rco
																										 join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
																										 join `online`.t_crm_order sco on sco.order_number =cod.link_number
																							where 1=1
																									 and rco.order_type=3
																									 and rco.order_status=4
																									 and rco.check_status in (4,6) and sco.check_status in (4,6)
																									 and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																							union all
																							-- 原单B --1999998.03
																							select  co1.adviser_other adviser,co1.buy_user_id,
																											ifnull(co1.deal_amount,0)*if(co1.is_profit=2, co1.profit_percent,0) actual_deal_amount
																							from 	`online`.t_crm_order  co1
																							where 1=1
																									 and co1.order_type=1
																									 and co1.order_status=4
																									 and co1.check_status in (4,6)
																									 and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																							union all
																							-- 退单B --1800
																							select sco.adviser_other adviser,rco.buy_user_id,
																										 ifnull(rco.refund_amount,0)*-1 *if(sco.is_profit=2,sco.profit_percent,0) actual_deal_amount
																										 from `online`.t_crm_order  rco
																										 join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
																										 join `online`.t_crm_order sco on sco.order_number =cod.link_number
																							where 1=1
																									 and rco.order_type=3
																									 and sco.order_type=1
																									 and rco.check_status in (4,6) and sco.check_status in (4,6)
																									 and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
														)t	
											 ) co on co.adviser=u.Id  
              left join(
													select u.major_dept_id ,
																 sum(st.sales_amount ) sales_amount ,
																 sum(st.person_num ) person_num 
													from  `online`.t_sales_target st
													join  `online`.t_user u on st.salesman_id=u.id
													where  st.effective_time  between '202104' and '202104'	
													GROUP BY u.major_dept_id
							          )st on st.major_dept_id=d.id
							where 1=1 and u.logic_delete=0 and u.user_status=1
									--  and u.major_dept_id=10
							group by dp.dept_name,d.dept_name ,u.major_dept_id,co.buy_user_id ,st.sales_amount,st.person_num
			)	t1
			group by  dept_name,group_name,major_dept_id,sales_amount,person_num

)t2				
				
				
				
				
				
				
				
				
				
				
				
				
				
-- 工作台销售统计	 old
select   id, nick_name ,
		 ROUND(ifnull(actual_sale_amount,0),2)actual_sale_amount,
			 ROUND(ifnull(sales_amount_goal,0),2)sales_amount_goal,
							 ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount
	from (
					select   u.id, u.nick_name,
									sum(
											(ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2)
										 ) actual_sale_amount ,
									st.sales_amount sales_amount_goal
					from `online`.t_user  u
					left join `online`.t_crm_order co on co.adviser=u.Id and co.order_status=4 and co.check_status in (4,6) and  co.order_type in (1,3)
						 and  pay_time>='2021-04-01' and pay_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
					left join (
										 select st.salesman_id , sum(st.sales_amount ) sales_amount ,sum(st.person_num ) person_num
													from  `online`.t_sales_target st
													where  st.effective_time  between '202104' and '202104'
													GROUP BY salesman_id,person_num
									 ) st on st.salesman_id =u.Id

							where 1=1
										and u.logic_delete=0 and u.user_status=1
					GROUP BY u.id, u.nick_name,st.sales_amount
	) t1
	ORDER BY actual_sale_amount desc
							 
	







-- 工作台统计 new	
	
SELECT id, nick_name ,actual_sale_amount,sales_amount_goal,should_sales_amount,
       CASE 
WHEN @rowtotal = t2.actual_sale_amount THEN @rownum      -- 当前数据分数跟上一条数据的分数比较，相同分数的排名就不变
WHEN @rowtotal := t2.actual_sale_amount THEN @rownum :=@rownum + 1    -- 不相同分数的排名就加一
END AS line
FROM (
			select   id, nick_name ,
					     ROUND(ifnull(actual_sale_amount,0),2)actual_sale_amount,
				       ROUND(ifnull(sales_amount_goal,0),2)sales_amount_goal,
               ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount
        from (
								select   u.id, u.nick_name,
											   co.actual_sale_amount,
												st.sales_amount sales_amount_goal
								from `online`.t_user  u
								left join 
								         (
												 		select  adviser,ROUND( sum(actual_deal_amount),2)actual_sale_amount
														from (
																		-- 原单A 
																		select  co1.adviser,
																						ifnull(co1.deal_amount,0)*(1-if(co1.is_profit=2,co1.profit_percent,0)) actual_deal_amount
																		from 	`online`.t_crm_order  co1
																		where 1=1
																				 and co1.order_type=1
																				 and co1.order_status=4
																				 and co1.check_status in (4,6)
																				 and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																		union all
																		-- 退单A --   
																		select rco.adviser,
																					 ifnull(rco.refund_amount,0)*-1 *(1-if(sco.is_profit=2,sco.profit_percent,0)) actual_deal_amount
																					 from `online`.t_crm_order  rco
																					 join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
																					 join `online`.t_crm_order sco on sco.order_number =cod.link_number
																		where 1=1
																				 and rco.order_type=3
																				 and rco.order_status=4
																				 and rco.check_status in (4,6) and sco.check_status in (4,6)
																				 and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																		union all
																		-- 原单B 
																		select  co1.adviser_other adviser,
																						ifnull(co1.deal_amount,0)*if(co1.is_profit=2, co1.profit_percent,0) actual_deal_amount
																		from 	`online`.t_crm_order  co1
																		where 1=1
																				 and co1.order_type=1
																				 and co1.order_status=4
																				 and co1.check_status in (4,6)
																				 and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
																		union all
																		-- 退单B --1800
																		select sco.adviser_other adviser,
																					 ifnull(rco.refund_amount,0)*-1 *if(sco.is_profit=2,sco.profit_percent,0) actual_deal_amount
																					 from `online`.t_crm_order  rco
																					 join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
																					 join `online`.t_crm_order sco on sco.order_number =cod.link_number
																		where 1=1
																				 and rco.order_type=3
																				 and sco.order_type=1
																				 and rco.check_status in (4,6) and sco.check_status in (4,6)
																				 and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
														)t	
													group by 	adviser	
													ORDER BY 	actual_sale_amount desc		
												 ) co on co.adviser=u.Id 
							  left join (
												   select st.salesman_id , sum(st.sales_amount ) sales_amount ,sum(st.person_num ) person_num
																from  `online`.t_sales_target st
																where  st.effective_time  between '202104' and '202104'
																GROUP BY salesman_id,person_num
											   ) st on st.salesman_id =u.Id
										where 1=1
										      and u.logic_delete=0 and u.user_status=1					
        ) t1
        ORDER BY actual_sale_amount desc
			)AS t2,
(SELECT @rownum := 0 ,@rowtotal := NULL)p			
				


-- 工作台统计 new dens
select   DENSE_RANK()over( ORDER BY actual_sale_amount desc	) line,
				 u.id, u.nick_name,
				 ROUND(ifnull(co.actual_sale_amount,0),2)actual_sale_amount,
				 ROUND(ifnull(st.sales_amount,0),2)sales_amount_goal,
         ROUND(ifnull(st.sales_amount*0.16666667,0),2) should_sales_amount
from `online`.t_user  u
left join (
						select  adviser,ROUND( sum(actual_deal_amount),2)actual_sale_amount
						from (
										-- 原单A 
										select  co1.adviser,
														ifnull(co1.deal_amount,0)*(1-if(co1.is_profit=2,co1.profit_percent,0)) actual_deal_amount
										from 	`online`.t_crm_order  co1
										where 1=1
												 and co1.order_type=1
												 and co1.order_status=4
												 and co1.check_status in (4,6)
												 and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
										union all
										-- 退单A --   
										select rco.adviser,
													 ifnull(rco.refund_amount,0)*-1 *(1-if(sco.is_profit=2,sco.profit_percent,0)) actual_deal_amount
													 from `online`.t_crm_order  rco
													 join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
													 join `online`.t_crm_order sco on sco.order_number =cod.link_number
										where 1=1
												 and rco.order_type=3
												 and rco.order_status=4
												 and rco.check_status in (4,6) and sco.check_status in (4,6)
												 and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
										union all
										-- 原单B 
										select  co1.adviser_other adviser,
														ifnull(co1.deal_amount,0)*if(co1.is_profit=2, co1.profit_percent,0) actual_deal_amount
										from 	`online`.t_crm_order  co1
										where 1=1
												 and co1.order_type=1
												 and co1.order_status=4
												 and co1.check_status in (4,6)
												 and co1.sign_date>='2021-04-01' and co1.sign_date<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
										union all
										-- 退单B --1800
										select sco.adviser_other adviser,
													 ifnull(rco.refund_amount,0)*-1 *if(sco.is_profit=2,sco.profit_percent,0) actual_deal_amount
													 from `online`.t_crm_order  rco
													 join `online`.t_crm_order_detail cod on rco.order_number =cod.order_number
													 join `online`.t_crm_order sco on sco.order_number =cod.link_number
										where 1=1
												 and rco.order_type=3
												 and sco.order_type=1
												 and rco.check_status in (4,6) and sco.check_status in (4,6)
												 and rco.create_time>='2021-04-01' and rco.create_time<=DATE_ADD('2021-04-30',INTERVAL 1 DAY)
						)t	
					group by 	adviser	
					ORDER BY 	actual_sale_amount desc		
				 ) co on co.adviser=u.Id 
left join (
					 select st.salesman_id , sum(st.sales_amount ) sales_amount ,sum(st.person_num ) person_num
								from  `online`.t_sales_target st
								where  st.effective_time  between '202104' and '202104'
								GROUP BY salesman_id,person_num
				 ) st on st.salesman_id =u.Id
where 1=1
			and u.logic_delete=0 and u.user_status=1					
	
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
	
	
	
	
	
	
	
	
	
	
	
	
							 
							 
							 
							 
				
-- 递归获取部门		
select   id,dept_name ,parent_id 
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
									(select @pids := 54) t2  --    此处设置要查询的部门@pids
					    ) t3
						where ischild != 0
						union 
						select id,dept_name,parent_id from `online`.t_dept where id=54
)	t
order by id	



-- 递归获取部门信息
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
									(select @pids := 54) t2  --     此处设置要查询的部门@pids
					    ) t3
						where ischild != 0
						union 
						select id,dept_name,parent_id from `online`.t_dept where id=54
)	t
left join  `online`.t_dept p on p.id=t.parent_id
order by id	

-- 递归获取部门员工
select u.*  
	from `online`.t_user  u
	join (
				select   id,dept_name  
								 from (		
												select id,dept_name
												from
													(
														select
															t1.id,t1.dept_name,
															if(find_in_set(parent_id, @pids) > 0,
																 @pids := concat(@pids, ',', id),
																 0) as ischild
														from
															(
															select id,parent_id,dept_name
															from `online`.t_dept t
															order by parent_id,id 
															) t1,
														(select @pids := 1) t2  -- 此处设置要查询的部门@pids
										) t3
								where ischild != 0
								union 
								select id,dept_name from `online`.t_dept where id=1
					)	t
					order by id	
	     )d on u.major_dept_id =d.id
	 where 1=1
	     	and u.on_job=1
				
				
-- 递归获取员工及部门信息	
select u.id user_id,u.nick_name user_name,u.mobile,
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
														(select @pids := 3) t2  --   此处设置要查询的部门@pids
												) t3
											where ischild != 0
											union 
											select id,dept_name,parent_id from `online`.t_dept where id=3
					  )	t
					left join  `online`.t_dept p on p.id=t.parent_dept_id
					order by id	
	    )d on u.major_dept_id =d.id
	 where 1=1
	       and u.logic_delete=0 and u.user_status=1
	       and u.on_job=1		
		order by d.id		
				
				
				
				
				
				
				