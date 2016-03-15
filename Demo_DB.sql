CREATE DATABASE  IF NOT EXISTS `demo` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `demo`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: demo
-- ------------------------------------------------------
-- Server version	5.7.11-log

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
-- Table structure for table `availablestatus`
--

DROP TABLE IF EXISTS `availablestatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `availablestatus` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availablestatus`
--

LOCK TABLES `availablestatus` WRITE;
/*!40000 ALTER TABLE `availablestatus` DISABLE KEYS */;
INSERT INTO `availablestatus` VALUES (1,'In Stock'),(2,'Out Stock'),(3,'Archived');
/*!40000 ALTER TABLE `availablestatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'SamSung','SamSung Electric Company'),(2,'Sony','Sony Electric Company'),(3,'Apple','Apple Technology'),(4,'Microsoft','Microsoft');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preview`
--

DROP TABLE IF EXISTS `preview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preview` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductId` int(11) NOT NULL,
  `Rating` int(11) NOT NULL DEFAULT '0',
  `Comment` varchar(2000) DEFAULT NULL,
  `UserId` int(11) NOT NULL,
  `Created` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Review_Product` (`ProductId`),
  KEY `FK_Review_User` (`UserId`),
  CONSTRAINT `FK_Review_Product` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ID`),
  CONSTRAINT `FK_Review_User` FOREIGN KEY (`UserId`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preview`
--

LOCK TABLES `preview` WRITE;
/*!40000 ALTER TABLE `preview` DISABLE KEYS */;
/*!40000 ALTER TABLE `preview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `BrandId` int(11) NOT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  `Price` decimal(13,2) DEFAULT '0.00',
  `Colour` varchar(100) DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `StatusId` int(11) NOT NULL DEFAULT '1',
  `Image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Product_Brand` (`BrandId`),
  KEY `FK_Product_Status` (`StatusId`),
  CONSTRAINT `FK_Product_Brand` FOREIGN KEY (`BrandId`) REFERENCES `brand` (`ID`),
  CONSTRAINT `FK_Product_Status` FOREIGN KEY (`StatusId`) REFERENCES `brand` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Galaxy Y',1,'Samsung galaxy Y',150.00,'Black','2014-01-01 00:00:00',2,'defaul-image.jpg'),(2,'Galaxy S2',1,'Samsung galaxy S2',350.00,'White','2014-03-03 00:00:00',3,'defaul-image.jpg'),(3,'Galaxy S3',1,'Samsung galaxy S3',350.00,'White','2015-01-01 00:00:00',1,'defaul-image.jpg'),(4,'Galaxy S4',1,'Samsung galaxy S4',550.00,'White','2016-01-01 00:00:00',1,'defaul-image.jpg'),(5,'Galaxy Edge',1,'Samsung galaxy Edge',750.00,'White','2016-03-03 00:00:00',1,'defaul-image.jpg'),(6,'Aqua M2',2,'Sony Aqua M2',250.00,'Snow','2015-05-05 00:00:00',2,'defaul-image.jpg'),(7,'C2',2,'Sony C2',350.00,'Blue','2014-06-07 00:00:00',1,'defaul-image.jpg'),(8,'C3',2,'Sony C3',450.00,'Black','2015-09-07 00:00:00',1,'defaul-image.jpg'),(9,'Revole',2,'Sony Revole',150.00,'White','2013-01-05 00:00:00',2,'defaul-image.jpg'),(10,'Iphone 4',3,'Appy iphone 4',150.00,'White','2013-01-03 00:00:00',3,'defaul-image.jpg'),(11,'Iphone 4s',3,'Appy iphone 4s',250.00,'White','2013-09-08 00:00:00',2,'defaul-image.jpg'),(12,'Iphone 5',3,'Appy iphone 5',300.00,'White','2014-08-06 00:00:00',1,'defaul-image.jpg'),(13,'Iphone 5c',3,'Appy iphone 5c',250.00,'White','2014-11-11 00:00:00',2,'defaul-image.jpg'),(14,'Iphone 5s',3,'Appy iphone 5s',350.00,'White','2015-06-03 00:00:00',1,'defaul-image.jpg'),(15,'Iphone 6',3,'Appy iphone 6',450.00,'White','2015-11-11 00:00:00',1,'defaul-image.jpg'),(16,'Iphone 6s',3,'Appy iphone 6s',250.00,'White','2016-01-01 00:00:00',1,'defaul-image.jpg');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(100) NOT NULL,
  `UserTypeId` int(11) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `DOB` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserName` (`UserName`),
  UNIQUE KEY `Email` (`Email`),
  KEY `FK_User_UserType` (`UserTypeId`),
  CONSTRAINT `FK_User_UserType` FOREIGN KEY (`UserTypeId`) REFERENCES `availablestatus` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user2',2,'admin@demo.com','1990-10-10 00:00:00'),(2,'user3',1,'user3@demo.com','1990-10-10 00:00:00'),(3,'user4',2,'user4@demo.com','1990-10-10 00:00:00');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertype` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertype`
--

LOCK TABLES `usertype` WRITE;
/*!40000 ALTER TABLE `usertype` DISABLE KEYS */;
INSERT INTO `usertype` VALUES (1,'Customer'),(2,'Merchant');
/*!40000 ALTER TABLE `usertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'demo'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_getListProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getListProducts`(
	IN brandId INT
)
BEGIN
	CREATE TABLE temp
	SELECT p.ProductId, p.Rating,p.Comment, u.UserName
	FROM preview p 
    INNER JOIN User u ON p.UserId = u.Id
	INNER JOIN (SELECT MAX(id) AS id
						FROM preview
						GROUP BY productId) mostRecent ON mostRecent.id = p.ID;


	SELECT 	p.ID, p.Name, p.Description, 
			b.Name AS Brand,
            p.Price,
			npr.UserName, 
			npr.Rating, 
			npr.Comment,
            p.Image
	FROM product p 
    LEFT JOIN Brand b ON p.BrandId = b.Id
	LEFT JOIN temp npr ON p.Id = npr.ProductId	
    WHERE p.brandId = brandId OR brandId = 0
	ORDER BY p.Created DESC LIMIT 10;

	DROP TABLE temp;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getProductDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getProductDetails`(
	IN productId INT
)
BEGIN
	SELECT p.*, b.Name as Brand, a.Name as Status
	FROM product p
	INNER JOIN brand b ON p.BrandId = b.Id 
    INNER JOIN availablestatus a ON p.StatusId = a.ID
    WHERE p.Id = productId;

	SELECT p.*, u.UserName
    FROM preview p 
    INNER JOIN user u ON p.UserId = u.ID
    WHERE p.ProductId = productId    
	ORDER BY p.ID DESC ;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-15 15:37:31
