-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: ting_ordering_system
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address_book`
--

DROP TABLE IF EXISTS `address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚嵉',
  `user_id` bigint NOT NULL COMMENT '鐢ㄦ埗id',
  `consignee` varchar(50) DEFAULT NULL COMMENT '鑱公浜?,
  `sex` varchar(2) DEFAULT NULL COMMENT '鎬у垾',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '鎵嬫铏熺⒓',
  `city_code` varchar(12) DEFAULT NULL COMMENT '甯傜礆绶ㄨ櫉',
  `city_name` varchar(32) DEFAULT NULL COMMENT '甯傜骇鍚嶇ū',
  `district_code` varchar(12) DEFAULT NULL COMMENT '鍗€绾х法铏?,
  `district_name` varchar(32) DEFAULT NULL COMMENT '鍗€绾у悕绋?,
  `detail` varchar(200) DEFAULT NULL COMMENT '瑭崇窗鍦板潃',
  `label` varchar(100) DEFAULT NULL COMMENT '妯欑堡',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '榛樿獚 0 鍚?1 鏄?,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鍦板潃绨?;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_book`
--

LOCK TABLES `address_book` WRITE;
/*!40000 ALTER TABLE `address_book` DISABLE KEYS */;
INSERT INTO `address_book` VALUES (3,1,NULL,'0','0912345888','2','鍗楁姇','2','瑗垮崁','杌嶆殙琛?82铏?F2','鍏徃',1),(4,1,NULL,'0','0933345888','3','鍙颁腑','2','鍖楀崁','澶ф睙琛?铏?F2','瀹?,0),(8,44,'193','0','0912345678','','鍙板寳','','鏉卞崁','98铏?,'',1),(9,32,'1234','0','0912345678','','鍙板寳','','鏉卞崁','38铏?,'',0),(12,32,'8743','1','0937489237','','瀹滆槶','','','澶ф睙琛?8铏?,'',0),(14,44,'1234','1','0912345678','','鏂板寳','','','238铏?妯?,'',0),(15,44,'1234','1','0912345678','','鏂扮','','','232铏熶笁妯?,'',0);
/*!40000 ALTER TABLE `address_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚敭',
  `name` varchar(32) NOT NULL COMMENT '鍒嗛鍚嶇ū',
  `status` int DEFAULT '1' COMMENT '鍒嗛鐙€鎱?0:绂佺敤锛?:鍟熺敤',
  `create_time` datetime DEFAULT NULL COMMENT '鍓靛缓鏅傞枔',
  `update_time` datetime DEFAULT NULL COMMENT '鏇存柊鏅傞枔',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='椁愰粸鍒嗛';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'榄氶',0,'2025-01-14 14:40:35','2025-02-08 14:20:58'),(2,'闁嬭儍鑿?,0,'2025-01-01 12:00:00','2025-02-08 14:21:50'),(3,'涓昏彍',1,'2025-01-02 13:30:00','2025-01-11 16:00:00'),(4,'鐢滈粸',1,'2025-01-03 14:00:00','2025-01-12 17:00:00'),(5,'椋插搧',1,'2025-01-04 14:30:00','2025-01-13 18:00:00'),(6,'灏忓悆',1,'2025-01-05 15:00:00','2025-01-14 19:00:00'),(7,'婀搧',1,'2025-01-06 16:00:00','2025-01-15 20:00:00'),(8,'娌欐媺',1,'2025-01-07 17:00:00','2025-01-16 21:00:00'),(9,'楹甸',0,'2025-01-08 18:00:00','2025-02-08 14:22:34'),(10,'鐕掔儰',1,'2025-01-09 19:00:00','2025-02-08 14:33:03'),(11,'鍐板搧',1,'2025-01-10 20:00:00','2025-02-08 14:24:50'),(14,'鍗堥',0,'2025-01-13 23:00:00','2025-02-08 14:18:40'),(15,'鏅氶',0,'2025-01-14 08:00:00','2025-02-08 14:18:39'),(16,'瀹靛',0,'2025-01-15 09:00:00','2025-02-08 14:18:36'),(23,'瑗块粸',0,'2025-01-14 18:08:23','2025-01-17 21:44:57'),(25,'娴疯崏',0,'2025-01-17 21:44:53','2025-01-17 21:44:55'),(30,'闆堕',1,'2025-02-08 14:17:39','2025-02-08 14:18:01');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meal`
--

DROP TABLE IF EXISTS `meal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚嵉',
  `name` varchar(32) NOT NULL COMMENT '椁愰粸鍚嶇ū',
  `category_id` bigint NOT NULL COMMENT '椁愰粸鍒嗛id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '椁愰粸鍍规牸',
  `image` varchar(255) DEFAULT NULL COMMENT '椁愰粸鍦栫墖',
  `description` varchar(255) DEFAULT NULL COMMENT '椁愰粸鎻忚堪',
  `status` int DEFAULT '1' COMMENT '0 鍋滃敭 1 璨╁敭涓?,
  `create_time` datetime DEFAULT NULL COMMENT '鍓靛缓鏅傞枔',
  `update_time` datetime DEFAULT NULL COMMENT '鏇存柊鏅傞枔',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='椁愰粸';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meal`
--

LOCK TABLES `meal` WRITE;
/*!40000 ALTER TABLE `meal` DISABLE KEYS */;
INSERT INTO `meal` VALUES (2,'铦﹂',30,60.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9d4eba2f-10ea-434a-8672-a6e53b9f27d8.jpg','棣欒剢鐨勮潶椁呬綈浠ョ壒瑁介啲鏂?,1,'2025-01-01 12:40:00','2025-02-08 14:18:18'),(3,'鐑ょ墰鎺?,3,350.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/33b21f85-ea65-4bb6-becd-4d21f5b60fc0.jpg','绮鹃伕鑲夎唱瀚╂粦鐨勭儰鐗涙帓',1,'2025-01-02 13:40:00','2025-02-08 14:19:22'),(5,'宸у厠鍔涜泲绯?,4,120.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/34410213-4971-4e4e-815f-41aefb1aa34b.jpg','婵冮儊鐨勫阀鍏嬪姏棰ㄥ懗铔嬬硶',1,'2025-01-03 14:40:00','2025-02-08 14:19:16'),(6,'鑽夎帗濂堕叒',4,90.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/dadd55a7-8d63-4753-ad63-215a9af12019.jpg','娓呮柊棣欑敎鐨勮崏鑾撳ザ閰?,1,'2025-01-03 14:50:00','2025-02-08 14:19:10'),(7,'妾告绱呰尪',5,40.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f4efbb29-2859-4f3a-bb77-98e0575a7f5d.jpg','鎻愮閱掕叇鐨勬妾磪鑼?,1,'2025-01-04 14:40:00','2025-02-08 14:19:04'),(8,'鎷块惖鍜栧暋',5,70.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9f560cac-4ee2-4de0-8455-08bef525b297.jpg','棣欐績鐨勭京寮忔嬁閻靛挅鍟?,1,'2025-01-04 14:50:00','2025-02-08 14:19:29'),(10,'鐐歌柉姊?,6,60.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/92a8d9af-3471-42d6-805d-5211983ee95f.jpg','棣欓叆鐨勭偢钖锛屾惌閰嶇壒瑁介啲鏂?,1,'2025-01-05 15:50:00','2025-02-08 14:19:37'),(11,'鍗楃摐婵冩汞',7,90.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/8ee334f4-18e9-4002-880a-7837e3798da8.jpg','婵冮儊鐨勫崡鐡滄績婀紝鏆栬儍鍙堢嚐椁?,1,'2025-01-06 16:40:00','2025-02-08 14:20:02'),(12,'娲嬭敟婀?,7,80.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/be53a625-910c-4e67-8b5d-bc8f9c70ce89.jpg','娉曞紡缍撳吀娲嬭敟婀紝棣欐埃鎾查蓟',1,'2025-01-06 16:50:00','2025-02-08 14:19:47'),(14,'姘存灉娌欐媺',8,90.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/60cbe8ff-b697-497b-9475-097268b7fec8.jpg','娓呯埥鐨勬按鏋滄矙鎷夛紝鍋ュ悍鍙堢編鍛?,1,'2025-01-07 17:50:00','2025-02-08 14:19:54'),(17,'鐑ら洖缈?,6,120.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/22f6b075-3285-480b-995a-6563bc642446.jpg','棣欐績鐑ら洖缈咃紝婊挎豢鐨勯啲棣欏懗',1,'2025-01-09 19:40:00','2025-02-08 14:20:32'),(18,'鐗涜倝涓?,10,150.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f7c3bc3a-994d-4498-9ace-3c3ab5135862.jpg','澶氭眮鐨勭偔鐑ょ墰鑲変覆',1,'2025-01-09 19:50:00','2025-02-08 14:28:16'),(19,'鑺掓灉鍐版矙',5,80.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/22c4c9a2-c2f2-49b7-8693-5ab08eacecf3.jpg','娓呮都鐨勮姃鏋滃啺娌欙紝澶忔棩蹇呭倷',1,'2025-01-10 20:40:00','2025-02-08 14:22:48'),(20,'鑽夎帗鑱栦唬',11,90.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/54be8604-3f3b-4d9e-b44d-fff4c2f6ac1b.jpg','棣欑敎鐨勮崏鑾撹仏浠ｏ紝鎼厤鏂伴姘存灉',1,'2025-01-10 20:50:00','2025-02-08 14:22:47'),(30,'璞嗘伎',5,20.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/b52e3be6-e150-40a4-9796-3d1460dada5d.jpg','棣欐績鐨勮眴婕?,1,'2025-01-19 15:14:22','2025-02-08 14:23:36'),(31,'鐗涘ザ',5,23.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/ab0dec6c-3807-4b79-bced-a2856d3b8dfc.jpg','鍏ㄨ剛鐗涘ザ锛屽仴搴锋粦闋?,1,'2025-01-19 15:17:19','2025-02-08 14:23:58');
/*!40000 ALTER TABLE `meal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meal_flavor`
--

DROP TABLE IF EXISTS `meal_flavor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal_flavor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚嵉',
  `meal_id` bigint NOT NULL COMMENT '椁愰粸id',
  `name` varchar(32) DEFAULT NULL COMMENT '鍙ｅ懗鍚嶇ū',
  `value` varchar(255) DEFAULT NULL COMMENT '鍙ｅ懗鏁告摎list',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='椁愰粸鍙ｅ懗闂滀總';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meal_flavor`
--

LOCK TABLES `meal_flavor` WRITE;
/*!40000 ALTER TABLE `meal_flavor` DISABLE KEYS */;
INSERT INTO `meal_flavor` VALUES (28,17,'婧害','[\'鐔遍２\', \'甯告韩\', \'鍘诲啺\', \'灏戝啺\', \'澶氬啺\']'),(29,30,'婧害','[\'鐔遍２\', \'甯告韩\', \'鍘诲啺\', \'灏戝啺\', \'澶氬啺\']');
/*!40000 ALTER TABLE `meal_flavor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item`
--

DROP TABLE IF EXISTS `menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '涓婚嵉',
  `name` varchar(255) NOT NULL COMMENT '閬稿柈鍚嶇ū',
  `path` varchar(255) NOT NULL COMMENT '鍓嶇璺緫',
  `level` varchar(2) NOT NULL COMMENT '閬稿柈绱氬垾',
  `icon` varchar(200) DEFAULT NULL COMMENT '鍦栫ず',
  `exclusive` tinyint(1) DEFAULT NULL COMMENT '鏄惁鐐哄皥灞?,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='閬稿柈';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item`
--

LOCK TABLES `menu_item` WRITE;
/*!40000 ALTER TABLE `menu_item` DISABLE KEYS */;
INSERT INTO `menu_item` VALUES (2,'鏁告摎绲辫▓','/admin/report','3','new URL(\'@/assets/images/statistics-icon.png\', import.meta.url).href',3),(3,'瑷傚柈绠＄悊','/admin/order','2','src/assets/images/order-management-icon.png',NULL),(4,'椁愰粸绠＄悊','/admin/meal','2','src/assets/images/meal-management-icon.png',NULL),(5,'鍒嗛绠＄悊','/admin/category','2','src/assets/images/category-icon.png',NULL),(6,'鍝″伐绠＄悊','/admin/employee','3','src/assets/images/employee-management-icon.png',3),(7,'鍊嬩汉涓績','/user/info','1','src/assets/images/user-info-icon.png',NULL),(8,'椁愰粸鐎忚','/customer/meal','1','src/assets/images/meal-browsing-icon.png',NULL),(10,'姝峰彶瑷傚柈','/customer/order/history','1','src/assets/images/history-order-icon.png',1);
/*!40000 ALTER TABLE `menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚嵉',
  `name` varchar(32) DEFAULT NULL COMMENT '椁愰粸鍚嶇ū',
  `image` varchar(255) DEFAULT NULL COMMENT '椁愰粸鍦栫墖',
  `order_id` bigint NOT NULL COMMENT '瑷傚柈id',
  `meal_id` bigint DEFAULT NULL COMMENT '椁愰粸id',
  `meal_flavor` varchar(50) DEFAULT NULL COMMENT '鍙ｅ懗',
  `number` int NOT NULL DEFAULT '1' COMMENT '鏁搁噺',
  `amount` decimal(10,2) NOT NULL COMMENT '閲戦',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='瑷傚柈鏄庣窗琛?;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (1,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',1,1,'',1,50.00),(2,'缇╁ぇ鍒╅旱',NULL,1,15,'',1,150.00),(3,'铦﹂',NULL,2,2,'',1,60.00),(4,'鍗楃摐婵冩汞',NULL,2,11,'',1,90.00),(5,'妾告绱呰尪',NULL,2,7,'',1,40.00),(6,'宸у厠鍔涜泲绯?,NULL,2,5,'',1,120.00),(7,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',2,17,'灏戝啺',1,120.00),(8,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',3,1,'',1,50.00),(9,'鍑辨拻娌欐媺','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',3,13,'',1,100.00),(10,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',4,1,'',1,50.00),(11,'铦﹂',NULL,4,2,'',1,60.00),(12,'铦﹂',NULL,5,2,'',1,60.00),(13,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',5,11,'',1,90.00),(14,'铦﹂',NULL,6,2,'',1,60.00),(15,'鑽夎帗濂堕叒','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/435c06ec-379a-40d0-8617-d7cd30401ced.png',6,6,'',1,90.00),(16,'铦﹂',NULL,7,2,'',1,60.00),(17,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',7,17,'鍘诲啺',1,120.00),(18,'鎷块惖鍜栧暋',NULL,7,8,'',1,70.00),(19,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',8,1,'',1,50.00),(20,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',8,11,'',1,90.00),(21,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',1,1,'',1,50.00),(22,'铦﹂',NULL,1,2,'',1,60.00),(23,'铦﹂',NULL,2,2,'',1,60.00),(24,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',2,1,'',1,50.00),(25,'鍑辨拻娌欐媺','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',2,13,'',1,100.00),(26,'铦﹂',NULL,3,2,'',1,60.00),(27,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',3,11,'',1,90.00),(28,'铦﹂',NULL,4,2,'',1,60.00),(29,'鐗涘ザ','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png',4,31,'',1,23.00),(30,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',5,1,'',1,50.00),(31,'铦﹂',NULL,5,2,'',1,60.00),(32,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',6,1,'',1,50.00),(33,'鐗涘ザ','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png',6,31,'',1,23.00),(34,'铦﹂',NULL,7,2,'',1,60.00),(35,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',7,17,'鐔遍２',1,120.00),(36,'铦﹂',NULL,8,2,'',1,60.00),(37,'鍑辨拻娌欐媺','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',8,13,'',1,100.00),(38,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',9,1,'',1,50.00),(39,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',9,11,'',1,90.00),(40,'铦﹂',NULL,10,2,'',1,60.00),(41,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',10,1,'',1,50.00),(42,'铦﹂',NULL,11,2,'',1,60.00),(43,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',12,1,'',1,50.00),(44,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',13,11,'',1,90.00),(45,'缇╁ぇ鍒╅旱','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/56b204aa-225c-4ed5-8142-75926f38509d.png',13,15,'',1,150.00),(46,'铦﹂',NULL,14,2,'',1,60.00),(47,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',15,1,'',1,50.00),(48,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',15,17,'',1,120.00),(49,'铦﹂',NULL,15,2,'',2,60.00),(50,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',16,1,'',1,50.00),(51,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',16,11,'',1,90.00),(52,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',17,1,'',1,50.00),(53,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',17,17,'甯告韩',2,120.00),(54,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',17,17,'鐔遍２',1,120.00),(55,'铚傝湝鐑忛緧123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',17,25,'鍘诲啺, 灏戠硸',1,45.00),(56,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',18,17,'灏戝啺',1,120.00),(57,'鐗涘ザ','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png',18,31,'',1,23.00),(58,'铦﹂',NULL,19,2,'',1,60.00),(59,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',20,1,'',1,50.00),(60,'铦﹂',NULL,21,2,'',1,60.00),(61,'铦﹂',NULL,22,2,'',1,60.00),(62,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',23,1,'',1,50.00),(63,'铦﹂',NULL,24,2,'',1,60.00),(64,'铦﹂',NULL,25,2,'',1,60.00),(65,'铦﹂',NULL,26,2,'',1,60.00),(66,'鍑辨拻娌欐媺','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',27,13,'',1,100.00),(67,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',28,1,'',1,50.00),(68,'铚傝湝鐑忛緧123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',28,25,'鍘诲啺, 灏戠硸',1,45.00),(69,'铦﹂',NULL,29,2,'',1,60.00),(70,'铚傝湝鐑忛緧123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',29,25,'灏戝啺, 鍗婄硸',1,45.00),(71,'铦﹂',NULL,30,2,'',1,60.00),(72,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',30,1,'',1,50.00),(73,'铦﹂',NULL,31,2,'',1,60.00),(74,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',32,1,'',1,50.00),(75,'铦﹂',NULL,33,2,'',1,60.00),(76,'鍗楃摐婵冩汞',NULL,33,11,'',1,90.00),(77,'妾告绱呰尪',NULL,33,7,'',1,40.00),(78,'宸у厠鍔涜泲绯?,NULL,33,5,'',1,120.00),(79,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',33,17,'灏戝啺',1,120.00),(80,'铦﹂',NULL,33,2,'',1,60.00),(81,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',33,1,'',1,50.00),(82,'鍑辨拻娌欐媺','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',33,13,'',1,100.00),(83,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',34,1,'',2,50.00),(84,'铚傝湝鐑忛緧123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',34,25,'鍘诲啺, 澶氱硸',1,45.00),(85,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',35,1,'',2,50.00),(86,'铚傝湝鐑忛緧123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',35,25,'鍘诲啺, 澶氱硸',1,45.00),(87,'铦﹂',NULL,35,2,'',1,60.00),(88,'鍗楃摐婵冩汞',NULL,35,11,'',1,90.00),(89,'妾告绱呰尪',NULL,35,7,'',1,40.00),(90,'宸у厠鍔涜泲绯?,NULL,35,5,'',1,120.00),(91,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',35,17,'灏戝啺',1,120.00),(92,'铦﹂',NULL,35,2,'',1,60.00),(93,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',35,1,'',1,50.00),(94,'鍑辨拻娌欐媺','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',35,13,'',1,100.00),(95,'铦﹂',NULL,36,2,'',1,60.00),(96,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',36,11,'',1,90.00),(97,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',37,1,'',1,50.00),(98,'铦﹂',NULL,38,2,'',1,60.00),(99,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',39,17,'',1,120.00),(100,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',39,11,'',1,90.00),(101,'鐑ら洖缈?,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',40,17,'',1,120.00),(102,'鍗楃摐婵冩汞','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',40,11,'',1,90.00),(103,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',41,1,'',1,50.00),(104,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',42,1,'',1,50.00),(105,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',43,1,'',1,50.00),(106,'鐐告磱钄ュ湀','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',44,1,'',1,50.00),(107,'铦﹂',NULL,45,2,'',1,60.00);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚嵉',
  `number` varchar(50) DEFAULT NULL COMMENT '瑷傚柈铏熺⒓',
  `status` int NOT NULL DEFAULT '1' COMMENT '瑷傚柈鐙€鎱?1寰呮敮浠?2寰呮帴鍠?3宸叉帴鍠?4娲鹃€佷腑 5宸插畬鎴?6宸插彇娑?,
  `user_id` bigint NOT NULL COMMENT '涓嬪柈鐢ㄦ埗id',
  `address_book_id` bigint NOT NULL COMMENT '鍦板潃id',
  `order_time` datetime NOT NULL COMMENT '涓嬪柈鏅傞枔',
  `checkout_time` datetime DEFAULT NULL COMMENT '绲愬赋鏅傞枔',
  `pay_status` tinyint NOT NULL DEFAULT '1' COMMENT '鏀粯鐙€鎱?0鏈敮浠?1宸叉敮浠?2閫€娆?,
  `amount` decimal(10,2) NOT NULL COMMENT '瀵︽敹閲戦',
  `remark` varchar(100) DEFAULT NULL COMMENT '鍌欒ɑ',
  `phone` varchar(10) DEFAULT NULL COMMENT '鎵嬫铏熺⒓',
  `address` varchar(255) DEFAULT NULL COMMENT '鍦板潃',
  `user_name` varchar(32) DEFAULT NULL COMMENT '鐢ㄦ埗鍚嶇ū',
  `consignee` varchar(32) DEFAULT NULL COMMENT '鏀惰波浜?,
  `cancel_reason` varchar(255) DEFAULT NULL COMMENT '瑷傚柈鍙栨秷鍘熷洜',
  `rejection_reason` varchar(255) DEFAULT NULL COMMENT '鎷掑柈鍘熷洜',
  `cancel_time` datetime DEFAULT NULL COMMENT '瑷傚柈鍙栨秷鏅傞枔',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '闋愯▓閫侀仈鏅傞枔',
  `delivery_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '閰嶉€佺媭鎱?1绔嬪嵆閫佸嚭 0閬告搰鍏烽珨鏅傞枔',
  `delivery_time` datetime DEFAULT NULL COMMENT '閫侀仈鏅傞枔',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='瑷傚柈琛?;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'1737553430709',6,1,2,'2025-01-22 21:43:51',NULL,2,140.00,'','0912345678',NULL,NULL,'asbc','椤у鍙栨秷',NULL,'2025-01-24 18:59:17','2025-01-22 22:22:05',1,NULL),(2,'1737555460462',5,1,3,'2025-01-22 22:17:40',NULL,0,240.00,'','0912345888',NULL,NULL,NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,'椋熸潗涓嶈冻','2025-01-23 14:39:34','2025-01-22 23:17:10',1,'2025-02-08 14:29:19'),(3,'1737555759564',5,1,2,'2025-01-22 22:22:40',NULL,0,180.00,'','0912345678',NULL,NULL,'asbc','椋熸潗涓嶈冻',NULL,'2025-01-23 14:43:30','2025-01-22 23:22:05',1,'2025-01-26 00:04:33'),(4,'1737556472155',6,1,3,'2025-01-22 22:34:32',NULL,0,113.00,'','0912345888',NULL,NULL,NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 18:58:00','2025-01-22 23:34:15',1,'2025-01-23 15:00:18'),(5,'1737556749599',6,1,2,'2025-01-22 22:39:10',NULL,0,140.00,'','0912345678',NULL,NULL,'asbc','瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 18:58:00','2025-01-22 23:39:07',1,'2025-01-23 15:00:30'),(6,'1737556832125',5,1,3,'2025-01-22 22:40:32',NULL,0,103.00,'','0912345888',NULL,NULL,NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-22 22:56:00','2025-01-22 23:40:29',1,'2025-01-23 23:38:29'),(7,'1737557051891',5,1,2,'2025-01-22 22:44:12',NULL,0,210.00,'','0912345678',NULL,NULL,'asbc','瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-22 23:45:00','2025-01-22 23:44:10',1,'2025-01-23 23:38:19'),(8,'1737557102765',5,1,3,'2025-01-22 22:45:03',NULL,0,190.00,'','0912345888',NULL,NULL,NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 01:00:00','2025-01-22 23:45:01',1,NULL),(9,'1737557406407',5,1,2,'2025-01-22 22:50:06',NULL,0,170.00,'','0912345678',NULL,NULL,'asbc','瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 01:00:00','2025-01-22 23:50:05',1,NULL),(10,'1737558020222',5,1,2,'2025-01-22 23:00:20',NULL,0,140.00,'','0912345678',NULL,NULL,'asbc','瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-22 23:46:00','2025-01-23 00:00:17',1,NULL),(11,'1737558150888',5,1,4,'2025-01-22 23:02:31',NULL,0,90.00,'','0933345888',NULL,NULL,NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-22 23:46:00','2025-01-23 00:02:28',1,NULL),(12,'1737558328724',5,1,3,'2025-01-22 23:05:29',NULL,0,80.00,'','0912345888',NULL,NULL,NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-22 23:39:00','2025-01-23 00:05:27',1,'2025-01-23 23:38:06'),(13,'1737558972114',5,1,2,'2025-01-22 23:16:12',NULL,0,270.00,'','0912345678',NULL,NULL,'asbc','瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-22 23:46:00','2025-01-23 00:16:01',1,NULL),(14,'1737559167650',6,1,3,'2025-01-22 23:19:28',NULL,0,90.00,'','0912345888',NULL,NULL,NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,'浼?,'2025-01-24 22:42:00','2025-01-23 00:19:25',1,NULL),(15,'1737559868627',6,1,2,'2025-01-22 23:31:09',NULL,0,320.00,'','0912345678',NULL,NULL,'asbc','瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,'澶仩鍝ュ悇','2025-01-24 22:42:00','2025-01-23 00:30:48',1,NULL),(16,'1737637670396',6,1,4,'2025-01-23 21:07:50',NULL,0,170.00,'11榛為€佷締','0933345888',NULL,'matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,'浼戜簡','2025-01-24 22:42:00',NULL,0,NULL),(17,'1737638653719',6,1,3,'2025-01-23 21:24:14',NULL,0,485.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,'閬犲埌鐖?,'2025-01-24 22:42:00','2025-01-23 22:24:10',1,NULL),(18,'1737650301572',6,1,4,'2025-01-24 00:38:22',NULL,0,173.00,'','0933345888','鍙颁腑鍖楀崁澶ф睙琛?铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 22:27:00','2025-01-24 01:38:06',1,NULL),(19,'1737695301549',5,1,3,'2025-01-24 13:08:22','2025-01-25 14:25:35',1,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 22:11:00','2025-01-24 14:08:16',1,'2025-02-08 14:29:19'),(20,'1737695586051',6,1,3,'2025-01-24 13:13:06',NULL,0,80.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 14:14:00','2025-01-24 14:13:04',1,NULL),(21,'1737697169981',5,1,3,'2025-01-24 13:39:30','2025-01-25 14:24:16',1,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 22:27:00','2025-01-24 14:39:27',1,'2025-02-08 14:29:19'),(22,'1737697275139',5,1,3,'2025-01-24 13:41:15','2025-01-25 14:26:59',1,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 14:14:00','2025-01-24 14:41:11',1,'2025-02-08 14:29:18'),(23,'1737697415775',6,1,4,'2025-01-24 13:43:36',NULL,0,80.00,'','0933345888','鍙颁腑鍖楀崁澶ф睙琛?铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 22:27:00','2025-01-24 14:43:27',1,NULL),(24,'1737697716355',5,1,3,'2025-01-24 13:48:36','2025-01-25 14:23:36',1,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 22:27:00','2025-01-24 14:48:31',1,'2025-02-08 14:29:18'),(25,'1737699175999',5,1,3,'2025-01-24 14:12:56','2025-01-24 14:24:52',1,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,NULL,NULL,NULL,'2025-01-24 15:12:53',1,'2025-01-26 00:04:32'),(26,'1737700812717',6,1,3,'2025-01-24 14:40:13',NULL,0,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 14:56:00','2025-01-24 15:40:06',1,NULL),(27,'1737700998781',5,1,4,'2025-01-24 14:43:19','2025-01-24 14:43:39',1,130.00,'','0933345888','鍙颁腑鍖楀崁澶ф睙琛?铏?F2','matt',NULL,NULL,NULL,NULL,'2025-01-24 15:43:04',1,'2025-02-08 14:29:17'),(28,'1737701532479',6,1,3,'2025-01-24 14:52:12',NULL,0,125.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-02-08 13:33:00','2025-01-24 15:52:07',1,NULL),(29,'1737701776354',5,1,3,'2025-01-24 14:56:16','2025-01-25 14:22:11',1,135.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 22:27:00','2025-01-24 15:56:11',1,'2025-01-26 00:04:32'),(30,'1737702474182',6,1,3,'2025-01-24 15:07:54','2025-01-24 23:22:15',1,140.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-02-08 13:33:00','2025-01-24 16:07:52',1,NULL),(31,'1737702589198',6,1,3,'2025-01-24 15:09:49','2025-01-24 23:22:06',1,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-02-08 13:33:00','2025-01-24 16:09:40',1,NULL),(32,'1737703701634',6,1,3,'2025-01-24 15:28:22',NULL,0,80.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-01-24 22:11:00','2025-01-24 16:27:46',1,NULL),(33,'1737723915481',6,1,3,'2025-01-24 21:05:15','2025-01-24 23:29:16',1,670.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,'瑷傚柈瓒呮檪锛岃嚜瑷傚彇娑?,NULL,'2025-02-08 13:33:00','2025-01-24 22:05:12',1,NULL),(34,'1737731932240',5,1,3,'2025-01-24 23:18:52','2025-01-25 14:56:55',1,175.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,NULL,NULL,NULL,'2025-01-25 00:18:50',1,'2025-01-26 00:04:32'),(35,'1737782659604',5,1,3,'2025-01-25 13:24:20','2025-01-25 14:55:23',1,815.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,NULL,NULL,NULL,'2025-01-25 14:24:14',1,'2025-01-26 00:04:32'),(36,'1737782832891',5,1,3,'2025-01-25 13:27:13','2025-01-25 14:53:13',1,180.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,NULL,NULL,NULL,NULL,0,'2025-01-26 00:04:32'),(37,'1737782873838',5,1,3,'2025-01-25 13:27:54','2025-01-25 14:47:35',1,80.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,NULL,NULL,NULL,'2025-01-25 14:27:50',1,'2025-01-26 00:04:31'),(38,'1737785318050',5,1,3,'2025-01-25 14:08:38','2025-01-25 14:08:50',1,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,NULL,NULL,NULL,'2025-01-25 15:08:34',1,'2025-01-26 00:04:31'),(39,'1737788506506',5,44,8,'2025-01-25 15:01:47','2025-01-25 15:01:49',1,240.00,'','0912345678','鍙板寳鏉卞崁98铏?,'uuu','193',NULL,NULL,NULL,'2025-01-25 16:01:44',1,'2025-02-08 14:29:17'),(40,'1737788626881',5,44,8,'2025-01-25 15:03:47','2025-01-25 15:03:52',1,240.00,'','0912345678','鍙板寳鏉卞崁98铏?,'uuu','193',NULL,NULL,NULL,'2025-01-25 16:03:45',1,'2025-02-08 14:29:16'),(41,'1737788960606',5,44,8,'2025-01-25 15:09:21','2025-01-25 15:09:22',1,80.00,'','0912345678','鍙板寳鏉卞崁98铏?,'uuu','193',NULL,NULL,NULL,'2025-01-25 16:09:15',1,'2025-02-08 14:29:16'),(42,'1737789098870',5,44,8,'2025-01-25 15:11:39','2025-01-25 15:11:40',1,80.00,'','0912345678','鍙板寳鏉卞崁98铏?,'uuu','193',NULL,NULL,NULL,'2025-01-25 16:11:37',1,'2025-02-08 14:29:16'),(43,'1737789163924',5,44,8,'2025-01-25 15:12:44','2025-01-25 15:12:45',1,80.00,'','0912345678','鍙板寳鏉卞崁98铏?,'uuu','193',NULL,NULL,NULL,'2025-01-25 16:12:42',1,'2025-02-08 14:29:15'),(44,'1737789198363',5,44,8,'2025-01-25 15:13:18','2025-01-25 15:13:19',1,80.00,'','0912345678','鍙板寳鏉卞崁98铏?,'uuu','193',NULL,NULL,NULL,'2025-01-25 16:13:17',1,'2025-02-08 14:29:14'),(45,'1737821054230',5,1,3,'2025-01-26 00:04:14','2025-01-26 00:04:15',1,90.00,'','0912345888','鍗楁姇瑗垮崁杌嶆殙琛?82铏?F2','matt',NULL,NULL,NULL,NULL,'2025-01-26 01:04:12',1,'2025-01-26 00:04:31');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚嵉',
  `name` varchar(32) DEFAULT NULL COMMENT '椁愰粸鍚嶇ū',
  `image` varchar(255) DEFAULT NULL COMMENT '椁愰粸鍦栫墖',
  `user_id` bigint NOT NULL COMMENT '椤уid',
  `meal_id` bigint NOT NULL COMMENT '椁愰粸id',
  `meal_flavor` varchar(50) DEFAULT NULL COMMENT '鍙ｅ懗',
  `number` int NOT NULL DEFAULT '1' COMMENT '鏁搁噺',
  `amount` decimal(10,2) NOT NULL COMMENT '閲戦',
  `create_time` datetime DEFAULT NULL COMMENT '鍓靛缓鏅傞枔',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='璩肩墿杌?;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚嵉',
  `role` varchar(2) NOT NULL COMMENT '瑙掕壊',
  `name` varchar(32) NOT NULL COMMENT '濮撳悕',
  `account` varchar(32) NOT NULL COMMENT '甯宠櫉',
  `password` varchar(64) NOT NULL COMMENT '瀵嗙⒓',
  `balance` decimal(10,2) DEFAULT NULL COMMENT '椁橀锛屽彧鏈夐¨瀹㈡墠鏈夋闋?,
  `phone` varchar(10) NOT NULL COMMENT '鎵嬫铏?,
  `sex` varchar(2) NOT NULL COMMENT '鎬у垾',
  `avatar` varchar(500) DEFAULT NULL COMMENT '闋儚',
  `create_time` datetime DEFAULT NULL COMMENT '瑷诲唺鏅傞枔',
  `update_time` datetime DEFAULT NULL COMMENT '鏈€寰岀櫥鍏ユ檪闁?,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鐢ㄦ埗璩囪▕';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'3','matt','admin','e10adc3949ba59abbe56e057f20f883e',5845.00,'0912345699','1','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/99936061-6122-4b8c-a397-fca53cc891d1.png','2025-01-13 11:20:24','2025-02-08 13:33:17'),(2,'1','閮潠','guojing','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(3,'1','榛冭搲','huangrong','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(4,'1','妤婇亷','yangguo','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(5,'1','灏忛緧濂?,'xiaolongnv','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(6,'1','娲竷鍏?,'hongqigong','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(7,'1','姝愰櫧閶?,'ouyangfeng','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(10,'1','榛冭棩甯?,'huangyaoshi','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(12,'2','闄哥劇闆?,'luwushuang','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(14,'2','閲戣吉娉曠帇','jinlunfawang','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(15,'1','閮','guoxiang','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(22,'1','John','john','e10adc3949ba59abbe56e057f20f883e',3000.00,'0912345678','1','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/00eefa20-6860-4a8e-b3bd-17ddec16f9f7.png','2025-01-13 11:57:39','2025-01-13 11:57:39'),(23,'2','婀璨?,'Tom','e10adc3949ba59abbe56e057f20f883e',NULL,'0912345678','1',NULL,'2025-01-13 22:50:17','2025-01-16 23:25:49'),(35,'2','tiger','tiger123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','1',NULL,'2025-01-17 11:02:32','2025-01-17 11:02:32'),(42,'2','mmm123','mmm123','e10adc3949ba59abbe56e057f20f883e',NULL,'0912345678','1',NULL,'2025-01-17 15:20:43','2025-01-17 15:20:43'),(44,'1','uuu','uuu123','e10adc3949ba59abbe56e057f20f883e',3500.00,'0985426514','1',NULL,'2025-01-17 18:31:43','2025-02-01 18:47:38'),(47,'1','绁為洉澶т繝','yang','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','1','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/0c91b88c-cdde-4e36-9de5-3761e32b7428.png','2025-01-27 23:48:03','2025-01-28 00:11:12'),(48,'2','employee','employee','e10adc3949ba59abbe56e057f20f883e',NULL,'0912345678','1',NULL,'2025-02-08 14:37:20','2025-02-08 14:37:20');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-08 14:43:01
