-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: farmmanagement_dpsk
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
  `Season_ID` int NOT NULL,
  `Yield_Estimate` int DEFAULT NULL,
  `Soil_ID` int DEFAULT NULL,
  `District_ID` int DEFAULT NULL,
  PRIMARY KEY (`Crop_ID`),
  KEY `Soil_ID` (`Soil_ID`),
  KEY `District_ID` (`District_ID`),
  KEY `Season_ID` (`Season_ID`),
  KEY `idx_crop_district` (`District_ID`),
  CONSTRAINT `crop_ibfk_1` FOREIGN KEY (`Soil_ID`) REFERENCES `soil` (`Soil_ID`) ON DELETE SET NULL,
  CONSTRAINT `crop_ibfk_2` FOREIGN KEY (`District_ID`) REFERENCES `districts` (`District_ID`) ON DELETE SET NULL,
  CONSTRAINT `crop_ibfk_3` FOREIGN KEY (`Season_ID`) REFERENCES `season` (`Season_ID`),
  CONSTRAINT `crop_chk_1` CHECK ((`Yield_Estimate` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop`
--

LOCK TABLES `crop` WRITE;
/*!40000 ALTER TABLE `crop` DISABLE KEYS */;
INSERT INTO `crop` VALUES (1,'Wheat',1,25,1,NULL),(2,'Rice',2,30,2,NULL),(3,'Sugarcane',2,40,3,NULL),(4,'Maize',2,20,4,NULL),(5,'Cotton',2,35,5,NULL),(6,'Soybean',2,28,6,NULL),(7,'Barley',1,22,7,NULL),(8,'Groundnut',2,30,8,NULL),(9,'Mustard',1,18,9,NULL),(10,'Pulses',1,15,10,NULL),(11,'Wheat',1,2000,NULL,2),(12,'Rice',2,1800,NULL,2),(13,'Soybean',2,2200,NULL,2),(14,'Maize',2,1500,NULL,2),(15,'Mustard',1,1700,NULL,2),(23,'Cotton',2,1500,3,1),(35,'Sugarcane',2,3000,4,18),(36,'Barley',1,1800,1,NULL),(42,'Rice',2,2100,1,21),(43,'Wheat',1,2000,2,21),(44,'Maize',2,1700,3,21),(45,'Soybean',2,1500,1,NULL),(49,'Maize',2,1600,2,NULL),(50,'Groundnut',2,1200,3,NULL),(52,'Barley',1,1800,2,NULL),(53,'Mustard',1,1500,3,NULL),(57,'Cotton',2,1800,1,26),(59,'Vegetables',2,1000,3,26),(83,'Rice',2,2200,3,33),(86,'Groundnut',2,2000,3,34),(88,'Cotton',2,1600,2,35),(89,'Wheat',1,1900,3,35),(94,'Cotton',2,1500,2,40),(98,'Mustard',1,1200,2,2),(100,'Pulses',1,1800,2,3),(101,'Sugarcane',2,5000,1,4),(102,'Groundnut',2,2200,2,4),(103,'Maize',1,2500,1,5),(105,'Cotton',2,1800,1,6),(106,'Coriander',1,1100,2,6),(108,'Gram',1,2000,2,7),(111,'Tobacco',2,4500,1,9),(118,'Chili',1,1800,2,12),(122,'Jute',2,3000,2,14),(126,'Tomato',1,1200,2,16),(128,'Maize',1,2100,2,17),(131,'Peas',1,1800,1,NULL),(139,'Groundnut',2,1900,1,NULL),(141,'Pulses',1,1700,1,NULL),(142,'Soybean',2,2600,2,NULL),(150,'Tapioca',2,2500,2,29),(151,'Coconut',2,2800,1,30),(158,'Coffee',2,2200,2,33),(161,'Wheat',1,3500,11,NULL),(162,'Rice',2,4000,11,NULL),(163,'Maize',1,3200,11,NULL),(164,'Sugarcane',2,4500,11,NULL),(165,'Barley',1,3300,11,NULL),(166,'Bajra',2,3100,11,NULL),(167,'Watermelon',3,2800,11,NULL),(168,'Muskmelon',3,2600,11,NULL),(169,'Cucumber',3,3000,11,NULL),(170,'Pumpkin',3,2900,11,NULL),(171,'Potato',1,1800,1,1),(172,'Onion',1,1500,2,2),(173,'Garlic',1,1200,3,3),(174,'Sunflower',2,2000,4,4),(175,'Sesame',2,1800,5,5),(176,'Pepper',3,2500,6,6),(177,'Cardamom',3,2200,7,7),(178,'Tea',3,3000,8,8),(179,'Coffee',3,2800,9,9),(180,'Rubber',3,3500,10,10),(181,'Banana',2,4000,1,11),(182,'Mango',2,3800,2,12),(183,'Apple',1,3200,3,13),(184,'Grapes',2,2800,4,14),(185,'Orange',2,3000,5,15),(186,'Lemon',2,2700,6,16),(187,'Pomegranate',2,2900,7,17),(188,'papaya',2,3500,8,18),(189,'Guava',2,3300,9,20),(190,'Pineapple',2,3600,10,15);
/*!40000 ALTER TABLE `crop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crop_disease`
--

DROP TABLE IF EXISTS `crop_disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop_disease` (
  `Disease_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Symptoms` text NOT NULL,
  `Treatment` text NOT NULL,
  `Crop_ID` int DEFAULT NULL,
  PRIMARY KEY (`Disease_ID`),
  KEY `Crop_ID` (`Crop_ID`),
  CONSTRAINT `crop_disease_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_disease`
--

LOCK TABLES `crop_disease` WRITE;
/*!40000 ALTER TABLE `crop_disease` DISABLE KEYS */;
INSERT INTO `crop_disease` VALUES (1,'Leaf Blight','Yellowing and wilting of leaves','Use fungicide spray',1),(2,'Stem Rot','Dark lesions on stem','Apply soil fungicide',2),(3,'Rust','Orange-brown pustules on leaves','Use resistant varieties',3),(4,'Powdery Mildew','White powdery spots on leaves','Spray sulfur-based fungicide',4),(5,'Root Rot','Blackened roots, wilting','Improve soil drainage',5),(6,'Downy Mildew','Yellow patches on leaves','Use copper-based fungicide',6),(7,'Anthracnose','Dark sunken lesions on leaves','Prune infected parts',7),(8,'Bacterial Wilt','Sudden wilting','Use disease-free seeds',8),(9,'Leaf Curl Virus','Distorted curled leaves','Control vector insects',9),(10,'Smut','Black powdery spores on grains','Use resistant crop varieties',10),(11,'Late Blight','Dark lesions on leaves and stems','Apply copper-based fungicides',171),(12,'Early Blight','Concentric rings on leaves','Use chlorothalonil or mancozeb',172),(13,'White Rot','White fungal growth at base','Crop rotation and fungicides',173),(14,'Downy Mildew','Yellow angular spots on leaves','Apply metalaxyl or fosetyl-Al',174),(15,'Alternaria Leaf Spot','Brown spots with yellow halos','Use mancozeb or chlorothalonil',175),(16,'Anthracnose','Sunken lesions on fruits','Apply copper fungicides',176),(17,'Leaf Rust','Orange pustules on undersides','Use triazole fungicides',177),(18,'Red Spider Mite','Yellow stippling on leaves','Apply miticides',178),(19,'Black Pod','Black lesions on pods','Use copper fungicides',179),(20,'Leaf Spot','Circular brown spots','Apply mancozeb or chlorothalonil',180);
/*!40000 ALTER TABLE `crop_disease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crop_district_mapping`
--

DROP TABLE IF EXISTS `crop_district_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop_district_mapping` (
  `Crop_ID` int NOT NULL,
  `District_ID` int NOT NULL,
  PRIMARY KEY (`Crop_ID`,`District_ID`),
  KEY `District_ID` (`District_ID`),
  CONSTRAINT `crop_district_mapping_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`),
  CONSTRAINT `crop_district_mapping_ibfk_2` FOREIGN KEY (`District_ID`) REFERENCES `districts` (`District_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_district_mapping`
--

LOCK TABLES `crop_district_mapping` WRITE;
/*!40000 ALTER TABLE `crop_district_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `crop_district_mapping` ENABLE KEYS */;
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
INSERT INTO `crop_irrigation_requirements` VALUES (1,'High'),(2,'High'),(3,'High'),(4,'Moderate'),(5,'Moderate'),(6,'Moderate'),(7,'Low'),(8,'Moderate'),(9,'Low'),(10,'Low'),(11,'Moderate'),(12,'High'),(13,'Moderate'),(14,'Moderate'),(15,'Low'),(23,'Moderate'),(35,'High'),(36,'Low'),(42,'High'),(43,'Moderate'),(44,'Moderate'),(45,'Moderate'),(49,'Moderate'),(50,'Moderate'),(52,'Low'),(53,'Low'),(57,'Moderate'),(59,'High'),(83,'High'),(86,'Moderate'),(88,'Moderate'),(89,'Moderate'),(94,'Moderate'),(98,'Low'),(100,'Low'),(101,'High'),(102,'Moderate'),(103,'Moderate'),(105,'Moderate'),(106,'High'),(108,'Low'),(111,'High'),(118,'Moderate'),(122,'High'),(126,'Moderate'),(128,'Moderate'),(131,'Moderate'),(139,'Moderate'),(141,'Low'),(142,'Moderate'),(150,'High'),(151,'High'),(158,'High'),(161,'Moderate'),(162,'High'),(163,'Moderate'),(164,'High'),(165,'Low'),(166,'Moderate'),(167,'High'),(168,'High'),(169,'High'),(170,'High'),(171,'High'),(172,'Moderate'),(173,'Low'),(174,'Moderate'),(175,'Low'),(176,'High'),(177,'High'),(178,'High'),(179,'High'),(180,'Moderate'),(181,'High'),(182,'Moderate'),(183,'Low'),(184,'High'),(185,'Moderate'),(186,'Moderate'),(187,'High'),(188,'High'),(189,'Moderate'),(190,'High');
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
  `Farmer_ID` int NOT NULL,
  `Crop_ID` int NOT NULL,
  `District_ID` int NOT NULL,
  `Season_ID` int NOT NULL,
  `Expected_Yield` int DEFAULT NULL,
  `Recommended_Fertilizer` varchar(50) DEFAULT NULL,
  `Disease_Risk` varchar(50) DEFAULT NULL,
  `Recommended_Treatment` varchar(50) DEFAULT NULL,
  `Sowing_Month` varchar(20) DEFAULT NULL,
  `Harvest_Month` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Plan_ID`),
  KEY `Crop_ID` (`Crop_ID`),
  KEY `Farmer_ID` (`Farmer_ID`),
  CONSTRAINT `crop_plan_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`),
  CONSTRAINT `crop_plan_ibfk_2` FOREIGN KEY (`Farmer_ID`) REFERENCES `farmer` (`Farmer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_plan`
--

LOCK TABLES `crop_plan` WRITE;
/*!40000 ALTER TABLE `crop_plan` DISABLE KEYS */;
INSERT INTO `crop_plan` VALUES (1,1,11,1,1,2000,'NPK 20-20-20','Leaf Blight','Fungicide spray','October','March'),(2,2,12,2,2,1800,'Urea + DAP','Stem Rot','Soil fungicide','June','September'),(3,3,13,3,2,3000,'MOP + Urea','Rust','Resistant varieties','June','September'),(4,4,14,4,2,1700,'Compost + NPK','Powdery Mildew','Sulfur fungicide','June','September'),(5,5,15,5,2,2200,'Zinc Sulphate','Root Rot','Improve drainage','June','September');
/*!40000 ALTER TABLE `crop_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crop_plan_backup`
--

DROP TABLE IF EXISTS `crop_plan_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop_plan_backup` (
  `Plan_ID` int NOT NULL DEFAULT '0',
  `Farmer_ID` int NOT NULL,
  `Crop_ID` int NOT NULL,
  `District_ID` int NOT NULL,
  `Season_ID` int NOT NULL,
  `Expected_Yield` int DEFAULT NULL,
  `Recommended_Fertilizer` varchar(50) DEFAULT NULL,
  `Disease_Risk` varchar(50) DEFAULT NULL,
  `Recommended_Treatment` varchar(50) DEFAULT NULL,
  `Sowing_Month` varchar(20) DEFAULT NULL,
  `Harvest_Month` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_plan_backup`
--

LOCK TABLES `crop_plan_backup` WRITE;
/*!40000 ALTER TABLE `crop_plan_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `crop_plan_backup` ENABLE KEYS */;
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
  KEY `idx_district_name` (`District_Name`),
  CONSTRAINT `districts_ibfk_1` FOREIGN KEY (`State_ID`) REFERENCES `states` (`State_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (1,'Indore',1),(2,'Bhopal',1),(3,'Nagpur',2),(4,'Pune',2),(5,'Lucknow',3),(6,'Jaipur',4),(7,'Udaipur',4),(8,'Chennai',5),(9,'Madurai',5),(10,'Varanasi',3),(11,'Surat',28),(12,'Ahmedabad',28),(13,'Bhubaneswar',16),(14,'Kolkata',8),(15,'Delhi',23),(16,'Dehradun',6),(17,'Patna',7),(18,'Bareilly',3),(20,'Chandigarh',24),(21,'Amritsar',26),(26,'Coimbatore',5),(27,'Patiala',26),(28,'Jabalpur',1),(29,'Kochi',10),(30,'Puducherry',25),(33,'Mysuru',29),(34,'Gurugram',5),(35,'Agra',3),(36,'Guwahati',9),(37,'Srinagar',2),(38,'Nagaland',17),(39,'Tiruchirappalli',5),(40,'Rajkot',28);
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farmer`
--

DROP TABLE IF EXISTS `farmer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmer` (
  `Farmer_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Contact` varchar(15) NOT NULL,
  `Location_ID` int DEFAULT NULL,
  PRIMARY KEY (`Farmer_ID`),
  UNIQUE KEY `Contact` (`Contact`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `farmer_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `location` (`Location_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farmer`
--

LOCK TABLES `farmer` WRITE;
/*!40000 ALTER TABLE `farmer` DISABLE KEYS */;
INSERT INTO `farmer` VALUES (1,'Ramesh Patel','9876543210',1),(2,'Suresh Yadav','9765432109',2),(3,'Amit Sharma','9654321098',3),(4,'Rajesh Gupta','9543210987',4),(5,'Manoj Singh','9432109876',5),(6,'Vikram Rao','9321098765',6),(7,'Arjun Mehta','9210987654',7),(8,'Mahesh Kumar','9109876543',8),(9,'Harish Nair','9098765432',9),(10,'Dinesh Verma','8987654321',10),(21,'Vijay Kumar','8876543210',11),(22,'Sanjay Gupta','8765432109',12),(23,'Rahul Sharma','8654321098',13),(24,'Amitabh Singh','8543210987',14),(25,'Rajiv Mehta','8432109876',15),(26,'Sunil Patel','8321098765',16),(27,'Anil Yadav','8210987654',17),(28,'Deepak Verma','8109876543',18),(29,'Prakash Nair','8098765432',19),(30,'Manoj Reddy','7987654321',20);
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
  KEY `Crop_ID` (`Crop_ID`),
  CONSTRAINT `farming_activity_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farming_activity`
--

LOCK TABLES `farming_activity` WRITE;
/*!40000 ALTER TABLE `farming_activity` DISABLE KEYS */;
INSERT INTO `farming_activity` VALUES (1,1,'June','Land Preparation','Prepare field and ensure proper irrigation for rice.'),(2,1,'July','Sowing','Sow rice seeds with proper spacing and apply initial fertilizers.'),(3,1,'August','Irrigation','Regular irrigation required every 7-10 days.'),(4,1,'October','Harvesting','Harvest rice when grains are mature and golden in color.'),(5,2,'May','Land Preparation','Prepare field with proper leveling for rice cultivation'),(6,2,'June','Sowing','Transplant rice seedlings with proper spacing'),(7,2,'July','Irrigation','Maintain 2-3 inches of standing water'),(8,2,'September','Harvesting','Harvest when 80-85% grains are mature'),(9,3,'May','Land Preparation','Prepare deep soil for sugarcane planting'),(10,3,'June','Sowing','Plant sugarcane setts in furrows'),(11,3,'July','Fertilization','Apply nitrogen fertilizer'),(12,3,'December','Harvesting','Cut mature canes at base'),(13,4,'May','Land Preparation','Prepare well-drained field'),(14,4,'June','Sowing','Sow maize seeds in rows'),(15,4,'July','Pest Control','Spray for stem borers'),(16,4,'September','Harvesting','Harvest when kernels are hard'),(17,5,'May','Land Preparation','Prepare flat beds for cotton'),(18,5,'June','Sowing','Sow cotton seeds in rows'),(19,5,'August','Pest Control','Spray for bollworms'),(20,5,'December','Harvesting','Pick cotton bolls when fully open');
/*!40000 ALTER TABLE `farming_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fertilizer`
--

DROP TABLE IF EXISTS `fertilizer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fertilizer` (
  `Fertilizer_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Type` varchar(50) NOT NULL,
  `Usage_Guide` text NOT NULL,
  `Crop_ID` int DEFAULT NULL,
  PRIMARY KEY (`Fertilizer_ID`),
  KEY `Crop_ID` (`Crop_ID`),
  CONSTRAINT `fertilizer_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fertilizer`
--

LOCK TABLES `fertilizer` WRITE;
/*!40000 ALTER TABLE `fertilizer` DISABLE KEYS */;
INSERT INTO `fertilizer` VALUES (1,'Urea','Nitrogen','50kg/acre',1),(2,'DAP','Phosphorus','40kg/acre',2),(3,'MOP','Potassium','30kg/acre',3),(4,'Compost','Organic','200kg/acre',4),(5,'Zinc Sulphate','Micronutrient','10kg/acre',5),(6,'Gypsum','Calcium','50kg/acre',6),(7,'NPK 10-26-26','Mixed','60kg/acre',7),(8,'NPK 12-32-16','Mixed','70kg/acre',8),(9,'Super Phosphate','Phosphorus','45kg/acre',9),(10,'Organic Manure','Organic','250kg/acre',10),(11,'Ammonium Sulfate','Nitrogen','40kg/acre',171),(12,'Rock Phosphate','Phosphorus','50kg/acre',172),(13,'Potash','Potassium','35kg/acre',173),(14,'Bone Meal','Organic','150kg/acre',174),(15,'Blood Meal','Organic','120kg/acre',175),(16,'Fish Emulsion','Organic','80kg/acre',176),(17,'Seaweed Extract','Micronutrient','15kg/acre',177),(18,'NPK 15-15-15','Mixed','65kg/acre',178),(19,'NPK 20-20-20','Mixed','70kg/acre',179),(20,'NPK 5-10-5','Mixed','55kg/acre',180),(21,'Magnesium Sulfate','Micronutrient','12kg/acre',181),(22,'Iron Chelate','Micronutrient','8kg/acre',182),(23,'Boron','Micronutrient','5kg/acre',183),(24,'Manganese Sulfate','Micronutrient','7kg/acre',184),(25,'Copper Sulfate','Micronutrient','6kg/acre',185);
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
  CONSTRAINT `historical_weather_ibfk_1` FOREIGN KEY (`District_ID`) REFERENCES `districts` (`District_ID`) ON DELETE CASCADE,
  CONSTRAINT `historical_weather_chk_1` CHECK ((`Month` between 1 and 12))
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historical_weather`
--

LOCK TABLES `historical_weather` WRITE;
/*!40000 ALTER TABLE `historical_weather` DISABLE KEYS */;
INSERT INTO `historical_weather` VALUES (1,1,1,18.5,5.2,60),(2,1,2,20.1,10.5,55),(3,2,3,25.4,15.8,50),(4,2,4,30.2,20,45),(5,3,5,35,40.5,40),(6,1,6,28.3,12,57),(7,2,6,32,14.5,50),(8,3,6,33.5,18,60),(9,4,6,31,20,52),(10,5,6,37,30,45),(19,1,7,28.5,15.2,65),(20,2,7,29.1,14.5,60),(21,3,7,30.4,18.8,55),(22,4,7,31.2,20,50),(23,5,7,32,22.5,45),(24,6,7,31.5,16,60),(25,7,7,30,17.5,55),(26,8,7,33.5,25,65),(27,9,7,32,23,57),(28,10,7,34,30,50);
/*!40000 ALTER TABLE `historical_weather` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insecticide_pesticide`
--

DROP TABLE IF EXISTS `insecticide_pesticide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insecticide_pesticide` (
  `Pest_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Affected_Crop_ID` int DEFAULT NULL,
  `Solution` text NOT NULL,
  PRIMARY KEY (`Pest_ID`),
  KEY `Affected_Crop_ID` (`Affected_Crop_ID`),
  CONSTRAINT `insecticide_pesticide_ibfk_1` FOREIGN KEY (`Affected_Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insecticide_pesticide`
--

LOCK TABLES `insecticide_pesticide` WRITE;
/*!40000 ALTER TABLE `insecticide_pesticide` DISABLE KEYS */;
INSERT INTO `insecticide_pesticide` VALUES (1,'Malathion',1,'Use 2ml/L water spray'),(2,'Chlorpyrifos',2,'Use 1.5ml/L water spray'),(3,'Cypermethrin',3,'Use 2ml/L water spray'),(4,'Neem Oil',4,'Use 5ml/L water spray'),(5,'Imidacloprid',5,'Use 1.2ml/L water spray'),(6,'Fipronil',6,'Use 1.5ml/L water spray'),(7,'Carbaryl',7,'Use 2.5ml/L water spray'),(8,'Acephate',8,'Use 2ml/L water spray'),(9,'Buprofezin',9,'Use 3ml/L water spray'),(10,'Spinosad',10,'Use 1ml/L water spray'),(11,'Deltamethrin',171,'Use 1ml/L water spray'),(12,'Lambda-cyhalothrin',172,'Use 1.5ml/L water spray'),(13,'Thiamethoxam',173,'Use 0.5ml/L water spray'),(14,'Acetamiprid',174,'Use 1.2ml/L water spray'),(15,'Diafenthiuron',175,'Use 2ml/L water spray'),(16,'Flubendiamide',176,'Use 1.5ml/L water spray'),(17,'Emamectin benzoate',177,'Use 1ml/L water spray'),(18,'Indoxacarb',178,'Use 2ml/L water spray'),(19,'Lufenuron',179,'Use 1.5ml/L water spray'),(20,'Pyriproxyfen',180,'Use 1ml/L water spray'),(21,'Abamectin',181,'Use 1.2ml/L water spray'),(22,'Spinetoram',182,'Use 1.5ml/L water spray'),(23,'Chlorantraniliprole',183,'Use 0.8ml/L water spray'),(24,'Cyantraniliprole',184,'Use 1ml/L water spray'),(25,'Tolfenpyrad',185,'Use 1.5ml/L water spray');
/*!40000 ALTER TABLE `insecticide_pesticide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `Location_ID` int NOT NULL AUTO_INCREMENT,
  `District_ID` int DEFAULT NULL,
  PRIMARY KEY (`Location_ID`),
  KEY `District_ID` (`District_ID`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`District_ID`) REFERENCES `districts` (`District_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(18,16),(17,17),(19,17),(20,18),(22,20),(23,21),(28,26),(29,27),(30,28),(31,29),(32,30),(35,33),(36,34),(37,35),(38,36),(39,37),(40,38),(41,39),(42,40);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_price`
--

DROP TABLE IF EXISTS `market_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_price` (
  `Price_ID` int NOT NULL AUTO_INCREMENT,
  `Crop_ID` int DEFAULT NULL,
  `Date` date NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Price_ID`),
  KEY `Crop_ID` (`Crop_ID`),
  CONSTRAINT `market_price_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE,
  CONSTRAINT `market_price_chk_1` CHECK ((`Price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_price`
--

LOCK TABLES `market_price` WRITE;
/*!40000 ALTER TABLE `market_price` DISABLE KEYS */;
INSERT INTO `market_price` VALUES (1,1,'2024-02-01',25.00),(2,2,'2024-02-01',30.00),(3,3,'2024-02-01',40.00),(4,4,'2024-02-01',20.00),(5,5,'2024-02-01',35.00),(6,6,'2024-02-01',28.00),(7,7,'2024-02-01',22.00),(8,8,'2024-02-01',30.00),(9,9,'2024-02-01',18.00),(10,10,'2024-02-01',15.00),(11,171,'2024-02-01',18.00),(12,172,'2024-02-01',22.00),(13,173,'2024-02-01',25.00),(14,174,'2024-02-01',30.00),(15,175,'2024-02-01',28.00),(16,176,'2024-02-01',35.00),(17,177,'2024-02-01',40.00),(18,178,'2024-02-01',45.00),(19,179,'2024-02-01',50.00),(20,180,'2024-02-01',55.00),(21,181,'2024-02-01',20.00),(22,182,'2024-02-01',25.00),(23,183,'2024-02-01',30.00),(24,184,'2024-02-01',35.00),(25,185,'2024-02-01',40.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `State_ID` int NOT NULL AUTO_INCREMENT,
  `State_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`State_ID`),
  UNIQUE KEY `State_Name` (`State_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (9,'Assam'),(7,'Bihar'),(24,'Chandigarh'),(19,'Chhattisgarh'),(23,'Delhi'),(20,'Goa'),(28,'Gujarat'),(27,'Haryana'),(21,'Himachal Pradesh'),(18,'Jharkhand'),(29,'Karnataka'),(10,'Kerala'),(1,'Madhya Pradesh'),(2,'Maharashtra'),(22,'Manipur'),(17,'Nagaland'),(16,'Odisha'),(25,'Puducherry'),(26,'Punjab'),(4,'Rajasthan'),(5,'Tamil Nadu'),(3,'Uttar Pradesh'),(6,'Uttarakhand'),(8,'West Bengal');
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
  CONSTRAINT `weekly_farming_plan_ibfk_1` FOREIGN KEY (`Plan_ID`) REFERENCES `yearly_farming_plan` (`Plan_ID`) ON DELETE CASCADE
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
  `Season_ID` int NOT NULL,
  `Sowing_Month` varchar(20) DEFAULT NULL,
  `Harvest_Month` varchar(20) DEFAULT NULL,
  `Avg_Growth_Days` int DEFAULT NULL,
  PRIMARY KEY (`Plan_ID`),
  KEY `Location_ID` (`Location_ID`),
  KEY `Crop_ID` (`Crop_ID`),
  KEY `Season_ID` (`Season_ID`),
  CONSTRAINT `yearly_farming_plan_ibfk_1` FOREIGN KEY (`Crop_ID`) REFERENCES `crop` (`Crop_ID`) ON DELETE CASCADE,
  CONSTRAINT `yearly_farming_plan_ibfk_2` FOREIGN KEY (`Location_ID`) REFERENCES `location` (`Location_ID`) ON DELETE SET NULL,
  CONSTRAINT `yearly_farming_plan_ibfk_3` FOREIGN KEY (`Season_ID`) REFERENCES `season` (`Season_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yearly_farming_plan`
--

LOCK TABLES `yearly_farming_plan` WRITE;
/*!40000 ALTER TABLE `yearly_farming_plan` DISABLE KEYS */;
INSERT INTO `yearly_farming_plan` VALUES (11,1,1,1,'October','March',120),(12,2,2,2,'June','September',110),(13,3,3,2,'June','September',90),(14,4,4,2,'June','September',95),(15,5,5,2,'June','September',130),(16,6,6,2,'June','September',100),(17,7,7,1,'October','March',100),(18,8,8,2,'June','September',100),(19,9,9,1,'October','March',100),(20,10,10,1,'October','March',100);
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

-- Dump completed on 2025-04-04 14:27:04
