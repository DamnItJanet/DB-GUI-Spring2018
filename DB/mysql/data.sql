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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'Casey','Hittinger2','kcdilla2','$2a$10$Usta0wUV0D5maQZDL9oQkuIkuyi1/Mlr4Vt66Vy20bqkeq7xw.jDO'),(2,'Casey','Hittinger','kcdilla','$2a$10$ILYRCBBVwFU40SbISyne/.gBPMBSzpLdvWHaWobksC8rTy3KTWsQ6'),(3,'Andrew','B','andyB','$2a$10$PJqRVPhfdX7FNtD4p2ooJuPlZ6305PJMtZE6TjNQ1m8PZmsEea23u'),(4,'Adam','A','aadam','$2a$10$Xrc.uUfzMzZq6L4D8un76egcV/qjigmGrZtjKfVORC50ZkfBhXA1G'),(5,'Michael','Watts','Mwatt','$2a$10$cbHeqktURwlhmgTw8tJx2Owcq5S.Rjk2VdNV5vm0Ra39u2rg.k4MO'),(6,'Chi','Tran','cheesy','$2a$10$ERjj8YKwbkhCFj3ZtiZejOEL9gDJIhT1CK/CpCybqW4JMzXRg5xs.');
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
  `foodSold` int(11) DEFAULT NULL,
  `foodCost` decimal(5,2) DEFAULT NULL,
  `menuId` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `foodING` mediumtext,
  PRIMARY KEY (`idfood`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Apple','Fruit',400,4.00,9,5,'Apple  (optional caramel)'),(2,'Lemon','Fruit',12,0.98,9,2,'Lemon (optional salt)'),(4,'Banana','Fruit',1,0.98,9,1,'Banana (optional peanut-butter)'),(5,'Chicken','Meat',1,3.90,2,3,'Chicken (optional ranch)'),(6,'Burrito','Meal',1,1.00,6,5,'Tortilla, Beans, RIce, Tomato'),(7,'Pizza','Meal',12,5.00,4,4,'Pepperoni, Cheese, Dough, Tomato Sauce'),(8,'Super Spicy Wings','Meal',12,2.00,2,3,'Spicy Sauce, Chicken'),(9,'Mild Wings','Meal',12,2.00,2,2,'Mild Sauce, Chicken'),(10,'Crab','Meal',12,22.00,7,4,'Crab'),(11,'Lobster','Meal',12,34.00,7,2,'Lobster'),(13,'Chocolate','Ice Cream',2,4.00,8,3,'Cocoa Beans'),(14,'Stuffed Crust Pizza','Meal',2,10.00,5,4,'Pepperoni, Cheese, Dough, Tomato Sauce'),(15,'Salad','Vegetable',2,3.00,1,5,'Lettuce, Tomato, Onion, Carrot'),(16,'Spaghetti','Meal',2,12.00,1,3,'Pasta, Tomato Sauce, Meat Balls'),(17,'Pasta','Meal',2,10.00,1,2,'Pasta, Parmesian'),(18,'Burger','Meal',2,5.00,8,4,'Bread, Meat, Lettuce, Tomato, Cheese, Ketchup'),(19,'Fetuccine Alfredo','Meal',2,15.00,10,4,'Parmasean, Pasta, Chicken, Cheese');
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
  `ingGroup` varchar(45) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`idingredients`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'Pepperonis','2018-12-31',1000,4,'Meat',1.00),(2,'Cheese','2018-12-31',300,4,'Cheese',2.00),(3,'Torillla','2018-12-31',300,6,'Bread',0.67),(4,'Dough','2018-12-31',1000,4,'Bread',1.00),(5,'Hot Sauce','2018-12-31',400,2,'Sauces',0.67),(6,'Rice','2018-12-31',4000,6,'Grain',0.03),(7,'Pepperonis','2018-12-31',1000,5,'Meat',1.00),(8,'Cheese','2018-12-31',300,5,'Cheese',1.00),(9,'Parmesian','2018-12-31',200,1,'Cheese',1.00),(10,'Tomato','2018-05-03',200,4,'Vegetables',0.57),(11,'Pasta','2018-05-04',200,10,'Grain',0.89),(12,'Chicken','2018-09-12',100,10,'Meat',1.23);
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
  `zipCode` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idrestaurant`),
  KEY `idaccount_idx` (`ownerId`),
  CONSTRAINT `idaccount` FOREIGN KEY (`ownerId`) REFERENCES `account` (`idaccount`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Olive Garden','123 Main Street',1,'https://www.olivegarden.com/home','New Location at SMU','http://media.olivegarden.com/images/site/ext/pages/_promotions/about-us/news-and-media/olive_garden_logo_hr.jpg','Italian','75205','Dallas'),(2,'Buffalo Wild Wings','123 West Street',1,'https://www.buffalowildwings.com/','New Location at SMU','http://www.nrn.com/sites/nrn.com/files/styles/article_featured_standard/public/uploads/2016/10/bww.gif?itok=4W6yQIpK','Wings','75205','Dallas'),(4,'Pizza Hut','SMU Street',2,'https://www.pizzahut.com/','New Location at SMU','https://vignette.wikia.nocookie.net/logopedia/images/b/b7/Waralaba_Pizza_Hut_Indonesia_%28PT_Sarimelati_Kencana%29.jpeg/revision/latest?cb=20161129153753','Italian','75205','Dallas'),(5,'Dominos','SMU Rd',3,'https://www.dominos.com/en/','New Location at SMU','https://logos-download.com/wp-content/uploads/2016/04/Dominos_Pizza_logo.png','Italian','75205','Dallas'),(6,'Chipotle','SMU Lane',3,'https://www.chipotle.com/','New Location at SMU','http://1000logos.net/wp-content/uploads/2017/11/Chipotle-Logo.png','Mexican','75205','Dallas'),(7,'Michaels Food Place','Times Times Square',5,'https://michaelscuisine.com/','New Location at SMU','http://michaelsgrillokc.com/portals/0/Images/home/mgsplash.jpg','Other','66209','Kansas City'),(8,'Dairy Queen','5656 Dallas Blvd',4,'https://www.dairyqueen.com/','New Location at SMU','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT15efjBinzH4_gVGYKtxu0JILsAfvJIgc1_-B4cKt1_OSu1BCy4w','Fast-Food','75205','Dallas'),(9,'Burrito Truck','SMU Court',2,'https://roaminghunger.com/texas-burrito-company/','New Location at SMU','https://roaminghunger.com/img/trucks/original/4dd43593-2268-4d6c-ab10-71e046204482.jpg','Other','75205','Dallas'),(10,'Chi\'s Italian Place','SMU Lane',6,'http://jengchirestaurant.com/','New Location at SMU','https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Former_Chi-Chi%27s_restaurant_in_Alexandria%2C_Virginia.png/300px-Former_Chi-Chi%27s_restaurant_in_Alexandria%2C_Virginia.png','Italian','76205','Dallas');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'foodapp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-18 18:48:06
