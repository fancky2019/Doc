

CREATE TABLE `person` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;












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
  `price` decimal(10,2) DEFAULT NULL,
  `count` bigint DEFAULT NULL,
  `produce_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;