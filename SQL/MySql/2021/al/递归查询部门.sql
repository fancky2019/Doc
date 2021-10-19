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