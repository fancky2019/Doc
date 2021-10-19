
ALTER TABLE `online`.`t_crm_tag_info` ADD COLUMN tag_type_id TINYINT(1) DEFAULT NULL COMMENT '标签类型id' AFTER data_permission_id;
ALTER TABLE `online`.`t_crm_tag_info` ADD COLUMN is_initiative TINYINT(1)  DEFAULT 1 COMMENT '是否主动：0否1是' ;
ALTER TABLE `online`.`t_crm_tag_info` ADD COLUMN remark VARCHAR(1000)  DEFAULT NULL COMMENT '备注' ;
ALTER TABLE `online`.`t_crm_tag_info` ADD COLUMN is_enable TINYINT(1)  DEFAULT 1 COMMENT '是否启用：0否1是' ;

-- ALTER TABLE `online`.`t_crm_tag_info` modify  COLUMN is_enable TINYINT(1)  DEFAULT 1 COMMENT '是否启用：0否1是' ;

CREATE TABLE `online`.`t_crm_tag_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT '标签类型名称',
  `parent_id` INT NOT NULL COMMENT '父节点id',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除：0否，1是',
  `merchant_id` BIGINT NOT NULL COMMENT '商户Id,默认昂立教育',
  `data_permission_id` BIGINT NOT NULL COMMENT '数据权限Id,默认新课程-初中',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='标签类型表';


-- drop table `online`.`t_crm_tag_type`;
-- TRUNCATE table `online`.`t_crm_tag_type`;
-- select  *  from `online`.`t_crm_tag_type`;


INSERT INTO `online`.`t_crm_tag_type`(`name`,`parent_id`,`is_deleted`,`merchant_id`,`data_permission_id`)
VALUES('基本学习情况',0, 0, 1, 1);


INSERT INTO `online`.`t_crm_tag_type`(`name`,`parent_id`,`is_deleted`,`merchant_id`,`data_permission_id`)
SELECT '谁管学习' `name` ,(SELECT  Id FROM t_crm_tag_type WHERE name='基本学习情况' limit 1) `parent_id`, 0 `is_deleted`,  1 `merchant_id`, 1 `data_permission_id`;
INSERT INTO `online`.`t_crm_tag_type`(`name`,`parent_id`,`is_deleted`,`merchant_id`,`data_permission_id`)
SELECT '班级层次及排名' `name` ,(SELECT  Id FROM t_crm_tag_type WHERE name='基本学习情况' limit 1) `parent_id`, 0 `is_deleted`,  1 `merchant_id`, 1 `data_permission_id`;
INSERT INTO `online`.`t_crm_tag_type`(`name`,`parent_id`,`is_deleted`,`merchant_id`,`data_permission_id`)
SELECT '薄弱科目' `name` ,(SELECT  Id FROM t_crm_tag_type WHERE name='基本学习情况' limit 1) `parent_id`, 0 `is_deleted`,  1 `merchant_id`, 1 `data_permission_id`;
INSERT INTO `online`.`t_crm_tag_type`(`name`,`parent_id`,`is_deleted`,`merchant_id`,`data_permission_id`)
SELECT '补课史' `name` ,(SELECT  Id FROM t_crm_tag_type WHERE name='基本学习情况' limit 1) `parent_id`, 0 `is_deleted`,  1 `merchant_id`, 1 `data_permission_id`;
INSERT INTO `online`.`t_crm_tag_type`(`name`,`parent_id`,`is_deleted`,`merchant_id`,`data_permission_id`)
SELECT '目标学校' `name` ,(SELECT  Id FROM t_crm_tag_type WHERE name='基本学习情况' limit 1) `parent_id`, 0 `is_deleted`,  1 `merchant_id`, 1 `data_permission_id`;
INSERT INTO `online`.`t_crm_tag_type`(`name`,`parent_id`,`is_deleted`,`merchant_id`,`data_permission_id`)
SELECT '选科偏好' `name` ,(SELECT  Id FROM t_crm_tag_type WHERE name='基本学习情况' limit 1) `parent_id`, 0 `is_deleted`,  1 `merchant_id`, 1 `data_permission_id`;



update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='谁管学习' LIMIT 1 ) where  `tag_name`= '爸爸管学习';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='谁管学习' LIMIT 1 ) where  `tag_name`= '妈妈管学习';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='谁管学习' LIMIT 1 ) where  `tag_name`= '自己管学习';

update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='班级层次及排名' LIMIT 1 ) where  `tag_name`= '重点班';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='班级层次及排名' LIMIT 1 ) where  `tag_name`= '班级排名前列';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='班级层次及排名' LIMIT 1 ) where  `tag_name`= '班级中等';

update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='薄弱科目' LIMIT 1 ) where  `tag_name`= '理科强';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='薄弱科目' LIMIT 1 ) where  `tag_name`= '文科强';

update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='补课史' LIMIT 1 ) where  `tag_name`= '补课史线上班级';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='补课史' LIMIT 1 ) where  `tag_name`= '补课史线上一对一';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='补课史' LIMIT 1 ) where  `tag_name`= '补课史线下小班';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='补课史' LIMIT 1 ) where  `tag_name`= '补课史线下一对一';

update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='目标学校' LIMIT 1 ) where  `tag_name`= '目标985';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='目标学校' LIMIT 1 ) where  `tag_name`= '目标211';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='目标学校' LIMIT 1 ) where  `tag_name`= '目标国外';

update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='选科偏好' LIMIT 1 ) where  `tag_name`= '选科地理';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='选科偏好' LIMIT 1 ) where  `tag_name`= '选科生物';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='选科偏好' LIMIT 1 ) where  `tag_name`= '选科物理';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='选科偏好' LIMIT 1 ) where  `tag_name`= '选科化学';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='选科偏好' LIMIT 1 ) where  `tag_name`= '选科政治';
update  `online`.`t_crm_tag_info` set tag_type_id  = (select id from `online`.`t_crm_tag_type` where `name` ='选科偏好' LIMIT 1 ) where  `tag_name`= '选科历史';



