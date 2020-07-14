CREATE DATABASE  IF NOT EXISTS `final_Project` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `final_Project`;
-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: final_Project
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `m_board`
--

DROP TABLE IF EXISTS `m_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_board` (
  `board_Seqno` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시글 키값',
  `board_uSeqno` int(11) DEFAULT NULL COMMENT 'FK 유저 키값',
  `board_Content` text COMMENT '게시글 정보',
  `board_Hit` int(11) DEFAULT NULL COMMENT '조회수',
  `board_Sido` varchar(45) DEFAULT NULL COMMENT '거래 지역 정보',
  `board_Latitude` varchar(45) DEFAULT NULL COMMENT '위치 표시 위도',
  `board_Longitude` varchar(45) DEFAULT NULL COMMENT '위치 표시 경도',
  `board_isDone` int(11) DEFAULT '0' COMMENT '판매 완료 여부',
  `board_InsertDate` date DEFAULT NULL COMMENT '작성 일자 (또는 String)',
  `board_DeleteDate` date DEFAULT NULL COMMENT '삭제 일자',
  `board_Title` varchar(45) DEFAULT NULL,
  `board_Price` int(11) DEFAULT NULL,
  PRIMARY KEY (`board_Seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_board`
--

LOCK TABLES `m_board` WRITE;
/*!40000 ALTER TABLE `m_board` DISABLE KEYS */;
INSERT INTO `m_board` VALUES (44,1,'최저 리셀가에여~',0,'대한민국 서울특별시 강남구 강남대로126길','37.51','127.022',0,'2020-04-12','2020-04-12','나이키 한정판 ',300000),(45,1,'요가매트에요! 실사용 한달정도?',2,'대한민국 서울특별시 강남구 강남대로126길','37.54','127.025',0,'2020-04-12',NULL,'요가매트',5000),(46,1,'보온병 거래합시다!',5,'대한민국 서울특별시 강남구 강남대로126길','37.54','127.025',1,'2020-04-12','2020-04-14','보온병',3000),(47,1,'1통 4000원, 3통하면 만원에 드려요',5,'대한민국 서울특별시 강남구 강남대로126길','37.53','127.025',0,'2020-04-12',NULL,'아이드롭 3통',4000),(48,1,'아이맥 거래해요 이마트 앞에서!',7,'서울특별시 성동구','37.51','127.023',1,'2020-04-12',NULL,'아이맥 2018 중고',2000000);
/*!40000 ALTER TABLE `m_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_dm`
--

DROP TABLE IF EXISTS `m_dm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_dm` (
  `dm_Seqno` int(11) NOT NULL AUTO_INCREMENT COMMENT '쪽지 키값',
  `dm_bSend` int(11) DEFAULT NULL COMMENT 'FK 보낸 유저 키값',
  `dm_bReceive` int(11) DEFAULT NULL COMMENT 'FK 받는 유저 키값',
  `dm_Content` text COMMENT '쪽지 내용',
  `dm_InsertDate` date DEFAULT NULL COMMENT '작성 일자',
  `dm_SendDelete` int(11) DEFAULT NULL COMMENT '보낸 유저 삭제 여부',
  `dm_ReceiveDelete` int(11) DEFAULT NULL COMMENT '받은 유저 삭제 여부',
  `dm_Title` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`dm_Seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_dm`
--

LOCK TABLES `m_dm` WRITE;
/*!40000 ALTER TABLE `m_dm` DISABLE KEYS */;
INSERT INTO `m_dm` VALUES (31,7,1,'오늘 저녁8시에 이마트 앞에서 거래해요!!','2020-04-12',NULL,NULL,'오늘 저녁8시에 이마트 앞에서 거래해요!!'),(32,7,1,'나오실꺼죠?? 저랑 거래해요','2020-04-12',NULL,NULL,'나오실꺼죠?? 저랑 거래해요'),(33,1,7,'좋아요 이따 앞에서 봬요!','2020-04-12',NULL,NULL,'좋아요 이따 앞에서 봬요!');
/*!40000 ALTER TABLE `m_dm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_image`
--

DROP TABLE IF EXISTS `m_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_image` (
  `image_Seqno` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시글 이미지 키값',
  `image_bSeqno` int(11) DEFAULT NULL COMMENT 'FK 해당 게시글 키값',
  `image_Blob` mediumblob COMMENT '인코딩 후 저장',
  `image_String` text COMMENT '파일이름 저장',
  PRIMARY KEY (`image_Seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_image`
--

LOCK TABLES `m_image` WRITE;
/*!40000 ALTER TABLE `m_image` DISABLE KEYS */;
INSERT INTO `m_image` VALUES (33,44,NULL,'http://localhost:8080/market/BC2C8A78-0D27-41EE-99F3-68A8E0686BC5.png'),(34,45,NULL,'http://localhost:8080/market/A7D28D17-1DB5-450E-81E3-E595217F0B35.png'),(35,46,NULL,'http://localhost:8080/market/909112D8-A780-489E-BCFB-A3DD2A2B4774.png'),(36,47,NULL,'http://localhost:8080/market/06A6D6BA-5F45-4A20-B406-671B4FE5E17C.png'),(37,48,NULL,'http://localhost:8080/market/10451C0A-4B73-46D4-8A5F-5485CBA76316.png');
/*!40000 ALTER TABLE `m_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_likes`
--

DROP TABLE IF EXISTS `m_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_likes` (
  `like_Seqno` int(11) NOT NULL AUTO_INCREMENT COMMENT '좋아요 키값',
  `like_bSeqno` int(11) DEFAULT NULL COMMENT 'FK 좋아요 누른 게시글',
  `like_uSeqno` int(11) DEFAULT NULL COMMENT '누른 유저 키값',
  PRIMARY KEY (`like_Seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_likes`
--

LOCK TABLES `m_likes` WRITE;
/*!40000 ALTER TABLE `m_likes` DISABLE KEYS */;
INSERT INTO `m_likes` VALUES (37,47,1),(38,46,1);
/*!40000 ALTER TABLE `m_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_reply`
--

DROP TABLE IF EXISTS `m_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_reply` (
  `reply_Seqno` int(11) NOT NULL AUTO_INCREMENT COMMENT '댓글 키값',
  `reply_bSeqno` int(11) DEFAULT NULL COMMENT 'FK 게시글 키값',
  `reply_uSeqno` varchar(45) DEFAULT NULL COMMENT 'FK 유저 키값',
  `reply_Date` date DEFAULT NULL,
  PRIMARY KEY (`reply_Seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_reply`
--

LOCK TABLES `m_reply` WRITE;
/*!40000 ALTER TABLE `m_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_searchData`
--

DROP TABLE IF EXISTS `m_searchData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_searchData` (
  `search_Seqno` int(11) NOT NULL AUTO_INCREMENT COMMENT '검색 기록 키값',
  `search_Content` varchar(45) DEFAULT NULL COMMENT '검색 내용',
  `search_Date` date DEFAULT NULL COMMENT '검색 날짜',
  PRIMARY KEY (`search_Seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_searchData`
--

LOCK TABLES `m_searchData` WRITE;
/*!40000 ALTER TABLE `m_searchData` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_searchData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_userInfo`
--

DROP TABLE IF EXISTS `m_userInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_userInfo` (
  `user_Seqno` int(11) NOT NULL AUTO_INCREMENT,
  `user_Id` varchar(45) NOT NULL,
  `user_Password` varchar(45) NOT NULL,
  `user_Name` varchar(45) DEFAULT NULL,
  `user_Telno` varchar(45) DEFAULT NULL,
  `user_Email` varchar(45) DEFAULT NULL,
  `user_Address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_Seqno`,`user_Id`),
  UNIQUE KEY `user_Id_UNIQUE` (`user_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_userInfo`
--

LOCK TABLES `m_userInfo` WRITE;
/*!40000 ALTER TABLE `m_userInfo` DISABLE KEYS */;
INSERT INTO `m_userInfo` VALUES (1,'ksb313','ksb313','김순빈','01074080313','ksb313@msn.cn',NULL),(7,'biny','biny','biny','12345','biny@naver.com',NULL);
/*!40000 ALTER TABLE `m_userInfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-21 12:09:13
