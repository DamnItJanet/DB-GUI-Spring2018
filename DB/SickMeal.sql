-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 18.208.50.214    Database: dbgui_5
-- ------------------------------------------------------
-- Server version	5.6.39-log

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `idaccount` int(11) NOT NULL AUTO_INCREMENT,
  `fName` varchar(45) DEFAULT NULL,
  `lName` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`idaccount`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'Admin','Site','admin','$2a$10$KWqt3MRfnTXaLIZpan5xN.w.ZJCb44gVtoSHKebV3/BFFpqikyf0O','casey@gmail.com',1,1),(2,'Casey','Hittinger','kcdilla','$2a$10$ILYRCBBVwFU40SbISyne/.gBPMBSzpLdvWHaWobksC8rTy3KTWsQ6','casey2@hotmail.com',2,0),(3,'Andrew','B','andyB','$2a$10$PJqRVPhfdX7FNtD4p2ooJuPlZ6305PJMtZE6TjNQ1m8PZmsEea23u','andrew@gmail.com',3,0),(4,'Adam','A','aadam','$2a$10$Xrc.uUfzMzZq6L4D8un76egcV/qjigmGrZtjKfVORC50ZkfBhXA1G','adamchi@gmail.com',3,0),(6,'Veve','Phe','pheveve','$2a$10$f0luhQPNkqp0/FS4f3mSQuY8JeMcyQetSP6ckXOBa.IUpskA8o1cu','phamvietvanc4@gmail.com',3,1),(7,' Owner 1','Restaurant','owner1','$2a$10$KWqt3MRfnTXaLIZpan5xN.w.ZJCb44gVtoSHKebV3/BFFpqikyf0O','phamvietvanc4@gmail.com',3,1),(8,'Restaurant ','Owner 2','owner2','$2a$10$LZrNjwuQEeEjTF4pRE5J.eU2mMSMXqvxiGh.V1lBgcZFqZStaH3LW','phamvietvanc4@gmail.com',3,1),(9,'Viet Van','Pham','owner3','$2a$10$VRAbVi1zVe9QWO1AbSlgA.Frs5iuTucJg3fcfxlb1Wjm9/IrEq00i','phamvietvanc4@gmail.com',3,0),(10,'Test','Owner','testowner','$2a$10$JVXRhkBppN4aSmjSdAA6yOLQLF0jZJ3efAOF5xsuLZnG2yH3S9.VS','owner@gmail.commm',3,1);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food` (
  `idfood` int(11) NOT NULL AUTO_INCREMENT,
  `foodName` varchar(45) DEFAULT NULL,
  `foodType` varchar(45) DEFAULT NULL,
  `foodGroup` varchar(45) DEFAULT NULL,
  `foodAmount` int(11) DEFAULT NULL,
  `foodSold` int(11) DEFAULT NULL,
  `foodCost` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`idfood`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Apple','Fruit','Red',355,43,1.25),(2,'Lemon','Fruit','Green',200,12,0.98),(4,'Banana','Fruit','Yellow',35,1,0.98),(5,'Chicken','Meat','Brown',23,1,3.90);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productName` varchar(100) NOT NULL,
  `importDate` datetime NOT NULL,
  `expirationDate` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `description` varchar(500) NOT NULL,
  `restaurantId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (3,'Name of P','2018-05-02 00:00:00','2018-05-26 00:00:00',1,102,'Tra Dao Cam Xa',16);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurantId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `rate` float DEFAULT NULL,
  `imageName` blob,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (9,16,'abc',NULL,5,NULL,1),(2,1,'Mons nay dang la 4 sao\r\n','desc\r\n',3.61538,' \r\n',1),(3,1,'Mons an 3\r\n','desc\r\n',3.15385,' \r\n',1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant` (
  `idrestaurant` int(11) NOT NULL AUTO_INCREMENT,
  `restName` varchar(45) DEFAULT NULL,
  `restLocation` varchar(45) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `restLink` varchar(45) DEFAULT NULL,
  `restNews` varchar(255) DEFAULT 'New Location at SMU',
  `restIMGLink` blob,
  `zipcode` varchar(20) NOT NULL DEFAULT '',
  `city` varchar(200) DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`idrestaurant`),
  KEY `idaccount_idx` (`ownerId`),
  CONSTRAINT `idaccount` FOREIGN KEY (`ownerId`) REFERENCES `account` (`idaccount`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Olive Garden','123 Main Street',7,'https://www.olivegarden.com/home','New Location at SMU','http://media.olivegarden.com/images/site/ext/pages/_promotions/about-us/news-and-media/olive_garden_logo_hr.jpg','',NULL,'cool restaurant'),(2,'Buffalo Wild Wings','123 West Street',8,'https://www.buffalowildwings.com/','New Location at SMU','data:image/png;base64,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','',NULL,'This is the description for this restaurant'),(4,'Pizza Hut','SMU Street',4,'https://www.pizzahut.com/','New Location at SMU','https://vignette.wikia.nocookie.net/logopedia/images/b/b7/Waralaba_Pizza_Hut_Indonesia_%28PT_Sarimelati_Kencana%29.jpeg/revision/latest?cb=20161129153753','',NULL,'Oh shit'),(5,'Dominos','SMU Rd',3,'https://www.dominos.com/en/','New Location at SMU','https://logos-download.com/wp-content/uploads/2016/04/Dominos_Pizza_logo.png','',NULL,'domino restaurant'),(6,'Chipotle','SMU Lane',1,'https://www.chipotle.com/','New Location at SMU','http://1000logos.net/wp-content/uploads/2017/11/Chipotle-Logo.png','',NULL,'chip chip chip'),(16,'Viet Van Pham','118/8/1 Nguyen Thi Thap',6,'123444','New Location at SMU','data:image/png;base64,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','1',NULL,'a'),(17,'Test','123 SMU BLVD',10,'http://smu.edu','New Location at SMU','https://www.hsjaa.com/images/joomlart/demo/default.jpg','75205',NULL,'Test');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurantpost`
--

DROP TABLE IF EXISTS `restaurantpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurantpost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(2000) NOT NULL,
  `userId` int(11) NOT NULL,
  `restaurantId` int(11) NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurantpost`
--

LOCK TABLES `restaurantpost` WRITE;
/*!40000 ALTER TABLE `restaurantpost` DISABLE KEYS */;
INSERT INTO `restaurantpost` VALUES (1,'updated content\nBut cannot update.\nWhy???\nO la la',1,1,'2018-04-25 17:19:52','2018-04-26 07:17:23',1),(2,'hello teacher',6,1,'2018-04-26 00:26:53','2018-04-26 00:26:53',1),(3,'toi da den day roi nhe',6,1,'2018-04-26 00:27:37','2018-04-26 01:11:43',0),(4,'toi o mien xa. troi quen dat la',6,6,'2018-04-26 18:37:12','2018-04-26 18:46:12',0),(5,'Hello, this is my new post.\n(updated)',6,6,'2018-04-26 18:43:00','2018-04-26 18:45:26',1);
/*!40000 ALTER TABLE `restaurantpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reviewOf` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` varchar(2000) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,'vanpv',4,'i want to review this restaurant','2018-04-25 00:00:00',1,1),(2,1,'tony',5,'Hello teacher dit ai nay ro','2018-04-25 03:21:44',1,1),(18,3,'pheveve',1,'','2018-04-25 13:12:57',2,1),(15,2,'pheveve',3,'','2018-04-25 13:07:28',2,1),(16,3,'pheveve',3,'','2018-04-25 13:12:43',2,1),(17,3,'pheveve',5,'','2018-04-25 13:12:52',2,1),(14,2,'pheveve',5,'','2018-04-25 13:06:37',2,1),(19,3,'pheveve',2,'','2018-04-25 13:21:16',2,1),(20,3,'pheveve',1,'','2018-04-25 13:21:19',2,1),(21,3,'pheveve',1,'','2018-04-25 13:21:23',2,1),(22,3,'pheveve',1,'','2018-04-25 13:21:27',2,1),(23,2,'pheveve',1,'','2018-04-25 13:21:32',2,1),(24,2,'pheveve',1,'','2018-04-25 13:21:35',2,1),(25,2,'pheveve',1,'','2018-04-25 13:21:39',2,1),(26,2,'pheveve',1,'','2018-04-25 13:21:42',2,1),(27,2,'pheveve',5,'','2018-04-25 13:21:46',2,1),(28,2,'pheveve',5,'','2018-04-25 13:21:49',2,1),(29,2,'pheveve',5,'','2018-04-25 13:21:51',2,1),(30,2,'pheveve',5,'','2018-04-25 13:21:53',2,1),(31,2,'pheveve',5,'','2018-04-25 13:21:55',2,1),(32,2,'pheveve',5,'','2018-04-25 13:21:57',2,1),(33,3,'pheveve',4,'','2018-04-25 23:35:38',2,1),(34,3,'pheveve',4,'','2018-04-25 23:35:43',2,1),(35,3,'pheveve',4,'','2018-04-25 23:35:47',2,1),(36,3,'pheveve',5,'','2018-04-25 23:35:51',2,1),(37,3,'pheveve',5,'','2018-04-25 23:35:54',2,1),(38,9,'pheveve',5,'','2018-05-02 00:25:29',2,1);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userfollows`
--

DROP TABLE IF EXISTS `userfollows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userfollows` (
  `userID` int(11) NOT NULL,
  `restID` int(11) NOT NULL,
  PRIMARY KEY (`userID`,`restID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userfollows`
--

LOCK TABLES `userfollows` WRITE;
/*!40000 ALTER TABLE `userfollows` DISABLE KEYS */;
INSERT INTO `userfollows` VALUES (6,1),(6,2);
/*!40000 ALTER TABLE `userfollows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'dbgui_5'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-01 15:51:18
