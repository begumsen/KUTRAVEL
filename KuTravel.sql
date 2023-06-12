-- MySQL dump 10.13  Distrib 8.0.32, for macos13 (x86_64)
--
-- Host: localhost    Database: app
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `Hitch`
--

DROP TABLE IF EXISTS `Hitch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Hitch` (
  `Status` int DEFAULT NULL,
  `HitchId` int NOT NULL,
  `RideId` int DEFAULT NULL,
  `UserEmail` varchar(30) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  PRIMARY KEY (`HitchId`),
  KEY `RideId` (`RideId`),
  KEY `UserEmail` (`UserEmail`),
  CONSTRAINT `hitch_ibfk_1` FOREIGN KEY (`RideId`) REFERENCES `Ride` (`RideId`),
  CONSTRAINT `hitch_ibfk_2` FOREIGN KEY (`UserEmail`) REFERENCES `User` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hitch`
--

LOCK TABLES `Hitch` WRITE;
/*!40000 ALTER TABLE `Hitch` DISABLE KEYS */;
INSERT INTO `Hitch` VALUES (0,1,2,'ualtintas19@ku.edu.tr','2024-07-02'),(0,2,1,'ualtintas19@ku.edu.tr','2024-07-02'),(1,3,4,'kpalalioglu17@ku.edu.tr','2024-07-02'),(1,4,7,'ualtintas19@ku.edu.tr','2024-07-02'),(1,5,2,'begumsen19@ku.edu.tr','2024-07-02'),(1,6,6,'begumsen19@ku.edu.tr','2024-07-02'),(1,7,7,'begumsen19@ku.edu.tr','2024-07-02'),(0,8,8,'begumsen19@ku.edu.tr','2024-07-02'),(1,9,5,'begumsen19@ku.edu.tr','2024-07-02'),(0,10,16,'ualtintas19@ku.edu.tr','2023-06-12'),(1,11,11,'ualtintas19@ku.edu.tr','2023-06-12'),(0,12,4,'ualtintas19@ku.edu.tr','2023-06-12'),(1,13,19,'begumsen19@ku.edu.tr','2023-06-12'),(1,14,35,'begumsen19@ku.edu.tr','2023-06-12'),(2,15,30,'kpalalioglu17@ku.edu.tr','2023-06-12'),(2,16,44,'kpalalioglu17@ku.edu.tr','2023-06-12'),(2,17,53,'kpalalioglu17@ku.edu.tr','2023-06-12'),(2,18,40,'kpalalioglu17@ku.edu.tr','2023-06-12'),(2,19,31,'aaliz19@ku.edu.tr','2023-06-12'),(2,20,34,'aaliz19@ku.edu.tr','2023-06-12'),(2,21,48,'aaliz19@ku.edu.tr','2023-06-12'),(2,22,44,'aaliz19@ku.edu.tr','2023-06-12'),(2,23,42,'aaliz19@ku.edu.tr','2023-06-12'),(2,24,49,'aaliz19@ku.edu.tr','2023-06-12'),(2,25,35,'aaliz19@ku.edu.tr','2023-06-12'),(2,26,43,'aaliz19@ku.edu.tr','2023-06-12'),(2,27,57,'aaliz19@ku.edu.tr','2023-06-12'),(2,28,45,'aaliz19@ku.edu.tr','2023-06-12'),(2,29,39,'aaliz19@ku.edu.tr','2023-06-12'),(2,30,21,'aaliz19@ku.edu.tr','2023-06-12'),(2,31,31,'agulseren19@ku.edu.tr','2023-06-12'),(2,32,2,'agulseren19@ku.edu.tr','2023-06-12'),(2,33,34,'agulseren19@ku.edu.tr','2023-06-12'),(2,34,33,'agulseren19@ku.edu.tr','2023-06-12'),(2,35,11,'agulseren19@ku.edu.tr','2023-06-12'),(2,36,7,'agulseren19@ku.edu.tr','2023-06-12'),(2,37,8,'agulseren19@ku.edu.tr','2023-06-12'),(2,38,30,'agulseren19@ku.edu.tr','2023-06-12'),(2,39,51,'agulseren19@ku.edu.tr','2023-06-12'),(2,40,44,'agulseren19@ku.edu.tr','2023-06-12'),(2,41,49,'agulseren19@ku.edu.tr','2023-06-12'),(2,42,23,'agulseren19@ku.edu.tr','2023-06-12'),(2,43,58,'agulseren19@ku.edu.tr','2023-06-12'),(2,44,43,'agulseren19@ku.edu.tr','2023-06-12'),(2,45,57,'agulseren19@ku.edu.tr','2023-06-12'),(2,46,28,'agulseren19@ku.edu.tr','2023-06-12'),(2,47,26,'agulseren19@ku.edu.tr','2023-06-12'),(2,48,36,'agulseren19@ku.edu.tr','2023-06-12'),(2,49,22,'agulseren19@ku.edu.tr','2023-06-12'),(2,50,21,'agulseren19@ku.edu.tr','2023-06-12'),(2,51,27,'agulseren19@ku.edu.tr','2023-06-12'),(2,52,2,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,53,46,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,54,33,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,55,15,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,56,10,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,57,9,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,58,44,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,59,47,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,60,35,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,61,43,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,62,58,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,63,28,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,64,45,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,65,54,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,66,1,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,67,53,'basfuroglu19@ku.edu.tr','2023-06-12'),(2,68,2,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,69,19,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,70,46,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,71,18,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,72,12,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,73,8,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,74,9,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,75,24,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,76,49,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,77,42,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,78,35,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,79,43,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,80,50,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,81,28,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,82,56,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,83,39,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,84,22,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,85,53,'bkarayilan19@ku.edu.tr','2023-06-12'),(2,86,19,'bsen18@ku.edu.tr','2023-06-12'),(2,87,46,'bsen18@ku.edu.tr','2023-06-12'),(2,88,16,'bsen18@ku.edu.tr','2023-06-12'),(2,89,8,'bsen18@ku.edu.tr','2023-06-12'),(2,90,29,'bsen18@ku.edu.tr','2023-06-12'),(2,91,24,'bsen18@ku.edu.tr','2023-06-12'),(2,92,44,'bsen18@ku.edu.tr','2023-06-12'),(2,93,49,'bsen18@ku.edu.tr','2023-06-12'),(2,94,47,'bsen18@ku.edu.tr','2023-06-12'),(2,95,50,'bsen18@ku.edu.tr','2023-06-12'),(2,96,25,'bsen18@ku.edu.tr','2023-06-12'),(2,97,28,'bsen18@ku.edu.tr','2023-06-12'),(2,98,39,'bsen18@ku.edu.tr','2023-06-12'),(2,99,36,'bsen18@ku.edu.tr','2023-06-12'),(2,100,14,'bsen18@ku.edu.tr','2023-06-12'),(2,101,21,'bsen18@ku.edu.tr','2023-06-12'),(2,102,53,'bsen18@ku.edu.tr','2023-06-12'),(2,103,19,'dkukul19@ku.edu.tr','2023-06-12'),(2,104,37,'dkukul19@ku.edu.tr','2023-06-12'),(2,105,10,'dkukul19@ku.edu.tr','2023-06-12'),(2,106,51,'dkukul19@ku.edu.tr','2023-06-12'),(2,107,23,'dkukul19@ku.edu.tr','2023-06-12'),(2,108,28,'dkukul19@ku.edu.tr','2023-06-12'),(2,109,57,'dkukul19@ku.edu.tr','2023-06-12'),(2,110,19,'etaskinvardar17@ku.edu.tr','2023-06-12'),(2,111,46,'etaskinvardar17@ku.edu.tr','2023-06-12'),(2,112,30,'etaskinvardar17@ku.edu.tr','2023-06-12'),(2,113,35,'etaskinvardar17@ku.edu.tr','2023-06-12'),(1,114,34,'emregursoy@ku.edu.tr','2023-06-12'),(0,115,31,'emregursoy@ku.edu.tr','2023-06-12'),(2,116,1,'emregursoy@ku.edu.tr','2023-06-12'),(2,117,60,'ualtintas19@ku.edu.tr','2023-06-12'),(1,118,60,'kpalalioglu17@ku.edu.tr','2023-06-12'),(0,119,60,'bkarayilan19@ku.edu.tr','2023-06-12');
/*!40000 ALTER TABLE `Hitch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Review` (
  `ReviewerMail` varchar(30) DEFAULT NULL,
  `ReviewedMail` varchar(30) DEFAULT NULL,
  `ReviewId` int NOT NULL,
  `Rating` int DEFAULT NULL,
  `Comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ReviewId`),
  KEY `ReviewerMail` (`ReviewerMail`),
  KEY `ReviewedMail` (`ReviewedMail`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`ReviewerMail`) REFERENCES `User` (`Email`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`ReviewedMail`) REFERENCES `User` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review`
--

LOCK TABLES `Review` WRITE;
/*!40000 ALTER TABLE `Review` DISABLE KEYS */;
INSERT INTO `Review` VALUES ('begumsen19@ku.edu.tr','kpalalioglu17@ku.edu.tr',1,5,'GOOD'),('bkarayilan19@ku.edu.tr','begumsen19@ku.edu.tr',2,3,'Average'),('begumsen19@ku.edu.tr','kpalalioglu17@ku.edu.tr',3,4,'FINE'),('begumsen19@ku.edu.tr','aaliz19@ku.edu.tr',4,5,'Perfect Ride'),('begumsen19@ku.edu.tr','bkarayilan19@ku.edu.tr',5,3,'Not Bad'),('begumsen19@ku.edu.tr','aaliz19@ku.edu.tr',6,3,'Meh'),('ualtintas19@ku.edu.tr','aaliz19@ku.edu.tr',7,2,'Worst Ride Ever!!!'),('kpalalioglu17@ku.edu.tr','begumsen19@ku.edu.tr',8,5,'The best ride ever !!!'),('bkarayilan19@ku.edu.tr','kpalalioglu17@ku.edu.tr',9,5,'Great Ride'),('bkarayilan19@ku.edu.tr','begumsen19@ku.edu.tr',10,5,'Great Great Great!!!'),('emregursoy@ku.edu.tr','begumsen19@ku.edu.tr',11,5,'Great Ride !'),('kpalalioglu17@ku.edu.tr','emregursoy@ku.edu.tr',12,5,'Best Ride of My Life !');
/*!40000 ALTER TABLE `Review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ride`
--

DROP TABLE IF EXISTS `Ride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ride` (
  `RideId` int NOT NULL,
  `UserEmail` varchar(30) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Fee` int DEFAULT NULL,
  `FromLoc` varchar(255) DEFAULT NULL,
  `ToLoc` varchar(255) DEFAULT NULL,
  `NoOfSeats` int DEFAULT NULL,
  PRIMARY KEY (`RideId`),
  KEY `UserEmail` (`UserEmail`),
  CONSTRAINT `ride_ibfk_1` FOREIGN KEY (`UserEmail`) REFERENCES `User` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ride`
--

LOCK TABLES `Ride` WRITE;
/*!40000 ALTER TABLE `Ride` DISABLE KEYS */;
INSERT INTO `Ride` VALUES (1,'ualtintas19@ku.edu.tr','2023-11-25',30,'Beşiktaş','Sarıyer',1),(2,'kpalalioglu17@ku.edu.tr','2023-07-19',20,'Sarıyer','Şişli',3),(3,'bkarayilan19@ku.edu.tr','2023-01-01',20,'Pendik','Ataşehir',4),(4,'begumsen19@ku.edu.tr','2023-08-01',100,'Pendik','Fatih',2),(5,'bkarayilan19@ku.edu.tr','2023-01-03',75,'Sarıyer','Beşiktaş',2),(6,'kpalalioglu17@ku.edu.tr','2023-04-03',63,'Bakırköy','Beşiktaş',2),(7,'aaliz19@ku.edu.tr','2023-07-08',55,'Bakırköy','Beşiktaş',2),(8,'aaliz19@ku.edu.tr','2023-09-16',32,'Sarıyer','Kadıköy',2),(9,'aaliz19@ku.edu.tr','2023-06-21',126,'Ataşehir','Bahçelievler',2),(10,'aaliz19@ku.edu.tr','2023-06-23',160,'Koç Üniversitesi','Beşiktaş',3),(11,'begumsen19@ku.edu.tr','2023-06-30',110,'Koç Üniversitesi','Beyoğlu',2),(12,'begumsen19@ku.edu.tr','2023-06-19',86,'Şişli','Koç Üniversitesi',1),(13,'ualtintas18@ku.edu.tr','2023-06-16',138,'Ataşehir','Bakırköy',2),(14,'ualtintas18@ku.edu.tr','2023-06-13',54,'Bağcılar','Bayrampaşa',2),(15,'begumsen19@ku.edu.tr','2023-06-15',76,'Koç Üniversitesi','Bağcılar',3),(16,'begumsen19@ku.edu.tr','2023-06-22',53,'Koç Üniversitesi','Şişli',3),(17,'begumsen19@ku.edu.tr','2023-06-26',131,'Ataşehir','Başakşehir',4),(18,'begumsen19@ku.edu.tr','2023-06-24',49,'Kadıköy','Koç Üniversitesi',2),(19,'kpalalioglu17@ku.edu.tr','2023-07-08',25,'Bakırköy','Beşiktaş',2),(20,'aaliz19@ku.edu.tr','2023-06-21',26,'Gaziosmanpaşa','Ataşehir',4),(21,'ualtintas19@ku.edu.tr','2023-06-25',13,'Bahçelievler','Fatih',4),(22,'ualtintas18@ku.edu.tr','2023-06-14',20,'Maltepe','Güngören',3),(23,'bsen18@ku.edu.tr','2023-06-24',17,'Küçükçekmece','Büyükçekmece',2),(24,'aaliz19@ku.edu.tr','2023-06-22',15,'Sarıyer','Çekmeköy',2),(25,'etaskinvardar17@ku.edu.tr','2023-06-18',13,'Kartal','Avcılar',1),(26,'basfuroglu19@ku.edu.tr','2023-06-29',15,'Arnavutköy','Kadıköy',0),(27,'ualtintas19@ku.edu.tr','2023-06-13',28,'Sultangazi','Sultanbeyli',3),(28,'fsen16@ku.edu.tr','2023-06-27',23,'Gaziosmanpaşa','Ümraniye',3),(29,'aaliz19@ku.edu.tr','2023-06-17',26,'Maltepe','Sarıyer',3),(30,'aaliz19@ku.edu.tr','2023-06-15',23,'Şile','Esenler',3),(31,'kpalalioglu17@ku.edu.tr','2023-06-17',13,'Güngören','Avcılar',2),(32,'begumsen19@ku.edu.tr','2023-06-23',22,'Bahçelievler','Tuzla',4),(33,'begumsen19@ku.edu.tr','2023-06-24',24,'Şişli','Çatalca',4),(34,'begumsen19@ku.edu.tr','2023-06-23',21,'Avcılar','Koç Üniversitesi',4),(35,'bsen18@ku.edu.tr','2023-06-17',30,'Çekmeköy','Kâğıthane',1),(36,'osen15@ku.edu.tr','2023-06-17',29,'Büyükçekmece','Ümraniye',3),(37,'begumsen19@ku.edu.tr','2023-06-26',15,'Eyüpsultan','Fatih',0),(38,'basfuroglu19@ku.edu.tr','2023-06-19',27,'Pendik','Çekmeköy',4),(39,'basfuroglu19@ku.edu.tr','2023-06-29',28,'Beyoğlu','Sancaktepe',1),(40,'osen15@ku.edu.tr','2023-06-28',28,'Küçükçekmece','Ümraniye',0),(41,'aaliz19@ku.edu.tr','2023-06-16',26,'Sultangazi','Sultanbeyli',2),(42,'agulseren19@ku.edu.tr','2023-06-29',30,'Bağcılar','Tuzla',4),(43,'dkukul19@ku.edu.tr','2023-06-21',28,'Fatih','Bahçelievler',4),(44,'bkarayilan19@ku.edu.tr','2023-06-27',24,'Maltepe','Küçükçekmece',3),(45,'fsen16@ku.edu.tr','2023-06-21',27,'Güngören','Sancaktepe',3),(46,'begumsen19@ku.edu.tr','2023-06-13',24,'Zeytinburnu','Sancaktepe',0),(47,'agulseren19@ku.edu.tr','2023-06-25',29,'Sarıyer','Çatalca',4),(48,'bkarayilan19@ku.edu.tr','2023-06-28',27,'Avcılar','Arnavutköy',1),(49,'basfuroglu19@ku.edu.tr','2023-06-19',21,'Başakşehir','Fatih',3),(50,'etaskinvardar17@ku.edu.tr','2023-06-20',30,'Şişli','Sarıyer',3),(51,'bkarayilan19@ku.edu.tr','2023-06-30',30,'Bayrampaşa','Esenyurt',4),(52,'begumsen19@ku.edu.tr','2023-06-14',28,'Büyükçekmece','Üsküdar',1),(53,'ualtintas19@ku.edu.tr','2023-06-16',20,'Kartal','Sarıyer',3),(54,'osen15@ku.edu.tr','2023-06-22',14,'Esenyurt','Bağcılar',3),(55,'bsen18@ku.edu.tr','2023-06-30',16,'Bayrampaşa','Sultangazi',3),(56,'fsen16@ku.edu.tr','2023-06-15',25,'Üsküdar','Beşiktaş',4),(57,'etaskinvardar17@ku.edu.tr','2023-06-18',22,'Kadıköy','Şişli',4),(58,'bsen18@ku.edu.tr','2023-06-29',18,'Maltepe','Kadıköy',4),(59,'aaliz19@ku.edu.tr','2023-06-13',23,'Koç Üniversitesi','Sarıyer',2),(60,'emregursoy@ku.edu.tr','2023-06-13',50,'Koç Üniversitesi','Beşiktaş',2);
/*!40000 ALTER TABLE `Ride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Email` varchar(30) NOT NULL,
  `FullName` varchar(30) DEFAULT NULL,
  `Major` varchar(100) DEFAULT NULL,
  `Class` varchar(30) DEFAULT NULL,
  `Chattiness` int DEFAULT NULL,
  `Smoking` int DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `PhoneNumber` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('aaliz19@ku.edu.tr','Arda Aliz','Physics','Freshman',0,1,'12qwerty','+905399999999'),('agulseren19@ku.edu.tr','Aslıhan Gülseren','Chemistry','Freshman',0,1,'12qwerty','+905322222222'),('basfuroglu19@ku.edu.tr','Bengisu Asfuroğlu','Business Administration','Junior',0,1,'12qwerty','+905311111111'),('begumsen19@ku.edu.tr','Begüm Şen','Computer Engineering','Senior',0,1,'12qwerty','+905355555555'),('bkarayilan19@ku.edu.tr','Berat Karayılan','Computer Engineering','Senior',0,1,'12qwerty','+905366666666'),('bsen18@ku.edu.tr','Beril Şen','Psychology','Sophomore',0,1,'12qwerty','+905366666666'),('dkukul19@ku.edu.tr','Doğa Kukul','Mechanical Engineering','Senior',0,1,'12qwerty','+905377777777'),('emregursoy@ku.edu.tr','Mehmet Emre Gürsoy','Computer Engineering','Senior',0,1,'12qwerty','+905322222222'),('etaskinvardar17@ku.edu.tr','Ege Taşkınvardar','Media and Visual Arts','Senior',0,1,'12qwerty','+905344444444'),('fsen16@ku.edu.tr','Figen Şen','Archaeology and History of Art','Sophomore',0,1,'12qwerty','+905333333333'),('kpalalioglu17@ku.edu.tr','Kutluhan Palalıoğlu','Computer Engineering','Senior',0,1,'12qwerty','+905333333333'),('osen15@ku.edu.tr','Özkan Şen','Electrical and Electronics Engineering','Senior',0,1,'12qwerty!','+905377777777'),('ualtintas18@ku.edu.tr','Utku Altintas','Electrical and Electronics Engineering','Freshman',0,1,'12qwerty','+905388888887'),('ualtintas19@ku.edu.tr','Utku Altıntaş','Computer Engineering','Senior',0,1,'12qwerty','+905388888888');
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

-- Dump completed on 2023-06-12 19:54:46
