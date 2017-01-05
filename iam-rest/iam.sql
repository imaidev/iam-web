/*
Navicat MySQL Data Transfer

Source Server         : 10.110.13.147
Source Server Version : 50547
Source Host           : 10.110.13.147:3306
Source Database       : iam

Target Server Type    : MYSQL
Target Server Version : 50547
File Encoding         : 65001

Date: 2017-01-05 11:08:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `accountPwd` varchar(255) DEFAULT NULL,
  `accountStatus` char(16) NOT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `passwordModifiedAt` char(32) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  `cloudDirectory` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_email` (`email`,`cloudDirectory`,`tenant`) USING BTREE,
  UNIQUE KEY `index_username` (`userName`,`cloudDirectory`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('0jxyzoXNS4SjMCDBuPQPrQ', '/v1/accounts/0jxyzoXNS4SjMCDBuPQPrQ', '123456789@qq.com', '账号 A', '123', 'Enabled', '2016-12-13 19:30:37.249', '2016-12-13 19:30:37.249', '2016-12-13 19:30:37.249', '4Ew8Yn7eQVi8hLPLWQpfCg', '6C-ehBlpQ4es3d-DCQP9Cw', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account` VALUES ('D8vaurVKQZa6r_zHklHjeQ', '/v1/accounts/D8vaurVKQZa6r_zHklHjeQ', 'adf', 'adf', '123', 'Enabled', '2016-12-09 11:25:54.666', '2016-12-09 11:25:54.666', '2016-12-09 11:25:54.666', '8JAlt3DdRhid-Sy3SnxiRw', '2O8Wkb8XQmCFoQTAtVOCdQ', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `account` VALUES ('gSLoKfDwTzqpmVZteYL7vA', '/v1/accounts/gSLoKfDwTzqpmVZteYL7vA', '4321432@qq.com', 'at1555', '123', 'Enabled', '2016-12-09 11:34:40.013', '2016-12-09 11:34:40.013', '2016-12-09 11:34:40.013', '6zTEekipTAu_8c6SQMLVLg', '2O8Wkb8XQmCFoQTAtVOCdQ', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `account` VALUES ('QtAvCv1sQp2kQzh5U2Ngqw', '/v1/accounts/QtAvCv1sQp2kQzh5U2Ngqw', 'test01@163.com', 'test01', 'test', 'enabled', '2016-12-09 14:48:31.267', '2016-12-09 14:48:31.267', '2016-12-09 14:48:31.267', 'ip1_XjeESQacS5vsX70q4A', '68DTMKYoRveuq-sbqhyVIA', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account` VALUES ('S7l8vuCHTT-zy8vwG530ww', '/v1/accounts/S7l8vuCHTT-zy8vwG530ww', '123@qq.com', '123@qq.com', '123', 'enabled', '2016-11-24 13:57:22.600', '2016-11-24 13:57:22.600', '2016-11-24 13:57:22.600', '8suGzG7BQaWjjRjk8sA3Zw', 'M_ACh3j-SQOiOw0t7HJk9w', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `account` VALUES ('Whlh038oSeytf8Yc1rt73A', '/v1/accounts/Whlh038oSeytf8Yc1rt73A', '654321231@qq.com', 'test01', '1234', 'Enabled', '2016-12-13 19:24:23.206', '2016-12-13 19:24:23.206', '2016-12-13 19:24:23.206', 'rNXTNYH8TqCm2Qr2a7i6wg', '6C-ehBlpQ4es3d-DCQP9Cw', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account` VALUES ('__dbfrQHR3CGFm9PfQyAlQ', '/v1/accounts/__dbfrQHR3CGFm9PfQyAlQ', '123456@qq.com', '123456@qq.com', '123456', 'enabled', '2016-11-24 11:04:17.790', '2016-11-24 11:04:17.790', '2016-11-24 11:04:17.790', 'Df0Pd36NQyiNLIM5fxQjlA', 'M_ACh3j-SQOiOw0t7HJk9w', 'akIH-IAAQM6LGenqbA4TIQ');

-- ----------------------------
-- Table structure for account_creation_policy
-- ----------------------------
DROP TABLE IF EXISTS `account_creation_policy`;
CREATE TABLE `account_creation_policy` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `verificationEmailStatus` char(16) DEFAULT NULL,
  `verificationSuccessEmailStatus` char(16) DEFAULT NULL,
  `welcomeEmailStatus` char(16) DEFAULT NULL,
  `emailDomainWhitelist` varchar(255) DEFAULT NULL,
  `emailDomainBlacklist` varchar(255) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_creation_policy
-- ----------------------------

-- ----------------------------
-- Table structure for account_link
-- ----------------------------
DROP TABLE IF EXISTS `account_link`;
CREATE TABLE `account_link` (
  `id` char(22) NOT NULL,
  `href` varchar(255) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `leftAccount` char(22) DEFAULT NULL,
  `rightAccount` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_link
-- ----------------------------
INSERT INTO `account_link` VALUES ('zPLeIE6rQ3-RnQjRczMvyQ', '/v1/accountLinks/zPLeIE6rQ3-RnQjRczMvyQ', '2016-11-24 14:04:29.569', '2016-11-24 14:04:29.569', 'S7l8vuCHTT-zy8vwG530ww', '__dbfrQHR3CGFm9PfQyAlQ', 'akIH-IAAQM6LGenqbA4TIQ');

-- ----------------------------
-- Table structure for account_store_mapping
-- ----------------------------
DROP TABLE IF EXISTS `account_store_mapping`;
CREATE TABLE `account_store_mapping` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `listIndex` int(11) DEFAULT NULL,
  `isDefaultAccountStore` char(16) DEFAULT NULL,
  `isDefaultGroupStore` char(16) DEFAULT NULL,
  `application` char(22) DEFAULT NULL,
  `storeType` char(22) DEFAULT NULL,
  `accountStore` char(22) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_app_account` (`application`,`accountStore`,`storeType`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_store_mapping
-- ----------------------------
INSERT INTO `account_store_mapping` VALUES ('2oNmd2pMSSSiYuMOazNv1w', '/v1/accountStoreMappings/2oNmd2pMSSSiYuMOazNv1w', '10', 'false', 'false', 'k7pFWSUaSDSrpDonrEszKQ', 'group', 'px-D33f6RziYd68MZOz4Kw', '2016-11-24 11:07:30.147', '2016-11-24 11:07:30.147', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `account_store_mapping` VALUES ('Cs6fvqttR2GG3rZysS9rOA', '/v1/accountStoreMappings/Cs6fvqttR2GG3rZysS9rOA', '1', 'false', 'false', 'AorQEPNjTQS1NfWUUh4b1A', 'directory', '68DTMKYoRveuq-sbqhyVIA', '2016-12-14 14:35:44.557', '2016-12-14 14:35:44.557', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account_store_mapping` VALUES ('gFibyQC5R4iuR3xVxrhYSg', '/v1/accountStoreMappings/gFibyQC5R4iuR3xVxrhYSg', '10', 'false', 'false', 'JxKeLNjRReetoTnei2KHMQ', 'directory', 'thBnX77CQayKxfok1pgaSA', '2016-12-05 11:21:56.817', '2016-12-05 11:21:56.817', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `account_store_mapping` VALUES ('LJ5dCWVwQ1-eLPmgM22Eiw', '/v1/accountStoreMappings/LJ5dCWVwQ1-eLPmgM22Eiw', '2', 'false', 'false', 'AorQEPNjTQS1NfWUUh4b1A', 'directory', '6C-ehBlpQ4es3d-DCQP9Cw', '2016-12-14 14:37:05.315', '2016-12-14 14:37:05.315', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account_store_mapping` VALUES ('nX_1NBMTQl6tUhV6O7k8sA', '/v1/accountStoreMappings/nX_1NBMTQl6tUhV6O7k8sA', '3', 'false', 'false', 'AorQEPNjTQS1NfWUUh4b1A', 'group', '_ZpCJEarSD6oYGLunpySqQ', '2016-12-14 14:37:31.022', '2016-12-14 14:37:31.022', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account_store_mapping` VALUES ('o4RCoxjFTq-SIxH-IwIjxA', '/v1/accountStoreMappings/o4RCoxjFTq-SIxH-IwIjxA', '10', 'false', 'false', 'DbDAlOrIQBGBtgwfepdqEA', 'directory', 'ax4VYYEQSaijCrFK1VihUw', '2016-12-09 14:50:02.360', '2016-12-09 14:50:02.360', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account_store_mapping` VALUES ('pXkk9nPHQJeXwQ7W42qEug', '/v1/accountStoreMappings/pXkk9nPHQJeXwQ7W42qEug', '10', 'false', 'false', 'm0sFsZC0RQqKLbWmWLIPLA', 'directory', 'TdXHov8zSPC7tFXf2Rhi5Q', '2016-12-06 11:23:33.894', '2016-12-06 11:23:33.894', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `account_store_mapping` VALUES ('qC6GmIzhQ4yU5GCYuOtcRg', '/v1/accountStoreMappings/qC6GmIzhQ4yU5GCYuOtcRg', '4', 'false', 'false', 'AorQEPNjTQS1NfWUUh4b1A', 'organization', 'A6a5o1HTSLSSH6giDdjy_w', '2016-12-14 14:37:44.637', '2016-12-14 14:37:44.637', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account_store_mapping` VALUES ('ttGp6K1OR1KAjug2j_rqGg', '/v1/accountStoreMappings/ttGp6K1OR1KAjug2j_rqGg', '10', 'false', 'false', 'A2mzIgyJRj-tVZsc5Y3_iA', 'directory', 'FeNskoLHTZ-1AkuiPLfdoA', '2016-12-06 09:57:39.671', '2016-12-06 09:57:39.671', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `account_store_mapping` VALUES ('ZZC2sSA5R7eoHyG-tTTdfg', '/v1/accountStoreMappings/ZZC2sSA5R7eoHyG-tTTdfg', '10', 'false', 'false', 'nnwpouLzSLCZQhd4rY86Wg', 'directory', '68DTMKYoRveuq-sbqhyVIA', '2016-12-09 14:48:31.261', '2016-12-09 14:48:31.261', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `account_store_mapping` VALUES ('_qtVP1QkRq2SBV70iZVRnw', '/v1/accountStoreMappings/_qtVP1QkRq2SBV70iZVRnw', '10', 'false', 'false', 'AorQEPNjTQS1NfWUUh4b1A', 'directory', '78gReuiLRma3IgWE1gJPyQ', '2016-12-09 14:49:55.808', '2016-12-09 14:49:55.808', 'vKVLdcpWT9iT8mUiVV3cew');

-- ----------------------------
-- Table structure for apikey
-- ----------------------------
DROP TABLE IF EXISTS `apikey`;
CREATE TABLE `apikey` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `akid` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `akName` varchar(255) DEFAULT NULL,
  `akDes` varchar(255) DEFAULT NULL,
  `akStatus` char(16) NOT NULL,
  `account` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_akid_secret` (`akid`,`secret`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of apikey
-- ----------------------------
INSERT INTO `apikey` VALUES ('1qZlNBjNT0K3VGkAKpUmHg', '/v1/apiKeys/1qZlNBjNT0K3VGkAKpUmHg', 'dh4BDDcKqzaorD3Bz6R21Q', 'Or3Pl3KSsq7r3SlugRNL76uWBzcXe7j3Z0NaY1YpKUI', null, null, 'enabled', 'S7l8vuCHTT-zy8vwG530ww', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `apikey` VALUES ('tspBfJIvSiaXPTzaau3SrQ', '/v1/apiKeys/tspBfJIvSiaXPTzaau3SrQ', 'hygnzMy2F1K-5WMQ4aonew', 'CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ', null, null, 'enabled', 'S7l8vuCHTT-zy8vwG530ww', 'akIH-IAAQM6LGenqbA4TIQ');

-- ----------------------------
-- Table structure for application
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `appName` varchar(255) DEFAULT NULL,
  `appDes` varchar(512) DEFAULT NULL,
  `appStatus` char(16) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `defaultAccountStoreMapping` char(22) DEFAULT NULL,
  `defaultGroupStoreMapping` char(22) DEFAULT NULL,
  `oAuthPolicy` char(22) DEFAULT NULL,
  `samlPolicy` char(22) DEFAULT NULL,
  `authorizedCallbackUris` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_appname` (`appName`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of application
-- ----------------------------
INSERT INTO `application` VALUES ('2yN7DmbwS3WsmtgyIFqQtg', '/v1/applications/2yN7DmbwS3WsmtgyIFqQtg', 'app03', '', 'enabled', 'RfsnjPNaTOCc9Ektl8ad5A', 'akIH-IAAQM6LGenqbA4TIQ', '2016-12-06 10:00:05.820', '2016-12-06 10:00:05.820', null, null, null, null, null);
INSERT INTO `application` VALUES ('8MqY9FZJQjGIZi2T_U1EHQ', '/v1/applications/8MqY9FZJQjGIZi2T_U1EHQ', 'dir01', '', 'enabled', 'LknHN2i4Ssyt3yCiWf0VAA', 'Y4uGIW1KR6qVKgA3hhWYEw', '2016-12-08 14:39:51.901', '2016-12-08 14:39:51.901', null, null, null, null, null);
INSERT INTO `application` VALUES ('A2mzIgyJRj-tVZsc5Y3_iA', '/v1/applications/A2mzIgyJRj-tVZsc5Y3_iA', 'app02', '', 'enabled', 'M97sWjJVRmegSYSfrhHXRQ', 'akIH-IAAQM6LGenqbA4TIQ', '2016-12-06 09:57:39.624', '2016-12-06 09:57:39.624', null, null, null, null, null);
INSERT INTO `application` VALUES ('AorQEPNjTQS1NfWUUh4b1A', '/v1/applications/AorQEPNjTQS1NfWUUh4b1A', 'app002', '', 'enabled', 'SNU7km8RRZKTbkwFIr5BTw', 'vKVLdcpWT9iT8mUiVV3cew', '2016-12-09 14:49:55.555', '2016-12-13 17:32:40.457', null, null, null, null, null);
INSERT INTO `application` VALUES ('DbDAlOrIQBGBtgwfepdqEA', '/v1/applications/DbDAlOrIQBGBtgwfepdqEA', 'app03', '', 'enabled', 'OLu4nROARj6HwKFItxde8Q', 'vKVLdcpWT9iT8mUiVV3cew', '2016-12-09 14:50:02.352', '2016-12-09 14:50:02.352', null, null, null, null, null);
INSERT INTO `application` VALUES ('JxKeLNjRReetoTnei2KHMQ', '/v1/applications/JxKeLNjRReetoTnei2KHMQ', 'IAM Admin', '', 'enabled', 'JG3dSZHYRTuZdwRxQw3Vjg', 'Y4uGIW1KR6qVKgA3hhWYEw', '2016-12-05 11:21:56.806', '2016-12-05 11:21:56.806', null, null, null, null, null);
INSERT INTO `application` VALUES ('k7pFWSUaSDSrpDonrEszKQ', '/v1/applications/k7pFWSUaSDSrpDonrEszKQ', 'app01', '', 'enabled', '81RceMzxRwOs13DRkib_VQ', 'akIH-IAAQM6LGenqbA4TIQ', '2016-11-24 10:57:36.580', '2016-12-05 15:14:52.959', null, null, null, null, null);
INSERT INTO `application` VALUES ('l43kOyWiTQCTUc0fUbAkkg', '/v1/applications/l43kOyWiTQCTUc0fUbAkkg', 'app06', '', 'enabled', 'WRzYoqX5S0SDBvUSOy8sFw', 'Y4uGIW1KR6qVKgA3hhWYEw', '2016-12-06 11:23:44.613', '2016-12-06 11:23:44.613', null, null, null, null, null);
INSERT INTO `application` VALUES ('nnwpouLzSLCZQhd4rY86Wg', '/v1/applications/nnwpouLzSLCZQhd4rY86Wg', 'IAM Admin', '', 'enabled', 'E4mclt-xQE2jYUrtJ8Zb2Q', 'vKVLdcpWT9iT8mUiVV3cew', '2016-12-09 14:48:31.247', '2016-12-09 14:48:31.247', null, null, null, null, null);
INSERT INTO `application` VALUES ('wK2qgKtyTZWQzWnSubtZDw', '/v1/applications/wK2qgKtyTZWQzWnSubtZDw', 'app07', 'miaoshu123123', 'enabled', '3JEuV3-gSEqYiwpXrfjODw', 'Y4uGIW1KR6qVKgA3hhWYEw', '2016-12-07 09:41:21.498', '2016-12-07 15:59:10.055', null, null, null, null, null);

-- ----------------------------
-- Table structure for cloud_directory
-- ----------------------------
DROP TABLE IF EXISTS `cloud_directory`;
CREATE TABLE `cloud_directory` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `directoryName` varchar(255) DEFAULT NULL,
  `directoryDes` varchar(512) DEFAULT NULL,
  `directoryStatus` char(16) NOT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `providerType` char(16) DEFAULT NULL,
  `providerId` char(22) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  `passwordPolicy` char(22) DEFAULT NULL,
  `accountCreationPolicy` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_directory` (`directoryName`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_directory
-- ----------------------------
INSERT INTO `cloud_directory` VALUES ('2O8Wkb8XQmCFoQTAtVOCdQ', '/v1/directories/2O8Wkb8XQmCFoQTAtVOCdQ', 'app02', '', 'enabled', '2016-12-07 08:57:28.651', '2016-12-07 08:57:28.651', 'cloud', '', '0fhTDi8eRaOogQ8hcS64JA', 'Y4uGIW1KR6qVKgA3hhWYEw', null, null);
INSERT INTO `cloud_directory` VALUES ('68DTMKYoRveuq-sbqhyVIA', '/v1/directories/68DTMKYoRveuq-sbqhyVIA', 'IAM Admin Directory', '', 'enabled', '2016-12-09 14:48:31.255', '2016-12-09 14:48:31.255', 'cloud', 'jcFA8DY-RPuk_dqQf-1XSg', 'JbgiU4m1SUCHKYPAnQ1QwQ', 'vKVLdcpWT9iT8mUiVV3cew', null, null);
INSERT INTO `cloud_directory` VALUES ('6C-ehBlpQ4es3d-DCQP9Cw', '/v1/directories/6C-ehBlpQ4es3d-DCQP9Cw', 'GitHub03', '测试id/secret', 'enabled', '2016-12-12 16:35:45.904', '2016-12-12 16:35:45.904', 'GitHub', '-cf71jfrQGOW2UoqQNTZMQ', 'AWn-b3a6TSudVZ_3a4pKKw', 'vKVLdcpWT9iT8mUiVV3cew', null, null);
INSERT INTO `cloud_directory` VALUES ('78gReuiLRma3IgWE1gJPyQ', '/v1/directories/78gReuiLRma3IgWE1gJPyQ', 'app002', '', 'enabled', '2016-12-09 14:49:55.803', '2016-12-09 14:49:55.803', 'cloud', 'H6MDtl0cSamXRATe4LbT0g', 'x2Qw1uQhQBGlOk-wG4H6-g', 'vKVLdcpWT9iT8mUiVV3cew', null, null);
INSERT INTO `cloud_directory` VALUES ('ax4VYYEQSaijCrFK1VihUw', '/v1/directories/ax4VYYEQSaijCrFK1VihUw', 'app03', '', 'enabled', '2016-12-09 14:50:02.357', '2016-12-09 14:50:02.357', 'cloud', 'Ud2AvywRQeOZa13vY1y3hw', 'T25mNtlASK6HQs_8WXMJIw', 'vKVLdcpWT9iT8mUiVV3cew', null, null);
INSERT INTO `cloud_directory` VALUES ('FeNskoLHTZ-1AkuiPLfdoA', '/v1/directories/FeNskoLHTZ-1AkuiPLfdoA', 'true', '', 'enabled', '2016-12-06 09:57:39.658', '2016-12-06 09:57:39.658', 'cloud', null, 'Go_NeAghTR2iO_s175SVpw', 'akIH-IAAQM6LGenqbA4TIQ', null, null);
INSERT INTO `cloud_directory` VALUES ('i37cBwsmSJW3TGFInt-AYg', '/v1/directories/i37cBwsmSJW3TGFInt-AYg', 'github01', 'GitHub01 测试是否数据插入Provider表', 'enabled', '2016-12-12 15:43:48.056', '2016-12-12 15:43:48.056', 'GitHub', 'NK-57guWTeCaa3hhgBg5Vw', 'qYlThtsCSsGWF7Ft5DJWog', 'vKVLdcpWT9iT8mUiVV3cew', null, null);
INSERT INTO `cloud_directory` VALUES ('ixz5Th3rREKUsfPwKLFLHQ', '/v1/directories/ixz5Th3rREKUsfPwKLFLHQ', 'GitHub02', '添加clientId,clientSecret', 'enabled', '2016-12-12 16:33:14.148', '2016-12-12 16:33:14.148', 'GitHub', 'trsMrvx_QQqRdxb-2RqLig', 'x2YS1sK-SAmQw50ClvfEsw', 'vKVLdcpWT9iT8mUiVV3cew', null, null);
INSERT INTO `cloud_directory` VALUES ('lmX7O21PQp217EbPgtPxVA', '/v1/directories/lmX7O21PQp217EbPgtPxVA', 'dir02', '', 'disabled', '2016-12-08 13:54:19.888', '2016-12-08 13:54:19.888', 'Google', 'CVr0PXI1TY2tAI6EpxVxpA', 'CdMHZr2sSyWJUfs-ajmZZg', 'Y4uGIW1KR6qVKgA3hhWYEw', null, null);
INSERT INTO `cloud_directory` VALUES ('M_ACh3j-SQOiOw0t7HJk9w', '/v1/directories/M_ACh3j-SQOiOw0t7HJk9w', 'dir01', '', 'enabled', '2016-11-24 10:58:14.901', '2016-11-24 10:58:14.901', 'cloud', null, 'Q5BmRQieRmqoVYMj5Ea43A', 'akIH-IAAQM6LGenqbA4TIQ', null, null);
INSERT INTO `cloud_directory` VALUES ('r19tssPgQySRv4JJdCerDA', '/v1/directories/r19tssPgQySRv4JJdCerDA', 'dir04', '', 'enabled', '2016-12-08 16:24:29.839', '2016-12-08 16:24:29.839', 'GitHub', 'hKyLybe4TYuBVppYalTGhw', 'PuoO4SoWRAOMkLoh1SfaOg', 'Y4uGIW1KR6qVKgA3hhWYEw', null, null);
INSERT INTO `cloud_directory` VALUES ('thBnX77CQayKxfok1pgaSA', '/v1/directories/thBnX77CQayKxfok1pgaSA', 'IAM Admin Directory', '', 'enabled', '2016-12-05 11:21:56.811', '2016-12-05 11:21:56.811', 'cloud', null, 'OTemHzXPQtajyCDuQ-oTEA', 'Y4uGIW1KR6qVKgA3hhWYEw', null, null);
INSERT INTO `cloud_directory` VALUES ('TIMKyuViShGVqZPWiCjadQ', '/v1/directories/TIMKyuViShGVqZPWiCjadQ', 'dir03', '', 'enabled', '2016-12-08 14:54:44.807', '2016-12-08 14:54:44.807', 'cloud', 'uxD4fCqpTC-q2B9J5KXWBw', 'NUyRO783RSm8-ZVAsYrc3A', 'Y4uGIW1KR6qVKgA3hhWYEw', null, null);

-- ----------------------------
-- Table structure for cloud_group
-- ----------------------------
DROP TABLE IF EXISTS `cloud_group`;
CREATE TABLE `cloud_group` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `groupName` varchar(255) DEFAULT NULL,
  `groupDes` varchar(512) DEFAULT NULL,
  `groupStatus` varchar(16) NOT NULL,
  `cloudDirectory` varchar(255) DEFAULT NULL,
  `tenant` varchar(255) DEFAULT NULL,
  `customData` varchar(255) DEFAULT NULL,
  `createdAt` varchar(32) DEFAULT NULL,
  `modifiedAt` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_group` (`groupName`,`cloudDirectory`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_group
-- ----------------------------
INSERT INTO `cloud_group` VALUES ('IdG_fRcDT3OKyGIuQHw1pQ', '/v1/groups/IdG_fRcDT3OKyGIuQHw1pQ', 'group02', '', 'enabled', '2O8Wkb8XQmCFoQTAtVOCdQ', 'Y4uGIW1KR6qVKgA3hhWYEw', 'E8Yvafy9SImE2PH-4RuxMA', '2016-12-08 16:48:39.409', '2016-12-08 16:48:39.409');
INSERT INTO `cloud_group` VALUES ('px-D33f6RziYd68MZOz4Kw', '/v1/groups/px-D33f6RziYd68MZOz4Kw', 'group01', '', 'enabled', 'M_ACh3j-SQOiOw0t7HJk9w', 'akIH-IAAQM6LGenqbA4TIQ', 'o0jkJ8keQ7GAQRkBYiJC5g', '2016-11-24 11:01:10.988', '2016-11-24 11:01:10.988');
INSERT INTO `cloud_group` VALUES ('qIlhGdtGT82mAFmuCsT9_w', '/v1/groups/qIlhGdtGT82mAFmuCsT9_w', 'group01', '', 'enabled', 'lmX7O21PQp217EbPgtPxVA', 'Y4uGIW1KR6qVKgA3hhWYEw', 'qC0rVEsUQOytGJWeER1ufA', '2016-12-08 16:51:41.511', '2016-12-08 16:51:41.511');
INSERT INTO `cloud_group` VALUES ('TTOqJVklQZ6XmAEXyHiPiQ', '/v1/groups/TTOqJVklQZ6XmAEXyHiPiQ', '小组之外', '', 'enabled', 'ixz5Th3rREKUsfPwKLFLHQ', 'vKVLdcpWT9iT8mUiVV3cew', 'TvfDyzWZS6ani9Y4ioaHxQ', '2016-12-14 15:38:51.168', '2016-12-14 15:38:51.168');
INSERT INTO `cloud_group` VALUES ('vA7ezrD6Q_SDG6R38TERDQ', '/v1/groups/vA7ezrD6Q_SDG6R38TERDQ', '第一小组', '小组A', 'enabled', '68DTMKYoRveuq-sbqhyVIA', 'vKVLdcpWT9iT8mUiVV3cew', 'h9JFHInnQOyuLgMNmWGDSg', '2016-12-13 16:45:38.504', '2016-12-13 16:45:38.504');
INSERT INTO `cloud_group` VALUES ('_ZpCJEarSD6oYGLunpySqQ', '/v1/groups/_ZpCJEarSD6oYGLunpySqQ', '组B', '新增组', 'disabled', '6C-ehBlpQ4es3d-DCQP9Cw', 'vKVLdcpWT9iT8mUiVV3cew', 'C79-kJZRRJOrFw41ytPNNA', '2016-12-13 18:28:15.516', '2016-12-13 18:28:15.516');

-- ----------------------------
-- Table structure for customdata
-- ----------------------------
DROP TABLE IF EXISTS `customdata`;
CREATE TABLE `customdata` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `data` varchar(4096) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customdata
-- ----------------------------
INSERT INTO `customdata` VALUES ('0fhTDi8eRaOogQ8hcS64JA', '/v1/directories/2O8Wkb8XQmCFoQTAtVOCdQ/customData', null, '2016-12-07 08:57:28.651', '2016-12-07 08:57:28.651', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('3JEuV3-gSEqYiwpXrfjODw', '/v1/applications/wK2qgKtyTZWQzWnSubtZDw/customData', null, '2016-12-07 09:41:21.499', '2016-12-07 09:41:21.499', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('4Ew8Yn7eQVi8hLPLWQpfCg', '/v1/accounts/0jxyzoXNS4SjMCDBuPQPrQ/customData', null, '2016-12-13 19:30:37.249', '2016-12-13 19:30:37.249', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('6zTEekipTAu_8c6SQMLVLg', '/v1/accounts/gSLoKfDwTzqpmVZteYL7vA/customData', null, '2016-12-09 11:34:40.013', '2016-12-09 11:34:40.013', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('81RceMzxRwOs13DRkib_VQ', '/v1/applications/k7pFWSUaSDSrpDonrEszKQ/customData', null, '2016-11-24 10:57:36.582', '2016-11-24 10:57:36.582', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('8JAlt3DdRhid-Sy3SnxiRw', '/v1/accounts/D8vaurVKQZa6r_zHklHjeQ/customData', null, '2016-12-09 11:25:54.666', '2016-12-09 11:25:54.666', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('8suGzG7BQaWjjRjk8sA3Zw', '/v1/accounts/S7l8vuCHTT-zy8vwG530ww/customData', null, '2016-11-24 13:57:22.603', '2016-11-24 13:57:22.603', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('AAsgZ6BaRhW3ohtB8Keo5A', '/v1/organizations/A6a5o1HTSLSSH6giDdjy_w/customData', null, '2016-12-13 16:16:59.971', '2016-12-13 16:16:59.971', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('AJft2RW1TEilr3e238u3Tg', '/v1/applications/m0sFsZC0RQqKLbWmWLIPLA/customData', null, '2016-12-06 11:23:33.885', '2016-12-06 11:23:33.885', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('aldWXQTRSpa3V9gTae_EqA', '/v1/organizations/KdXTo0ISRkqERqwfK3RJRA/customData', null, '2016-12-08 09:03:16.024', '2016-12-08 09:03:16.024', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('AWn-b3a6TSudVZ_3a4pKKw', '/v1/directories/6C-ehBlpQ4es3d-DCQP9Cw/customData', null, '2016-12-12 16:35:45.909', '2016-12-12 16:35:45.909', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('C79-kJZRRJOrFw41ytPNNA', '/v1/groups/_ZpCJEarSD6oYGLunpySqQ/customData', null, '2016-12-13 18:28:15.516', '2016-12-13 18:28:15.516', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('CdMHZr2sSyWJUfs-ajmZZg', '/v1/directories/lmX7O21PQp217EbPgtPxVA/customData', null, '2016-12-08 13:54:19.888', '2016-12-08 13:54:19.888', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('ctib6qaoR926S48O8jRyzg', '/v1/accounts/51v-Ll11RNKocz2TOR9ybA/customData', null, '2016-11-23 20:11:55.486', '2016-11-23 20:11:55.486', 'HaAHavmTTG6g28PD1GnNsw');
INSERT INTO `customdata` VALUES ('Df0Pd36NQyiNLIM5fxQjlA', '/v1/accounts/__dbfrQHR3CGFm9PfQyAlQ/customData', null, '2016-11-24 11:04:17.790', '2016-11-24 11:04:17.790', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('DzW7JgaoSXauvmrO7vO2Rw', '/v1/organizations/m58oUN1FQWa8l0J1fVfkKw/customData', null, '2016-12-08 09:02:36.173', '2016-12-08 09:02:36.173', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('E4mclt-xQE2jYUrtJ8Zb2Q', '/v1/applications/nnwpouLzSLCZQhd4rY86Wg/customData', null, '2016-12-09 14:48:31.247', '2016-12-09 14:48:31.247', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('E8Yvafy9SImE2PH-4RuxMA', '/v1/groups/IdG_fRcDT3OKyGIuQHw1pQ/customData', null, '2016-12-08 16:48:39.412', '2016-12-08 16:48:39.412', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('fRYvMJwoQziSTkbqypkptQ', '/v1/tenants/akIH-IAAQM6LGenqbA4TIQ/customData', null, '2016-11-23 09:23:09.125', '2016-11-23 09:23:09.125', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('Go_NeAghTR2iO_s175SVpw', '/v1/directories/FeNskoLHTZ-1AkuiPLfdoA/customData', null, '2016-12-06 09:57:39.659', '2016-12-06 09:57:39.659', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('H0Msts_PS1m3ZIa1CwcG8w', '/v1/organizations/knAvWt_lTkqPrUClQQoBNw/customData', null, '2016-12-08 08:43:13.435', '2016-12-08 08:43:13.435', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('h9JFHInnQOyuLgMNmWGDSg', '/v1/groups/vA7ezrD6Q_SDG6R38TERDQ/customData', null, '2016-12-13 16:45:38.504', '2016-12-13 16:45:38.504', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('ip1_XjeESQacS5vsX70q4A', '/v1/accounts/QtAvCv1sQp2kQzh5U2Ngqw/customData', null, '2016-12-09 14:48:31.267', '2016-12-09 14:48:31.267', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('J4HweHwmT-ueEBQFZ87_Aw', '/v1/applications/BjaYFHrjR26xYnOl-jvQ-Q/customData', null, '2016-12-06 10:01:07.171', '2016-12-06 10:01:07.171', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('JbgiU4m1SUCHKYPAnQ1QwQ', '/v1/directories/68DTMKYoRveuq-sbqhyVIA/customData', null, '2016-12-09 14:48:31.255', '2016-12-09 14:48:31.255', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('JG3dSZHYRTuZdwRxQw3Vjg', '/v1/applications/JxKeLNjRReetoTnei2KHMQ/customData', null, '2016-12-05 11:21:56.806', '2016-12-05 11:21:56.806', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('LknHN2i4Ssyt3yCiWf0VAA', '/v1/applications/8MqY9FZJQjGIZi2T_U1EHQ/customData', null, '2016-12-08 14:39:51.905', '2016-12-08 14:39:51.905', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('M97sWjJVRmegSYSfrhHXRQ', '/v1/applications/A2mzIgyJRj-tVZsc5Y3_iA/customData', null, '2016-12-06 09:57:39.629', '2016-12-06 09:57:39.629', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('NUyRO783RSm8-ZVAsYrc3A', '/v1/directories/TIMKyuViShGVqZPWiCjadQ/customData', null, '2016-12-08 14:54:44.810', '2016-12-08 14:54:44.810', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('o0jkJ8keQ7GAQRkBYiJC5g', '/v1/groups/px-D33f6RziYd68MZOz4Kw/customData', null, '2016-11-24 11:01:10.990', '2016-11-24 11:01:10.990', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('OLu4nROARj6HwKFItxde8Q', '/v1/applications/DbDAlOrIQBGBtgwfepdqEA/customData', null, '2016-12-09 14:50:02.352', '2016-12-09 14:50:02.352', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('OTemHzXPQtajyCDuQ-oTEA', '/v1/directories/thBnX77CQayKxfok1pgaSA/customData', null, '2016-12-05 11:21:56.812', '2016-12-05 11:21:56.812', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('pJTarjGqSL61j-XuwgtZ-g', '/v1/organizations/D0AWFy4zQUu65sG2lNueeg/customData', null, '2016-12-08 08:30:21.339', '2016-12-08 08:30:21.339', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('PuoO4SoWRAOMkLoh1SfaOg', '/v1/directories/r19tssPgQySRv4JJdCerDA/customData', null, '2016-12-08 16:24:29.843', '2016-12-08 16:24:29.843', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('Q5BmRQieRmqoVYMj5Ea43A', '/v1/directories/M_ACh3j-SQOiOw0t7HJk9w/customData', null, '2016-11-24 10:58:14.901', '2016-11-24 10:58:14.901', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('qC0rVEsUQOytGJWeER1ufA', '/v1/groups/qIlhGdtGT82mAFmuCsT9_w/customData', null, '2016-12-08 16:51:41.513', '2016-12-08 16:51:41.513', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('Qh29C9a3TKCiTBobvJtfQA', '/v1/organizations/wg0chIJxS-Gwf_adiCSkqA/customData', null, '2016-12-08 08:56:01.244', '2016-12-08 08:56:01.244', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('qYlThtsCSsGWF7Ft5DJWog', '/v1/directories/i37cBwsmSJW3TGFInt-AYg/customData', null, '2016-12-12 15:43:48.183', '2016-12-12 15:43:48.183', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('RfsnjPNaTOCc9Ektl8ad5A', '/v1/applications/2yN7DmbwS3WsmtgyIFqQtg/customData', null, '2016-12-06 10:00:05.821', '2016-12-06 10:00:05.821', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('rNXTNYH8TqCm2Qr2a7i6wg', '/v1/accounts/Whlh038oSeytf8Yc1rt73A/customData', null, '2016-12-13 19:24:23.210', '2016-12-13 19:24:23.210', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('ro5jl-8bSCGSBtpr-t0KNw', '/v1/directories/TdXHov8zSPC7tFXf2Rhi5Q/customData', null, '2016-12-06 11:23:33.889', '2016-12-06 11:23:33.889', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('SNU7km8RRZKTbkwFIr5BTw', '/v1/applications/AorQEPNjTQS1NfWUUh4b1A/customData', null, '2016-12-09 14:49:55.555', '2016-12-09 14:49:55.555', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('T25mNtlASK6HQs_8WXMJIw', '/v1/directories/ax4VYYEQSaijCrFK1VihUw/customData', null, '2016-12-09 14:50:02.358', '2016-12-09 14:50:02.358', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('tu2efWKXRfeQR6ZZ0-_JNQ', '/v1/organizations/2h2t3m-HRruksMk_G4F9RQ/customData', null, '2016-11-24 10:47:02.828', '2016-11-24 10:47:02.828', 'HaAHavmTTG6g28PD1GnNsw');
INSERT INTO `customdata` VALUES ('TvfDyzWZS6ani9Y4ioaHxQ', '/v1/groups/TTOqJVklQZ6XmAEXyHiPiQ/customData', null, '2016-12-14 15:38:51.181', '2016-12-14 15:38:51.181', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('TYmwy06KQR2MKGdXpO8uvQ', '/v1/tenants/Y4uGIW1KR6qVKgA3hhWYEw/customData', null, '2016-12-05 11:21:56.777', '2016-12-05 11:21:56.777', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('u1LoBwoqRRqjoy7s2nSVaQ', '/v1/organizations/SqjbdmDRRDG3JxBLZy-P2Q/customData', null, '2016-12-08 08:43:10.437', '2016-12-08 08:43:10.437', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('WRzYoqX5S0SDBvUSOy8sFw', '/v1/applications/l43kOyWiTQCTUc0fUbAkkg/customData', null, '2016-12-06 11:23:44.613', '2016-12-06 11:23:44.613', 'Y4uGIW1KR6qVKgA3hhWYEw');
INSERT INTO `customdata` VALUES ('x2Qw1uQhQBGlOk-wG4H6-g', '/v1/directories/78gReuiLRma3IgWE1gJPyQ/customData', null, '2016-12-09 14:49:55.803', '2016-12-09 14:49:55.803', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('x2YS1sK-SAmQw50ClvfEsw', '/v1/directories/ixz5Th3rREKUsfPwKLFLHQ/customData', null, '2016-12-12 16:33:14.151', '2016-12-12 16:33:14.151', 'vKVLdcpWT9iT8mUiVV3cew');
INSERT INTO `customdata` VALUES ('x9PQVAcBRkObtswUcTbSRg', '/v1/organizations/fp7JPC3fQ3WSrPQgp8an8A/customData', null, '2016-11-24 11:01:53.758', '2016-11-24 11:01:53.758', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `customdata` VALUES ('YeBlFks9Q1yvd7FtiDVk-A', '/v1/tenants/vKVLdcpWT9iT8mUiVV3cew/customData', null, '2016-12-09 14:48:31.116', '2016-12-09 14:48:31.116', 'vKVLdcpWT9iT8mUiVV3cew');

-- ----------------------------
-- Table structure for email_template
-- ----------------------------
DROP TABLE IF EXISTS `email_template`;
CREATE TABLE `email_template` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `fromEmailAddress` varchar(255) DEFAULT NULL,
  `fromName` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `htmlBody` varchar(2048) DEFAULT NULL,
  `textBody` varchar(2048) DEFAULT NULL,
  `mimeType` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of email_template
-- ----------------------------

-- ----------------------------
-- Table structure for group_membership
-- ----------------------------
DROP TABLE IF EXISTS `group_membership`;
CREATE TABLE `group_membership` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL DEFAULT '',
  `account` char(22) DEFAULT NULL,
  `cloudGroup` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ca` (`account`,`cloudGroup`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group_membership
-- ----------------------------
INSERT INTO `group_membership` VALUES ('M-l2LTYZSnG_0DURwk2PdA', '/v1/groupMemberships/M-l2LTYZSnG_0DURwk2PdA', '__dbfrQHR3CGFm9PfQyAlQ', 'px-D33f6RziYd68MZOz4Kw', 'akIH-IAAQM6LGenqbA4TIQ');
INSERT INTO `group_membership` VALUES ('TZ0iXGK5SiiyTcu__0UJUQ', '/v1/groupMemberships/TZ0iXGK5SiiyTcu__0UJUQ', '51v-Ll11RNKocz2TOR9ybA', 'LXR9G1zUQIGabfsTeYL_Kg', 'HaAHavmTTG6g28PD1GnNsw');

-- ----------------------------
-- Table structure for idsite
-- ----------------------------
DROP TABLE IF EXISTS `idsite`;
CREATE TABLE `idsite` (
  `href` varchar(25) NOT NULL DEFAULT '',
  `domainName` varchar(128) DEFAULT NULL,
  `gitRepoUrl` varchar(255) DEFAULT NULL,
  `gitBranch` varchar(30) DEFAULT NULL,
  `authorizedOriginURLs` varchar(1024) DEFAULT NULL,
  `authorizedRedirectURLs` varchar(1024) DEFAULT NULL,
  `sessionTti` int(11) DEFAULT NULL,
  `sessionTtl` int(11) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`href`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idsite
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_policy
-- ----------------------------
DROP TABLE IF EXISTS `oauth_policy`;
CREATE TABLE `oauth_policy` (
  `id` char(22) NOT NULL,
  `href` varchar(255) DEFAULT NULL,
  `accessTokenTtl` varchar(255) DEFAULT NULL,
  `refreshTokenTtl` varchar(255) DEFAULT NULL,
  `createdAt` varchar(32) DEFAULT NULL,
  `modifiedAt` varchar(32) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_policy
-- ----------------------------

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `organKey` varchar(255) DEFAULT NULL,
  `organName` varchar(255) DEFAULT NULL,
  `organStatus` char(16) NOT NULL,
  `organDes` varchar(512) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  `defaultAccountStoreMapping` varchar(255) DEFAULT NULL,
  `defaultGroupStoreMapping` varchar(255) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_name` (`organName`,`tenant`) USING BTREE,
  UNIQUE KEY `index_key` (`organKey`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES ('A6a5o1HTSLSSH6giDdjy_w', '/v1/organizations/A6a5o1HTSLSSH6giDdjy_w', 'org-At', '组织 A', 'enabled', '', 'AAsgZ6BaRhW3ohtB8Keo5A', null, null, 'vKVLdcpWT9iT8mUiVV3cew', '2016-12-13 16:16:59.970', '2016-12-13 16:16:59.970');
INSERT INTO `organization` VALUES ('D0AWFy4zQUu65sG2lNueeg', '/v1/organizations/D0AWFy4zQUu65sG2lNueeg', 'org-01', 'org01', 'enabled', '', 'pJTarjGqSL61j-XuwgtZ-g', null, null, 'akIH-IAAQM6LGenqbA4TIQ', '2016-12-08 08:30:21.336', '2016-12-08 08:30:21.336');
INSERT INTO `organization` VALUES ('fp7JPC3fQ3WSrPQgp8an8A', '/v1/organizations/fp7JPC3fQ3WSrPQgp8an8A', 'ISC', 'Inspur Software Company', 'enabled', '', 'x9PQVAcBRkObtswUcTbSRg', null, null, 'akIH-IAAQM6LGenqbA4TIQ', '2016-11-24 11:01:53.758', '2016-11-24 11:01:53.758');
INSERT INTO `organization` VALUES ('wg0chIJxS-Gwf_adiCSkqA', '/v1/organizations/wg0chIJxS-Gwf_adiCSkqA', 'org-02', 'org02', 'enabled', '', 'Qh29C9a3TKCiTBobvJtfQA', null, null, 'Y4uGIW1KR6qVKgA3hhWYEw', '2016-12-08 08:56:01.244', '2016-12-08 08:56:01.244');

-- ----------------------------
-- Table structure for organization_account_store_mapping
-- ----------------------------
DROP TABLE IF EXISTS `organization_account_store_mapping`;
CREATE TABLE `organization_account_store_mapping` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `listIndex` int(11) DEFAULT NULL,
  `isDefaultAccountStore` char(16) DEFAULT NULL,
  `isDefaultGroupStore` char(16) DEFAULT NULL,
  `organization` char(22) DEFAULT NULL,
  `storeType` char(22) DEFAULT NULL,
  `accountStore` char(22) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_account_store_mapping
-- ----------------------------
INSERT INTO `organization_account_store_mapping` VALUES ('9jfrbYZwQ1KpaEc3kpkU5g', '/v1/organizationAccountStoreMappings/9jfrbYZwQ1KpaEc3kpkU5g', '10', 'false', 'false', 'fp7JPC3fQ3WSrPQgp8an8A', 'group', 'px-D33f6RziYd68MZOz4Kw', '2016-11-24 11:36:33.029', '2016-11-24 11:36:33.029', 'akIH-IAAQM6LGenqbA4TIQ');

-- ----------------------------
-- Table structure for password_policy
-- ----------------------------
DROP TABLE IF EXISTS `password_policy`;
CREATE TABLE `password_policy` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `resetTokenTtl` int(11) DEFAULT NULL,
  `resetEmailStatus` char(16) DEFAULT NULL,
  `resetSuccessEmailStatus` char(16) DEFAULT NULL,
  `strength` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of password_policy
-- ----------------------------

-- ----------------------------
-- Table structure for password_strength
-- ----------------------------
DROP TABLE IF EXISTS `password_strength`;
CREATE TABLE `password_strength` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `minLength` int(11) DEFAULT NULL,
  `maxLength` int(11) DEFAULT NULL,
  `minLowerCase` int(11) DEFAULT NULL,
  `minUpperCase` int(11) DEFAULT NULL,
  `minNumeric` int(11) DEFAULT NULL,
  `minSymbol` int(11) DEFAULT NULL,
  `preventReuse` int(11) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of password_strength
-- ----------------------------

-- ----------------------------
-- Table structure for provider
-- ----------------------------
DROP TABLE IF EXISTS `provider`;
CREATE TABLE `provider` (
  `id` char(22) NOT NULL,
  `href` varchar(255) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `providerType` char(32) DEFAULT NULL,
  `clientId` varchar(255) DEFAULT NULL,
  `clientSecret` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of provider
-- ----------------------------
INSERT INTO `provider` VALUES ('-cf71jfrQGOW2UoqQNTZMQ', '/v1/directories/6C-ehBlpQ4es3d-DCQP9Cw/provider', 'vKVLdcpWT9iT8mUiVV3cew', '2016-12-12 16:35:45.904', '2016-12-12 16:35:45.904', 'GitHub', '123', '321');
INSERT INTO `provider` VALUES ('NK-57guWTeCaa3hhgBg5Vw', '/v1/directories/i37cBwsmSJW3TGFInt-AYg/provider', 'vKVLdcpWT9iT8mUiVV3cew', '2016-12-12 15:43:48.056', '2016-12-12 15:43:48.056', 'GitHub', null, null);
INSERT INTO `provider` VALUES ('trsMrvx_QQqRdxb-2RqLig', '/v1/directories/ixz5Th3rREKUsfPwKLFLHQ/provider', 'vKVLdcpWT9iT8mUiVV3cew', '2016-12-12 16:33:14.148', '2016-12-12 16:33:14.148', 'GitHub', null, null);

-- ----------------------------
-- Table structure for smtp_server
-- ----------------------------
DROP TABLE IF EXISTS `smtp_server`;
CREATE TABLE `smtp_server` (
  `href` char(22) NOT NULL,
  `smtpName` varchar(128) DEFAULT NULL,
  `smtpDes` varchar(128) DEFAULT NULL,
  `createdAt` varchar(128) DEFAULT NULL,
  `modifiedAt` varchar(128) DEFAULT NULL,
  `userName` varchar(128) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `smtpHost` varchar(128) DEFAULT NULL,
  `smtpPort` varchar(128) DEFAULT NULL,
  `securityProtocol` varchar(128) DEFAULT NULL,
  `smtpStatus` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`href`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smtp_server
-- ----------------------------

-- ----------------------------
-- Table structure for tenant
-- ----------------------------
DROP TABLE IF EXISTS `tenant`;
CREATE TABLE `tenant` (
  `id` char(22) NOT NULL,
  `href` varchar(255) NOT NULL,
  `tenantKey` varchar(64) DEFAULT NULL,
  `tenantName` varchar(255) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tenantKey` (`tenantKey`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tenant
-- ----------------------------
INSERT INTO `tenant` VALUES ('akIH-IAAQM6LGenqbA4TIQ', '/v1/tenants/akIH-IAAQM6LGenqbA4TIQ', 'kghxvz-wgkndo', 'kghxvz-wgkndo', '2016-11-23 09:23:09.125', '2016-11-23 09:23:09.125', 'fRYvMJwoQziSTkbqypkptQ');
INSERT INTO `tenant` VALUES ('vKVLdcpWT9iT8mUiVV3cew', '/v1/tenants/vKVLdcpWT9iT8mUiVV3cew', 'vdaggr-ypyyyy', 'vdaggr-ypyyyy', '2016-12-09 14:48:31.112', '2016-12-09 14:48:31.112', 'YeBlFks9Q1yvd7FtiDVk-A');
INSERT INTO `tenant` VALUES ('Y4uGIW1KR6qVKgA3hhWYEw', '/v1/tenants/Y4uGIW1KR6qVKgA3hhWYEw', 'aisbsg-mstnym', 'aisbsg-mstnym', '2016-12-05 11:21:56.774', '2016-12-05 11:21:56.774', 'TYmwy06KQR2MKGdXpO8uvQ');

-- ----------------------------
-- View structure for v_directory
-- ----------------------------
DROP VIEW IF EXISTS `v_directory`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_directory` AS select distinct `cloud_directory`.`id` AS `id`,`cloud_directory`.`href` AS `href`,`cloud_directory`.`directoryName` AS `directoryName`,`cloud_directory`.`directoryDes` AS `directoryDes`,`cloud_directory`.`directoryStatus` AS `directoryStatus`,`cloud_directory`.`createdAt` AS `createdAt`,`cloud_directory`.`modifiedAt` AS `modifiedAt`,`cloud_directory`.`customData` AS `customData`,`cloud_directory`.`tenant` AS `tenant`,`cloud_directory`.`passwordPolicy` AS `passwordPolicy`,`cloud_directory`.`accountCreationPolicy` AS `accountCreationPolicy` from `cloud_directory` ;
