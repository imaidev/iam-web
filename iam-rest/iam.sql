/*
Navicat MySQL Data Transfer

Source Database       : iam

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-09-08 10:43:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `userName` varchar(256) DEFAULT NULL,
  `accountPwd` varchar(256) DEFAULT NULL,
  `accountStatus` char(16) NOT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `passwordModifiedAt` char(32) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  `cloudDirectory` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_email` (`email`,`cloudDirectory`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_creation_policy
-- ----------------------------
DROP TABLE IF EXISTS `account_creation_policy`;
CREATE TABLE `account_creation_policy` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `verificationEmailStatus` char(16) DEFAULT NULL,
  `verificationSuccessEmailStatus` char(16) DEFAULT NULL,
  `welcomeEmailStatus` char(16) DEFAULT NULL,
  `emailDomainWhitelist` varchar(256) DEFAULT NULL,
  `emailDomainBlacklist` varchar(256) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_store_mapping
-- ----------------------------
DROP TABLE IF EXISTS `account_store_mapping`;
CREATE TABLE `account_store_mapping` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `listIndex` int(11) DEFAULT NULL,
  `isDefaultAccountStore` char(16) DEFAULT NULL,
  `isDefaultGroupStore` char(16) DEFAULT NULL,
  `application` char(22) DEFAULT NULL,
  `accountStore` varchar(256) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_app_account` (`application`,`accountStore`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for apikey
-- ----------------------------
DROP TABLE IF EXISTS `apikey`;
CREATE TABLE `apikey` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `akid` varchar(256) NOT NULL,
  `secret` varchar(256) NOT NULL,
  `akName` varchar(256) DEFAULT NULL,
  `akDes` varchar(256) DEFAULT NULL,
  `akStatus` char(16) NOT NULL,
  `account` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_akid_secret` (`akid`,`secret`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for application
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `appName` varchar(256) DEFAULT NULL,
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
  `authorizedCallbackUris` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_appname` (`appName`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cloud_directory
-- ----------------------------
DROP TABLE IF EXISTS `cloud_directory`;
CREATE TABLE `cloud_directory` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `directoryName` varchar(256) DEFAULT NULL,
  `directoryDes` varchar(512) DEFAULT NULL,
  `directoryStatus` char(16) NOT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  `passwordPolicy` char(22) DEFAULT NULL,
  `accountCreationPolicy` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_directory` (`directoryName`,`tenant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cloud_group
-- ----------------------------
DROP TABLE IF EXISTS `cloud_group`;
CREATE TABLE `cloud_group` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `groupName` varchar(256) DEFAULT NULL,
  `groupDes` varchar(512) DEFAULT NULL,
  `groupStatus` varchar(16) NOT NULL,
  `cloudDirectory` varchar(256) DEFAULT NULL,
  `tenant` varchar(256) DEFAULT NULL,
  `customData` varchar(256) DEFAULT NULL,
  `createdAt` varchar(32) DEFAULT NULL,
  `modifiedAt` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_group` (`groupName`,`cloudDirectory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for customdata
-- ----------------------------
DROP TABLE IF EXISTS `customdata`;
CREATE TABLE `customdata` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `data` varchar(4096) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for email_template
-- ----------------------------
DROP TABLE IF EXISTS `email_template`;
CREATE TABLE `email_template` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `fromEmailAddress` varchar(256) DEFAULT NULL,
  `fromName` varchar(256) DEFAULT NULL,
  `subject` varchar(256) DEFAULT NULL,
  `htmlBody` varchar(2048) DEFAULT NULL,
  `textBody` varchar(2048) DEFAULT NULL,
  `mimeType` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for group_membership
-- ----------------------------
DROP TABLE IF EXISTS `group_membership`;
CREATE TABLE `group_membership` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL DEFAULT '',
  `account` char(22) DEFAULT NULL,
  `cloudGroup` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ca` (`account`,`cloudGroup`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idsite
-- ----------------------------
DROP TABLE IF EXISTS `idsite`;
CREATE TABLE `idsite` (
  `href` varchar(25) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `domainName` varchar(128) DEFAULT NULL,
  `gitRepoUrl` varchar(256) DEFAULT NULL,
  `gitBranch` varchar(30) DEFAULT NULL,
  `authorizedOriginURLs` varchar(1024) DEFAULT NULL,
  `authorizedRedirectURLs` varchar(1024) DEFAULT NULL,
  `sessionTti` int(11) DEFAULT NULL,
  `sessionTtl` int(11) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`href`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` char(22) NOT NULL,
  `href` varchar(256) NOT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `organName` varchar(256) DEFAULT NULL,
  `organKey` varchar(64) DEFAULT NULL,
  `organStatus` char(16) NOT NULL,
  `organDes` varchar(512) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  `defaultAccountStoreMapping` varchar(256) DEFAULT NULL,
  `defaultGroupStoreMapping` varchar(256) DEFAULT NULL,
  `accountStoreMappings` varchar(256) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for organization_account_store_mapping
-- ----------------------------
DROP TABLE IF EXISTS `organization_account_store_mapping`;
CREATE TABLE `organization_account_store_mapping` (
  `id` char(22) NOT NULL,
  `href` varchar(256) NOT NULL,
  `listIndex` int(11) DEFAULT NULL,
  `isDefaultAccountStore` char(16) DEFAULT NULL,
  `isDefaultGroupStore` char(16) DEFAULT NULL,
  `organization` char(22) DEFAULT NULL,
  `accountStore` varchar(256) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for password_policy
-- ----------------------------
DROP TABLE IF EXISTS `password_policy`;
CREATE TABLE `password_policy` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `resetTokenTtl` int(11) DEFAULT NULL,
  `resetEmailStatus` char(16) DEFAULT NULL,
  `resetSuccessEmailStatus` char(16) DEFAULT NULL,
  `strength` char(22) DEFAULT NULL,
  `tenant` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for password_strength
-- ----------------------------
DROP TABLE IF EXISTS `password_strength`;
CREATE TABLE `password_strength` (
  `id` char(22) NOT NULL,
  `href` varchar(256) NOT NULL,
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
-- Table structure for tenant
-- ----------------------------
DROP TABLE IF EXISTS `tenant`;
CREATE TABLE `tenant` (
  `id` char(22) CHARACTER SET utf8 NOT NULL,
  `href` varchar(256) NOT NULL,
  `tenantKey` varchar(64) DEFAULT NULL,
  `tenantName` varchar(256) DEFAULT NULL,
  `createdAt` char(32) DEFAULT NULL,
  `modifiedAt` char(32) DEFAULT NULL,
  `customData` char(22) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tenantKey` (`tenantKey`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;