

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_age`(`age`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES (1, 'fancky', 2, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
INSERT INTO `person` VALUES (2, 'fancky2', 7, '2022-03-08 19:54:29', '2022-03-02 10:36:54');
INSERT INTO `person` VALUES (3, 'fancky china', 6, NULL, '2022-03-03 13:59:17');
INSERT INTO `person` VALUES (4, 'fancky test', 10, NULL, '2022-03-10 14:15:50');
INSERT INTO `person` VALUES (5, 'china fancky test', 15, NULL, '2022-03-09 16:10:18');
INSERT INTO `person` VALUES (6, 'fancky read', 16, NULL, '2022-03-10 16:17:48');
INSERT INTO `person` VALUES (7, 'you are very smart', 27, NULL, '2022-03-10 16:39:57');
INSERT INTO `person` VALUES (9, 'shiwu', 20, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
INSERT INTO `person` VALUES (12, 'START TRANSACTIO2', 22, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
INSERT INTO `person` VALUES (14, 'shiwu1', 18, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
INSERT INTO `person` VALUES (15, 'ts12', 31, '2022-03-09 19:54:11', '2022-03-01 10:36:48');
INSERT INTO `person` VALUES (16, 'shiwu_COMMIT', 13, '2022-03-09 19:54:11', '2022-03-01 10:36:48');

SET FOREIGN_KEY_CHECKS = 1;


-- age
-- 
-- 2
-- 6
-- 7
-- 10
-- 13
-- 15
-- 16
-- 18
-- 20
-- 22
-- 27
-- 31

-- 查看数据锁 https://dev.mysql.com/doc/mysql-perfschema-excerpt/8.0/en/performance-schema-data-locks-table.html
select * from performance_schema.data_locks
where index_name='index_age'




SELECT * FROM `person` for update;

INSERT INTO `person` (`name`,age,`birthday`,`update_time`) VALUES ( 'fancky', 15, '2022-04-13 19:54:11', '2022-04-19 10:36:48');

INSERT INTO `person` (`name`,age,`birthday`,`update_time`) VALUES ( 'fancky', 21, '2022-04-13 19:54:11', '2022-04-19 10:36:48');


INSERT INTO `person` (`name`,age,`birthday`,`update_time`) VALUES ( 'fancky', 22, '2022-04-13 19:54:11', '2022-04-19 10:36:48');


INSERT INTO `person` (`name`,age,`birthday`,`update_time`) VALUES ( 'fancky', 26, '2022-04-13 19:54:11', '2022-04-19 10:36:48');


INSERT INTO `person`  (`name`,age,`birthday`,`update_time`)VALUES( 'fancky', 27, '2022-04-13 19:54:11', '2022-04-19 10:36:48');



INSERT INTO `person`  (`name`,age,`birthday`,`update_time`)VALUES( 'fancky', 28, '2022-04-13 19:54:11', '2022-04-19 10:36:48');



INSERT INTO `person`  (`name`,age,`birthday`,`update_time`)VALUES( 'fancky', 31, '2022-04-13 19:54:11', '2022-04-19 10:36:48');


INSERT INTO `person`  (`name`,age,`birthday`,`update_time`)VALUES( 'fancky', 32, '2022-04-13 19:54:11', '2022-04-19 10:36:48');



UPDATE person SET name='gap_lock_test1' WHERE id=7;





