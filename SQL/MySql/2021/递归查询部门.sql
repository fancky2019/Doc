SELECT   id,dept_name  FROM (		
			SELECT id,dept_name
			FROM
				(
					SELECT
						t1.id,t1.dept_name,
						IF(FIND_IN_SET(parent_id, @pids) > 0,
							 @pids := CONCAT(@pids, ',', id),
							0) AS ischild
				FROM
					(
					SELECT id,parent_id,dept_name
					FROM `online`.t_dept t
					ORDER BY parent_id,id 
						) t1,
					 (SELECT @pids := 1) t2  -- 此处设置要查询的部门@pids
					) t3
			WHERE ischild != 0
			UNION 
			SELECT id,dept_name FROM `online`.t_dept WHERE id=1
)	t
ORDER BY id



-- 递归获取部门信息
SELECT  t.*,IFNULL(p.dept_name,'') parent_dept_name
 FROM (		
							SELECT id,dept_name,parent_id
							FROM
								(
									SELECT
										t1.id,t1.dept_name,parent_id,
										-- 如果父节点，就将该节点加入字符串中。FIND_IN_SET(str,strlist) 返回索引位置，索引从1开始
										IF(FIND_IN_SET(parent_id, @pids) > 0, @pids := CONCAT(@pids, ',', id), 0) AS ischild
									FROM
										(
											SELECT id,parent_id,dept_name
											FROM `online`.t_dept t
											-- 这点一定要排序
											ORDER BY parent_id,id 
										) t1,
									(SELECT @pids := 54) t2  --  此处设置要查询的部门@pids
					    ) t3
						WHERE ischild != 0
						UNION 
						SELECT id,dept_name,parent_id FROM `online`.t_dept WHERE id=54
)	t
LEFT JOIN  `online`.t_dept p ON p.id=t.parent_id
ORDER BY id	