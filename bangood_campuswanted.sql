-- MySQL dump 10.14  Distrib 5.5.47-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: campuswanted
-- ------------------------------------------------------
-- Server version	5.5.47-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `active_admin_comments`
--

DROP TABLE IF EXISTS `active_admin_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_admin_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namespace` varchar(255) DEFAULT NULL,
  `body` text,
  `resource_id` varchar(255) NOT NULL,
  `resource_type` varchar(255) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_active_admin_comments_on_namespace` (`namespace`),
  KEY `index_active_admin_comments_on_author_type_and_author_id` (`author_type`,`author_id`),
  KEY `index_active_admin_comments_on_resource_type_and_resource_id` (`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_admin_comments`
--

LOCK TABLES `active_admin_comments` WRITE;
/*!40000 ALTER TABLE `active_admin_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_admin_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_version`
--

DROP TABLE IF EXISTS `app_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_version` (
  `version_code` int(11) NOT NULL AUTO_INCREMENT,
  `version_name` varchar(64) DEFAULT NULL,
  `force_update` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`version_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_version`
--

LOCK TABLES `app_version` WRITE;
/*!40000 ALTER TABLE `app_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(45) DEFAULT NULL,
  `bank_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `draw_pool`
--

DROP TABLE IF EXISTS `draw_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draw_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(64) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `050_idx` (`post_id`) USING BTREE,
  CONSTRAINT `050` FOREIGN KEY (`post_id`) REFERENCES `wanted_board` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `draw_pool`
--

LOCK TABLES `draw_pool` WRITE;
/*!40000 ALTER TABLE `draw_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `draw_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facebook_user`
--

DROP TABLE IF EXISTS `facebook_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facebook_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(255) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `oauth_token` varchar(255) DEFAULT NULL,
  `oauth_expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facebook_user`
--

LOCK TABLES `facebook_user` WRITE;
/*!40000 ALTER TABLE `facebook_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `facebook_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` longtext,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_pool`
--

DROP TABLE IF EXISTS `image_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(64) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `011_idx` (`user_id`) USING BTREE,
  CONSTRAINT `011` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_pool`
--

LOCK TABLES `image_pool` WRITE;
/*!40000 ALTER TABLE `image_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` longtext,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_log`
--

DROP TABLE IF EXISTS `pay_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imp` varchar(255) DEFAULT NULL,
  `merchant` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_log`
--

LOCK TABLES `pay_log` WRITE;
/*!40000 ALTER TABLE `pay_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_term`
--

DROP TABLE IF EXISTS `pay_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_term` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `term_code` varchar(8) DEFAULT NULL,
  `term_content` longtext,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_term`
--

LOCK TABLES `pay_term` WRITE;
/*!40000 ALTER TABLE `pay_term` DISABLE KEYS */;
INSERT INTO `pay_term` VALUES (1,'1.0','this is pay_term vision1.0','2016-04-14 09:07:43','2016-04-14 09:07:43');
/*!40000 ALTER TABLE `pay_term` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_configurations`
--

DROP TABLE IF EXISTS `push_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `app` varchar(255) NOT NULL,
  `properties` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `connections` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_configurations`
--

LOCK TABLES `push_configurations` WRITE;
/*!40000 ALTER TABLE `push_configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_feedback`
--

DROP TABLE IF EXISTS `push_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `device` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `follow_up` varchar(255) NOT NULL,
  `failed_at` datetime NOT NULL,
  `processed` tinyint(1) NOT NULL DEFAULT '0',
  `processed_at` datetime DEFAULT NULL,
  `properties` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_push_feedback_on_processed` (`processed`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_feedback`
--

LOCK TABLES `push_feedback` WRITE;
/*!40000 ALTER TABLE `push_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_messages`
--

DROP TABLE IF EXISTS `push_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `device` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `properties` text,
  `delivered` tinyint(1) NOT NULL DEFAULT '0',
  `delivered_at` datetime DEFAULT NULL,
  `failed` tinyint(1) NOT NULL DEFAULT '0',
  `failed_at` datetime DEFAULT NULL,
  `error_code` int(11) DEFAULT NULL,
  `error_description` varchar(255) DEFAULT NULL,
  `deliver_after` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_push_messages_on_delivered_and_failed_and_deliver_after` (`delivered`,`failed`,`deliver_after`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_messages`
--

LOCK TABLES `push_messages` WRITE;
/*!40000 ALTER TABLE `push_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_onoff`
--

DROP TABLE IF EXISTS `push_onoff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_onoff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `onoff` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_onoff`
--

LOCK TABLES `push_onoff` WRITE;
/*!40000 ALTER TABLE `push_onoff` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_onoff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reward_item`
--

DROP TABLE IF EXISTS `reward_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reward_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_code` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reward_item`
--

LOCK TABLES `reward_item` WRITE;
/*!40000 ALTER TABLE `reward_item` DISABLE KEYS */;
INSERT INTO `reward_item` VALUES (1,0,'no_item',0,'2016-04-14 09:07:43','2016-04-14 09:07:43'),(2,1,'pop_corn',1500,'2016-04-14 09:07:43','2016-04-14 09:07:43'),(3,2,'americano',4100,'2016-04-14 09:07:43','2016-04-14 09:07:43'),(4,3,'ice_americano',4100,'2016-04-14 09:07:43','2016-04-14 09:07:43'),(5,4,'gift_ticket',5000,'2016-04-14 09:07:43','2016-04-14 09:07:43');
/*!40000 ALTER TABLE `reward_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('1'),('20160414090404');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `share_log`
--

DROP TABLE IF EXISTS `share_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `share_type` varchar(8) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `007_idx` (`post_id`) USING BTREE,
  CONSTRAINT `007` FOREIGN KEY (`post_id`) REFERENCES `wanted_board` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `share_log`
--

LOCK TABLES `share_log` WRITE;
/*!40000 ALTER TABLE `share_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `share_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `term`
--

DROP TABLE IF EXISTS `term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `term` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `term_code` varchar(8) DEFAULT NULL,
  `term_content` longtext,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `term`
--

LOCK TABLES `term` WRITE;
/*!40000 ALTER TABLE `term` DISABLE KEYS */;
INSERT INTO `term` VALUES (1,'1.0','this is terms version 1.0','2016-04-14 09:07:43','2016-04-14 09:07:43'),(2,'1.1','this is terms version 1.1','2016-04-14 09:07:43','2016-04-14 09:07:43');
/*!40000 ALTER TABLE `term` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utoken` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `univ_category`
--

DROP TABLE IF EXISTS `univ_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `univ_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `univ_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `univ_category`
--

LOCK TABLES `univ_category` WRITE;
/*!40000 ALTER TABLE `univ_category` DISABLE KEYS */;
INSERT INTO `univ_category` VALUES (1,'ajou'),(2,'korea'),(3,'seoul');
/*!40000 ALTER TABLE `univ_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `facebook_token` varchar(255) DEFAULT NULL,
  `profile_img` int(11) DEFAULT NULL,
  `user_token` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wanted_board`
--

DROP TABLE IF EXISTS `wanted_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wanted_board` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `univ_id` int(11) DEFAULT NULL,
  `witness_date` datetime DEFAULT NULL,
  `is_place_maps` tinyint(1) DEFAULT NULL,
  `witness_place` varchar(255) DEFAULT NULL,
  `target_gen` varchar(1) DEFAULT NULL,
  `talk_to` mediumtext,
  `reward` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `count_share` int(11) DEFAULT '0',
  `draw_img` varchar(255) DEFAULT NULL,
  `choosed_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `lat` decimal(10,6) DEFAULT NULL,
  `lon` decimal(10,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `004_idx` (`univ_id`) USING BTREE,
  KEY `001_idx` (`user_id`) USING BTREE,
  CONSTRAINT `001` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `004` FOREIGN KEY (`univ_id`) REFERENCES `univ_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wanted_board`
--

LOCK TABLES `wanted_board` WRITE;
/*!40000 ALTER TABLE `wanted_board` DISABLE KEYS */;
/*!40000 ALTER TABLE `wanted_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wanted_comment`
--

DROP TABLE IF EXISTS `wanted_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wanted_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wanted_board_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `003_idx` (`wanted_board_id`) USING BTREE,
  KEY `002_idx` (`user_id`) USING BTREE,
  CONSTRAINT `003` FOREIGN KEY (`wanted_board_id`) REFERENCES `wanted_board` (`id`),
  CONSTRAINT `002` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wanted_comment`
--

LOCK TABLES `wanted_comment` WRITE;
/*!40000 ALTER TABLE `wanted_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `wanted_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraw`
--

DROP TABLE IF EXISTS `withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `sum` int(11) DEFAULT NULL,
  `bank_account` varchar(64) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `009_idx` (`bank_id`) USING BTREE,
  KEY `008_idx` (`user_id`) USING BTREE,
  CONSTRAINT `008` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `010` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw`
--

LOCK TABLES `withdraw` WRITE;
/*!40000 ALTER TABLE `withdraw` DISABLE KEYS */;
/*!40000 ALTER TABLE `withdraw` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-14 10:13:35
