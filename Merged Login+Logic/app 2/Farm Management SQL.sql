CREATE DATABASE  IF NOT EXISTS `farmmanagement` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `farmmanagement`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: farmmanagement
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `crop`
--

DROP TABLE IF EXISTS `crop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop` (
  `Crop_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Season` enum('Rabi','Kharif','Annual','Zaid') NOT NULL,
  `Yield_Estimate` int DEFAULT NULL,
  `Soil_ID` int DEFAULT NULL,
  `District_ID` int DEFAULT NULL,
  PRIMARY KEY (`Crop_ID`),
  KEY `Soil_ID` (`Soil_ID`),
  CONSTRAINT `crop_chk_1` CHECK ((`Yield_Estimate` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop`
--

LOCK TABLES `crop` WRITE;
/*!40000 ALTER TABLE `crop` DISABLE KEYS */;
INSERT INTO `crop` VALUES (1,'Wheat','Rabi',25,1,NULL),(2,'Rice','Kharif',30,2,NULL),(3,'Sugarcane','Annual',40,3,NULL),(4,'Maize','Kharif',20,4,NULL),(5,'Cotton','Kharif',35,5,NULL),(6,'Soybean','Kharif',28,6,NULL),(7,'Barley','Rabi',22,7,NULL),(8,'Groundnut','Kharif',30,8,NULL),(9,'Mustard','Rabi',18,9,NULL),(10,'Pulses','Rabi',15,10,NULL),(11,'Wheat','Rabi',2000,NULL,2),(12,'Rice','Kharif',1800,NULL,2),(13,'Soybean','Kharif',2200,NULL,2),(14,'Maize','Kharif',1500,NULL,2),(15,'Mustard','Rabi',1700,NULL,2),(23,'Cotton','Annual',1500,3,1),(35,'Sugarcane','Annual',3000,4,18),(36,'Barley','Rabi',1800,1,19),(42,'Rice','Kharif',2100,1,21),(43,'Wheat','Rabi',2000,2,21),(44,'Maize','Kharif',1700,3,21),(45,'Soybean','Kharif',1500,1,22),(49,'Maize','Kharif',1600,2,23),(50,'Groundnut','Annual',1200,3,23),(52,'Barley','Rabi',1800,2,24),(53,'Mustard','Rabi',1500,3,24),(57,'Cotton','Annual',1800,1,26),(59,'Vegetables','Annual',1000,3,26),(83,'Rice','Kharif',2200,3,33),(86,'Groundnut','Kharif',2000,3,34),(88,'Cotton','Annual',1600,2,35),(89,'Wheat','Rabi',1900,3,35),(94,'Cotton','Kharif',1500,2,40),(98,'Mustard','Rabi',1200,2,2),(100,'Pulses','Rabi',1800,2,3),(101,'Sugarcane','Annual',5000,1,4),(102,'Groundnut','Kharif',2200,2,4),(103,'Maize','Rabi',2500,1,5),(105,'Cotton','Kharif',1800,1,6),(106,'Coriander','Rabi',1100,2,6),(108,'Gram','Rabi',2000,2,7),(111,'Tobacco','Annual',4500,1,9),(118,'Chili','Rabi',1800,2,12),(122,'Jute','Annual',3000,2,14),(126,'Tomato','Rabi',1200,2,16),(128,'Maize','Rabi',2100,2,17),(131,'Peas','Rabi',1800,1,19),(139,'Groundnut','Kharif',1900,1,24),(141,'Pulses','Rabi',1700,1,25),(142,'Soybean','Kharif',2600,2,25),(150,'Tapioca','Annual',2500,2,29),(151,'Coconut','Annual',2800,1,30),(158,'Coffee','Annual',2200,2,33),(161,'Wheat','Rabi',3500,11,NULL),(162,'Rice','Kharif',4000,11,NULL),(163,'Maize','Rabi',3200,11,NULL),(164,'Sugarcane','Kharif',4500,11,NULL),(165,'Barley','Rabi',3300,11,NULL),(166,'Bajra','Kharif',3100,11,NULL),(167,'Watermelon','Zaid',2800,11,NULL),(168,'Muskmelon','Zaid',2600,11,NULL),(169,'Cucumber','Zaid',3000,11,NULL),(170,'Pumpkin','Zaid',2900,11,NULL);
/*!40000 ALTER TABLE `crop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crop_disease`
--

DROP TABLE IF EXISTS `crop_disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop_disease` (
  `Disease_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Symptoms` text NOT NULL,
  `Treatment` text NOT NULL,
  `Crop_ID` int DEFAULT NULL,
  PRIMARY KEY (`Disease_ID`),
  KEY `crop_disease_ibfk_1` (`Crop_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_disease`
--

LOCK TABLES `crop_disease` WRITE;
/*!40000 ALTER TABLE `crop_disease` DISABLE KEYS */;
INSERT INTO `crop_disease` VALUES (1,'Leaf Blight','Yellowing and wilting of leaves','Use fungicide spray',1),(2,'Stem Rot','Dark lesions on stem','Apply soil fungicide',2),(3,'Rust','Orange-brown pustules on leaves','Use resistant varieties',3),(4,'Powdery Mildew','White powdery spots on leaves','Spray sulfur-based fungicide',4),(5,'Root Rot','Blackened roots, wilting','Improve soil drainage',5),(6,'Downy Mildew','Yellow patches on leaves','Use copper-based fungicide',6),(7,'Anthracnose','Dark sunken lesions on leaves','Prune infected parts',7),(8,'Bacterial Wilt','Sudden wilting','Use disease-free seeds',8),(9,'Leaf Curl Virus','Distorted curled leaves','Control vector insects',9),(10,'Smut','Black powdery spores on grains','Use resistant crop varieties',10);
/*!40000 ALTER TABLE `crop_disease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crop_irrigation_requirements`
--

DROP TABLE IF EXISTS `crop_irrigation_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop_irrigation_requirements` (
  `Crop_ID` int NOT NULL,
  `Irrigation_Requirement` varchar(20) NOT NULL,
  PRIMARY KEY (`Crop_ID`),
  CONSTRAINT `crop_irrigation_requirements_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_irrigation_requirements`
--

LOCK TABLES `crop_irrigation_requirements` WRITE;
/*!40000 ALTER TABLE `crop_irrigation_requirements` DISABLE KEYS */;
INSERT INTO `crop_irrigation_requirements` VALUES (1,'Moderate'),(2,'High'),(3,'High'),(4,'Moderate'),(5,'Moderate'),(6,'Moderate'),(7,'Low'),(8,'Moderate'),(9,'Low'),(10,'Low'),(126,'Moderate');
/*!40000 ALTER TABLE `crop_irrigation_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crop_plan`
--

DROP TABLE IF EXISTS `crop_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop_plan` (
  `Plan_ID` int NOT NULL AUTO_INCREMENT,
  `Crop_ID` int DEFAULT NULL,
  `Location_ID` int DEFAULT NULL,
  `Season` enum('Summer','Kharif','Rabi','Zaid') DEFAULT NULL,
  `Sowing_Month` varchar(20) DEFAULT NULL,
  `Harvest_Month` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Plan_ID`),
  KEY `Location_ID` (`Location_ID`),
  KEY `crop_plan_ibfk_1` (`Crop_ID`),
  CONSTRAINT `crop_plan_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE,
  CONSTRAINT `crop_plan_ibfk_2` FOREIGN KEY (`Location_ID`) REFERENCES `location` (`Location_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_plan`
--

LOCK TABLES `crop_plan` WRITE;
/*!40000 ALTER TABLE `crop_plan` DISABLE KEYS */;
INSERT INTO `crop_plan` VALUES (3,126,1,'Rabi','October','February'),(5,126,16,'Rabi','October','February');
/*!40000 ALTER TABLE `crop_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crop_plan1`
--

DROP TABLE IF EXISTS `crop_plan1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop_plan1` (
  `Plan_ID` int NOT NULL AUTO_INCREMENT,
  `Farmer_ID` int DEFAULT NULL,
  `Crop_ID` int DEFAULT NULL,
  `District_ID` int DEFAULT NULL,
  `Suggested_Season` varchar(20) DEFAULT NULL,
  `Expected_Yield` int DEFAULT NULL,
  `Recommended_Fertilizer` varchar(50) DEFAULT NULL,
  `Disease_Risk` varchar(100) DEFAULT NULL,
  `Recommended_Treatment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Plan_ID`),
  KEY `Farmer_ID` (`Farmer_ID`),
  KEY `crop_plan1_ibfk_2` (`Crop_ID`),
  KEY `crop_plan1_ibfk_3` (`District_ID`),
  CONSTRAINT `crop_plan1_ibfk_1` FOREIGN KEY (`Farmer_ID`) REFERENCES `farmer` (`Farmer_ID`),
  CONSTRAINT `crop_plan1_ibfk_2` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE,
  CONSTRAINT `crop_plan1_ibfk_3` FOREIGN KEY (`District_ID`) REFERENCES `districts` (`District_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_plan1`
--

LOCK TABLES `crop_plan1` WRITE;
/*!40000 ALTER TABLE `crop_plan1` DISABLE KEYS */;
INSERT INTO `crop_plan1` VALUES (1,1,1,1,'Rabi',25,'Urea','Leaf Blight','Use fungicide spray');
/*!40000 ALTER TABLE `crop_plan1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `districts` (
  `District_ID` int NOT NULL AUTO_INCREMENT,
  `District_Name` varchar(100) NOT NULL,
  `State_ID` int DEFAULT NULL,
  PRIMARY KEY (`District_ID`),
  KEY `State_ID` (`State_ID`),
  CONSTRAINT `districts_ibfk_1` FOREIGN KEY (`State_ID`) REFERENCES `states` (`State_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (1,'Indore',1),(2,'Bhopal',1),(3,'Nagpur',2),(4,'Pune',2),(5,'Lucknow',3),(6,'Jaipur',4),(7,'Udaipur',4),(8,'Chennai',5),(9,'Madurai',5),(10,'Varanasi',3),(11,'Surat',2),(12,'Ahmedabad',2),(13,'Bhubaneswar',3),(14,'Kolkata',5),(15,'Delhi',4),(16,'Dehradun',6),(17,'Patna',3),(18,'Bareilly',3),(19,'Lucknow',3),(20,'Chandigarh',4),(21,'Amritsar',5),(22,'Indore',1),(23,'Bhubaneswar',3),(24,'Jaipur',4),(25,'Nagpur',2),(26,'Coimbatore',5),(27,'Patiala',1),(28,'Jabalpur',2),(29,'Kochi',3),(30,'Puducherry',4),(31,'Kolkata',5),(32,'Varanasi',3),(33,'Mysuru',4),(34,'Gurugram',5),(35,'Agra',2),(36,'Guwahati',1),(37,'Srinagar',2),(38,'Nagaland',3),(39,'Tiruchirappalli',4),(40,'Rajkot',5);
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farmer`
--

DROP TABLE IF EXISTS `farmer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmer` (
  `Farmer_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Contact` varchar(15) NOT NULL,
  `Location_ID` int DEFAULT NULL,
  PRIMARY KEY (`Farmer_ID`),
  UNIQUE KEY `Contact` (`Contact`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `farmer_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `location` (`Location_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farmer`
--

LOCK TABLES `farmer` WRITE;
/*!40000 ALTER TABLE `farmer` DISABLE KEYS */;
INSERT INTO `farmer` VALUES (1,'Ramesh Patel','9876543210',1),(2,'Suresh Yadav','9765432109',2),(3,'Amit Sharma','9654321098',3),(4,'Rajesh Gupta','9543210987',4),(5,'Manoj Singh','9432109876',5),(6,'Vikram Rao','9321098765',6),(7,'Arjun Mehta','9210987654',7),(8,'Mahesh Kumar','9109876543',8),(9,'Harish Nair','9098765432',9),(10,'Dinesh Verma','8987654321',10);
/*!40000 ALTER TABLE `farmer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farming_activity`
--

DROP TABLE IF EXISTS `farming_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farming_activity` (
  `Activity_ID` int NOT NULL AUTO_INCREMENT,
  `Crop_ID` int DEFAULT NULL,
  `Month` enum('January','February','March','April','May','June','July','August','September','October','November','December') DEFAULT NULL,
  `Activity_Type` enum('Land Preparation','Sowing','Irrigation','Fertilization','Pest Control','Harvesting') DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`Activity_ID`),
  KEY `farming_activity_ibfk_1` (`Crop_ID`),
  CONSTRAINT `farming_activity_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farming_activity`
--

LOCK TABLES `farming_activity` WRITE;
/*!40000 ALTER TABLE `farming_activity` DISABLE KEYS */;
INSERT INTO `farming_activity` VALUES (1,1,'June','Land Preparation','Prepare field and ensure proper irrigation for rice.'),(2,1,'July','Sowing','Sow rice seeds with proper spacing and apply initial fertilizers.'),(3,1,'August','Irrigation','Regular irrigation required every 7-10 days.'),(4,1,'October','Harvesting','Harvest rice when grains are mature and golden in color.');
/*!40000 ALTER TABLE `farming_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fertilizer`
--

DROP TABLE IF EXISTS `fertilizer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fertilizer` (
  `Fertilizer_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Type` varchar(50) NOT NULL,
  `Usage_Guide` text NOT NULL,
  `Crop_ID` int DEFAULT NULL,
  PRIMARY KEY (`Fertilizer_ID`),
  KEY `Crop_ID` (`Crop_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fertilizer`
--

LOCK TABLES `fertilizer` WRITE;
/*!40000 ALTER TABLE `fertilizer` DISABLE KEYS */;
INSERT INTO `fertilizer` VALUES (1,'Urea','Nitrogen','50kg/acre',1),(2,'DAP','Phosphorus','40kg/acre',2),(3,'MOP','Potassium','30kg/acre',3),(4,'Compost','Organic','200kg/acre',4),(5,'Zinc Sulphate','Micronutrient','10kg/acre',5),(6,'Gypsum','Calcium','50kg/acre',6),(7,'NPK 10-26-26','Mixed','60kg/acre',7),(8,'NPK 12-32-16','Mixed','70kg/acre',8),(9,'Super Phosphate','Phosphorus','45kg/acre',9),(10,'Organic Manure','Organic','250kg/acre',10);
/*!40000 ALTER TABLE `fertilizer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historical_weather`
--

DROP TABLE IF EXISTS `historical_weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historical_weather` (
  `Weather_ID` int NOT NULL AUTO_INCREMENT,
  `District_ID` int DEFAULT NULL,
  `Month` int DEFAULT NULL,
  `Avg_Temperature` float DEFAULT NULL,
  `Avg_Rainfall` float DEFAULT NULL,
  `Avg_Humidity` float DEFAULT NULL,
  PRIMARY KEY (`Weather_ID`),
  KEY `District_ID` (`District_ID`),
  CONSTRAINT `historical_weather_chk_1` CHECK ((`Month` between 1 and 12))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historical_weather`
--

LOCK TABLES `historical_weather` WRITE;
/*!40000 ALTER TABLE `historical_weather` DISABLE KEYS */;
INSERT INTO `historical_weather` VALUES (1,1,1,18.5,5.2,60),(2,1,2,20.1,10.5,55),(3,2,3,25.4,15.8,50),(4,2,4,30.2,20,45),(5,3,5,35,40.5,40),(6,1,6,28.3,12,57),(7,2,6,32,14.5,50),(8,3,6,33.5,18,60),(9,4,6,31,20,52),(10,5,6,37,30,45);
/*!40000 ALTER TABLE `historical_weather` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insecticide_pesticide`
--

DROP TABLE IF EXISTS `insecticide_pesticide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insecticide_pesticide` (
  `Pest_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Affected_Crop_ID` int DEFAULT NULL,
  `Solution` text NOT NULL,
  PRIMARY KEY (`Pest_ID`),
  KEY `Affected_Crop_ID` (`Affected_Crop_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insecticide_pesticide`
--

LOCK TABLES `insecticide_pesticide` WRITE;
/*!40000 ALTER TABLE `insecticide_pesticide` DISABLE KEYS */;
INSERT INTO `insecticide_pesticide` VALUES (1,'Malathion',1,'Use 2ml/L water spray'),(2,'Chlorpyrifos',2,'Use 1.5ml/L water spray'),(3,'Cypermethrin',3,'Use 2ml/L water spray'),(4,'Neem Oil',4,'Use 5ml/L water spray'),(5,'Imidacloprid',5,'Use 1.2ml/L water spray'),(6,'Fipronil',6,'Use 1.5ml/L water spray'),(7,'Carbaryl',7,'Use 2.5ml/L water spray'),(8,'Acephate',8,'Use 2ml/L water spray'),(9,'Buprofezin',9,'Use 3ml/L water spray'),(10,'Spinosad',10,'Use 1ml/L water spray');
/*!40000 ALTER TABLE `insecticide_pesticide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `Location_ID` int NOT NULL,
  `District_ID` int DEFAULT NULL,
  PRIMARY KEY (`Location_ID`),
  KEY `District_ID` (`District_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(18,16),(17,17),(19,17),(20,18),(21,19),(22,20),(23,21),(24,22),(25,23),(26,24),(27,25),(28,26),(29,27),(30,28),(31,29),(32,30),(33,31),(34,32),(35,33),(36,34),(37,35),(38,36),(39,37),(40,38),(41,39),(42,40);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_price`
--

DROP TABLE IF EXISTS `market_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_price` (
  `Price_ID` int NOT NULL,
  `Crop_ID` int DEFAULT NULL,
  `Date` date NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Price_ID`),
  KEY `Crop_ID` (`Crop_ID`),
  CONSTRAINT `market_price_chk_1` CHECK ((`Price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_price`
--

LOCK TABLES `market_price` WRITE;
/*!40000 ALTER TABLE `market_price` DISABLE KEYS */;
INSERT INTO `market_price` VALUES (1,1,'2024-02-01',25.00),(2,2,'2024-02-01',30.00),(3,3,'2024-02-01',40.00),(4,4,'2024-02-01',20.00),(5,5,'2024-02-01',35.00),(6,6,'2024-02-01',28.00),(7,7,'2024-02-01',22.00),(8,8,'2024-02-01',30.00),(9,9,'2024-02-01',18.00),(10,10,'2024-02-01',15.00);
/*!40000 ALTER TABLE `market_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season`
--

DROP TABLE IF EXISTS `season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `season` (
  `Season_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Start_Month` varchar(50) DEFAULT NULL,
  `End_Month` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Season_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season`
--

LOCK TABLES `season` WRITE;
/*!40000 ALTER TABLE `season` DISABLE KEYS */;
INSERT INTO `season` VALUES (1,'Rabi','October','March'),(2,'Kharif','June','September'),(3,'Zaid','March','June');
/*!40000 ALTER TABLE `season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soil`
--

DROP TABLE IF EXISTS `soil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soil` (
  `Soil_ID` int NOT NULL AUTO_INCREMENT,
  `Soil_Type` varchar(50) NOT NULL,
  `Nutrient_Level` enum('Low','Medium','High') NOT NULL,
  `Location_ID` int DEFAULT NULL,
  PRIMARY KEY (`Soil_ID`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `soil_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `location` (`Location_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soil`
--

LOCK TABLES `soil` WRITE;
/*!40000 ALTER TABLE `soil` DISABLE KEYS */;
INSERT INTO `soil` VALUES (1,'Black Soil','High',1),(2,'Red Soil','Medium',2),(3,'Clay Soil','Low',3),(4,'Alluvial Soil','High',4),(5,'Sandy Soil','Medium',5),(6,'Loamy Soil','High',6),(7,'Peaty Soil','Low',7),(8,'Saline Soil','Medium',8),(9,'Laterite Soil','Low',9),(10,'Marshy Soil','High',10),(11,'Alluvial','Medium',15),(12,'Alluvial','High',17),(13,'Alluvial','Medium',19);
/*!40000 ALTER TABLE `soil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `State_ID` int NOT NULL,
  `State_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`State_ID`),
  UNIQUE KEY `State_Name` (`State_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (1,'Madhya Pradesh'),(2,'Maharashtra'),(4,'Rajasthan'),(5,'Tamil Nadu'),(3,'Uttar Pradesh'),(6,'Uttarakhand');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekly_farming_plan`
--

DROP TABLE IF EXISTS `weekly_farming_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weekly_farming_plan` (
  `Week_ID` int NOT NULL AUTO_INCREMENT,
  `Plan_ID` int DEFAULT NULL,
  `Week_Number` int NOT NULL,
  `Activity` varchar(255) DEFAULT NULL,
  `Weather_Impact` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Week_ID`),
  KEY `Plan_ID` (`Plan_ID`),
  CONSTRAINT `weekly_farming_plan_ibfk_1` FOREIGN KEY (`Plan_ID`) REFERENCES `yearly_farming_plan` (`Plan_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekly_farming_plan`
--

LOCK TABLES `weekly_farming_plan` WRITE;
/*!40000 ALTER TABLE `weekly_farming_plan` DISABLE KEYS */;
INSERT INTO `weekly_farming_plan` VALUES (1,11,1,'Seed Sowing','Ideal'),(2,11,2,'Fertilizer Application','Ideal'),(3,11,3,'Irrigation','Rainy'),(4,11,4,'Weeding','Ideal'),(5,11,5,'Pest Control','Rainy'),(6,11,6,'Growth Monitoring','Sunny'),(7,11,7,'Harvest Preparation','Rainy'),(8,11,8,'Harvesting','Cloudy'),(9,11,9,'Soil Preparation','Sunny'),(10,11,10,'Seed Sowing','Ideal'),(11,12,1,'Seed Sowing','Sunny'),(12,12,2,'Fertilizer Application','Rainy'),(13,12,3,'Irrigation','Ideal'),(14,12,4,'Weeding','Sunny'),(15,12,5,'Pest Control','Storm'),(16,12,6,'Growth Monitoring','Storm'),(17,12,7,'Harvest Preparation','Rainy'),(18,12,8,'Harvesting','Rainy'),(19,12,9,'Soil Preparation','Sunny'),(20,12,10,'Seed Sowing','Rainy'),(21,13,1,'Seed Sowing','Rainy'),(22,13,2,'Fertilizer Application','Sunny'),(23,13,3,'Irrigation','Cloudy'),(24,13,4,'Weeding','Cloudy'),(25,13,5,'Pest Control','Storm'),(26,13,6,'Growth Monitoring','Cloudy'),(27,13,7,'Harvest Preparation','Cloudy'),(28,13,8,'Harvesting','Sunny'),(29,13,9,'Soil Preparation','Cloudy'),(30,13,10,'Seed Sowing','Ideal'),(31,14,1,'Seed Sowing','Ideal'),(32,14,2,'Fertilizer Application','Ideal'),(33,14,3,'Irrigation','Rainy'),(34,14,4,'Weeding','Cloudy'),(35,14,5,'Pest Control','Cloudy'),(36,14,6,'Growth Monitoring','Storm'),(37,14,7,'Harvest Preparation','Cloudy'),(38,14,8,'Harvesting','Cloudy'),(39,14,9,'Soil Preparation','Cloudy'),(40,14,10,'Seed Sowing','Ideal'),(41,15,1,'Seed Sowing','Rainy'),(42,15,2,'Fertilizer Application','Storm'),(43,15,3,'Irrigation','Ideal'),(44,15,4,'Weeding','Sunny'),(45,15,5,'Pest Control','Ideal'),(46,15,6,'Growth Monitoring','Ideal'),(47,15,7,'Harvest Preparation','Ideal'),(48,15,8,'Harvesting','Cloudy'),(49,15,9,'Soil Preparation','Sunny'),(50,15,10,'Seed Sowing','Ideal'),(51,16,1,'Seed Sowing','Cloudy'),(52,16,2,'Fertilizer Application','Rainy'),(53,16,3,'Irrigation','Cloudy'),(54,16,4,'Weeding','Rainy'),(55,16,5,'Pest Control','Ideal'),(56,16,6,'Growth Monitoring','Ideal'),(57,16,7,'Harvest Preparation','Sunny'),(58,16,8,'Harvesting','Sunny'),(59,16,9,'Soil Preparation','Storm'),(60,16,10,'Seed Sowing','Cloudy'),(61,17,1,'Seed Sowing','Rainy'),(62,17,2,'Fertilizer Application','Ideal'),(63,17,3,'Irrigation','Sunny'),(64,17,4,'Weeding','Rainy'),(65,17,5,'Pest Control','Rainy'),(66,17,6,'Growth Monitoring','Sunny'),(67,17,7,'Harvest Preparation','Storm'),(68,17,8,'Harvesting','Cloudy'),(69,17,9,'Soil Preparation','Cloudy'),(70,17,10,'Seed Sowing','Rainy'),(71,18,1,'Seed Sowing','Rainy'),(72,18,2,'Fertilizer Application','Sunny'),(73,18,3,'Irrigation','Storm'),(74,18,4,'Weeding','Ideal'),(75,18,5,'Pest Control','Sunny'),(76,18,6,'Growth Monitoring','Storm'),(77,18,7,'Harvest Preparation','Cloudy'),(78,18,8,'Harvesting','Sunny'),(79,18,9,'Soil Preparation','Ideal'),(80,18,10,'Seed Sowing','Rainy'),(81,19,1,'Seed Sowing','Ideal'),(82,19,2,'Fertilizer Application','Ideal'),(83,19,3,'Irrigation','Storm'),(84,19,4,'Weeding','Ideal'),(85,19,5,'Pest Control','Rainy'),(86,19,6,'Growth Monitoring','Cloudy'),(87,19,7,'Harvest Preparation','Rainy'),(88,19,8,'Harvesting','Storm'),(89,19,9,'Soil Preparation','Rainy'),(90,19,10,'Seed Sowing','Storm'),(91,20,1,'Seed Sowing','Cloudy'),(92,20,2,'Fertilizer Application','Storm'),(93,20,3,'Irrigation','Ideal'),(94,20,4,'Weeding','Rainy'),(95,20,5,'Pest Control','Sunny'),(96,20,6,'Growth Monitoring','Rainy'),(97,20,7,'Harvest Preparation','Ideal'),(98,20,8,'Harvesting','Ideal'),(99,20,9,'Soil Preparation','Ideal'),(100,20,10,'Seed Sowing','Cloudy');
/*!40000 ALTER TABLE `weekly_farming_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yearly_farming_plan`
--

DROP TABLE IF EXISTS `yearly_farming_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yearly_farming_plan` (
  `Plan_ID` int NOT NULL AUTO_INCREMENT,
  `Crop_ID` int DEFAULT NULL,
  `Location_ID` int DEFAULT NULL,
  `Season` enum('Summer','Kharif','Rabi','Zaid') DEFAULT NULL,
  `Sowing_Month` varchar(20) DEFAULT NULL,
  `Harvest_Month` varchar(20) DEFAULT NULL,
  `Season_ID` int NOT NULL,
  `Avg_Growth_Days` int DEFAULT NULL,
  PRIMARY KEY (`Plan_ID`),
  KEY `Location_ID` (`Location_ID`),
  KEY `fk_season` (`Season_ID`),
  KEY `yearly_farming_plan_ibfk_1` (`Crop_ID`),
  CONSTRAINT `fk_season` FOREIGN KEY (`Season_ID`) REFERENCES `season` (`Season_ID`),
  CONSTRAINT `yearly_farming_plan_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE,
  CONSTRAINT `yearly_farming_plan_ibfk_2` FOREIGN KEY (`Location_ID`) REFERENCES `location` (`Location_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yearly_farming_plan`
--

LOCK TABLES `yearly_farming_plan` WRITE;
/*!40000 ALTER TABLE `yearly_farming_plan` DISABLE KEYS */;
INSERT INTO `yearly_farming_plan` VALUES (11,1,1,NULL,'October','March',1,120),(12,2,2,NULL,'June','September',2,110),(13,3,3,NULL,'June','September',2,90),(14,4,4,NULL,'June','September',2,95),(15,5,5,NULL,'June','September',2,130),(16,6,6,NULL,'June','September',2,100),(17,7,7,NULL,'October','March',1,100),(18,8,8,NULL,'June','September',2,100),(19,9,9,NULL,'October','March',1,100),(20,10,10,NULL,'October','March',1,100);
/*!40000 ALTER TABLE `yearly_farming_plan` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-01 23:24:01
