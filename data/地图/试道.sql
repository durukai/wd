/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : db

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-03-23 21:55:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for 试道
-- ----------------------------
DROP TABLE IF EXISTS `试道`;
CREATE TABLE `试道` (
  `id` int(11) NOT NULL,
  `领取` int(11) DEFAULT NULL,
  `日期` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
