CREATE TABLE `person` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `demo`.`person` (`name`, `age`, `birthday`) VALUES ( 'fancky', 31, '2022-08-24 02:00:14');

create INDEX person_age on person (age);

-- show index  from person;

CREATE TABLE `demo_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `guid` varchar(36) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_style` varchar(255) DEFAULT NULL,
  `image_path` varchar(500) DEFAULT NULL,
  `create_time` datetime(3) DEFAULT NULL,
  `modify_time` datetime(3) DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=301011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




  INSERT INTO `demo`.`demo_product` ( `guid`, `product_name`, `product_style`, `image_path`, `create_time`, `modify_time`, `status`, `description`, `timestamp`) VALUES ( 'd006c24a-0a9c-436b-8bdb-9e5835e351db', 'product_name7', 'productStyle6', 'D:\\fancky\\git\\Doc', '2022-12-17 05:22:14.603', '2022-12-17 05:22:14.603', 1, 'setDescription_sdsdddddddddddddddd', '2022-12-17 05:22:15');
