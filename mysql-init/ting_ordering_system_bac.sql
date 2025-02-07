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
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `user_id` bigint NOT NULL COMMENT '用戶id',
  `consignee` varchar(50) DEFAULT NULL COMMENT '聯繫人',
  `sex` varchar(2) DEFAULT NULL COMMENT '性別',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手機號碼',
  `city_code` varchar(12) DEFAULT NULL COMMENT '市級編號',
  `city_name` varchar(32) DEFAULT NULL COMMENT '市级名稱',
  `district_code` varchar(12) DEFAULT NULL COMMENT '區级編號',
  `district_name` varchar(32) DEFAULT NULL COMMENT '區级名稱',
  `detail` varchar(200) DEFAULT NULL COMMENT '詳細地址',
  `label` varchar(100) DEFAULT NULL COMMENT '標籤',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默認 0 否 1 是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='地址簿';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_book`
--

LOCK TABLES `address_book` WRITE;
/*!40000 ALTER TABLE `address_book` DISABLE KEYS */;
INSERT INTO `address_book` VALUES (3,1,NULL,'0','0912345888','2','南投','2','西區','軍暉街282號5F2','公司',1),(4,1,NULL,'0','0933345888','3','台中','2','北區','大江街2號7F2','家',0),(8,44,'193','0','0912345678','','台北','','東區','98號','',1),(9,32,'1234','0','0912345678','','台北','','東區','38號','',0),(12,32,'8743','1','0937489237','','宜蘭','','','大江街98號','',0),(14,44,'1234','1','0912345678','','新北','','','238號2樓','',0),(15,44,'1234','1','0912345678','','新竹','','','232號三樓','',0);
/*!40000 ALTER TABLE `address_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) NOT NULL COMMENT '分類名稱',
  `status` int DEFAULT '1' COMMENT '分類狀態 0:禁用，1:啟用',
  `create_time` datetime DEFAULT NULL COMMENT '創建時間',
  `update_time` datetime DEFAULT NULL COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='餐點分類';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'魚類',1,'2025-01-14 14:40:35','2025-01-17 23:05:08'),(2,'開胃菜',1,'2025-01-01 12:00:00','2025-01-17 23:05:26'),(3,'主菜',1,'2025-01-02 13:30:00','2025-01-11 16:00:00'),(4,'甜點',1,'2025-01-03 14:00:00','2025-01-12 17:00:00'),(5,'飲品',1,'2025-01-04 14:30:00','2025-01-13 18:00:00'),(6,'小吃',1,'2025-01-05 15:00:00','2025-01-14 19:00:00'),(7,'湯品',1,'2025-01-06 16:00:00','2025-01-15 20:00:00'),(8,'沙拉',1,'2025-01-07 17:00:00','2025-01-16 21:00:00'),(9,'麵食',1,'2025-01-08 18:00:00','2025-01-17 22:00:00'),(10,'燒烤',0,'2025-01-09 19:00:00','2025-01-17 23:17:34'),(11,'冰品',0,'2025-01-10 20:00:00','2025-01-17 23:17:38'),(14,'午餐',1,'2025-01-13 23:00:00','2025-01-17 23:05:44'),(15,'晚餐',1,'2025-01-14 08:00:00','2025-01-17 23:04:38'),(16,'宵夜',1,'2025-01-15 09:00:00','2025-01-17 23:03:35'),(23,'西點',0,'2025-01-14 18:08:23','2025-01-17 21:44:57'),(25,'海草',0,'2025-01-17 21:44:53','2025-01-17 21:44:55');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meal`
--

DROP TABLE IF EXISTS `meal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `name` varchar(32) NOT NULL COMMENT '餐點名稱',
  `category_id` bigint NOT NULL COMMENT '餐點分類id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '餐點價格',
  `image` varchar(255) DEFAULT NULL COMMENT '餐點圖片',
  `description` varchar(255) DEFAULT NULL COMMENT '餐點描述',
  `status` int DEFAULT '1' COMMENT '0 停售 1 販售中',
  `create_time` datetime DEFAULT NULL COMMENT '創建時間',
  `update_time` datetime DEFAULT NULL COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='餐點';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meal`
--

LOCK TABLES `meal` WRITE;
/*!40000 ALTER TABLE `meal` DISABLE KEYS */;
INSERT INTO `meal` VALUES (1,'炸洋蔥圈',1,50.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png','酥脆可口的炸洋蔥圈',1,'2025-01-01 12:30:00','2025-01-18 11:52:11'),(2,'蝦餅',1,60.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/8f7a8347-0a07-412b-943b-617d656d5c2a.png','香脆的蝦餅佐以特製醬料',1,'2025-01-01 12:40:00','2025-01-10 15:40:00'),(3,'烤牛排',2,350.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/99d801fc-267e-4e8b-a88d-49015723036f.png','精選肉質嫩滑的烤牛排',1,'2025-01-02 13:40:00','2025-01-11 16:40:00'),(4,'奶油焗雞排',2,280.00,NULL,'香濃奶油搭配嫩雞肉',1,'2025-01-02 13:50:00','2025-01-11 16:50:00'),(5,'巧克力蛋糕',3,120.00,NULL,'濃郁的巧克力風味蛋糕',1,'2025-01-03 14:40:00','2025-01-12 17:40:00'),(6,'草莓奶酪',3,90.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/435c06ec-379a-40d0-8617-d7cd30401ced.png','清新香甜的草莓奶酪',1,'2025-01-03 14:50:00','2025-01-12 17:50:00'),(7,'檸檬紅茶',4,40.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/13f78165-302f-4d38-8500-f217d06e4ae5.png','提神醒腦的檸檬紅茶',1,'2025-01-04 14:40:00','2025-01-13 18:40:00'),(8,'拿鐵咖啡',4,70.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/1dcbc99d-cdb7-4f11-8b6c-53d34f27c552.png','香濃的義式拿鐵咖啡',1,'2025-01-04 14:50:00','2025-01-13 18:50:00'),(9,'鹽酥雞',5,80.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/7ccab567-8d08-4c2c-9eb3-d2cb20c02204.png','外酥內嫩的台灣鹽酥雞',1,'2025-01-05 15:40:00','2025-01-14 19:40:00'),(10,'炸薯條',5,60.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/a1b0114b-5c71-4238-823d-71edc31c8eac.png','香酥的炸薯條，搭配特製醬料',1,'2025-01-05 15:50:00','2025-01-14 19:50:00'),(11,'南瓜濃湯',6,90.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png','濃郁的南瓜濃湯，暖胃又營養',1,'2025-01-06 16:40:00','2025-01-15 20:40:00'),(12,'洋蔥湯',6,80.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/39dab213-1c4b-407b-8f2a-7cd94d7f8555.png','法式經典洋蔥湯，香氣撲鼻',1,'2025-01-06 16:50:00','2025-01-15 20:50:00'),(13,'凱撒沙拉',7,100.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png','經典凱撒沙拉，搭配自製醬料',1,'2025-01-07 17:40:00','2025-01-16 21:40:00'),(14,'水果沙拉',7,90.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/fedba37d-e020-4e39-8caa-1ea199249bd4.png','清爽的水果沙拉，健康又美味',1,'2025-01-07 17:50:00','2025-01-16 21:50:00'),(15,'義大利麵',8,150.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/56b204aa-225c-4ed5-8142-75926f38509d.png','經典茄汁義大利麵',1,'2025-01-08 18:40:00','2025-01-17 22:40:00'),(16,'海鮮麵',8,180.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/3ad73015-2abf-4521-9f56-ec423e2d0655.png','搭配新鮮海鮮的義大利麵',1,'2025-01-08 18:50:00','2025-01-17 22:50:00'),(17,'烤雞翅',9,120.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png','香濃烤雞翅，滿滿的醬香味',1,'2025-01-09 19:40:00','2025-01-19 19:25:52'),(18,'牛肉串',9,150.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/fcd1c980-63f9-444b-ba70-f80768555e88.png','多汁的炭烤牛肉串',0,'2025-01-09 19:50:00','2025-01-19 19:53:42'),(19,'芒果冰沙',10,80.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9788f6e6-18f6-4630-a5da-c68746f16714.png','清涼的芒果冰沙，夏日必備',0,'2025-01-10 20:40:00','2025-01-18 11:55:31'),(20,'草莓聖代',10,90.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/4871a0ea-127c-4ca6-9a44-e7fb1108cbab.png','香甜的草莓聖代，搭配新鮮水果',0,'2025-01-10 20:50:00','2025-01-18 11:55:20'),(25,'蜂蜜烏龍123',5,45.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png','清爽微甜的蜂蜜烏龍1',1,'2025-01-15 10:54:20','2025-01-18 11:53:48'),(30,'豆漿',5,20.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/932407d8-486f-4b91-a0c7-055ff1a51954.png','',0,'2025-01-19 15:14:22','2025-01-19 18:59:56'),(31,'牛奶',5,23.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png','',1,'2025-01-19 15:17:19','2025-01-19 15:17:19'),(35,'水水123',5,22.00,'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/7a0d1cb6-0c63-4338-816f-739b9dc1e73c.png','',1,'2025-01-19 16:00:22','2025-01-19 16:00:22');
/*!40000 ALTER TABLE `meal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meal_flavor`
--

DROP TABLE IF EXISTS `meal_flavor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal_flavor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `meal_id` bigint NOT NULL COMMENT '餐點id',
  `name` varchar(32) DEFAULT NULL COMMENT '口味名稱',
  `value` varchar(255) DEFAULT NULL COMMENT '口味數據list',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='餐點口味關係';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meal_flavor`
--

LOCK TABLES `meal_flavor` WRITE;
/*!40000 ALTER TABLE `meal_flavor` DISABLE KEYS */;
INSERT INTO `meal_flavor` VALUES (17,17,'溫度','[\'熱飲\', \'常溫\', \'去冰\', \'少冰\', \'多冰\']'),(19,25,'溫度','[\'熱飲\',\'常溫\',\'去冰\',\'少冰\',\'多冰\']'),(20,25,'甜度','[\'無糖\',\'少糖\',\'半糖\',\'多糖\',\'全糖\']'),(25,30,'溫度','[\'熱飲\', \'常溫\', \'去冰\', \'少冰\', \'多冰\']');
/*!40000 ALTER TABLE `meal_flavor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item`
--

DROP TABLE IF EXISTS `menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `name` varchar(255) NOT NULL COMMENT '選單名稱',
  `path` varchar(255) NOT NULL COMMENT '前端路徑',
  `level` varchar(2) NOT NULL COMMENT '選單級別',
  `icon` varchar(200) DEFAULT NULL COMMENT '圖示',
  `exclusive` tinyint(1) DEFAULT NULL COMMENT '是否為專屬',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='選單';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item`
--

LOCK TABLES `menu_item` WRITE;
/*!40000 ALTER TABLE `menu_item` DISABLE KEYS */;
INSERT INTO `menu_item` VALUES (2,'數據統計','/admin/report','3','new URL(\'@/assets/images/statistics-icon.png\', import.meta.url).href',3),(3,'訂單管理','/admin/order','2','src/assets/images/order-management-icon.png',NULL),(4,'餐點管理','/admin/meal','2','src/assets/images/meal-management-icon.png',NULL),(5,'分類管理','/admin/category','2','src/assets/images/category-icon.png',NULL),(6,'員工管理','/admin/employee','3','src/assets/images/employee-management-icon.png',3),(7,'個人中心','/user/info','1','src/assets/images/user-info-icon.png',NULL),(8,'餐點瀏覽','/customer/meal','1','src/assets/images/meal-browsing-icon.png',NULL),(10,'歷史訂單','/customer/order/history','1','src/assets/images/history-order-icon.png',1);
/*!40000 ALTER TABLE `menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `name` varchar(32) DEFAULT NULL COMMENT '餐點名稱',
  `image` varchar(255) DEFAULT NULL COMMENT '餐點圖片',
  `order_id` bigint NOT NULL COMMENT '訂單id',
  `meal_id` bigint DEFAULT NULL COMMENT '餐點id',
  `meal_flavor` varchar(50) DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '數量',
  `amount` decimal(10,2) NOT NULL COMMENT '金額',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='訂單明細表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (1,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',1,1,'',1,50.00),(2,'義大利麵',NULL,1,15,'',1,150.00),(3,'蝦餅',NULL,2,2,'',1,60.00),(4,'南瓜濃湯',NULL,2,11,'',1,90.00),(5,'檸檬紅茶',NULL,2,7,'',1,40.00),(6,'巧克力蛋糕',NULL,2,5,'',1,120.00),(7,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',2,17,'少冰',1,120.00),(8,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',3,1,'',1,50.00),(9,'凱撒沙拉','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',3,13,'',1,100.00),(10,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',4,1,'',1,50.00),(11,'蝦餅',NULL,4,2,'',1,60.00),(12,'蝦餅',NULL,5,2,'',1,60.00),(13,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',5,11,'',1,90.00),(14,'蝦餅',NULL,6,2,'',1,60.00),(15,'草莓奶酪','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/435c06ec-379a-40d0-8617-d7cd30401ced.png',6,6,'',1,90.00),(16,'蝦餅',NULL,7,2,'',1,60.00),(17,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',7,17,'去冰',1,120.00),(18,'拿鐵咖啡',NULL,7,8,'',1,70.00),(19,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',8,1,'',1,50.00),(20,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',8,11,'',1,90.00),(21,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',1,1,'',1,50.00),(22,'蝦餅',NULL,1,2,'',1,60.00),(23,'蝦餅',NULL,2,2,'',1,60.00),(24,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',2,1,'',1,50.00),(25,'凱撒沙拉','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',2,13,'',1,100.00),(26,'蝦餅',NULL,3,2,'',1,60.00),(27,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',3,11,'',1,90.00),(28,'蝦餅',NULL,4,2,'',1,60.00),(29,'牛奶','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png',4,31,'',1,23.00),(30,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',5,1,'',1,50.00),(31,'蝦餅',NULL,5,2,'',1,60.00),(32,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',6,1,'',1,50.00),(33,'牛奶','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png',6,31,'',1,23.00),(34,'蝦餅',NULL,7,2,'',1,60.00),(35,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',7,17,'熱飲',1,120.00),(36,'蝦餅',NULL,8,2,'',1,60.00),(37,'凱撒沙拉','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',8,13,'',1,100.00),(38,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',9,1,'',1,50.00),(39,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',9,11,'',1,90.00),(40,'蝦餅',NULL,10,2,'',1,60.00),(41,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',10,1,'',1,50.00),(42,'蝦餅',NULL,11,2,'',1,60.00),(43,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',12,1,'',1,50.00),(44,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',13,11,'',1,90.00),(45,'義大利麵','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/56b204aa-225c-4ed5-8142-75926f38509d.png',13,15,'',1,150.00),(46,'蝦餅',NULL,14,2,'',1,60.00),(47,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',15,1,'',1,50.00),(48,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',15,17,'',1,120.00),(49,'蝦餅',NULL,15,2,'',2,60.00),(50,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',16,1,'',1,50.00),(51,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',16,11,'',1,90.00),(52,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',17,1,'',1,50.00),(53,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',17,17,'常溫',2,120.00),(54,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',17,17,'熱飲',1,120.00),(55,'蜂蜜烏龍123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',17,25,'去冰, 少糖',1,45.00),(56,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',18,17,'少冰',1,120.00),(57,'牛奶','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png',18,31,'',1,23.00),(58,'蝦餅',NULL,19,2,'',1,60.00),(59,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',20,1,'',1,50.00),(60,'蝦餅',NULL,21,2,'',1,60.00),(61,'蝦餅',NULL,22,2,'',1,60.00),(62,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',23,1,'',1,50.00),(63,'蝦餅',NULL,24,2,'',1,60.00),(64,'蝦餅',NULL,25,2,'',1,60.00),(65,'蝦餅',NULL,26,2,'',1,60.00),(66,'凱撒沙拉','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',27,13,'',1,100.00),(67,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',28,1,'',1,50.00),(68,'蜂蜜烏龍123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',28,25,'去冰, 少糖',1,45.00),(69,'蝦餅',NULL,29,2,'',1,60.00),(70,'蜂蜜烏龍123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',29,25,'少冰, 半糖',1,45.00),(71,'蝦餅',NULL,30,2,'',1,60.00),(72,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',30,1,'',1,50.00),(73,'蝦餅',NULL,31,2,'',1,60.00),(74,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',32,1,'',1,50.00),(75,'蝦餅',NULL,33,2,'',1,60.00),(76,'南瓜濃湯',NULL,33,11,'',1,90.00),(77,'檸檬紅茶',NULL,33,7,'',1,40.00),(78,'巧克力蛋糕',NULL,33,5,'',1,120.00),(79,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',33,17,'少冰',1,120.00),(80,'蝦餅',NULL,33,2,'',1,60.00),(81,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',33,1,'',1,50.00),(82,'凱撒沙拉','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',33,13,'',1,100.00),(83,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',34,1,'',2,50.00),(84,'蜂蜜烏龍123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',34,25,'去冰, 多糖',1,45.00),(85,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',35,1,'',2,50.00),(86,'蜂蜜烏龍123','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png',35,25,'去冰, 多糖',1,45.00),(87,'蝦餅',NULL,35,2,'',1,60.00),(88,'南瓜濃湯',NULL,35,11,'',1,90.00),(89,'檸檬紅茶',NULL,35,7,'',1,40.00),(90,'巧克力蛋糕',NULL,35,5,'',1,120.00),(91,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',35,17,'少冰',1,120.00),(92,'蝦餅',NULL,35,2,'',1,60.00),(93,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',35,1,'',1,50.00),(94,'凱撒沙拉','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png',35,13,'',1,100.00),(95,'蝦餅',NULL,36,2,'',1,60.00),(96,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',36,11,'',1,90.00),(97,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',37,1,'',1,50.00),(98,'蝦餅',NULL,38,2,'',1,60.00),(99,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',39,17,'',1,120.00),(100,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',39,11,'',1,90.00),(101,'烤雞翅','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png',40,17,'',1,120.00),(102,'南瓜濃湯','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png',40,11,'',1,90.00),(103,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',41,1,'',1,50.00),(104,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',42,1,'',1,50.00),(105,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',43,1,'',1,50.00),(106,'炸洋蔥圈','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png',44,1,'',1,50.00),(107,'蝦餅',NULL,45,2,'',1,60.00);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `number` varchar(50) DEFAULT NULL COMMENT '訂單號碼',
  `status` int NOT NULL DEFAULT '1' COMMENT '訂單狀態 1待支付 2待接單 3已接單 4派送中 5已完成 6已取消',
  `user_id` bigint NOT NULL COMMENT '下單用戶id',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下單時間',
  `checkout_time` datetime DEFAULT NULL COMMENT '結帳時間',
  `pay_status` tinyint NOT NULL DEFAULT '1' COMMENT '支付狀態 0未支付 1已支付 2退款',
  `amount` decimal(10,2) NOT NULL COMMENT '實收金額',
  `remark` varchar(100) DEFAULT NULL COMMENT '備註',
  `phone` varchar(10) DEFAULT NULL COMMENT '手機號碼',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) DEFAULT NULL COMMENT '用戶名稱',
  `consignee` varchar(32) DEFAULT NULL COMMENT '收貨人',
  `cancel_reason` varchar(255) DEFAULT NULL COMMENT '訂單取消原因',
  `rejection_reason` varchar(255) DEFAULT NULL COMMENT '拒單原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '訂單取消時間',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '預計送達時間',
  `delivery_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '配送狀態 1立即送出 0選擇具體時間',
  `delivery_time` datetime DEFAULT NULL COMMENT '送達時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='訂單表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'1737553430709',6,1,2,'2025-01-22 21:43:51',NULL,2,140.00,'','0912345678',NULL,NULL,'asbc','顧客取消',NULL,'2025-01-24 18:59:17','2025-01-22 22:22:05',1,NULL),(2,'1737555460462',3,1,3,'2025-01-22 22:17:40',NULL,0,240.00,'','0912345888',NULL,NULL,NULL,'訂單超時，自訂取消','食材不足','2025-01-23 14:39:34','2025-01-22 23:17:10',1,NULL),(3,'1737555759564',5,1,2,'2025-01-22 22:22:40',NULL,0,180.00,'','0912345678',NULL,NULL,'asbc','食材不足',NULL,'2025-01-23 14:43:30','2025-01-22 23:22:05',1,'2025-01-26 00:04:33'),(4,'1737556472155',6,1,3,'2025-01-22 22:34:32',NULL,0,113.00,'','0912345888',NULL,NULL,NULL,'訂單超時，自訂取消',NULL,'2025-01-24 18:58:00','2025-01-22 23:34:15',1,'2025-01-23 15:00:18'),(5,'1737556749599',6,1,2,'2025-01-22 22:39:10',NULL,0,140.00,'','0912345678',NULL,NULL,'asbc','訂單超時，自訂取消',NULL,'2025-01-24 18:58:00','2025-01-22 23:39:07',1,'2025-01-23 15:00:30'),(6,'1737556832125',5,1,3,'2025-01-22 22:40:32',NULL,0,103.00,'','0912345888',NULL,NULL,NULL,'訂單超時，自訂取消',NULL,'2025-01-22 22:56:00','2025-01-22 23:40:29',1,'2025-01-23 23:38:29'),(7,'1737557051891',5,1,2,'2025-01-22 22:44:12',NULL,0,210.00,'','0912345678',NULL,NULL,'asbc','訂單超時，自訂取消',NULL,'2025-01-22 23:45:00','2025-01-22 23:44:10',1,'2025-01-23 23:38:19'),(8,'1737557102765',5,1,3,'2025-01-22 22:45:03',NULL,0,190.00,'','0912345888',NULL,NULL,NULL,'訂單超時，自訂取消',NULL,'2025-01-24 01:00:00','2025-01-22 23:45:01',1,NULL),(9,'1737557406407',5,1,2,'2025-01-22 22:50:06',NULL,0,170.00,'','0912345678',NULL,NULL,'asbc','訂單超時，自訂取消',NULL,'2025-01-24 01:00:00','2025-01-22 23:50:05',1,NULL),(10,'1737558020222',5,1,2,'2025-01-22 23:00:20',NULL,0,140.00,'','0912345678',NULL,NULL,'asbc','訂單超時，自訂取消',NULL,'2025-01-22 23:46:00','2025-01-23 00:00:17',1,NULL),(11,'1737558150888',5,1,4,'2025-01-22 23:02:31',NULL,0,90.00,'','0933345888',NULL,NULL,NULL,'訂單超時，自訂取消',NULL,'2025-01-22 23:46:00','2025-01-23 00:02:28',1,NULL),(12,'1737558328724',5,1,3,'2025-01-22 23:05:29',NULL,0,80.00,'','0912345888',NULL,NULL,NULL,'訂單超時，自訂取消',NULL,'2025-01-22 23:39:00','2025-01-23 00:05:27',1,'2025-01-23 23:38:06'),(13,'1737558972114',5,1,2,'2025-01-22 23:16:12',NULL,0,270.00,'','0912345678',NULL,NULL,'asbc','訂單超時，自訂取消',NULL,'2025-01-22 23:46:00','2025-01-23 00:16:01',1,NULL),(14,'1737559167650',6,1,3,'2025-01-22 23:19:28',NULL,0,90.00,'','0912345888',NULL,NULL,NULL,'訂單超時，自訂取消','休','2025-01-24 22:42:00','2025-01-23 00:19:25',1,NULL),(15,'1737559868627',6,1,2,'2025-01-22 23:31:09',NULL,0,320.00,'','0912345678',NULL,NULL,'asbc','訂單超時，自訂取消','太遠哥各','2025-01-24 22:42:00','2025-01-23 00:30:48',1,NULL),(16,'1737637670396',6,1,4,'2025-01-23 21:07:50',NULL,0,170.00,'11點送來','0933345888',NULL,'matt',NULL,'訂單超時，自訂取消','休了','2025-01-24 22:42:00',NULL,0,NULL),(17,'1737638653719',6,1,3,'2025-01-23 21:24:14',NULL,0,485.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消','遠到爆','2025-01-24 22:42:00','2025-01-23 22:24:10',1,NULL),(18,'1737650301572',6,1,4,'2025-01-24 00:38:22',NULL,0,173.00,'','0933345888','台中北區大江街2號7F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:27:00','2025-01-24 01:38:06',1,NULL),(19,'1737695301549',3,1,3,'2025-01-24 13:08:22','2025-01-25 14:25:35',1,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:11:00','2025-01-24 14:08:16',1,NULL),(20,'1737695586051',6,1,3,'2025-01-24 13:13:06',NULL,0,80.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 14:14:00','2025-01-24 14:13:04',1,NULL),(21,'1737697169981',3,1,3,'2025-01-24 13:39:30','2025-01-25 14:24:16',1,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:27:00','2025-01-24 14:39:27',1,NULL),(22,'1737697275139',3,1,3,'2025-01-24 13:41:15','2025-01-25 14:26:59',1,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 14:14:00','2025-01-24 14:41:11',1,NULL),(23,'1737697415775',6,1,4,'2025-01-24 13:43:36',NULL,0,80.00,'','0933345888','台中北區大江街2號7F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:27:00','2025-01-24 14:43:27',1,NULL),(24,'1737697716355',3,1,3,'2025-01-24 13:48:36','2025-01-25 14:23:36',1,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:27:00','2025-01-24 14:48:31',1,NULL),(25,'1737699175999',5,1,3,'2025-01-24 14:12:56','2025-01-24 14:24:52',1,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,NULL,NULL,NULL,'2025-01-24 15:12:53',1,'2025-01-26 00:04:32'),(26,'1737700812717',6,1,3,'2025-01-24 14:40:13',NULL,0,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 14:56:00','2025-01-24 15:40:06',1,NULL),(27,'1737700998781',3,1,4,'2025-01-24 14:43:19','2025-01-24 14:43:39',1,130.00,'','0933345888','台中北區大江街2號7F2','matt',NULL,NULL,NULL,NULL,'2025-01-24 15:43:04',1,NULL),(28,'1737701532479',1,1,3,'2025-01-24 14:52:12',NULL,0,125.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 15:08:00','2025-01-24 15:52:07',1,NULL),(29,'1737701776354',5,1,3,'2025-01-24 14:56:16','2025-01-25 14:22:11',1,135.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:27:00','2025-01-24 15:56:11',1,'2025-01-26 00:04:32'),(30,'1737702474182',1,1,3,'2025-01-24 15:07:54','2025-01-24 23:22:15',1,140.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:27:00','2025-01-24 16:07:52',1,NULL),(31,'1737702589198',1,1,3,'2025-01-24 15:09:49','2025-01-24 23:22:06',1,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:27:00','2025-01-24 16:09:40',1,NULL),(32,'1737703701634',6,1,3,'2025-01-24 15:28:22',NULL,0,80.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 22:11:00','2025-01-24 16:27:46',1,NULL),(33,'1737723915481',1,1,3,'2025-01-24 21:05:15','2025-01-24 23:29:16',1,670.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,'訂單超時，自訂取消',NULL,'2025-01-24 21:21:00','2025-01-24 22:05:12',1,NULL),(34,'1737731932240',5,1,3,'2025-01-24 23:18:52','2025-01-25 14:56:55',1,175.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,NULL,NULL,NULL,'2025-01-25 00:18:50',1,'2025-01-26 00:04:32'),(35,'1737782659604',5,1,3,'2025-01-25 13:24:20','2025-01-25 14:55:23',1,815.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,NULL,NULL,NULL,'2025-01-25 14:24:14',1,'2025-01-26 00:04:32'),(36,'1737782832891',5,1,3,'2025-01-25 13:27:13','2025-01-25 14:53:13',1,180.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,NULL,NULL,NULL,NULL,0,'2025-01-26 00:04:32'),(37,'1737782873838',5,1,3,'2025-01-25 13:27:54','2025-01-25 14:47:35',1,80.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,NULL,NULL,NULL,'2025-01-25 14:27:50',1,'2025-01-26 00:04:31'),(38,'1737785318050',5,1,3,'2025-01-25 14:08:38','2025-01-25 14:08:50',1,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,NULL,NULL,NULL,'2025-01-25 15:08:34',1,'2025-01-26 00:04:31'),(39,'1737788506506',2,44,8,'2025-01-25 15:01:47','2025-01-25 15:01:49',1,240.00,'','0912345678','台北東區98號','uuu','193',NULL,NULL,NULL,'2025-01-25 16:01:44',1,NULL),(40,'1737788626881',2,44,8,'2025-01-25 15:03:47','2025-01-25 15:03:52',1,240.00,'','0912345678','台北東區98號','uuu','193',NULL,NULL,NULL,'2025-01-25 16:03:45',1,NULL),(41,'1737788960606',2,44,8,'2025-01-25 15:09:21','2025-01-25 15:09:22',1,80.00,'','0912345678','台北東區98號','uuu','193',NULL,NULL,NULL,'2025-01-25 16:09:15',1,NULL),(42,'1737789098870',2,44,8,'2025-01-25 15:11:39','2025-01-25 15:11:40',1,80.00,'','0912345678','台北東區98號','uuu','193',NULL,NULL,NULL,'2025-01-25 16:11:37',1,NULL),(43,'1737789163924',2,44,8,'2025-01-25 15:12:44','2025-01-25 15:12:45',1,80.00,'','0912345678','台北東區98號','uuu','193',NULL,NULL,NULL,'2025-01-25 16:12:42',1,NULL),(44,'1737789198363',2,44,8,'2025-01-25 15:13:18','2025-01-25 15:13:19',1,80.00,'','0912345678','台北東區98號','uuu','193',NULL,NULL,NULL,'2025-01-25 16:13:17',1,NULL),(45,'1737821054230',5,1,3,'2025-01-26 00:04:14','2025-01-26 00:04:15',1,90.00,'','0912345888','南投西區軍暉街282號5F2','matt',NULL,NULL,NULL,NULL,'2025-01-26 01:04:12',1,'2025-01-26 00:04:31');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `name` varchar(32) DEFAULT NULL COMMENT '餐點名稱',
  `image` varchar(255) DEFAULT NULL COMMENT '餐點圖片',
  `user_id` bigint NOT NULL COMMENT '顧客id',
  `meal_id` bigint NOT NULL COMMENT '餐點id',
  `meal_flavor` varchar(50) DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '數量',
  `amount` decimal(10,2) NOT NULL COMMENT '金額',
  `create_time` datetime DEFAULT NULL COMMENT '創建時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='購物車';
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
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `role` varchar(2) NOT NULL COMMENT '角色',
  `name` varchar(32) NOT NULL COMMENT '姓名',
  `account` varchar(32) NOT NULL COMMENT '帳號',
  `password` varchar(64) NOT NULL COMMENT '密碼',
  `balance` decimal(10,2) DEFAULT NULL COMMENT '餘額，只有顧客才有此項',
  `phone` varchar(10) NOT NULL COMMENT '手機號',
  `sex` varchar(2) NOT NULL COMMENT '性別',
  `avatar` varchar(500) DEFAULT NULL COMMENT '頭像',
  `create_time` datetime DEFAULT NULL COMMENT '註冊時間',
  `update_time` datetime DEFAULT NULL COMMENT '最後登入時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用戶資訊';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'3','matt','admin','e10adc3949ba59abbe56e057f20f883e',5845.00,'0912345699','1','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/99936061-6122-4b8c-a397-fca53cc891d1.png','2025-01-13 11:20:24','2025-02-06 14:36:03'),(2,'1','郭靖','guojing','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(3,'1','黃蓉','huangrong','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(4,'1','楊過','yangguo','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(5,'1','小龍女','xiaolongnv','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(6,'1','洪七公','hongqigong','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(7,'1','歐陽鋒','ouyangfeng','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(8,'1','周伯通','zhoubotong','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(9,'2','穆念慈','munianci','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(10,'1','黃藥師','huangyaoshi','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(11,'1','李莫愁','limochou','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(12,'2','陸無雙','luwushuang','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(13,'1','裘千仞','qiuqianren','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(14,'2','金輪法王','jinlunfawang','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(15,'1','郭襄','guoxiang','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(16,'2','郭芙','guofu','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(17,'1','楊康','yangkang','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(18,'2','程英','chengying','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(19,'1','公孫止','gongsunzhi','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(20,'2','王重陽','wangchongyang','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','1',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(21,'1','韓小瑩','hanxiaoying','e10adc3949ba59abbe56e057f20f883e',2000.00,'0912345678','0',NULL,'2025-01-13 11:20:41','2025-01-13 11:20:41'),(22,'1','John','john','e10adc3949ba59abbe56e057f20f883e',3000.00,'0912345678','1','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/00eefa20-6860-4a8e-b3bd-17ddec16f9f7.png','2025-01-13 11:57:39','2025-01-13 11:57:39'),(23,'2','湯姆貓','Tom','e10adc3949ba59abbe56e057f20f883e',NULL,'0912345678','1',NULL,'2025-01-13 22:50:17','2025-01-16 23:25:49'),(25,'1','John1','john1','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','1',NULL,'2025-01-13 23:56:40','2025-01-14 00:14:55'),(26,'1','John1234','john1234','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','1',NULL,'2025-01-14 20:20:42','2025-01-15 14:47:51'),(28,'2','Tom123','tom123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','0',NULL,'2025-01-16 15:03:15','2025-01-16 15:03:15'),(29,'1','alisa','alisa123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0987273647','0',NULL,'2025-01-16 15:11:54','2025-01-16 15:11:54'),(30,'1','ben','ben123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0936428471','0',NULL,'2025-01-16 15:15:18','2025-01-16 23:25:14'),(31,'1','Simon','simon123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0983654723','1',NULL,'2025-01-17 10:55:15','2025-01-17 10:55:15'),(32,'2','Simo','simo123','e10adc3949ba59abbe56e057f20f883e',NULL,'0983654723','0',NULL,'2025-01-17 10:56:54','2025-01-27 23:19:34'),(33,'1','alima','alima123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','0',NULL,'2025-01-17 10:58:58','2025-01-17 10:58:58'),(34,'1','adel','adel123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','0',NULL,'2025-01-17 11:00:42','2025-01-17 11:00:42'),(35,'2','tiger','tiger123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','1',NULL,'2025-01-17 11:02:32','2025-01-17 11:02:32'),(36,'2','mouse','mouse123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','0',NULL,'2025-01-17 11:04:34','2025-01-17 11:04:34'),(37,'1','amaa','amaa123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','1',NULL,'2025-01-17 11:06:56','2025-01-17 11:06:56'),(38,'1','abcd','abcd123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','0',NULL,'2025-01-17 11:08:00','2025-01-17 11:08:00'),(40,'1','bbb','bbb123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','0',NULL,'2025-01-17 11:14:49','2025-01-17 11:14:49'),(41,'1','ccc','ccc123','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','0',NULL,'2025-01-17 11:26:05','2025-01-17 11:26:05'),(42,'2','mmm123','mmm123','e10adc3949ba59abbe56e057f20f883e',NULL,'0912345678','1',NULL,'2025-01-17 15:20:43','2025-01-17 15:20:43'),(44,'1','uuu','uuu123','e10adc3949ba59abbe56e057f20f883e',3500.00,'0985426514','1',NULL,'2025-01-17 18:31:43','2025-02-01 18:47:38'),(47,'1','神雕大俠','yang','e10adc3949ba59abbe56e057f20f883e',5000.00,'0912345678','1','https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/0c91b88c-cdde-4e36-9de5-3761e32b7428.png','2025-01-27 23:48:03','2025-01-28 00:11:12');
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

-- Dump completed on 2025-02-06 15:18:53
