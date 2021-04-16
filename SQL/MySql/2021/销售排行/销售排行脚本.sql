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
        select  id, nick_name ,dept_name,dept_id,group_name,
        actual_sale_amount, ROUND(ifnull(sales_amount_goal,0),2)sales_amount_goal,
        ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount,
        case actual_sale_amount>=ifnull( sales_amount_goal*0.16666667,0)
        when true  then 1
        else 0
        end is_reach
        from (
								select   u.id, u.nick_name,ifnull(dp.dept_name,'')dept_name ,ifnull( dp.id ,'')dept_id , d.dept_name group_name,
												sum(
												(ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2)
												)	actual_sale_amount ,
												st.sales_amount sales_amount_goal
												from `online`.t_user  u
												JOIN `online`.t_dept d on u.major_dept_id =d.id
												left JOIN `online`.t_dept dp on d.parent_id=dp.id
												left join `online`.t_crm_order co on co.adviser=u.Id  and co.order_status=4 and co.check_status=6  and  co.order_type in (1,3)    
											 		and  co.pay_time>='2020-04-10' and co.pay_time<=DATE_ADD('2021-04-17',INTERVAL 1 DAY)
												left join (
																		select st.salesman_id , sum(st.sales_amount ) sales_amount from  `online`.t_sales_target st	
																		where  st.effective_time  between '202004' and '202104'
																				 --   and salesman_id=19
																		GROUP BY salesman_id
																 ) st on st.salesman_id =u.Id 
												where 1=1
												-- and u.major_dept_id=3
											GROUP BY u.id, u.nick_name,dp.dept_name , d.dept_name

            ) t1
        )t2
        where 1=1  
				  --     and group_name is not null
				-- order by dept_name ,group_name,actual_sale_amount desc
				limit 0,20
				
				
				-- 小组排行
select ROW_NUMBER() OVER (ORDER BY actual_sale_amount desc) as row_num,
        dept_name,group_name,major_dept_id, ROUND(ifnull(sales_amount_goal,0),2)sales_amount_goal,
        ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount,
        ifnull(person_num_goal,0)person_num_goal, ifnull(  actual_student_count,0)actual_student_count
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
											left join `online`.t_crm_order co on co.adviser=u.Id  and co.order_status=4 and co.check_status=6  and  co.order_type in (1,3)    
											and  co.pay_time>='2020-04-10' and co.pay_time<=DATE_ADD('2021-04-15',INTERVAL 1 DAY)
											left join (
															select st.salesman_id , sum(st.sales_amount ) sales_amount ,sum(st.person_num ) person_num 
															from  `online`.t_sales_target st	
															where  st.effective_time  between '202004' and '202104'
																-- 		 and salesman_id=19
															GROUP BY salesman_id,person_num
												 ) st on st.salesman_id =u.Id 

											group by dp.dept_name,d.dept_name ,u.major_dept_id,co.buy_user_id ,st.sales_amount,st.person_num
							)	t1
							group by  dept_name,group_name,major_dept_id

        )t2
				
				
				
			-- 工作天统计	
				select   id, nick_name ,
        actual_sale_amount, ROUND(ifnull(sales_amount_goal,0),2)sales_amount_goal,
        ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount
        from (
								select   u.id, u.nick_name,
								sum(
								(ifnull(co.deal_amount,0)+ifnull( co.refund_amount,0)*-1 ) * ROUND(1-ifnull(co.profit_percent,0),2)
								)	actual_sale_amount ,
								st.sales_amount sales_amount_goal
								from `online`.t_user  u
								JOIN `online`.t_dept d on u.major_dept_id =d.id
								left JOIN `online`.t_dept dp on d.parent_id=dp.id
								left join `online`.t_crm_order co on co.adviser=u.Id and co.order_status=4 and co.check_status=6  and  co.order_type in (1,3)    
								 and  co.pay_time>='2020-04-10' and co.pay_time<=DATE_ADD('2021-04-15',INTERVAL 1 DAY)
								join (
												select st.salesman_id , sum(st.sales_amount ) sales_amount ,sum(st.person_num ) person_num 
																from  `online`.t_sales_target st	
																where  st.effective_time  between '202104' and '202104'
																GROUP BY salesman_id,person_num
											) st on st.salesman_id =u.Id 
								
								where 1=1
								-- and u.major_dept_id=3
								GROUP BY u.id, u.nick_name,st.sales_amount
        ) t1
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				