-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Current Database: `mydb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mydb` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `mydb`;

--
-- Table structure for table `Group45`
--

DROP TABLE IF EXISTS `Group45`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group45` (
  `id` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `technique` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `d_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `n_samples` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `t_samples` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pubmed_id` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group45`
--

LOCK TABLES `Group45` WRITE;
/*!40000 ALTER TABLE `Group45` DISABLE KEYS */;
INSERT INTO `Group45` VALUES ('ID1','Affymetrix Array','GSE62232','91','81 HCC and 10 non-tumor','25822088'),('ID2','Affymetrix Array','GSE63067','18','Steatosis, healthy and Non-alcoholic steatohepatitis','25993042'),('ID3','Affymetrix Array','GSE64041','125','60 pairs HCC and non-tumor, 5 normal','27499918'),('ID4','Affymetrix Array','GSE69715','103','HCV-associated hepatocellular carcinoma (HCC) and adjacent non tumor','29538454'),('ID5','Affymetrix Array','GSE72981','30','Subcutaneous and orthotopic HCC tissue','26520397');
/*!40000 ALTER TABLE `Group45` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-14 10:52:11
