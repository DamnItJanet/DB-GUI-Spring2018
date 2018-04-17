-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: foodapp
-- ------------------------------------------------------
-- Server version	5.7.21

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
  PRIMARY KEY (`idaccount`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'Casey','Hittinger2','kcdilla2','$2a$10$Usta0wUV0D5maQZDL9oQkuIkuyi1/Mlr4Vt66Vy20bqkeq7xw.jDO'),(2,'Casey','Hittinger','kcdilla','$2a$10$ILYRCBBVwFU40SbISyne/.gBPMBSzpLdvWHaWobksC8rTy3KTWsQ6'),(3,'Andrew','B','andyB','$2a$10$PJqRVPhfdX7FNtD4p2ooJuPlZ6305PJMtZE6TjNQ1m8PZmsEea23u'),(4,'Adam','A','aadam','$2a$10$Xrc.uUfzMzZq6L4D8un76egcV/qjigmGrZtjKfVORC50ZkfBhXA1G'),(5,'Michael','Watts','Mwatt','$2a$10$cbHeqktURwlhmgTw8tJx2Owcq5S.Rjk2VdNV5vm0Ra39u2rg.k4MO');
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
  `foodSold` int(11) DEFAULT NULL,
  `foodCost` decimal(5,2) DEFAULT NULL,
  `menuId` int(11) DEFAULT NULL,
  PRIMARY KEY (`idfood`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Apple','Fruit','Red',43,1.25,9),(2,'Lemon','Fruit','Green',12,0.98,9),(4,'Banana','Fruit','Yellow',1,0.98,9),(5,'Chicken','Meat','Brown',1,3.90,2),(6,'Burrito','Meal','Brown',1,1.00,6),(7,'Pizza','Meal','Red',12,5.00,4),(8,'Super Spicy Wings','Meal','Red',12,2.00,2),(9,'Mild Wings','Meal','Red',12,2.00,2),(10,'Crab','Meal','Red',12,22.00,7),(11,'Lobster','Meal','Red',12,34.00,7),(13,'Chocolate','Ice Cream','Brown',2,4.00,8),(14,'Stuffed Crust Pizza','Meal','Red',2,10.00,5),(15,'Salad','Vegetable','Green',2,3.00,1),(16,'Spaghetti','Meal','Red',2,12.00,1),(17,'Pasta','Meal','Yellow',2,10.00,1);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients` (
  `idingredients` int(11) NOT NULL AUTO_INCREMENT,
  `ingredientName` varchar(45) DEFAULT NULL,
  `ingredientEXP` date DEFAULT NULL,
  `ingredientAmt` int(11) DEFAULT NULL,
  `restID` int(11) DEFAULT NULL,
  PRIMARY KEY (`idingredients`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'Pepperonis','2018-12-31',1000,4),(2,'Cheese','2018-12-31',300,4),(3,'Torillla','2018-12-31',300,6),(4,'Dough','2018-12-31',1000,4),(5,'Hot Sauce','2018-12-31',400,2),(6,'Rice','2018-12-31',4000,6),(7,'Pepperonis','2018-12-31',1000,5),(8,'Cheese','2018-12-31',300,5),(9,'Parmesian','2018-12-31',200,1);
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
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
  `restLink` varchar(255) DEFAULT NULL,
  `restNews` varchar(255) DEFAULT 'New Location at SMU',
  `restIMGLink` mediumtext,
  `restType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idrestaurant`),
  KEY `idaccount_idx` (`ownerId`),
  CONSTRAINT `idaccount` FOREIGN KEY (`ownerId`) REFERENCES `account` (`idaccount`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Olive Garden','123 Main Street',1,'https://www.olivegarden.com/home','New Location at SMU','http://media.olivegarden.com/images/site/ext/pages/_promotions/about-us/news-and-media/olive_garden_logo_hr.jpg','Italian'),(2,'Buffalo Wild Wings','123 West Street',1,'https://www.buffalowildwings.com/','New Location at SMU','http://www.nrn.com/sites/nrn.com/files/styles/article_featured_standard/public/uploads/2016/10/bww.gif?itok=4W6yQIpK','Wings'),(4,'Pizza Hut','SMU Street',2,'https://www.pizzahut.com/','New Location at SMU','https://vignette.wikia.nocookie.net/logopedia/images/b/b7/Waralaba_Pizza_Hut_Indonesia_%28PT_Sarimelati_Kencana%29.jpeg/revision/latest?cb=20161129153753','Italian'),(5,'Dominos','SMU Rd',3,'https://www.dominos.com/en/','New Location at SMU','https://logos-download.com/wp-content/uploads/2016/04/Dominos_Pizza_logo.png','Italian'),(6,'Chipotle','SMU Lane',3,'https://www.chipotle.com/','New Location at SMU','http://1000logos.net/wp-content/uploads/2017/11/Chipotle-Logo.png','Mexican'),(7,'Michaels Food Place','Times Times Square',5,'https://michaelscuisine.com/','New Location at SMU','http://michaelsgrillokc.com/portals/0/Images/home/mgsplash.jpg','Other'),(8,'Dairy Queen','5656 Dallas Blvd',4,'https://www.dairyqueen.com/','New Location at SMU','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT15efjBinzH4_gVGYKtxu0JILsAfvJIgc1_-B4cKt1_OSu1BCy4w','Fast-Food'),(9,'Burrito Truck','SMU Court',2,'https://roaminghunger.com/texas-burrito-company/','New Location at SMU','https://roaminghunger.com/img/trucks/original/4dd43593-2268-4d6c-ab10-71e046204482.jpg','Other');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-17 15:59:30
