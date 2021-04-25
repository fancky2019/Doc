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
				select  DENSE_RANK()over( ORDER BY actual_sale_amount desc	) line,
								id, nick_name ,dept_name,dept_id,
								ifnull(actual_sale_amount,0) actual_sale_amount,
								ROUND(ifnull(sales_amount_goal,0),2)sales_amount_goal,
								ROUND( ifnull( sales_amount_goal*0.16666667,0),2) should_sales_amount,
								if( actual_sale_amount>=ifnull( sales_amount_goal*0.16666667,0),1,0) is_reach
					from (
									select  u.id, u.nick_name,ifnull(d.dept_name,'')dept_name ,u.major_dept_id dept_id , 
													co.actual_sale_amount ,
													st.sales_amount sales_amount_goal
									from `online`.t_user  u
									join department_user_cte d on u.major_dept_id =d.id
									left join sales_order_cte co on co.adviser=u.Id
									left join sales_goal_cte st on st.salesman_id =u.Id 
									where 1=1 and u.logic_delete=0 and u.user_status=1
							) t1
												
        )t
where 1=1  
-- 	limit 0,20