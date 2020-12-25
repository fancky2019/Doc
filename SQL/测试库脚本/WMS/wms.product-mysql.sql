/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : demo

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 21/12/2020 14:39:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `ID` int NULL DEFAULT NULL,
  `GUID` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `StockID` int NULL DEFAULT NULL,
  `BarCodeID` int NULL DEFAULT NULL,
  `SkuID` int NULL DEFAULT NULL,
  `ProductName` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ProductStyle` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Price` double NULL DEFAULT NULL,
  `CreateTime` timestamp NULL DEFAULT NULL,
  `Status` smallint NULL DEFAULT NULL,
  `Count` int NULL DEFAULT NULL,
  `ModifyTime` timestamp NULL DEFAULT NULL,
  `TimeStamp` blob NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, '{23919DA1-DE7F-49F0-912D-D4E06A212CAA}', NULL, NULL, 0, 'ProductName', 'ProductStyle', 57.21, '2020-12-21 14:25:24', 1, 1000, '2020-12-21 14:25:24', 0x00000000000007D1);

SET FOREIGN_KEY_CHECKS = 1;
