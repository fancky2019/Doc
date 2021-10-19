
UPDATE t_crm_tag_type SET  `is_deleted`=1
WHERE 1=1
AND NOT EXISTS
(
   -- You can't specify target table 't_crm_tag_type' for update in FROM clause
   -- 包一层，不能将待更新的表当做更新条件里的表 
  SELECT *  FROM 
	( 
		-- 不存在子节点
   SELECT id FROM `online`.t_crm_tag_type WHERE `is_deleted`=0 AND parent_id=9  
	 )t
)
AND NOT EXISTS
(
   -- 不存在绑定数据
  SELECT id FROM `t_crm_tag_info` WHERE `is_deleted`=0 AND `tag_type_id`=9
) 
AND id=9