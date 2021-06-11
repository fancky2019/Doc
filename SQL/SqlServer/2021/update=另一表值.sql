 update `online`.t_crm_clue_copy1 co, 
         ( select id, 
								 case when ifnull(FIND_IN_SET('tg020',tag_id),-1) >0 then 1
									when ifnull(FIND_IN_SET('tg021',tag_id),-1) >0 then 0
									when ifnull(FIND_IN_SET('tg022',tag_id),-1) >0 then 2
									else 2
								 end tag_valid
						from `online`.t_crm_clue_copy1 
						where  tag_id is not null
									) t  set co.valid = t.tag_valid
	where co.id=t.id