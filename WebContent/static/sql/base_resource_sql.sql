/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.6.16 : Database - 2profit_stage
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`2profit_stage` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `2profit_stage`;

/*Table structure for table `base_advertisement` */

DROP TABLE IF EXISTS `base_advertisement`;

CREATE TABLE `base_advertisement` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_advertisement` */

/*Table structure for table `base_degree` */

DROP TABLE IF EXISTS `base_degree`;

CREATE TABLE `base_degree` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_degree` */

/*Table structure for table `base_exchange_rate` */

DROP TABLE IF EXISTS `base_exchange_rate`;

CREATE TABLE `base_exchange_rate` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `coin` int(11) NOT NULL,
  `hkd` double NOT NULL,
  `rmb` double NOT NULL,
  `usd` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_exchange_rate` */

/*Table structure for table `base_mobile_backlist` */

DROP TABLE IF EXISTS `base_mobile_backlist`;

CREATE TABLE `base_mobile_backlist` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_mobile_backlist` */

/*Table structure for table `base_nationality` */

DROP TABLE IF EXISTS `base_nationality`;

CREATE TABLE `base_nationality` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `order_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_nationality` */

/*Table structure for table `base_nickname_backlist` */

DROP TABLE IF EXISTS `base_nickname_backlist`;

CREATE TABLE `base_nickname_backlist` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_nickname_backlist` */

/*Table structure for table `base_notice` */

DROP TABLE IF EXISTS `base_notice`;

CREATE TABLE `base_notice` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `apply_type` varchar(2) DEFAULT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `display_type` varchar(2) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `language` varchar(2) DEFAULT NULL,
  `notice_type` varchar(2) DEFAULT NULL,
  `photo_url` varchar(128) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_notice` */

/*Table structure for table `broker_base_info` */

DROP TABLE IF EXISTS `broker_base_info`;

CREATE TABLE `broker_base_info` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `cn_name` varchar(128) DEFAULT NULL,
  `en_name` varchar(128) DEFAULT NULL,
  `exchange_no1` varchar(64) DEFAULT NULL,
  `exchange_no2` varchar(64) DEFAULT NULL,
  `exchange_no3` varchar(64) DEFAULT NULL,
  `exchange_no4` varchar(64) DEFAULT NULL,
  `exchange_type1` varchar(2) DEFAULT NULL,
  `exchange_type2` varchar(2) DEFAULT NULL,
  `exchange_type3` varchar(2) DEFAULT NULL,
  `exchange_type4` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `broker_base_info` */

insert  into `broker_base_info`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`cn_name`,`en_name`,`exchange_no1`,`exchange_no2`,`exchange_no3`,`exchange_no4`,`exchange_type1`,`exchange_type2`,`exchange_type3`,`exchange_type4`) values ('40286581510178e40151018378ab0000','2015-11-13 23:42:52','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 15:18:44','艾拓思','AETOS','12345','23456','34567','45678',NULL,NULL,NULL,NULL),('40286581510178e40151018551720001','2015-11-13 23:44:53','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 15:21:37','博美','BMFN','23456','56789','556677','889963',NULL,NULL,NULL,NULL),('40286581510178e401510186e4a90002','2015-11-13 23:46:36','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 15:46:23','戴盛资本','DCM','223344','334455','112233','445566',NULL,NULL,NULL,NULL),('402865815101d2ec015101dbf9db0000','2015-11-14 01:19:32','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 15:23:38','大旗金融','FXBTG.','111222','222333','333444','444555',NULL,NULL,NULL,NULL),('402865815101d2ec015101dd4baf0001','2015-11-14 01:20:58','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 15:26:35','西城','（City Wealth）','000111','111000','444555','555666',NULL,NULL,NULL,NULL),('402865815101d2ec015101df28670002','2015-11-14 01:23:00','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-20 15:04:56','Deltastock AD','Deltastock AD','777888','888999','999000','111000',NULL,NULL,NULL,NULL),('40286581510576690151057a20760000','2015-11-14 18:11:08','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 15:49:05','KRCNZ（凯汇）','KRCNZ','12000','12001','12002','12003',NULL,NULL,NULL,NULL);

/*Table structure for table `broker_ext_info` */

DROP TABLE IF EXISTS `broker_ext_info`;

CREATE TABLE `broker_ext_info` (
  `close_rate` double DEFAULT NULL,
  `close_rate_ext` double DEFAULT NULL,
  `commission_code` varchar(64) DEFAULT NULL,
  `commission_hkg` decimal(19,2) DEFAULT NULL,
  `commission_lkg` decimal(19,2) DEFAULT NULL,
  `commission_llg` decimal(19,2) DEFAULT NULL,
  `commission_lls` decimal(19,2) DEFAULT NULL,
  `commission_url` varchar(64) DEFAULT NULL,
  `commission_wh` decimal(19,2) DEFAULT NULL,
  `commission_yy` decimal(19,2) DEFAULT NULL,
  `company_area` varchar(8) DEFAULT NULL,
  `company_index` int(11) DEFAULT NULL,
  `company_type` varchar(8) DEFAULT NULL,
  `image_url` varchar(64) DEFAULT NULL,
  `image_urlh5` varchar(64) DEFAULT NULL,
  `introduction` varchar(256) DEFAULT NULL,
  `is_account_seperate` varchar(8) DEFAULT NULL,
  `is_close_fee` varchar(8) DEFAULT NULL,
  `is_ea_support` varchar(2) DEFAULT NULL,
  `is_in_out_free` varchar(2) DEFAULT NULL,
  `is_open_fee` varchar(8) DEFAULT NULL,
  `is_recommet` int(11) DEFAULT NULL,
  `is_return_commission` varchar(8) DEFAULT NULL,
  `is_rmb_support` varchar(2) DEFAULT NULL,
  `is_show_url` varchar(2) DEFAULT NULL,
  `is_singal_service` varchar(8) DEFAULT NULL,
  `is_trade_code` varchar(8) DEFAULT NULL,
  `is_unionpay` varchar(2) DEFAULT NULL,
  `lever_rate` double DEFAULT NULL,
  `license_type` varchar(2) DEFAULT NULL,
  `long_rate` double DEFAULT NULL,
  `max_hold_num` double DEFAULT NULL,
  `max_trade_num_hkg` double DEFAULT NULL,
  `max_trade_num_lkg` double DEFAULT NULL,
  `max_trade_num_llg` double DEFAULT NULL,
  `max_trade_num_lls` double DEFAULT NULL,
  `max_trade_num_wh` double DEFAULT NULL,
  `max_trade_num_yy` double DEFAULT NULL,
  `min_income_money` decimal(19,2) DEFAULT NULL,
  `min_trade_num_hkg` double DEFAULT NULL,
  `min_trade_num_lkg` double DEFAULT NULL,
  `min_trade_num_llg` double DEFAULT NULL,
  `min_trade_num_lls` double DEFAULT NULL,
  `min_trade_num_wh` double DEFAULT NULL,
  `min_trade_num_yy` double DEFAULT NULL,
  `money_type` varchar(8) DEFAULT NULL,
  `notice_content1` varchar(512) DEFAULT NULL,
  `notice_content2` varchar(512) DEFAULT NULL,
  `notice_content3` varchar(512) DEFAULT NULL,
  `open_money_hkg` decimal(19,2) DEFAULT NULL,
  `open_money_lkg` decimal(19,2) DEFAULT NULL,
  `open_money_llg` decimal(19,2) DEFAULT NULL,
  `open_money_lls` decimal(19,2) DEFAULT NULL,
  `open_money_wh` decimal(19,2) DEFAULT NULL,
  `open_money_yy` decimal(19,2) DEFAULT NULL,
  `platform` varchar(8) DEFAULT NULL,
  `point_diff` varchar(8) DEFAULT NULL,
  `point_diff_min_hkg` double DEFAULT NULL,
  `point_diff_min_lkg` double DEFAULT NULL,
  `point_diff_min_llg` double DEFAULT NULL,
  `point_diff_min_lls` double DEFAULT NULL,
  `point_diff_min_wh` double DEFAULT NULL,
  `point_diff_min_yy` double DEFAULT NULL,
  `product_type` varchar(8) DEFAULT NULL,
  `profit_star` int(11) DEFAULT NULL,
  `service_shape` varchar(8) DEFAULT NULL,
  `short_rate` double DEFAULT NULL,
  `website_url` varchar(64) DEFAULT NULL,
  `id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_6r5n9i5rlbbi4omlkiwx36hy` FOREIGN KEY (`id`) REFERENCES `broker_base_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `broker_ext_info` */

insert  into `broker_ext_info`(`close_rate`,`close_rate_ext`,`commission_code`,`commission_hkg`,`commission_lkg`,`commission_llg`,`commission_lls`,`commission_url`,`commission_wh`,`commission_yy`,`company_area`,`company_index`,`company_type`,`image_url`,`image_urlh5`,`introduction`,`is_account_seperate`,`is_close_fee`,`is_ea_support`,`is_in_out_free`,`is_open_fee`,`is_recommet`,`is_return_commission`,`is_rmb_support`,`is_show_url`,`is_singal_service`,`is_trade_code`,`is_unionpay`,`lever_rate`,`license_type`,`long_rate`,`max_hold_num`,`max_trade_num_hkg`,`max_trade_num_lkg`,`max_trade_num_llg`,`max_trade_num_lls`,`max_trade_num_wh`,`max_trade_num_yy`,`min_income_money`,`min_trade_num_hkg`,`min_trade_num_lkg`,`min_trade_num_llg`,`min_trade_num_lls`,`min_trade_num_wh`,`min_trade_num_yy`,`money_type`,`notice_content1`,`notice_content2`,`notice_content3`,`open_money_hkg`,`open_money_lkg`,`open_money_llg`,`open_money_lls`,`open_money_wh`,`open_money_yy`,`platform`,`point_diff`,`point_diff_min_hkg`,`point_diff_min_lkg`,`point_diff_min_llg`,`point_diff_min_lls`,`point_diff_min_wh`,`point_diff_min_yy`,`product_type`,`profit_star`,`service_shape`,`short_rate`,`website_url`,`id`) values (10,NULL,NULL,NULL,NULL,'20.00',NULL,'',NULL,NULL,'0',1,'0','photos/BrokerExtInfo/1447571923875.jpg','photos/BrokerExtInfo/h5/1447571924275.jpg','AETOS Capital Group艾拓思资本集团始建于2007年，是澳大利亚知名的金融交易服务商。AETOS艾拓思获得澳大...','0','1','0','1','1',1,'1','1','1','0','1','1',NULL,'AA',100,NULL,300,300,300,300,300,300,'100.00',200,200,200,200,200,200,'0','','','','400.00','400.00','400.00','400.00','400.00','400.00','0','1',100,100,100,100,100,100,'0,1',3,'',400,'','40286581510178e40151018378ab0000'),(60,NULL,NULL,NULL,NULL,'30.00',NULL,'',NULL,NULL,'0',2,'0','photos/BrokerExtInfo/1447572097765.jpg','photos/BrokerExtInfo/h5/1447572097779.jpg','Boston Merchant Financial（BMFN）全球领先的金融服务公司。BMFN集团自1988年注册成立，持续快速增长，BMFN集..','0','1','0','1','1',0,'1','1','1','0','1','1',NULL,'AA',40,NULL,30,30,30,30,30,30,'200.00',20,20,20,20,20,20,'0','','','','40.00','40.00','40.00','40.00','40.00','40.00','0','1',10,10,10,10,10,10,'0,1',1,'',50,'','40286581510178e40151018551720001'),(20,NULL,NULL,NULL,NULL,'40.00',NULL,'',NULL,NULL,'0',3,'0','photos/BrokerExtInfo/1447573583385.jpg','photos/BrokerExtInfo/h5/1447573583397.jpg','DELTA Capital Markets Ltd（简称DCM）是一家提供外汇、期货、股票和指数等金融投资的全球性金融集团。DCM于2006年成立，公司领导层均是有着超过10年经验的金融界专业人士。Delta提供提网上外汇、期货、股票和指数等保证金交易，客户资金和营运资金独立分离，客户的资金安全受保险公司保护。','0','1','0','1','1',1,'1','1','1','0','1','1',NULL,'AA',80,NULL,80,80,80,80,80,80,'300.00',70,70,70,70,70,70,'0','','','','90.00','90.00','90.00','90.00','90.00','90.00','0','1',60,60,60,60,60,60,'0,1',5,'',80,'','40286581510178e401510186e4a90002'),(110,110,NULL,'110.00','110.00','110.00','110.00','','110.00','110.00','0',4,'0','photos/BrokerExtInfo/1447572218718.jpg','photos/BrokerExtInfo/h5/1447572218728.jpg','BTG GLOBAL (FXBTG)是提供网上外汇交易的服务商。除提供外汇交易外，还提供包括黄金，白银，原油，和股指交易。...','0','1','0','1','1',0,'1','1','1','0','1','1',NULL,'AA',110,NULL,110,110,110,110,110,110,'110.00',110,110,110,110,110,110,'0','','','','110.00','110.00','110.00','110.00','110.00','110.00','0','1',110,110,110,110,110,110,'0,1',4,'',110,'','402865815101d2ec015101dbf9db0000'),(130,NULL,NULL,'130.00','130.00','130.00','130.00','','130.00','130.00','0',5,'0','photos/BrokerExtInfo/1447572395585.jpg','photos/BrokerExtInfo/h5/1447572395605.jpg','City Wealth Group Limited (以下中文简称“西城威尔士”)是新西兰顶级金融服务提供商，我们致力为全球机...','0','1','0','1','1',1,'1','1','1','0','1','1',130,'AA',130,130,130,130,130,130,130,130,'130.00',130,130,130,130,130,130,'0','','','','130.00','130.00','130.00','130.00','130.00','130.00','0','1',130,130,130,130,130,130,'0,1',1,'',130,'','402865815101d2ec015101dd4baf0001'),(140,NULL,NULL,'140.00','140.00','140.00','140.00','','140.00','140.00','0',6,'0','photos/BrokerExtInfo/1447572662745.jpg',NULL,'Deltastock AD是一家保加利亚经纪商。','0','1','0','1','1',1,'1','1','1','0','1','1',NULL,'AA',140,NULL,140,140,140,140,140,140,'140.00',140,140,140,140,140,140,'0','','','','140.00','140.00','140.00','140.00','140.00','140.00','0','1',140,140,140,140,140,140,'0,1',3,'',140,'','402865815101d2ec015101df28670002'),(160,NULL,NULL,'160.00','160.00','160.00','160.00','','160.00','160.00','0',7,'0','photos/BrokerExtInfo/1447573745157.jpg','photos/BrokerExtInfo/h5/1447573745268.jpg','KRCNZ（凯汇）总部设于新西兰，获得新西兰金融服务供应商(FSP)认可及监管(注册牌照号FSP322906)，并同时加入了FDR计划。作为全球领先值得信赖的线上外汇交易商，KRCNZ凯汇提供真正的ECN模式，并由国际顶尖报价银行提供充足流动性，多种外汇交易产品，有竞争力的点差0点起，并精准撮合成交的同时确保平台的稳定和可靠性。','0','1','0','1','1',0,'1','1','1','0','1','1',160,'AA',160,160,160,160,NULL,160,160160,160,'160.00',160,160,160,160,160,160,'0','','','','160.00','160.00','160.00','160.00','160.00','160.00','0','1',160,160,160,160,160,160,'0,1',1,'',160,'','40286581510576690151057a20760000');

/*Table structure for table `mem_bank_info` */

DROP TABLE IF EXISTS `mem_bank_info`;

CREATE TABLE `mem_bank_info` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `bank_account` varchar(64) DEFAULT NULL,
  `bank_address` varchar(512) DEFAULT NULL,
  `bank_card_num` varchar(64) DEFAULT NULL,
  `bank_photo_url` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_bank_info` */

insert  into `mem_bank_info`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`bank_account`,`bank_address`,`bank_card_num`,`bank_photo_url`) values ('297e13e7510abab301510abc6e6e0001','2015-11-15 18:41:39',NULL,NULL,0,'2015-11-15 18:41:39','中国工商银行','王大锤','626648669485',NULL),('8a2a0842510bb6e2015120151780000b','2015-11-19 22:10:31',NULL,NULL,0,'2015-11-19 22:10:31','','','',NULL),('8a2a0842511b00d701511dcb82a60006','2015-11-19 11:30:55',NULL,NULL,0,'2015-11-19 12:30:46','中国银行','jo','1546',NULL),('8a2a0842511b00d70151201002980010','2015-11-19 22:04:58',NULL,NULL,0,'2015-11-19 23:07:34','建設銀行','李澄幸','123124657897',NULL);

/*Table structure for table `mem_broker_comment` */

DROP TABLE IF EXISTS `mem_broker_comment`;

CREATE TABLE `mem_broker_comment` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `broker_info_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_jpnxrpks34xk73mc3to5lbx89` (`broker_info_id`),
  KEY `FK_aymkjpbs75ybgch7d2vaqqxy2` (`member_id`),
  CONSTRAINT `FK_aymkjpbs75ybgch7d2vaqqxy2` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`),
  CONSTRAINT `FK_jpnxrpks34xk73mc3to5lbx89` FOREIGN KEY (`broker_info_id`) REFERENCES `broker_base_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_broker_comment` */

/*Table structure for table `mem_broker_rel` */

DROP TABLE IF EXISTS `mem_broker_rel`;

CREATE TABLE `mem_broker_rel` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `broker_info_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `mt4_card` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_b61do2ehslvpmcokcixfwdegc` (`broker_info_id`),
  KEY `FK_mqy4kdun6et1r7300p8epbe85` (`member_id`),
  CONSTRAINT `FK_b61do2ehslvpmcokcixfwdegc` FOREIGN KEY (`broker_info_id`) REFERENCES `broker_base_info` (`id`),
  CONSTRAINT `FK_mqy4kdun6et1r7300p8epbe85` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_broker_rel` */

insert  into `mem_broker_rel`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`broker_info_id`,`member_id`,`mt4_card`) values ('297e13e7510abab301510abc93640003','2015-11-15 18:41:49',NULL,NULL,0,'2015-11-15 18:41:49','40286581510178e40151018378ab0000','297e13e7510abab301510abc6e780002','123456789'),('8a2a0842510bb6e201511e00c7cb0008','2015-11-19 12:29:06',NULL,NULL,0,'2015-11-19 12:29:06','40286581510576690151057a20760000','8a2a0842511b00d701511daada0c0005','123456'),('8a2a0842510bb6e201511e0234c00009','2015-11-19 12:30:39',NULL,NULL,0,'2015-11-19 12:30:39','40286581510178e40151018551720001','8a2a0842511b00d701511daada0c0005','23154'),('8a2a0842510bb6e20151204946ac000d','2015-11-19 23:07:31',NULL,NULL,0,'2015-11-19 23:07:31','40286581510178e40151018551720001','8a2a0842511b00d701511f28a0ef000f','12345678');

/*Table structure for table `mem_code` */

DROP TABLE IF EXISTS `mem_code`;

CREATE TABLE `mem_code` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_7ar34k2klvbe3oa9op08e0ml7` (`member_id`),
  CONSTRAINT `FK_7ar34k2klvbe3oa9op08e0ml7` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_code` */

insert  into `mem_code`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`code`,`email`,`mobile`,`status`,`type`,`member_id`) values ('297e13e75104a84f015104a9d92d0000','2015-11-14 14:23:38',NULL,NULL,0,'2015-11-14 14:24:49','9415',NULL,'15622238485',1,0,'297e13e75104a84f015104aaebcd0001'),('297e13e7510ab22901510ab700ad0000','2015-11-15 18:35:44',NULL,NULL,0,'2015-11-15 18:35:44','9829',NULL,'15622238485',0,0,NULL),('297e13e7510abab301510abb476a0000','2015-11-15 18:40:24',NULL,NULL,0,'2015-11-15 18:41:49','7386',NULL,'15622238485',1,0,'297e13e7510abab301510abc6e780002'),('40286581510554e401510557229c0000','2015-11-14 17:32:55',NULL,NULL,0,'2015-11-14 17:33:23','6102',NULL,'18665686291',1,0,'40286581510554e4015105578f690001'),('8a2a0842510adc7801510b36fad90002','2015-11-15 20:55:31',NULL,NULL,0,'2015-11-15 20:55:31','9337','382269727@qq.com',NULL,0,1,'297e13e7510abab301510abc6e780002'),('8a2a0842510adc7801510b55883f0003','2015-11-15 21:28:53',NULL,NULL,0,'2015-11-15 21:28:53','6748','382269727@qq.com',NULL,0,1,'297e13e7510abab301510abc6e780002'),('8a2a0842510b606a01510b60e72a0000','2015-11-15 21:41:18',NULL,NULL,0,'2015-11-15 21:41:18','6298','382269727@qq.com',NULL,0,1,'297e13e7510abab301510abc6e780002'),('8a2a08425111137a0151148149ef0001','2015-11-17 16:13:16',NULL,NULL,0,'2015-11-17 16:13:16','0898',NULL,'15907679719',0,0,NULL),('8a2a0842511b00d701511d974efe0000','2015-11-19 10:33:54',NULL,NULL,0,'2015-11-19 10:33:54','3436',NULL,'15813354208',0,0,NULL),('8a2a0842511b00d701511da200530001','2015-11-19 10:45:34',NULL,NULL,0,'2015-11-19 10:45:34','5844',NULL,'15813354208',0,0,NULL),('8a2a0842511b00d701511da51eff0002','2015-11-19 10:48:59',NULL,NULL,0,'2015-11-19 10:48:59','4405',NULL,'15813354208',0,0,NULL),('8a2a0842511b00d701511da7b3b80003','2015-11-19 10:51:48',NULL,NULL,0,'2015-11-19 10:51:48','5155',NULL,'15813354208',0,0,NULL),('8a2a0842511b00d701511daa27390004','2015-11-19 10:54:29',NULL,NULL,0,'2015-11-19 10:55:14','3080',NULL,'15813354208',1,0,'8a2a0842511b00d701511daada0c0005'),('8a2a0842511b00d701511f2820c7000e','2015-11-19 17:51:42',NULL,NULL,0,'2015-11-19 17:52:15','1190',NULL,'13088844913',1,0,'8a2a0842511b00d701511f28a0ef000f'),('8a2a0842511b00d701513344614f0018','2015-11-23 15:34:58',NULL,NULL,0,'2015-11-23 15:35:14','4510',NULL,'15813354208',1,1,'8a2a0842511b00d701511daada0c0005'),('8aad3a75510e718101510ea3fa930001','2015-11-16 12:53:26',NULL,NULL,0,'2015-11-16 12:54:00','7431',NULL,'18688489640',1,0,'8aad3a75510e718101510ea47e900002');

/*Table structure for table `mem_coin_log` */

DROP TABLE IF EXISTS `mem_coin_log`;

CREATE TABLE `mem_coin_log` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `after_coin` int(11) DEFAULT NULL,
  `before_coin` int(11) DEFAULT NULL,
  `change_id` varchar(255) DEFAULT NULL,
  `change_type` int(11) DEFAULT NULL,
  `coin` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_2utd9phdmgmxlgbvyhcar9e4l` (`member_id`),
  CONSTRAINT `FK_2utd9phdmgmxlgbvyhcar9e4l` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_coin_log` */

insert  into `mem_coin_log`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`after_coin`,`before_coin`,`change_id`,`change_type`,`coin`,`type`,`member_id`) values ('8a2a0842510bb64001510bd7fd140002','2015-11-15 23:51:23','297e13e7510abab301510abc6e780002',NULL,0,'2015-11-15 23:51:23',1,0,'8a2a0842510bb64001510bd7fccb0000',0,1,0,'297e13e7510abab301510abc6e780002'),('8a2a0842510bb6e201510bdbdf4f0003','2015-11-15 23:55:37','2c9025a54d4ffb4a014d4ffe3a670001',NULL,0,'2015-11-15 23:55:37',101,1,'8a2a0842510bb6e201510bdbb28c0002',2,100,0,'297e13e7510abab301510abc6e780002'),('8a2a0842510bb6e201510bdc7a990005','2015-11-15 23:56:17','2c9025a54d4ffb4a014d4ffe3a670001',NULL,0,'2015-11-15 23:56:17',121,101,'8a2a0842510bb6e201510bdc622b0004',1,20,0,'297e13e7510abab301510abc6e780002');

/*Table structure for table `mem_follow` */

DROP TABLE IF EXISTS `mem_follow`;

CREATE TABLE `mem_follow` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `follow_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_hr65mlrybuvouxdsv85qvy3fr` (`follow_id`),
  KEY `FK_r52im98qc8cp53lpfusmqwmlp` (`member_id`),
  CONSTRAINT `FK_hr65mlrybuvouxdsv85qvy3fr` FOREIGN KEY (`follow_id`) REFERENCES `mem_member` (`id`),
  CONSTRAINT `FK_r52im98qc8cp53lpfusmqwmlp` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_follow` */

/*Table structure for table `mem_follower` */

DROP TABLE IF EXISTS `mem_follower`;

CREATE TABLE `mem_follower` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `follower_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_1fgp73n5yfd1qde2s1ltvko04` (`follower_id`),
  KEY `FK_4d5f5rbxrf44h7oeyypgy1q80` (`member_id`),
  CONSTRAINT `FK_1fgp73n5yfd1qde2s1ltvko04` FOREIGN KEY (`follower_id`) REFERENCES `mem_member` (`id`),
  CONSTRAINT `FK_4d5f5rbxrf44h7oeyypgy1q80` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_follower` */

/*Table structure for table `mem_integral` */

DROP TABLE IF EXISTS `mem_integral`;

CREATE TABLE `mem_integral` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_q076anj7heshei4gqxn5gvwg0` (`member_id`),
  CONSTRAINT `FK_q076anj7heshei4gqxn5gvwg0` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_integral` */

/*Table structure for table `mem_member` */

DROP TABLE IF EXISTS `mem_member`;

CREATE TABLE `mem_member` (
  `account_category` varchar(2) DEFAULT NULL,
  `account_type` varchar(2) DEFAULT NULL,
  `address` varchar(512) DEFAULT NULL,
  `card` varchar(128) DEFAULT NULL,
  `card_type` int(11) DEFAULT NULL,
  `cn_name` varchar(64) DEFAULT NULL,
  `coin` int(11) DEFAULT NULL,
  `create_account_date` datetime DEFAULT NULL,
  `en_name` varchar(64) DEFAULT NULL,
  `head_url` varchar(256) DEFAULT NULL,
  `img_back_card_status` int(11) DEFAULT NULL,
  `img_bank_card` varchar(255) DEFAULT NULL,
  `img_id_card_a` varchar(128) DEFAULT NULL,
  `img_id_card_b` varchar(128) DEFAULT NULL,
  `img_id_card_status` int(11) DEFAULT NULL,
  `is_bind_we_chat` varchar(2) DEFAULT NULL,
  `is_comment_auth` varchar(2) DEFAULT NULL,
  `is_vote_auth` varchar(2) DEFAULT NULL,
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `sex` int(11) DEFAULT NULL,
  `status` varchar(2) DEFAULT '0',
  `id` varchar(32) NOT NULL,
  `degree_id` varchar(32) DEFAULT NULL,
  `mem_bank_info_id` varchar(32) DEFAULT NULL,
  `nationality_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_6gnhuqtu28yqt7rdq5vba1x1b` (`degree_id`),
  KEY `FK_kfh9e01cpya6b8oul19r7114w` (`mem_bank_info_id`),
  KEY `FK_leoyusyaphk3djp6sl8nt35o3` (`nationality_id`),
  KEY `no` (`no`),
  CONSTRAINT `FK_6gnhuqtu28yqt7rdq5vba1x1b` FOREIGN KEY (`degree_id`) REFERENCES `base_degree` (`id`),
  CONSTRAINT `FK_6ijpchot03wdbi74v8q9j8gdk` FOREIGN KEY (`id`) REFERENCES `mem_user` (`id`),
  CONSTRAINT `FK_kfh9e01cpya6b8oul19r7114w` FOREIGN KEY (`mem_bank_info_id`) REFERENCES `mem_bank_info` (`id`),
  CONSTRAINT `FK_leoyusyaphk3djp6sl8nt35o3` FOREIGN KEY (`nationality_id`) REFERENCES `base_nationality` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `mem_member` */

insert  into `mem_member`(`account_category`,`account_type`,`address`,`card`,`card_type`,`cn_name`,`coin`,`create_account_date`,`en_name`,`head_url`,`img_back_card_status`,`img_bank_card`,`img_id_card_a`,`img_id_card_b`,`img_id_card_status`,`is_bind_we_chat`,`is_comment_auth`,`is_vote_auth`,`no`,`sex`,`status`,`id`,`degree_id`,`mem_bank_info_id`,`nationality_id`) values ('0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'0','297e13e75104a84f015104aaebcd0001',NULL,NULL,NULL),('0','0','','',NULL,'',121,'2015-11-15 23:58:47',NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,3,NULL,'1','297e13e7510abab301510abc6e780002',NULL,'297e13e7510abab301510abc6e6e0001',NULL),('0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,'0','40286581510554e4015105578f690001',NULL,NULL,NULL),('0','0','','',NULL,'',NULL,'2015-11-15 23:16:16',NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,7,0,'0','8a2a0842510bb6e2015120151783000c',NULL,'8a2a0842510bb6e2015120151780000b',NULL),('0','0','','12345687899',NULL,'李四',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,NULL,NULL,'8a2a0842511b00d701511daada0c0005',NULL,'8a2a0842511b00d701511dcb82a60006',NULL),('0','0','TESTING@19NOV2015','12345678',0,'李澄幸',NULL,'2015-11-19 22:05:53',NULL,'/uploads/gateway/head_image/177e0aea-30b0-453b-ae32-abf20fa6a711.jpg',2,'/uploads/gateway/attachment//2015/11/19/8b303817-91d5-47f4-b2c2-6bb3d0dc39f4.jpg','/uploads/gateway/attachment//2015/11/19/56615551-9733-4737-a9e8-efcb53037885.jpg',NULL,2,NULL,NULL,NULL,6,NULL,'0','8a2a0842511b00d701511f28a0ef000f',NULL,'8a2a0842511b00d70151201002980010',NULL),('0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4,NULL,NULL,'8aad3a75510e718101510ea47e900002',NULL,NULL,NULL);

/*Table structure for table `mem_mobile_code_log` */

DROP TABLE IF EXISTS `mem_mobile_code_log`;

CREATE TABLE `mem_mobile_code_log` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_1eokojdkdqbpmfhub865xe8w7` (`member_id`),
  CONSTRAINT `FK_1eokojdkdqbpmfhub865xe8w7` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_mobile_code_log` */

/*Table structure for table `mem_order` */

DROP TABLE IF EXISTS `mem_order`;

CREATE TABLE `mem_order` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `msg` varchar(512) DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `pay_type` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rvkywtba8mt261gc1581b56o5` (`member_id`),
  CONSTRAINT `FK_rvkywtba8mt261gc1581b56o5` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_order` */

insert  into `mem_order`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`amount`,`msg`,`order_id`,`pay_type`,`status`,`member_id`) values ('8a2a0842510bb64001510bd7fccb0000','2015-11-15 23:51:23','297e13e7510abab301510abc6e780002',NULL,0,'2015-11-15 23:51:23',1,'',NULL,0,1,'297e13e7510abab301510abc6e780002');

/*Table structure for table `mem_pay` */

DROP TABLE IF EXISTS `mem_pay`;

CREATE TABLE `mem_pay` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `pay_id` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `order_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rp0bk6tgm57pbk38c7on2bs13` (`order_id`),
  KEY `FK_s5hln40harn1jr5kjkesn2nbc` (`member_id`),
  CONSTRAINT `FK_rp0bk6tgm57pbk38c7on2bs13` FOREIGN KEY (`order_id`) REFERENCES `mem_order` (`id`),
  CONSTRAINT `FK_s5hln40harn1jr5kjkesn2nbc` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_pay` */

insert  into `mem_pay`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`pay_id`,`status`,`order_id`,`member_id`) values ('8a2a0842510bb64001510bd7fd0b0001','2015-11-15 23:51:23','297e13e7510abab301510abc6e780002',NULL,0,'2015-11-15 23:51:23','',1,'8a2a0842510bb64001510bd7fccb0000','297e13e7510abab301510abc6e780002');

/*Table structure for table `mem_prasie` */

DROP TABLE IF EXISTS `mem_prasie`;

CREATE TABLE `mem_prasie` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ps7qpsehg6x1p3fi3o7qj29m6` (`member_id`),
  CONSTRAINT `FK_ps7qpsehg6x1p3fi3o7qj29m6` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_prasie` */

/*Table structure for table `mem_user` */

DROP TABLE IF EXISTS `mem_user`;

CREATE TABLE `mem_user` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `last_login_ip` varchar(64) DEFAULT NULL,
  `locked` bit(1) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nick_name` varchar(128) DEFAULT NULL,
  `pwd` varchar(36) DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_user` */

insert  into `mem_user`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`email`,`last_login_date`,`last_login_ip`,`locked`,`mobile`,`nick_name`,`pwd`,`user_name`) values ('297e13e75104a84f015104aaebcd0001','2015-11-14 14:24:49',NULL,NULL,0,'2015-11-15 18:31:30',NULL,'2015-11-15 18:31:30','0:0:0:0:0:0:0:1',NULL,'15622238489','LL','25D55AD283AA400AF464C76D713C07AD',NULL),('297e13e7510abab301510abc6e780002','2015-11-15 18:41:39',NULL,NULL,0,'2015-11-15 23:58:57','382269727@qq.com','2015-11-15 23:50:40','202.105.64.223',NULL,'15622238485','Haha','8DDCFF3A80F4189CA1C9D4D902C3C909',NULL),('40286581510554e4015105578f690001','2015-11-14 17:33:23',NULL,NULL,0,'2015-11-23 14:29:46',NULL,'2015-11-23 14:29:46','0:0:0:0:0:0:0:1',NULL,'18665686291','vivian','25D55AD283AA400AF464C76D713C07AD',NULL),('8a2a0842510bb6e2015120151783000c','2015-11-19 22:10:31',NULL,NULL,0,'2015-11-19 22:10:31','',NULL,NULL,NULL,'15622231234',NULL,NULL,NULL),('8a2a0842511b00d701511daada0c0005','2015-11-19 10:55:14',NULL,NULL,0,'2015-11-23 15:37:33','994179198@qq.com','2015-11-19 15:47:49','14.147.95.121',NULL,'15813354208','lz','38C4ACEE04F062EC557B462034ADB2AB',NULL),('8a2a0842511b00d701511f28a0ef000f','2015-11-19 17:52:15',NULL,NULL,0,'2015-11-20 15:08:32','2896805219@qq.com','2015-11-20 15:08:32','14.147.92.185',NULL,'13088844913','raylee','25D55AD283AA400AF464C76D713C07AD',NULL),('8aad3a75510e718101510ea47e900002','2015-11-16 12:54:00',NULL,NULL,0,'2015-11-21 18:37:26',NULL,'2015-11-21 18:37:26','14.145.253.0',NULL,'18688489640','535150','25D55AD283AA400AF464C76D713C07AD',NULL);

/*Table structure for table `mem_virtual_coin_detail` */

DROP TABLE IF EXISTS `mem_virtual_coin_detail`;

CREATE TABLE `mem_virtual_coin_detail` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ije7kbccjh5aworh6fs736i4q` (`member_id`),
  CONSTRAINT `FK_ije7kbccjh5aworh6fs736i4q` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mem_virtual_coin_detail` */

/*Table structure for table `org_role` */

DROP TABLE IF EXISTS `org_role`;

CREATE TABLE `org_role` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `org_role` */

/*Table structure for table `org_role_resource_rel` */

DROP TABLE IF EXISTS `org_role_resource_rel`;

CREATE TABLE `org_role_resource_rel` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `resource_id` varchar(32) DEFAULT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_g685lwm9whl80x6u6he0do7uj` (`resource_id`),
  KEY `FK_ew2x71wsjwd939pdgqdsvnnsd` (`role_id`),
  CONSTRAINT `FK_ew2x71wsjwd939pdgqdsvnnsd` FOREIGN KEY (`role_id`) REFERENCES `org_role` (`id`),
  CONSTRAINT `FK_g685lwm9whl80x6u6he0do7uj` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `org_role_resource_rel` */

/*Table structure for table `org_user` */

DROP TABLE IF EXISTS `org_user`;

CREATE TABLE `org_user` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `real_name` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `org_user` */

insert  into `org_user`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`email`,`mobile`,`password`,`real_name`,`status`,`username`) values ('2c9025a54d4ffb4a014d4ffe3a670001','2015-09-06 12:56:59','1',NULL,0,'2015-09-20 00:51:15',NULL,NULL,'E10ADC3949BA59ABBE56E057F20F883E','超级管理员',NULL,'admin');

/*Table structure for table `org_user_role_rel` */

DROP TABLE IF EXISTS `org_user_role_rel`;

CREATE TABLE `org_user_role_rel` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ikyyd9vv4u7y3m3yqvqo1vwdd` (`role_id`),
  KEY `FK_92837trmh851io1pb73qjakvf` (`user_id`),
  CONSTRAINT `FK_92837trmh851io1pb73qjakvf` FOREIGN KEY (`user_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_ikyyd9vv4u7y3m3yqvqo1vwdd` FOREIGN KEY (`role_id`) REFERENCES `org_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `org_user_role_rel` */

/*Table structure for table `proposal_back_discount` */

DROP TABLE IF EXISTS `proposal_back_discount`;

CREATE TABLE `proposal_back_discount` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `approvier_date` datetime DEFAULT NULL,
  `bank_card` varchar(128) DEFAULT NULL,
  `bank_name` varchar(128) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `mt4_card` varchar(128) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `pos_status` int(11) DEFAULT NULL,
  `proposal_no` int(11) NOT NULL AUTO_INCREMENT,
  `applier_id` varchar(32) DEFAULT NULL,
  `approvier_id` varchar(32) DEFAULT NULL,
  `broker_info_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `msg` varchar(1024) DEFAULT NULL,
  `register_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_b83ac45w31fas82waxckhsmjx` (`applier_id`),
  KEY `FK_m3w4iubx6fk7pr4axbb6mw83w` (`approvier_id`),
  KEY `FK_fk0hn00lfow18tn33qs665kan` (`broker_info_id`),
  KEY `proposal_no` (`proposal_no`),
  KEY `FK_s97cqyxgkm7gmt4env3cn2s6c` (`member_id`),
  CONSTRAINT `FK_b83ac45w31fas82waxckhsmjx` FOREIGN KEY (`applier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_fk0hn00lfow18tn33qs665kan` FOREIGN KEY (`broker_info_id`) REFERENCES `broker_base_info` (`id`),
  CONSTRAINT `FK_m3w4iubx6fk7pr4axbb6mw83w` FOREIGN KEY (`approvier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_s97cqyxgkm7gmt4env3cn2s6c` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `proposal_back_discount` */

insert  into `proposal_back_discount`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`approvier_date`,`bank_card`,`bank_name`,`email`,`mt4_card`,`name`,`pos_status`,`proposal_no`,`applier_id`,`approvier_id`,`broker_info_id`,`member_id`,`msg`,`register_status`) values ('297e13e751052e5a01510532d5840000','2015-11-14 16:53:16',NULL,NULL,0,'2015-11-15 18:41:49','2015-11-15 16:57:00','626648669485','中国工商银行','382269727@qq.com','123456789','王大锤',0,1,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510178e40151018378ab0000','297e13e7510abab301510abc6e780002',NULL,1),('297e13e75105c683015105d0a2470000','2015-11-14 19:45:37',NULL,NULL,0,'2015-11-15 16:35:05','2015-11-15 16:34:59','6226648900789','中国工商银行','382269727@qq.com','55ww','王小帅',2,2,NULL,'2c9025a54d4ffb4a014d4ffe3a670001',NULL,NULL,'开户平台，核对未通过',NULL),('8a2a0842510adc7801510b0310c70000','2015-11-15 19:58:49',NULL,NULL,0,'2015-11-15 19:59:43','2015-11-15 19:59:42','1234567890','中国银行','xuzhe1111@126.com','xuzhe1111','徐峥',1,3,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510576690151057a20760000',NULL,NULL,NULL),('8a2a0842510adc7801510b10cf560001','2015-11-15 20:13:49',NULL,NULL,0,'2015-11-15 21:27:49','2015-11-15 21:27:48','1234567890','中国工商银行','382269727@qq.com','1234567','王大宝',2,4,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','402865815101d2ec015101dbf9db0000',NULL,'开户平台，开户邮箱，MT4账号，银行卡号，开户银行，开户姓名，核对未通过',NULL),('8a2a08425111137a01511a04446d0003','2015-11-18 17:54:26',NULL,NULL,0,'2015-11-18 17:55:26','2015-11-18 17:55:26','1234567890','招商银行','535150@qq.com','123456','vincentwu',2,5,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510178e40151018378ab0000',NULL,'MT4账号，银行卡号，核对未通过',NULL),('8a2a08425111137a01511a0c1ee50004','2015-11-18 18:03:00',NULL,NULL,0,'2015-11-18 18:03:32','2015-11-18 18:03:31','111111111','中国银行','xuzhe1111@126.com','xuzhe1111','张三',1,6,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510178e40151018551720001',NULL,NULL,NULL),('8a2a08425111137a01511a0f49800005','2015-11-18 18:06:28',NULL,NULL,0,'2015-11-18 18:06:47','2015-11-18 18:06:47','111','张三','2658127751@qq.com','1111','张三',1,7,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','402865815101d2ec015101df28670002',NULL,NULL,NULL),('8a2a08425111137a01511a11148e0006','2015-11-18 18:08:25',NULL,NULL,0,'2015-11-18 18:08:44','2015-11-18 18:08:44','345678922333344','招商银行','whueric@gmail.com','123456','vvvvvv',1,8,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510576690151057a20760000',NULL,NULL,NULL),('8a2a08425111137a01511a1438810007','2015-11-18 18:11:51',NULL,NULL,0,'2015-11-18 18:12:11','2015-11-18 18:12:10','44444','招商银行','535150@qq.com','1233344','GGGGG',2,9,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510178e40151018551720001',NULL,'银行卡号，开户银行，开户姓名，核对未通过',NULL),('8a2a08425111137a01511a15db6d0008','2015-11-18 18:13:38',NULL,NULL,0,'2015-11-18 18:13:57','2015-11-18 18:13:55','34555566','招商银行','535150@qq.com','12233','MyBlog',1,10,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','402865815101d2ec015101df28670002',NULL,NULL,NULL),('8a2a08425111137a01511a1d3dca0009','2015-11-18 18:21:42',NULL,NULL,0,'2015-11-18 18:25:31','2015-11-18 18:25:31','6227003327','建设银行','543201721@qq.com','vivian123an','陈先生',1,11,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','402865815101d2ec015101df28670002',NULL,NULL,NULL),('8a2a08425111137a01511adc693f000a','2015-11-18 21:50:31',NULL,NULL,0,'2015-11-18 21:51:03','2015-11-18 21:51:00','1122333','中国工商银行','382269727@qq.com','1234567','zl',2,12,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','402865815101d2ec015101df28670002',NULL,'开户平台，开户邮箱，MT4账号，银行卡号，开户银行，开户姓名，核对未通过',NULL),('8a2a08425111137a01511ae04789000b','2015-11-18 21:54:44',NULL,NULL,0,'2015-11-18 21:55:26','2015-11-18 21:55:21','333','中国银行','2658127751@qq.com','xu','张三',2,13,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510576690151057a20760000',NULL,'开户平台，开户邮箱，MT4账号，银行卡号，开户银行，开户姓名，核对未通过',NULL),('8a2a0842511b00d701511dd506400007','2015-11-19 11:41:18',NULL,NULL,0,'2015-11-19 12:19:52','2015-11-19 12:19:33','134646987','中国银行','994179198@qq.com','12346','李四',2,14,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','402865815101d2ec015101df28670002',NULL,'MT4账号，银行卡号，开户姓名，核对未通过',NULL),('8a2a0842511b00d701511dfcad9f0008','2015-11-19 12:24:37',NULL,NULL,0,'2015-11-19 12:29:19','2015-11-19 12:29:06','13564698','中国银行','994179198@qq.com','123456','lk',1,15,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510576690151057a20760000','8a2a0842511b00d701511daada0c0005',NULL,NULL),('8a2a0842511b00d701511e01d0730009','2015-11-19 12:30:14',NULL,NULL,0,'2015-11-19 12:30:46','2015-11-19 12:30:39','1546','中国银行','994179198@qq.com','23154','jo',1,16,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510178e40151018551720001','8a2a0842511b00d701511daada0c0005',NULL,NULL),('8a2a0842511b00d701511e0b72cc000a','2015-11-19 12:40:45',NULL,NULL,0,'2015-11-19 12:40:45',NULL,'46487984621','中国银行','994179198@qq.com','132','hoh',0,17,NULL,NULL,'402865815101d2ec015101df28670002',NULL,NULL,NULL),('8a2a0842511b00d701511e69920c000c','2015-11-19 14:23:33',NULL,NULL,0,'2015-11-19 14:23:33',NULL,'4646','随便','994179198@qq.com','16465','jk',0,18,NULL,NULL,'402865815101d2ec015101df28670002',NULL,NULL,NULL),('8a2a0842511b00d701511f0ae09e000d','2015-11-19 17:19:45',NULL,NULL,0,'2015-11-19 17:51:18','2015-11-19 17:51:16','98','好久','994179198@qq.com','79','sg',2,19,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510576690151057a20760000',NULL,'开户平台，开户邮箱，MT4账号，银行卡号，开户银行，开户姓名，核对未通过',NULL),('8a2a0842511b00d70151204807710014','2015-11-19 23:06:10',NULL,NULL,0,'2015-11-19 23:07:34','2015-11-19 23:07:31','123124657897','建設銀行','2896805219@qq.com','12345678','李澄幸',1,20,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510178e40151018551720001','8a2a0842511b00d701511f28a0ef000f',NULL,NULL),('8a2a0842511b00d701512051a38c0015','2015-11-19 23:16:39',NULL,NULL,0,'2015-11-19 23:17:10','2015-11-19 23:17:09','544654441','測試銀行','cuhkraylee@gmail.com','415456464','RRR',2,21,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','402865815101d2ec015101dbf9db0000',NULL,'开户平台，开户邮箱，MT4账号，银行卡号，开户银行，开户姓名，核对未通过',NULL),('8a2a0842511b00d701512055b6320016','2015-11-19 23:21:06',NULL,NULL,0,'2015-11-19 23:21:06',NULL,'52456465465431','最後一個','cuhklee@gmail.com','14545434657','RAFJDJF',0,22,NULL,NULL,'40286581510576690151057a20760000',NULL,NULL,NULL),('8a2a0842511b00d701512055b8c90017','2015-11-19 23:21:07',NULL,NULL,0,'2015-11-19 23:22:18','2015-11-19 23:22:17','52456465465431','最後一個','cuhklee@gmail.com','14545434657','RAFJDJF',1,23,NULL,'2c9025a54d4ffb4a014d4ffe3a670001','40286581510576690151057a20760000',NULL,NULL,NULL);

/*Table structure for table `proposal_coin` */

DROP TABLE IF EXISTS `proposal_coin`;

CREATE TABLE `proposal_coin` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `approvier_date` datetime DEFAULT NULL,
  `coin` int(11) DEFAULT NULL,
  `msg` varchar(1024) DEFAULT NULL,
  `pos_status` int(11) DEFAULT NULL,
  `proposal_no` int(11) NOT NULL AUTO_INCREMENT,
  `applier_id` varchar(32) DEFAULT NULL,
  `approvier_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_39lh82kk13pb77uvl0ihpt8q4` (`applier_id`),
  KEY `FK_cgd79229ad7aqfb0wljashhjg` (`approvier_id`),
  KEY `FK_p0i2kiwbjtsuxvn3tt5rb2yyq` (`member_id`),
  KEY `proposal_no` (`proposal_no`),
  CONSTRAINT `FK_39lh82kk13pb77uvl0ihpt8q4` FOREIGN KEY (`applier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_cgd79229ad7aqfb0wljashhjg` FOREIGN KEY (`approvier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_p0i2kiwbjtsuxvn3tt5rb2yyq` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `proposal_coin` */

insert  into `proposal_coin`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`approvier_date`,`coin`,`msg`,`pos_status`,`proposal_no`,`applier_id`,`approvier_id`,`member_id`) values ('8a2a0842510bb6e201510bdbb28c0002','2015-11-15 23:55:26',NULL,NULL,0,'2015-11-15 23:55:37','2015-11-15 23:55:37',100,NULL,1,1,'2c9025a54d4ffb4a014d4ffe3a670001','2c9025a54d4ffb4a014d4ffe3a670001','297e13e7510abab301510abc6e780002');

/*Table structure for table `proposal_mem_balance` */

DROP TABLE IF EXISTS `proposal_mem_balance`;

CREATE TABLE `proposal_mem_balance` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `applier_id` varchar(32) DEFAULT NULL,
  `approvier_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_94hi0vd30s5alkltxt78003hc` (`applier_id`),
  KEY `FK_o3qg03wem0nug8qpyvsihew36` (`approvier_id`),
  CONSTRAINT `FK_94hi0vd30s5alkltxt78003hc` FOREIGN KEY (`applier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_o3qg03wem0nug8qpyvsihew36` FOREIGN KEY (`approvier_id`) REFERENCES `org_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `proposal_mem_balance` */

/*Table structure for table `proposal_mem_img` */

DROP TABLE IF EXISTS `proposal_mem_img`;

CREATE TABLE `proposal_mem_img` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `approve_date` datetime DEFAULT NULL,
  `img_path` varchar(256) DEFAULT NULL,
  `pos_status` int(11) DEFAULT NULL,
  `proposal_no` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `approvier_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_srd94pls7o8dgey1ytwgxqvsk` (`approvier_id`),
  KEY `FK_or95du40k8vcpuek70c34c33d` (`member_id`),
  KEY `proposal_no` (`proposal_no`),
  CONSTRAINT `FK_or95du40k8vcpuek70c34c33d` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`),
  CONSTRAINT `FK_srd94pls7o8dgey1ytwgxqvsk` FOREIGN KEY (`approvier_id`) REFERENCES `org_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `proposal_mem_img` */

insert  into `proposal_mem_img`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`approve_date`,`img_path`,`pos_status`,`proposal_no`,`type`,`approvier_id`,`member_id`) values ('8a2a0842511b00d701512013f3b10011','2015-11-19 22:09:17','8a2a0842511b00d701511f28a0ef000f','raylee',0,'2015-11-19 22:10:09','2015-11-19 22:10:09','/uploads/gateway/attachment//2015/11/19/a115864e-a63e-4372-b289-af2f1806a363.jpg',2,1,0,'2c9025a54d4ffb4a014d4ffe3a670001','8a2a0842511b00d701511f28a0ef000f'),('8a2a0842511b00d701512014069e0012','2015-11-19 22:09:22','8a2a0842511b00d701511f28a0ef000f','raylee',0,'2015-11-19 22:09:45','2015-11-19 22:09:45','/uploads/gateway/attachment//2015/11/19/8b303817-91d5-47f4-b2c2-6bb3d0dc39f4.jpg',1,2,1,'2c9025a54d4ffb4a014d4ffe3a670001','8a2a0842511b00d701511f28a0ef000f'),('8a2a0842511b00d701512014f0ee0013','2015-11-19 22:10:22','8a2a0842511b00d701511f28a0ef000f','raylee',0,'2015-11-19 22:56:13','2015-11-19 22:56:13','/uploads/gateway/attachment//2015/11/19/56615551-9733-4737-a9e8-efcb53037885.jpg',1,3,0,NULL,'8a2a0842511b00d701511f28a0ef000f');

/*Table structure for table `proposal_mem_modify` */

DROP TABLE IF EXISTS `proposal_mem_modify`;

CREATE TABLE `proposal_mem_modify` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `account_category` varchar(255) DEFAULT NULL,
  `account_type` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bank_account` varchar(255) DEFAULT NULL,
  `bank_address` varchar(255) DEFAULT NULL,
  `bank_card_num` varchar(255) DEFAULT NULL,
  `card` varchar(255) DEFAULT NULL,
  `card_type` int(11) DEFAULT NULL,
  `cn_name` varchar(255) DEFAULT NULL,
  `creator_account_date` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `en_name` varchar(255) DEFAULT NULL,
  `img_bank_card` varchar(255) DEFAULT NULL,
  `img_id_card_a` varchar(255) DEFAULT NULL,
  `img_id_card_b` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `msg` varchar(1024) DEFAULT NULL,
  `nationality_id` varchar(255) DEFAULT NULL,
  `nick_name` varchar(128) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `pos_status` int(11) DEFAULT NULL,
  `pos_type` varchar(255) DEFAULT NULL,
  `proposal_no` int(11) NOT NULL AUTO_INCREMENT,
  `pwd` varchar(128) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `applier_id` varchar(32) DEFAULT NULL,
  `approvier_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_euf7fay2ybfuu27jtofc9xidy` (`applier_id`),
  KEY `FK_tairrmeosoqlddw0jq322l8g2` (`approvier_id`),
  KEY `FK_sp6nh4immih6w1u2ydj07u42` (`member_id`),
  KEY `proposal_no` (`proposal_no`),
  CONSTRAINT `FK_euf7fay2ybfuu27jtofc9xidy` FOREIGN KEY (`applier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_sp6nh4immih6w1u2ydj07u42` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`),
  CONSTRAINT `FK_tairrmeosoqlddw0jq322l8g2` FOREIGN KEY (`approvier_id`) REFERENCES `org_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `proposal_mem_modify` */

insert  into `proposal_mem_modify`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`account_category`,`account_type`,`address`,`bank_account`,`bank_address`,`bank_card_num`,`card`,`card_type`,`cn_name`,`creator_account_date`,`email`,`en_name`,`img_bank_card`,`img_id_card_a`,`img_id_card_b`,`mobile`,`msg`,`nationality_id`,`nick_name`,`no`,`pos_status`,`pos_type`,`proposal_no`,`pwd`,`sex`,`status`,`applier_id`,`approvier_id`,`member_id`) values ('8a2a0842510bb6e201510bb7d66d0000','2015-11-15 23:16:16','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-19 22:10:31','0','0','','','','','',NULL,'','2015-11-15 23:16:16','',NULL,'','',NULL,'15622231234',NULL,'','',NULL,1,'添加',1,'12345678',0,'0','2c9025a54d4ffb4a014d4ffe3a670001','2c9025a54d4ffb4a014d4ffe3a670001',NULL),('8a2a0842510bb6e201510bd2cccc0001','2015-11-15 23:45:43','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 23:49:26','0','0','','中国工商银行','王大锤','626648669485','',NULL,'','2015-11-15 23:45:43','382269727@qq.com',NULL,'','',NULL,'15622238485',NULL,'','Haha',3,1,'修改',2,'88888888',NULL,'0','2c9025a54d4ffb4a014d4ffe3a670001','2c9025a54d4ffb4a014d4ffe3a670001','297e13e7510abab301510abc6e780002'),('8a2a0842510bb6e201510bdec5980006','2015-11-15 23:58:47','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 23:58:57','0','0','','中国工商银行','王大锤','626648669485','',NULL,'','2015-11-15 23:58:47','382269727@qq.com',NULL,'','',NULL,'15622238485',NULL,'','Haha',3,1,'修改',3,'########',NULL,'1','2c9025a54d4ffb4a014d4ffe3a670001','2c9025a54d4ffb4a014d4ffe3a670001','297e13e7510abab301510abc6e780002'),('8a2a0842510bb6e201512010d7bc000a','2015-11-19 22:05:53','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-19 22:06:03','0','0','TESTING@19NOV2015','中國銀行','RAY','62719070000006644478','12345678',0,'李澄幸','2015-11-19 22:05:53','2896805219@qq.com',NULL,'','',NULL,'13088844913',NULL,'','raylee',6,1,'修改',4,'########',NULL,'0','2c9025a54d4ffb4a014d4ffe3a670001','2c9025a54d4ffb4a014d4ffe3a670001','8a2a0842511b00d701511f28a0ef000f');

/*Table structure for table `proposal_mem_regist` */

DROP TABLE IF EXISTS `proposal_mem_regist`;

CREATE TABLE `proposal_mem_regist` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `applier_id` varchar(32) DEFAULT NULL,
  `approvier_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rymvihvuenrm8cwtlte1d6xe4` (`applier_id`),
  KEY `FK_rvhu4bkbxrjcstdukh143csqj` (`approvier_id`),
  CONSTRAINT `FK_rvhu4bkbxrjcstdukh143csqj` FOREIGN KEY (`approvier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_rymvihvuenrm8cwtlte1d6xe4` FOREIGN KEY (`applier_id`) REFERENCES `org_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `proposal_mem_regist` */

/*Table structure for table `proposal_mem_trade` */

DROP TABLE IF EXISTS `proposal_mem_trade`;

CREATE TABLE `proposal_mem_trade` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `approve_date` datetime DEFAULT NULL,
  `bg_msg` varchar(512) DEFAULT NULL,
  `front_msg` varchar(512) DEFAULT NULL,
  `ip` varchar(128) DEFAULT NULL,
  `pay_type` int(11) DEFAULT NULL,
  `proposal_no` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT NULL,
  `trade_id` varchar(255) DEFAULT NULL,
  `applier_id` varchar(32) DEFAULT NULL,
  `approvier_id` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_8afbu6moxxximtil95klhg2f1` (`applier_id`),
  KEY `FK_lpbpdps6f3qed5fkd2c46nnow` (`approvier_id`),
  KEY `FK_c5mo3ummlvciwpauo8gfftecj` (`member_id`),
  KEY `proposal_no` (`proposal_no`),
  CONSTRAINT `FK_8afbu6moxxximtil95klhg2f1` FOREIGN KEY (`applier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_c5mo3ummlvciwpauo8gfftecj` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`),
  CONSTRAINT `FK_lpbpdps6f3qed5fkd2c46nnow` FOREIGN KEY (`approvier_id`) REFERENCES `org_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `proposal_mem_trade` */

insert  into `proposal_mem_trade`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`amount`,`approve_date`,`bg_msg`,`front_msg`,`ip`,`pay_type`,`proposal_no`,`status`,`trade_id`,`applier_id`,`approvier_id`,`member_id`) values ('8a2a0842510b52ba01510b71ee960000','2015-11-15 21:59:54','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 21:59:54',1,NULL,NULL,NULL,'116.23.24.237',3,1,0,'12345678','2c9025a54d4ffb4a014d4ffe3a670001',NULL,'297e13e7510abab301510abc6e780002'),('8a2a0842510bb6e201510bdc622b0004','2015-11-15 23:56:11','2c9025a54d4ffb4a014d4ffe3a670001','admin',0,'2015-11-15 23:56:17',2,'2015-11-15 23:56:17',NULL,NULL,'202.105.64.52',3,2,1,'12345678','2c9025a54d4ffb4a014d4ffe3a670001','2c9025a54d4ffb4a014d4ffe3a670001','297e13e7510abab301510abc6e780002');

/*Table structure for table `proposal_teacher_draw` */

DROP TABLE IF EXISTS `proposal_teacher_draw`;

CREATE TABLE `proposal_teacher_draw` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `applier_id` varchar(32) DEFAULT NULL,
  `approvier_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pme4n4wy2j456orrrtwevb5mr` (`applier_id`),
  KEY `FK_g5rqhfihyko5ee6t76kou937l` (`approvier_id`),
  CONSTRAINT `FK_g5rqhfihyko5ee6t76kou937l` FOREIGN KEY (`approvier_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_pme4n4wy2j456orrrtwevb5mr` FOREIGN KEY (`applier_id`) REFERENCES `org_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `proposal_teacher_draw` */

/*Table structure for table `resource` */

DROP TABLE IF EXISTS `resource`;

CREATE TABLE `resource` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `order_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_gnufb2v2pygtgyoexh7kmv3dc` (`parent_id`),
  CONSTRAINT `FK_gnufb2v2pygtgyoexh7kmv3dc` FOREIGN KEY (`parent_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `resource` */

insert  into `resource`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`name`,`type`,`url`,`parent_id`,`order_no`) values ('1',NULL,NULL,NULL,0,NULL,'经纪商模块','module',NULL,NULL,3000),('2',NULL,NULL,NULL,0,NULL,'经纪商列表','page','/brokerExtInfo/list','1',3001),('297e13e75105f192015105f9d79d0000','2015-11-14 20:30:38',NULL,NULL,0,'2015-11-14 20:30:38','返佣申请提案','page','/mem/pos/back_discount_list','8',NULL),('2c9081294dc93abd014dc93bb5700001',NULL,NULL,NULL,0,NULL,'系统管理','module','javascript:void(0);',NULL,1000),('2c9081294dc93abd014dc93c52650002',NULL,NULL,NULL,1,NULL,'部门管理','page','/boss/department/list','2c9081294dc93abd014dc93bb5700001',1001),('2c9081294dc93abd014dc93cb5ad0003',NULL,NULL,NULL,0,NULL,'用户管理','page','/boss/user/list','2c9081294dc93abd014dc93bb5700001',1002),('2c9081294dc93abd014dc93d0cba0004',NULL,NULL,NULL,0,NULL,'角色管理','page','/boss/role/list','2c9081294dc93abd014dc93bb5700001',1003),('2c9081294dc93abd014dc93d6f4c0005',NULL,NULL,NULL,0,NULL,'资源管理','page','/boss/resource/list','2c9081294dc93abd014dc93bb5700001',1004),('2c9081294dc93abd014dc93e933f0006',NULL,NULL,NULL,1,NULL,'登录管理','page','/boss/log/list','2c9081294dc93abd014dc93bb5700001',1005),('2c9081294dc93abd014dc93f2dca0007',NULL,NULL,NULL,0,NULL,'修改密码','page','/boss/user/updatePwd','2c9081294dc93abd014dc93bb5700001',1006),('3',NULL,NULL,NULL,0,NULL,'投票模块','module',NULL,NULL,4000),('4',NULL,NULL,NULL,0,NULL,'投票主题列表','page','/voteTopic/list','3',4001),('402865815085d1e9015085d313360000','2015-10-20 23:16:54',NULL,NULL,0,'2015-10-20 23:32:50','举报明细列表','page','/postUnionReplay/report/list','3',NULL),('402881e5503bcb6601503bcd27580000','2015-10-06 14:18:32',NULL,NULL,0,'2015-10-06 14:18:32','资金管理','module','javascript:void(0);',NULL,7000),('402881e5503bcb6601503bcdc5ae0001','2015-10-06 14:19:13',NULL,NULL,0,'2015-10-18 02:24:18','虚拟币充值','page','/fund/pay/list','402881e5503bcb6601503bcd27580000',7001),('402881e550734b240150734cd4190000','2015-10-17 08:57:06',NULL,NULL,0,'2015-10-17 08:57:06','会员提案','page','/mem/pos/list?posStatus=0','8',NULL),('402881e5509928a10150992c5fa20000','2015-10-24 17:27:13',NULL,NULL,0,'2015-10-24 17:28:01','会员证明提案','page','/mem/pos/img/list?status=0','8',NULL),('5',NULL,NULL,NULL,0,NULL,'投票结果列表','page','/voteResult/list','3',4002),('6',NULL,NULL,NULL,0,NULL,'公告模块','module',NULL,NULL,5000),('7',NULL,NULL,NULL,0,NULL,'公告列表','page','/notice/list','6',5001),('8',NULL,NULL,NULL,0,NULL,'账户模块','module',NULL,NULL,2000),('8a2a08425076316b015078b78fcb0000','2015-10-18 10:11:47',NULL,NULL,0,'2015-10-18 10:11:47','支付平台','module','javascript:void(0);',NULL,6000),('8a2a08425076316b015078b7c9860001','2015-10-18 10:12:02',NULL,NULL,0,'2015-10-18 11:25:04','支付平台记录','page','/order/list','8a2a08425076316b015078b78fcb0000',6001),('8a2a08425076316b015078c08c230002','2015-10-18 10:21:36',NULL,NULL,0,'2015-10-18 03:51:21','虚拟币调整','page','/pos/coin/list','402881e5503bcb6601503bcd27580000',7002),('8a2a084250792ac501508414e5c40005','2015-10-20 15:09:34',NULL,NULL,0,'2015-10-20 15:09:34','评论回复管理','page','/postUnionReplay/list','3',NULL),('8a2a0842509a7f3d01509cbe70a80000','2015-10-25 10:05:38',NULL,NULL,0,'2015-10-25 10:05:38','批量导入','page','/member/import/list','8',NULL),('8a2a0842509fc9040150d326146f004c','2015-11-04 23:38:20',NULL,NULL,0,'2015-11-04 23:38:20','经纪商excel导出','page','/brokerExtInfo/exl/list','1',NULL),('9',NULL,NULL,NULL,0,'2015-10-08 00:02:32','会员管理','page','/member/list','8',2001);

/*Table structure for table `vote_member_log` */

DROP TABLE IF EXISTS `vote_member_log`;

CREATE TABLE `vote_member_log` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `vote_topic_id` varchar(32) DEFAULT NULL,
  `vote_topic_option_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_4i7cnvm36q2vrahxpy8nvw6p8` (`member_id`),
  KEY `FK_t00508s8q577vx8xk7flk11u4` (`vote_topic_id`),
  KEY `FK_6pb82914p7xqaeueg2t50i814` (`vote_topic_option_id`),
  CONSTRAINT `FK_4i7cnvm36q2vrahxpy8nvw6p8` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`),
  CONSTRAINT `FK_6pb82914p7xqaeueg2t50i814` FOREIGN KEY (`vote_topic_option_id`) REFERENCES `vote_topic_option` (`id`),
  CONSTRAINT `FK_t00508s8q577vx8xk7flk11u4` FOREIGN KEY (`vote_topic_id`) REFERENCES `vote_topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_member_log` */

insert  into `vote_member_log`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`ip_address`,`member_id`,`vote_topic_id`,`vote_topic_option_id`) values ('4028658151060b6b0151061c82a60000','2015-11-14 21:08:30',NULL,NULL,0,'2015-11-14 21:08:30','0:0:0:0:0:0:0:1','40286581510554e4015105578f690001','40288a60510067490151006802ff0000','40288a60510067490151006803240001'),('40286581510924950151092b8f4e0000','2015-11-15 11:23:48',NULL,NULL,0,'2015-11-15 11:23:48','0:0:0:0:0:0:0:1','40286581510554e4015105578f690001','40286581510924c30151092800d80000','40286581510924c30151092800f10001'),('8a2a0842510a3f3201510a4037720000','2015-11-15 16:25:59',NULL,NULL,0,'2015-11-15 16:25:59','119.131.175.189',NULL,'40286581510924c30151092800d80000','40286581510924c30151092800f10003'),('8a2a08425111137a0151131146390000','2015-11-17 09:31:17',NULL,NULL,0,'2015-11-17 09:31:17','14.147.95.66',NULL,'40286581510924c30151092800d80000','40286581510924c30151092800f10001'),('8a2a08425111137a01511498d0690002','2015-11-17 16:38:57',NULL,NULL,0,'2015-11-17 16:38:57','120.197.20.159',NULL,'40286581510924c30151092800d80000','40286581510924c30151092800f10001'),('8a2a0842511b00d701511e2b3de8000b','2015-11-19 13:15:29',NULL,NULL,0,'2015-11-19 13:15:29','14.147.95.121',NULL,'40286581510924c30151092800d80000','40286581510924c30151092800f10001');

/*Table structure for table `vote_post_praise` */

DROP TABLE IF EXISTS `vote_post_praise`;

CREATE TABLE `vote_post_praise` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `vote_topic_post_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_a8ae0t8j9ul0c0ctqne94ilr` (`member_id`),
  KEY `FK_1q4fymnkhtxqd4j1en2e635u3` (`vote_topic_post_id`),
  CONSTRAINT `FK_1q4fymnkhtxqd4j1en2e635u3` FOREIGN KEY (`vote_topic_post_id`) REFERENCES `vote_topic_post` (`id`),
  CONSTRAINT `FK_a8ae0t8j9ul0c0ctqne94ilr` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_post_praise` */

insert  into `vote_post_praise`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`ip_address`,`member_id`,`vote_topic_post_id`) values ('40286581510924950151092c0ff70002','2015-11-15 11:24:21',NULL,NULL,0,'2015-11-15 11:24:21','0:0:0:0:0:0:0:1','40286581510554e4015105578f690001','40286581510924950151092bfa1c0001');

/*Table structure for table `vote_post_report` */

DROP TABLE IF EXISTS `vote_post_report`;

CREATE TABLE `vote_post_report` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `vote_topic_post_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_oxeca8dkat79tk8706d62epqe` (`member_id`),
  KEY `FK_mer5qto611a6uacquu5306j8x` (`vote_topic_post_id`),
  CONSTRAINT `FK_mer5qto611a6uacquu5306j8x` FOREIGN KEY (`vote_topic_post_id`) REFERENCES `vote_topic_post` (`id`),
  CONSTRAINT `FK_oxeca8dkat79tk8706d62epqe` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_post_report` */

/*Table structure for table `vote_replay_praise` */

DROP TABLE IF EXISTS `vote_replay_praise`;

CREATE TABLE `vote_replay_praise` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `vote_post_replay_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_r2jdywu9ik34lgk35ftlhwc8t` (`member_id`),
  KEY `FK_gw50dabjittpldniu1cfhajaj` (`vote_post_replay_id`),
  CONSTRAINT `FK_gw50dabjittpldniu1cfhajaj` FOREIGN KEY (`vote_post_replay_id`) REFERENCES `vote_topic_post_replay` (`id`),
  CONSTRAINT `FK_r2jdywu9ik34lgk35ftlhwc8t` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_replay_praise` */

/*Table structure for table `vote_replay_report` */

DROP TABLE IF EXISTS `vote_replay_report`;

CREATE TABLE `vote_replay_report` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `vote_post_replay_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_amixc9q5ywbwp3ps6fqiw681k` (`member_id`),
  KEY `FK_6n6rehr009tmrx99d40xg2w0a` (`vote_post_replay_id`),
  CONSTRAINT `FK_6n6rehr009tmrx99d40xg2w0a` FOREIGN KEY (`vote_post_replay_id`) REFERENCES `vote_topic_post_replay` (`id`),
  CONSTRAINT `FK_amixc9q5ywbwp3ps6fqiw681k` FOREIGN KEY (`member_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_replay_report` */

/*Table structure for table `vote_topic` */

DROP TABLE IF EXISTS `vote_topic`;

CREATE TABLE `vote_topic` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `display_position` varchar(2) DEFAULT NULL,
  `display_type` varchar(2) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `is_comment` bit(1) DEFAULT NULL,
  `schedule` varchar(2) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `title_content` varchar(128) DEFAULT NULL,
  `vote_count` int(11) DEFAULT NULL,
  `image_url` varchar(64) DEFAULT NULL,
  `post_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_topic` */

insert  into `vote_topic`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`display_position`,`display_type`,`end_date`,`is_comment`,`schedule`,`start_date`,`title_content`,`vote_count`,`image_url`,`post_count`) values ('40286581510924c30151092800d80000','2015-11-15 11:19:55','','',0,'2015-11-19 13:15:29','0','0','2015-11-25 11:19:02','','2','2015-11-15 11:18:58','人民币是否在挑战美元？',5,'',1),('40288a60510067490151006802ff0000','2015-11-13 18:33:15','','admin',0,'2015-11-15 11:20:19','0','0','2015-11-14 18:32:51','','1','2015-11-10 18:32:47','美国总统候选人开始挑战中国？',NULL,'',NULL);

/*Table structure for table `vote_topic_option` */

DROP TABLE IF EXISTS `vote_topic_option`;

CREATE TABLE `vote_topic_option` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `option_content` varchar(256) DEFAULT NULL,
  `vote_count` int(11) DEFAULT NULL,
  `vote_topic_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_57aihs7091hbi44buxkyobhk4` (`vote_topic_id`),
  CONSTRAINT `FK_57aihs7091hbi44buxkyobhk4` FOREIGN KEY (`vote_topic_id`) REFERENCES `vote_topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_topic_option` */

insert  into `vote_topic_option`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`option_content`,`vote_count`,`vote_topic_id`) values ('40286581510924c30151092800f10001','2015-11-15 11:19:55',NULL,'',0,'2015-11-19 13:15:29','是的',4,'40286581510924c30151092800d80000'),('40286581510924c30151092800f10002','2015-11-15 11:19:55',NULL,'',0,'2015-11-15 11:19:55','不是',0,'40286581510924c30151092800d80000'),('40286581510924c30151092800f10003','2015-11-15 11:19:55',NULL,'',0,'2015-11-15 16:25:59','不好说',1,'40286581510924c30151092800d80000'),('40288a60510067490151006803240001','2015-11-13 18:33:15',NULL,'admin',0,'2015-11-14 21:08:30','是的',1,'40288a60510067490151006802ff0000'),('40288a60510067490151006803250002','2015-11-13 18:33:15',NULL,'admin',0,'2015-11-13 18:33:15','没有',0,'40288a60510067490151006802ff0000'),('40288a60510067490151006803250003','2015-11-13 18:33:15',NULL,'admin',0,'2015-11-13 18:33:15','不清楚',0,'40288a60510067490151006802ff0000');

/*Table structure for table `vote_topic_post` */

DROP TABLE IF EXISTS `vote_topic_post`;

CREATE TABLE `vote_topic_post` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `floor_numb` int(11) DEFAULT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `post_content` varchar(512) DEFAULT NULL,
  `praise_count` int(11) DEFAULT NULL,
  `report_count` int(11) DEFAULT NULL,
  `publisher_id` varchar(32) DEFAULT NULL,
  `vote_topic_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_j5vtardwret4lp0mmpvn25rcm` (`publisher_id`),
  KEY `FK_57kb3n8ve7ebqi5m8f8uif77b` (`vote_topic_id`),
  CONSTRAINT `FK_57kb3n8ve7ebqi5m8f8uif77b` FOREIGN KEY (`vote_topic_id`) REFERENCES `vote_topic` (`id`),
  CONSTRAINT `FK_j5vtardwret4lp0mmpvn25rcm` FOREIGN KEY (`publisher_id`) REFERENCES `mem_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_topic_post` */

insert  into `vote_topic_post`(`id`,`create_date`,`create_id`,`create_name`,`delete_flag`,`update_date`,`floor_numb`,`ip_address`,`post_content`,`praise_count`,`report_count`,`publisher_id`,`vote_topic_id`) values ('40286581510924950151092bfa1c0001','2015-11-15 11:24:15',NULL,NULL,0,'2015-11-15 11:24:21',1,'0:0:0:0:0:0:0:1','测试投票功能',1,0,'40286581510554e4015105578f690001','40286581510924c30151092800d80000');

/*Table structure for table `vote_topic_post_replay` */

DROP TABLE IF EXISTS `vote_topic_post_replay`;

CREATE TABLE `vote_topic_post_replay` (
  `id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_id` varchar(32) DEFAULT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `praise_count` int(11) DEFAULT NULL,
  `replay_content` varchar(512) DEFAULT NULL,
  `report_count` int(11) DEFAULT NULL,
  `replayer_id` varchar(32) DEFAULT NULL,
  `vote_topic_id` varchar(32) DEFAULT NULL,
  `vote_topic_post_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cn6c7iugkmot8n3pms3l876s4` (`replayer_id`),
  KEY `FK_iia0bxvsw1bwba0umtavtvwce` (`vote_topic_id`),
  KEY `FK_tma7vusyltb72kbflfsv6bkoa` (`vote_topic_post_id`),
  CONSTRAINT `FK_cn6c7iugkmot8n3pms3l876s4` FOREIGN KEY (`replayer_id`) REFERENCES `mem_member` (`id`),
  CONSTRAINT `FK_iia0bxvsw1bwba0umtavtvwce` FOREIGN KEY (`vote_topic_id`) REFERENCES `vote_topic` (`id`),
  CONSTRAINT `FK_tma7vusyltb72kbflfsv6bkoa` FOREIGN KEY (`vote_topic_post_id`) REFERENCES `vote_topic_post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vote_topic_post_replay` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;