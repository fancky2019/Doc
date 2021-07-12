-- 没有订单的线索
select  cl.*  from 	t_crm_clue 
where not EXISTS 
	(
		select *  from `online`.t_crm_order  co		
		where cl.id=co.buy_user_id
 )