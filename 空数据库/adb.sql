/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : adb

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-07-12 19:09:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for a1
-- ----------------------------
DROP TABLE IF EXISTS `a1`;
CREATE TABLE `a1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zhanghao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rmb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shifoulingqu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shijian` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of a1
-- ----------------------------

-- ----------------------------
-- Table structure for a2
-- ----------------------------
DROP TABLE IF EXISTS `a2`;
CREATE TABLE `a2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zhanghao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rmb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shifoulingqu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shijian` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of a2
-- ----------------------------

-- ----------------------------
-- Table structure for a3
-- ----------------------------
DROP TABLE IF EXISTS `a3`;
CREATE TABLE `a3` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zhanghao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rmb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shifoulingqu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shijian` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of a3
-- ----------------------------

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `sid` int(8) NOT NULL AUTO_INCREMENT,
  `account` varchar(32) NOT NULL DEFAULT '0',
  `pwd` varchar(32) NOT NULL DEFAULT '0',
  `safe` varchar(32) NOT NULL DEFAULT '0',
  `cookie` varchar(32) NOT NULL DEFAULT '0',
  `yaoqingma` varchar(11) NOT NULL DEFAULT '0',
  `erjimima` varchar(255) NOT NULL DEFAULT '0',
  `regist_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `quanxian` int(11) NOT NULL DEFAULT '0',
  `ban` int(11) NOT NULL DEFAULT '0',
  `mac` varchar(255) DEFAULT NULL,
  `pwds` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`) USING BTREE,
  UNIQUE KEY `account` (`account`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=472352 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES ('472346', '726816958', 'e10adc3949ba59abbe56e057f20f883e', 'b59c61d241c1e5671772805f40989f28', 'eafa9ce596c00e6921fcd29274d0f028', 'A100', '123456', '2021-07-06 12:15:19', '0', '0', '00:DB:B6:92:BB:D7|358523024473679|0046605a|b291f0fbdb57e463', null);
INSERT INTO `accounts` VALUES ('472347', 'a726816958', 'e10adc3949ba59abbe56e057f20f883e', '0e8d4cbe5051ac5a6ceb9bcb2f50279f', 'defa8301d9896e63581f7899115fdcd1', 'A1', '123456', '2021-06-29 18:59:48', '0', '0', '00:DB:B6:92:BB:D7|358523024473679|0046605a|b291f0fbdb57e463', null);
INSERT INTO `accounts` VALUES ('472348', '1000004', 'e10adc3949ba59abbe56e057f20f883e', '0e8d4cbe5051ac5a6ceb9bcb2f50279f', '8d79aa1bc6df733fb82d3160961d19a7', 'A1', '123456', '2021-06-20 09:10:12', '0', '0', '00:DB:05:E3:6B:8F|863342027371964|001eb02b|479bfa729cf0118e', null);
INSERT INTO `accounts` VALUES ('472349', 'c726816958', 'e10adc3949ba59abbe56e057f20f883e', '0e8d4cbe5051ac5a6ceb9bcb2f50279f', '1ac68516fbb51a4fc2cd2b4d460d727a', 'A1', '123456', '2021-07-06 12:24:32', '0', '0', '00:DB:DA:AF:88:4C|010045021543379|00dd5367|0652cc57b58a2260', null);
INSERT INTO `accounts` VALUES ('472350', 'V726816958', 'e10adc3949ba59abbe56e057f20f883e', 'c5e812a5770fdbf7330258d5d5387b8d', '522d30037388a7cd9d5202a8c6b258e4', 'A20', '123456', '2021-07-06 18:33:04', '0', '0', null, null);
INSERT INTO `accounts` VALUES ('472351', 'b726816958', 'e10adc3949ba59abbe56e057f20f883e', '6408a74096f85eb029e087af761b4fdd', '8d79aa1bc6df733fb82d3160961d19a7', 'A1', '123456', '2021-07-07 09:46:48', '0', '0', '00:DB:9C:38:58:C2|010305025373375|005383f0|08736a9535eae851', null);

-- ----------------------------
-- Table structure for charge
-- ----------------------------
DROP TABLE IF EXISTS `charge`;
CREATE TABLE `charge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL,
  `coin` int(11) NOT NULL,
  `money` int(11) DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '0:已充值未领取 1:已充值已领取',
  `add_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of charge
-- ----------------------------

-- ----------------------------
-- Table structure for yuanbao
-- ----------------------------
DROP TABLE IF EXISTS `yuanbao`;
CREATE TABLE `yuanbao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zhanghao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rmb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shifoulingqu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shijian` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of yuanbao
-- ----------------------------
INSERT INTO `yuanbao` VALUES ('6', 'c726816958', '100', '1', '2021-07-06 12:23:53');

-- ----------------------------
-- Table structure for zhucema
-- ----------------------------
DROP TABLE IF EXISTS `zhucema`;
CREATE TABLE `zhucema` (
  `ma` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `acc` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhucema
-- ----------------------------
INSERT INTO `zhucema` VALUES ('A1', 'A1', '123456');
INSERT INTO `zhucema` VALUES ('A2', 'A2', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A3', 'A3', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A4', 'A4', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A5', 'A5', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A6', 'A6', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A7', 'A7', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A8', 'A8', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A9', 'A9', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A10', 'A10', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A11', 'A11', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A12', 'A12', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A13', 'A13', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A14', 'A14', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A15', 'A15', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A16', 'A16', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A17', 'A17', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A18', 'A18', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A19', 'A19', '写代理查询密码');
INSERT INTO `zhucema` VALUES ('A20', 'A20', '写代理查询密码');
