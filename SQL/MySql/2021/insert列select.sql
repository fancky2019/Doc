

delete  from `online`.`t_customize_data_permission_type` where id in 
(
  -- 包装一下指定别名表。不然不能更新读同一张表： You can't specify target table 't_customize_data_permission_type' for update in FROM clause
	select  *  from 
	(
    SELECT  id FROM `online`.`t_customize_data_permission_type` where type_key in ( 'PHONE_RECORD' ,'PHONE_RECORD_LINE','SELLER')
	) t
);

 delete  from  `online`.`t_customize_data_permission` where type_id in 
	(
    SELECT  id FROM `online`.`t_customize_data_permission_type` where type_key in ( 'PHONE_RECORD' ,'PHONE_RECORD_LINE','SELLER')
  );

INSERT INTO `online`.`t_customize_data_permission_type` (
  `type_key`,
  `description`,
  `merchant_id`,
  `create_time`,
  `create_user`
)
VALUES
  ('PHONE_RECORD','话务报表',1, NOW(), 1),
  ('PHONE_RECORD_LINE','话务排行',1, NOW(), 1),
  ( 'SELLER','销售业绩', 1, NOW(), 1 );
  


INSERT INTO `online`.`t_customize_data_permission` (
  `type_id`,
  `permission_key`,
  `description`,
  `merchant_id`,
  `create_time`,
  `create_user`
)

SELECT  id, 'ALL_PHONE_RECORD', '全部话务报表',1, NOW(),1 FROM `online`.`t_customize_data_permission_type` where type_key= 'PHONE_RECORD' 
UNION
SELECT  id, 'MY_AND_CHILD_DEPT_USER_PHONE_RECORD', '我及我以下话务报表',1, NOW(),1 FROM `online`.`t_customize_data_permission_type` where type_key= 'PHONE_RECORD' 
UNION
SELECT  id, 'MY_PHONE_RECORD', '只看到我话务报表',1, NOW(),1 FROM `online`.`t_customize_data_permission_type` where type_key= 'PHONE_RECORD' 

UNION
SELECT  id, 'ALL_PHONE_RECORD_LINE', '全部话务排行',1, NOW(),1 FROM `online`.`t_customize_data_permission_type` where type_key= 'PHONE_RECORD_LINE' 
UNION
SELECT  id, 'MY_AND_CHILD_DEPT_USER_PHONE_RECORD_LINE', '我及我以下话务排行',1, NOW(),1 FROM `online`.`t_customize_data_permission_type` where type_key= 'PHONE_RECORD_LINE' 
UNION
SELECT  id, 'MY_PHONE_RECORD_LINE', '只看到我话务排行',1, NOW(),1 FROM `online`.`t_customize_data_permission_type` where type_key= 'PHONE_RECORD_LINE' 

UNION
SELECT  id, 'ALL_SELLER', '全部销售业绩',1, NOW(),1 FROM `online`.`t_customize_data_permission_type` where type_key= 'SELLER' 
UNION
SELECT  id, 'MY_AND_CHILD_DEPT_USER_SELLER', '我及我以下销售业绩',1, NOW(),1  FROM `online`.`t_customize_data_permission_type` where type_key= 'SELLER' 
UNION
SELECT  id, 'MY_SELLER', '只看到我销售业绩',1, NOW(),1  FROM `online`.`t_customize_data_permission_type` where type_key= 'SELLER' 
  ;
  
 
  
  