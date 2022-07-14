DROP DATABASE IF EXISTS library_2;
CREATE DATABASE library_2 ;
USE library_2 ;

DROP TABLE IF EXISTS authors; -- авторы
CREATE TABLE authors ( 
	author_id SERIAL PRIMARY KEY, -- предпосылка для внешнего ключа, точно такого же типа как и поле, на которое ссылается
	firstname VARCHAR(255), 
	lastname VARCHAR(255),
	INDEX authors_firstname_lastname_idx(firstname, lastname) -- поиск в системе по имени и фамилии автора
);

DROP TABLE IF EXISTS genre; -- жанры
CREATE TABLE genre( 
	genre_id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

DROP TABLE IF EXISTS publisher;
CREATE TABLE publisher(
	publisher_id SERIAL PRIMARY KEY,
	name VARCHAR(255)
); 

DROP TABLE IF EXISTS books; -- книги
CREATE TABLE books ( 
	id SERIAL PRIMARY KEY, -- serial == BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	book_name VARCHAR(255),
	author_id BIGINT UNSIGNED NOT NULL,
	genre_id BIGINT UNSIGNED NOT NULL,
	publisher_id BIGINT UNSIGNED NOT NULL,
	amount INT UNSIGNED NOT NULL,
	
	INDEX book_name_idx(book_name), -- поиск в системе по названию книги
	FOREIGN KEY (author_id) REFERENCES authors(author_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (genre_id) REFERENCES genre(genre_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id) ON UPDATE CASCADE ON DELETE CASCADE 
);

DROP TABLE IF EXISTS users; -- пользователи(читатели)
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(255),
	lastname VARCHAR(255),
	email VARCHAR(255) UNIQUE,
	phone BIGINT
);

DROP TABLE IF EXISTS likes; -- лайки книгам
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	books_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS comments; -- комментарии книгам
CREATE TABLE comments(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	books_id BIGINT UNSIGNED NOT NULL,
	comment TEXT
);

DROP TABLE IF EXISTS user_basket; -- корзина пользователя, какие книги он взял
CREATE TABLE user_basket(
	user_id BIGINT UNSIGNED NOT NULL, 
	books_id BIGINT UNSIGNED NOT NULL,
	books_count BIGINT UNSIGNED NOT NULL DEFAULT 0,
	
	PRIMARY KEY (user_id, books_id)
);

DROP TABLE IF EXISTS reading_room; -- читальные залы
CREATE TABLE reading_room(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название зала',
	UNIQUE unique_name(name(10))
);

DROP TABLE IF EXISTS book_accounting; -- учет книг(кому, какую книгу, когда выдали, когда вернуть)
CREATE TABLE book_accounting(
	id SERIAL PRIMARY KEY,
	books_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	date_of_issue DATETIME DEFAULT NOW(),
	date_of_delivery DATETIME
);

DROP TABLE IF EXISTS book_placemant; -- смотрим местонахождение книги в данный момент, которая у пользователя
CREATE TABLE book_placemant (
	id SERIAL PRIMARY KEY,
	books_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	reading_room_id BIGINT UNSIGNED NOT NULL
);


ALTER TABLE library_2.likes ADD CONSTRAINT likes_FK FOREIGN KEY (user_id) REFERENCES library_2.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE library_2.likes ADD CONSTRAINT likes_FK_1 FOREIGN KEY (books_id) REFERENCES library_2.books(id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE library_2.comments ADD CONSTRAINT comments_FK FOREIGN KEY (books_id) REFERENCES library_2.books(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE library_2.comments ADD CONSTRAINT comments_FK_1 FOREIGN KEY (user_id) REFERENCES library_2.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE library_2.user_basket ADD CONSTRAINT user_basket_FK FOREIGN KEY (books_id) REFERENCES library_2.books(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE library_2.user_basket ADD CONSTRAINT user_basket_FK_1 FOREIGN KEY (user_id) REFERENCES library_2.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE library_2.book_placemant ADD CONSTRAINT book_placemant_FK FOREIGN KEY (books_id) REFERENCES library_2.books(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE library_2.book_placemant ADD CONSTRAINT book_placemant_FK_1 FOREIGN KEY (reading_room_id) REFERENCES library_2.reading_room(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE library_2.book_placemant ADD CONSTRAINT book_placemant_FK_2 FOREIGN KEY (user_id) REFERENCES library_2.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE library_2.book_accounting ADD CONSTRAINT book_accounting_FK FOREIGN KEY (books_id) REFERENCES library_2.books(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE library_2.book_accounting ADD CONSTRAINT book_accounting_FK_1 FOREIGN KEY (user_id) REFERENCES library_2.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_25
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `author_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`author_id`),
  KEY `authors_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (11,'Aglae','Nitzsche'),(12,'Alanna','Cassin'),(5,'Alisa','Brakus'),(22,'Allan','Harris'),(18,'April','Cartwright'),(50,'Armani','Paucek'),(3,'Bernadette','Kautzer'),(47,'Bethany','Corkery'),(15,'Britney','Beahan'),(9,'Camilla','Blanda'),(44,'Christina','Rath'),(30,'Cruz','Satterfield'),(25,'Daphne','Murray'),(28,'Elaina','Larkin'),(21,'Elliot','Bechtelar'),(46,'Emory','Funk'),(7,'Enola','Predovic'),(16,'Erik','Volkman'),(24,'Golda','Reinger'),(37,'Gregoria','Reichel'),(2,'Gregoria','Streich'),(40,'Helen','Reichert'),(20,'Isac','Fahey'),(6,'Jamison','Nikolaus'),(32,'Jeffery','Schiller'),(27,'Johnpaul','Turner'),(29,'Joseph','Emmerich'),(34,'Jude','Kuphal'),(49,'Khalil','Homenick'),(26,'Kiarra','Nitzsche'),(43,'Kristina','Waelchi'),(8,'Layne','Osinski'),(42,'Lennie','Gleichner'),(13,'Lisette','Moore'),(17,'Lula','Torp'),(10,'Marc','Nicolas'),(38,'Millie','Doyle'),(23,'Monte','Predovic'),(39,'Murl','Grant'),(4,'Nyasia','Bruen'),(41,'Rey','Harvey'),(33,'Rhianna','Morissette'),(36,'Rosa','White'),(19,'Sabina','Welch'),(14,'Stewart','Okuneva'),(1,'Toby','Brakus'),(31,'Tony','Thiel'),(45,'Trenton','Schowalter'),(35,'Yoshiko','Beier'),(48,'Zane','Sauer');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_accounting`
--

DROP TABLE IF EXISTS `book_accounting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_accounting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `books_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `date_of_issue` datetime DEFAULT current_timestamp(),
  `date_of_delivery` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_accounting`
--

LOCK TABLES `book_accounting` WRITE;
/*!40000 ALTER TABLE `book_accounting` DISABLE KEYS */;
INSERT INTO `book_accounting` VALUES (1,3,88,'1992-11-09 05:13:30','1977-01-21 00:57:39'),(2,34,18,'1993-11-21 16:52:03','1999-02-04 13:58:00'),(3,7,65,'1971-03-07 12:37:53','1974-04-08 02:35:28'),(4,79,11,'1991-08-25 03:54:45','2005-09-01 12:49:09'),(5,95,67,'2017-05-03 13:49:03','1995-08-19 01:10:06'),(6,71,28,'1988-02-16 10:56:39','2017-12-03 22:05:40'),(7,44,70,'1981-11-08 00:29:58','1990-03-29 09:37:39'),(8,47,100,'1980-12-08 01:21:19','2004-02-19 08:31:30'),(9,72,45,'1986-04-06 02:24:04','2013-03-05 12:59:59'),(10,91,14,'1983-10-25 15:30:36','1989-06-27 13:49:09'),(11,7,1,'2011-05-13 06:19:49','1980-09-03 11:38:09'),(12,5,48,'1984-04-16 13:23:56','2006-05-18 21:34:33'),(13,14,69,'2002-10-28 23:21:14','2005-04-24 15:44:59'),(14,26,95,'2007-11-12 19:04:48','2010-12-01 21:47:18'),(15,73,99,'1976-04-01 13:42:28','1994-09-20 01:17:27'),(16,59,76,'1999-07-11 00:23:44','2019-06-03 08:39:11'),(17,87,92,'2002-04-03 22:07:14','2011-07-10 22:35:05'),(18,93,93,'1994-03-10 22:11:47','1977-10-26 13:19:02'),(19,57,72,'1996-11-07 17:55:06','1976-12-20 14:30:26'),(20,3,51,'1996-03-05 19:47:41','1970-09-10 20:53:07'),(21,39,74,'1972-10-21 10:46:06','2015-06-11 12:18:04'),(22,79,82,'2002-09-23 16:09:51','2021-11-24 12:05:03'),(23,43,26,'2005-04-10 14:28:26','1983-06-09 03:50:57'),(24,81,15,'1980-05-23 07:55:45','2017-05-08 08:19:30'),(25,70,72,'2006-02-05 13:59:28','2004-12-28 03:56:43'),(26,28,77,'1972-12-17 20:36:12','1982-07-27 07:45:59'),(27,73,32,'2017-11-19 14:58:23','1995-12-16 13:04:14'),(28,25,87,'1978-08-31 00:13:45','1992-03-18 20:56:29'),(29,1,51,'2000-07-19 15:00:07','1993-06-28 14:38:21'),(30,81,73,'2009-10-19 03:58:06','1997-10-26 19:18:36'),(31,49,39,'1974-08-08 14:28:10','2003-01-27 19:06:20'),(32,48,35,'1971-10-19 10:13:46','1972-01-27 19:24:02'),(33,31,41,'1995-04-06 16:29:13','1970-08-23 14:58:28'),(34,28,88,'1977-08-15 19:36:46','2015-06-21 10:31:49'),(35,12,31,'2021-09-26 22:56:05','1990-07-16 21:11:35'),(36,38,51,'2005-06-30 00:39:41','1993-11-01 15:57:36'),(37,4,17,'2020-09-09 18:01:39','1971-07-07 21:37:17'),(38,32,46,'1987-06-18 10:57:19','2000-05-25 04:21:34'),(39,42,13,'2008-04-03 04:56:33','2015-07-23 11:35:10'),(40,60,12,'1992-11-18 22:12:00','1990-04-20 14:28:49'),(41,84,87,'2015-10-25 03:48:27','2020-06-17 17:15:42'),(42,89,57,'1974-11-10 22:18:11','2009-03-01 07:03:22'),(43,19,14,'1982-09-18 12:00:43','1975-09-12 06:46:54'),(44,43,19,'2011-04-09 04:27:49','2006-03-25 17:53:33'),(45,64,23,'1975-02-13 17:07:19','2003-07-02 23:18:58'),(46,92,12,'2004-12-29 19:28:26','1972-05-23 09:06:35'),(47,62,40,'1975-05-26 09:54:55','1976-04-30 19:38:24'),(48,47,92,'1978-02-20 14:21:34','1985-12-31 23:47:49'),(49,80,75,'2011-10-19 11:36:47','2007-11-08 04:18:00'),(50,79,92,'1976-02-14 05:38:06','1996-09-08 19:12:21'),(51,5,17,'1993-12-21 22:44:33','1976-07-02 23:32:09'),(52,42,8,'2000-08-01 23:14:10','1994-02-07 08:00:32'),(53,34,74,'2003-11-18 00:37:21','2019-03-13 01:21:33'),(54,53,75,'2006-09-01 05:12:11','1979-10-17 14:33:07'),(55,86,13,'2017-12-23 16:09:04','1999-06-05 20:37:46'),(56,87,70,'1997-07-26 05:45:40','1985-05-06 06:30:51'),(57,100,75,'1991-08-13 04:45:44','2019-06-13 13:53:45'),(58,26,18,'1979-01-28 14:11:47','1970-10-17 04:07:33'),(59,88,68,'2012-03-26 16:55:04','1975-06-20 04:25:09'),(60,37,52,'1997-04-26 12:33:50','1999-12-22 05:29:42'),(61,90,29,'2001-10-14 07:12:55','1997-09-22 10:04:11'),(62,64,51,'1986-07-06 06:25:26','2008-09-18 00:14:51'),(63,68,10,'1979-11-01 22:44:02','1980-01-16 20:12:12'),(64,43,48,'1981-08-04 06:43:25','2012-08-21 11:46:00'),(65,85,22,'1993-12-13 06:11:23','1975-06-24 12:36:33'),(66,40,89,'2004-09-09 23:53:14','1977-05-19 01:44:25'),(67,39,82,'2005-02-01 02:17:48','1991-07-17 08:37:00'),(68,97,72,'2021-12-12 21:08:42','1973-01-28 02:00:59'),(69,55,50,'2011-08-27 08:27:15','2013-02-16 05:15:41'),(70,47,41,'1977-05-12 19:37:11','2015-02-16 00:43:59'),(71,62,34,'2002-04-03 18:38:50','1992-06-02 07:10:06'),(72,10,62,'1995-09-20 06:00:19','2016-08-23 09:25:44'),(73,8,35,'1990-11-12 11:03:30','2009-12-13 16:47:07'),(74,80,96,'1985-09-27 12:19:11','2008-12-30 08:06:12'),(75,2,16,'2017-12-30 17:28:43','2010-01-04 20:35:51'),(76,48,92,'2005-05-18 11:02:22','2011-09-01 19:52:45'),(77,45,11,'2007-09-03 20:24:04','2010-08-17 05:12:36'),(78,43,13,'1986-07-27 05:11:17','1980-07-30 17:25:21'),(79,21,86,'2016-03-13 19:17:44','1983-04-22 06:30:26'),(80,60,5,'1980-10-26 18:27:08','1992-07-20 15:11:36'),(81,8,100,'2005-03-30 15:14:08','1995-08-07 11:41:19'),(82,93,46,'1971-12-15 01:09:09','1985-07-08 10:16:56'),(83,81,90,'1996-08-24 10:08:45','2015-10-31 14:17:12'),(84,18,36,'2006-02-04 10:43:33','1970-09-12 11:45:16'),(85,39,65,'2008-11-05 01:47:56','2014-12-14 00:57:43'),(86,76,1,'2001-04-15 10:47:22','2002-10-29 22:42:17'),(87,98,85,'2020-04-04 19:45:46','1993-09-05 21:04:09'),(88,62,6,'2011-04-17 20:31:02','1990-06-29 03:25:24'),(89,20,41,'1983-05-26 07:32:57','2017-09-26 23:04:35'),(90,2,22,'2011-09-24 16:15:10','1974-04-17 18:46:31'),(91,57,49,'2013-08-07 23:05:59','1991-01-04 20:45:27'),(92,14,1,'2000-02-19 18:27:10','1993-03-24 15:30:28'),(93,59,56,'1971-06-07 03:01:23','1987-10-07 22:59:53'),(94,13,79,'2003-04-07 08:56:38','1984-10-04 14:41:10'),(95,42,73,'1988-11-15 03:59:54','2004-09-29 05:17:43'),(96,83,49,'1981-12-12 12:48:22','2015-07-28 22:31:13'),(97,73,76,'1985-01-29 20:17:06','1971-03-18 07:49:37'),(98,95,54,'1979-05-02 00:04:18','1997-08-24 01:22:22'),(99,65,12,'2012-04-05 08:05:51','1992-08-01 18:09:45'),(100,89,4,'1970-11-23 01:56:26','1988-04-13 14:51:17');
/*!40000 ALTER TABLE `book_accounting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_placemant`
--

DROP TABLE IF EXISTS `book_placemant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_placemant` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `books_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `reading_room_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_placemant`
--

LOCK TABLES `book_placemant` WRITE;
/*!40000 ALTER TABLE `book_placemant` DISABLE KEYS */;
INSERT INTO `book_placemant` VALUES (1,36,22,2),(2,62,81,4),(3,4,75,5),(4,6,2,3),(5,88,19,4),(6,52,26,1),(7,90,21,1),(8,68,21,5),(9,52,68,2),(10,49,21,1),(11,35,56,2),(12,62,18,1),(13,38,21,5),(14,37,27,5),(15,77,14,1),(16,41,66,2),(17,58,56,3),(18,60,24,4),(19,60,75,3),(20,83,23,4),(21,97,58,2),(22,32,20,2),(23,48,57,3),(24,39,94,5),(25,31,71,1),(26,42,11,4),(27,79,69,2),(28,36,28,3),(29,13,88,1),(30,58,70,3),(31,24,67,5),(32,45,99,1),(33,84,46,4),(34,43,85,4),(35,30,16,2),(36,30,57,3),(37,96,35,1),(38,17,71,3),(39,62,83,2),(40,81,41,1),(41,23,65,4),(42,22,10,4),(43,40,93,1),(44,15,36,5),(45,83,65,1),(46,21,94,4),(47,70,90,1),(48,87,6,4),(49,31,68,3),(50,63,49,5),(51,64,71,4),(52,32,92,4),(53,98,32,4),(54,10,47,5),(55,6,29,4),(56,18,50,3),(57,86,20,3),(58,89,6,3),(59,62,36,1),(60,19,98,4),(61,16,62,2),(62,77,94,2),(63,48,92,4),(64,11,2,1),(65,9,7,2),(66,72,25,5),(67,28,10,1),(68,74,99,1),(69,25,61,3),(70,44,79,3),(71,11,94,1),(72,48,71,5),(73,77,18,5),(74,38,28,5),(75,45,37,5),(76,81,8,2),(77,66,36,2),(78,71,9,2),(79,80,34,5),(80,25,77,4),(81,69,87,4),(82,74,34,2),(83,72,11,3),(84,63,49,4),(85,54,93,1),(86,52,73,2),(87,74,39,3),(88,6,9,4),(89,37,89,5),(90,27,14,4),(91,95,82,4),(92,57,55,5),(93,89,27,1),(94,38,89,3),(95,16,42,3),(96,29,93,1),(97,51,67,3),(98,8,73,4),(99,73,9,3),(100,72,36,4);
/*!40000 ALTER TABLE `book_placemant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `book_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `genre_id` bigint(20) unsigned NOT NULL,
  `publisher_id` bigint(20) unsigned NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `book_name_idx` (`book_name`),
  KEY `author_id` (`author_id`),
  KEY `genre_id` (`genre_id`),
  KEY `publisher_id` (`publisher_id`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `books_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `books_ibfk_3` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'nobis',42,16,3,8),(2,'aut',43,18,1,48),(3,'aut',26,16,2,12),(4,'molestiae',3,2,4,7),(5,'dolores',21,5,3,22),(6,'temporibus',39,11,10,37),(7,'ipsum',50,10,1,33),(8,'suscipit',13,14,1,38),(9,'omnis',31,3,4,29),(10,'cupiditate',8,10,9,12),(11,'repellat',45,6,6,45),(12,'et',6,3,5,50),(13,'praesentium',9,14,3,7),(14,'consequatur',18,15,4,1),(15,'et',38,3,7,50),(16,'est',49,18,2,26),(17,'aperiam',47,18,6,7),(18,'possimus',47,3,3,29),(19,'soluta',2,15,4,39),(20,'exercitationem',20,18,9,47),(21,'qui',11,16,2,46),(22,'aut',40,18,3,5),(23,'voluptatibus',14,1,10,50),(24,'dolores',28,9,7,13),(25,'et',46,3,8,17),(26,'et',26,3,7,38),(27,'qui',31,1,6,17),(28,'totam',10,20,7,37),(29,'voluptates',22,1,4,9),(30,'unde',39,9,3,1),(31,'ullam',29,13,1,48),(32,'quis',35,9,9,26),(33,'eum',47,14,10,48),(34,'delectus',42,5,4,5),(35,'facilis',23,3,5,38),(36,'amet',10,14,7,14),(37,'itaque',42,6,7,5),(38,'ipsum',18,10,7,11),(39,'animi',50,18,7,29),(40,'vel',18,13,1,47),(41,'voluptas',31,5,8,19),(42,'quae',32,19,2,30),(43,'dolores',26,17,9,25),(44,'veritatis',23,14,1,6),(45,'vel',41,3,3,34),(46,'excepturi',16,7,9,32),(47,'voluptatem',47,4,2,41),(48,'beatae',30,11,7,7),(49,'aut',13,11,5,39),(50,'et',47,18,2,20),(51,'rem',1,10,4,27),(52,'eum',37,2,3,49),(53,'quasi',43,13,2,32),(54,'totam',34,2,8,6),(55,'nulla',38,18,10,48),(56,'quam',49,4,3,10),(57,'fugit',43,2,5,5),(58,'ut',50,14,10,10),(59,'quasi',31,19,5,16),(60,'minus',5,18,4,47),(61,'quia',12,18,9,50),(62,'sed',30,12,10,4),(63,'fuga',44,9,6,32),(64,'ex',49,3,6,33),(65,'corporis',39,18,5,1),(66,'numquam',36,17,7,46),(67,'omnis',50,14,8,35),(68,'eius',23,14,5,34),(69,'eum',22,6,4,26),(70,'adipisci',47,8,3,18),(71,'rem',14,13,1,26),(72,'eos',6,4,7,11),(73,'rerum',1,2,2,9),(74,'et',28,1,3,7),(75,'odio',7,17,1,14),(76,'non',30,11,10,31),(77,'sit',11,11,7,44),(78,'quae',47,20,3,7),(79,'repellat',18,9,6,22),(80,'commodi',35,7,10,8),(81,'et',45,13,6,1),(82,'ut',49,15,8,27),(83,'laboriosam',32,15,9,1),(84,'voluptatem',37,6,9,21),(85,'ad',49,8,7,13),(86,'autem',3,20,2,21),(87,'mollitia',49,4,7,8),(88,'officiis',30,3,7,13),(89,'et',45,10,1,44),(90,'voluptatibus',24,4,4,40),(91,'autem',21,2,10,42),(92,'qui',50,1,8,13),(93,'ipsa',37,14,5,38),(94,'perspiciatis',28,8,7,35),(95,'qui',20,8,1,1),(96,'quia',2,9,1,15),(97,'adipisci',10,8,3,30),(98,'nisi',44,20,5,19),(99,'dolor',27,18,9,17),(100,'et',30,7,1,33);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `books_id` bigint(20) unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,24,19,'Voluptatibus eligendi officiis velit velit.'),(2,99,70,'Doloremque accusantium ratione cumque laboriosam iste maiores in.'),(3,28,79,'Voluptatum repellat excepturi necessitatibus nostrum iusto hic est voluptatem.'),(4,14,74,'Ipsum sed quisquam explicabo blanditiis et.'),(5,8,41,'Modi maxime fuga beatae et quae distinctio maiores corrupti.'),(6,80,68,'Et praesentium neque maiores harum dolores earum perferendis sed libero.'),(7,22,45,'Aut aut nam veritatis voluptatem aut consequatur accusantium vero.'),(8,52,18,'Eos corporis dolores quo corporis rerum.'),(9,57,32,'Animi animi quia id sit et qui laborum.'),(10,37,25,'Sunt eveniet accusamus enim et culpa.'),(11,61,38,'Reiciendis possimus placeat dolorem consectetur veniam.'),(12,24,10,'Incidunt consequatur aperiam maiores doloribus facere sed sit aut.'),(13,93,48,'Enim quidem nobis iste quis maiores.'),(14,38,27,'Et architecto placeat ullam tenetur a quod facilis corporis beatae.'),(15,96,18,'Perspiciatis neque ea totam voluptatum natus quos et laboriosam.'),(16,88,20,'Enim officiis autem hic aut et sunt tempore.'),(17,37,87,'Praesentium libero eius sit eos.'),(18,90,64,'Modi fugiat sapiente dolorum in a commodi eos commodi perspiciatis.'),(19,65,3,'Ipsum dolores dolores quia eius.'),(20,37,72,'Nisi perspiciatis officiis illum aut laboriosam esse.'),(21,43,17,'Perspiciatis quia placeat rerum voluptatem.'),(22,40,64,'Molestiae autem aut veniam unde.'),(23,62,91,'Distinctio odio nostrum sunt adipisci.'),(24,82,18,'Vel deserunt quia vitae error et aspernatur aliquam sit.'),(25,23,19,'Quidem iusto ad voluptatem labore.'),(26,42,84,'Voluptas quasi est aperiam ut facere fuga suscipit cum.'),(27,56,65,'Et praesentium ex amet laborum.'),(28,94,49,'Fuga ullam alias exercitationem corporis esse.'),(29,13,32,'Maiores culpa reprehenderit odit dolore beatae sit.'),(30,76,9,'Non ut ipsam esse modi voluptatem quod beatae earum.'),(31,49,64,'Dolor itaque qui facilis amet accusamus nesciunt esse.'),(32,29,86,'Officia voluptates vitae eligendi culpa aut fugit nihil.'),(33,50,18,'Quos blanditiis harum rerum animi tempora minus.'),(34,50,15,'Natus assumenda quis id modi.'),(35,20,86,'Ad voluptatem quia ratione deserunt quam non occaecati qui vero.'),(36,87,63,'Voluptatem molestias eius repudiandae eius laudantium eum.'),(37,3,26,'Voluptatem non earum ut provident magni.'),(38,27,64,'Harum facere quia corporis qui tempora vitae odio eum et.'),(39,17,8,'Et quae incidunt eius quam.'),(40,81,39,'Architecto unde reprehenderit et perspiciatis ea aut.'),(41,26,23,'Recusandae laboriosam asperiores incidunt placeat ut sit.'),(42,23,82,'Libero molestiae cum facere omnis libero accusantium quia.'),(43,88,16,'Exercitationem et nihil et maxime aliquid eum labore possimus.'),(44,31,1,'Veritatis iste velit qui rerum tenetur similique repellat pariatur.'),(45,48,7,'Odit dolores ut officia atque autem molestiae cupiditate non sed.'),(46,9,96,'Sit repellendus quia enim corporis ut maxime sint maiores.'),(47,71,37,'Quisquam aut dolor et veritatis.'),(48,82,20,'Nisi corrupti repudiandae et veritatis tempora alias.'),(49,55,31,'Pariatur eos voluptates temporibus et.'),(50,35,75,'Quos nostrum reiciendis blanditiis autem facere reiciendis ullam fugiat.'),(51,17,21,'Unde ea voluptate quia cupiditate ut totam dolor tenetur quasi.'),(52,37,19,'Dignissimos veritatis debitis at id error.'),(53,47,63,'Beatae libero cum sunt placeat nostrum illo et provident.'),(54,83,63,'Qui odit velit minima quos suscipit porro.'),(55,71,64,'Quia debitis asperiores sunt omnis quos cumque voluptatibus commodi.'),(56,2,97,'Sit molestiae itaque et temporibus aliquid aut.'),(57,86,25,'Id consequatur molestiae sed quibusdam.'),(58,79,74,'Necessitatibus repellat eligendi sit fuga voluptatem.'),(59,41,9,'Blanditiis aut voluptatem nihil quia modi.'),(60,74,88,'Harum natus vitae natus numquam assumenda id.'),(61,16,83,'Aliquam facilis aut recusandae eum sint.'),(62,83,86,'Cupiditate perspiciatis quis voluptatibus hic.'),(63,19,65,'Quasi at fugit occaecati explicabo expedita provident.'),(64,6,74,'Doloremque temporibus neque libero nihil veniam.'),(65,95,40,'Et ut aut voluptate voluptas corrupti recusandae atque.'),(66,48,11,'A ipsam tenetur delectus dolores vitae non.'),(67,61,85,'Et debitis ut cum voluptatum voluptates non et tempore.'),(68,30,7,'Atque necessitatibus atque repudiandae consequatur natus aut.'),(69,47,13,'Inventore pariatur aut quam mollitia eius et est adipisci perspiciatis.'),(70,70,17,'Ut dolorem aut totam aliquid inventore sit praesentium.'),(71,76,72,'Et at magni cum esse non sunt.'),(72,14,62,'Perferendis iste fugiat quo nihil quae doloremque iusto itaque ut.'),(73,96,92,'Facere enim iusto aut illum quia qui.'),(74,35,36,'Est quia voluptatem quaerat ut assumenda a quae.'),(75,100,8,'Eius atque occaecati temporibus illum quam esse.'),(76,23,16,'Et qui sequi quis eaque quibusdam quia dolores.'),(77,91,6,'Itaque tempore iste et voluptatibus.'),(78,1,9,'Est non fugiat libero commodi.'),(79,70,6,'Fugit corrupti ducimus accusantium doloremque ex officiis ducimus possimus et.'),(80,83,64,'Perspiciatis reiciendis est ut eveniet voluptatem reiciendis eum non iure.'),(81,46,30,'Tenetur in distinctio eos excepturi facere esse.'),(82,75,7,'Deleniti quidem magnam cumque non quidem.'),(83,14,5,'Et ad totam nulla mollitia ut est provident animi ea.'),(84,14,61,'Dolores architecto culpa consequatur ratione aut.'),(85,17,83,'Vel dolor voluptatem asperiores qui fugit.'),(86,78,92,'Eius sunt natus beatae blanditiis sint commodi non consequatur.'),(87,54,91,'Aut est qui quibusdam commodi aut est.'),(88,54,49,'Rerum incidunt et dignissimos neque totam enim tempora quam.'),(89,82,88,'Nostrum sunt quia natus et.'),(90,85,82,'Qui sunt eum soluta animi dolorem magnam dolore est.'),(91,96,7,'Provident amet eaque laborum sit omnis omnis.'),(92,97,86,'Voluptas excepturi architecto voluptates eveniet.'),(93,13,98,'Ad aut voluptatem accusamus quis.'),(94,95,82,'Est fuga assumenda beatae natus.'),(95,4,77,'Beatae cupiditate odio et vel excepturi omnis corporis qui laudantium.'),(96,46,49,'Ratione nemo minus rem in modi earum sapiente.'),(97,7,21,'Maxime quis soluta nisi et numquam.'),(98,55,21,'Enim hic quisquam quis magni cupiditate unde.'),(99,25,68,'Ut repudiandae ad architecto alias.'),(100,81,41,'Autem est aliquam omnis recusandae aut rerum qui vero.');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `genre_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'odio'),(2,'fugit'),(3,'doloribus'),(4,'nostrum'),(5,'velit'),(6,'animi'),(7,'cupiditate'),(8,'vero'),(9,'ad'),(10,'unde'),(11,'enim'),(12,'et'),(13,'culpa'),(14,'ipsam'),(15,'harum'),(16,'et'),(17,'dolores'),(18,'quo'),(19,'dolore'),(20,'laborum');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `books_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,59,66,'1994-03-07 20:15:52'),(2,99,73,'2011-12-06 20:28:40'),(3,41,26,'1985-09-28 21:14:02'),(4,77,99,'2009-08-15 22:13:48'),(5,81,2,'2004-04-12 19:09:33'),(6,38,21,'2004-12-16 19:00:10'),(7,34,17,'1970-12-02 11:17:52'),(8,68,45,'1989-07-16 12:37:34'),(9,19,78,'2002-03-18 23:08:34'),(10,13,52,'1985-12-16 05:15:10'),(11,38,72,'2001-04-15 23:01:00'),(12,29,95,'2002-09-29 21:19:28'),(13,70,32,'1975-07-06 07:12:15'),(14,71,55,'2010-09-23 06:57:24'),(15,19,67,'1973-03-31 05:25:48'),(16,54,77,'2010-01-03 20:28:43'),(17,32,53,'1971-06-23 05:48:19'),(18,50,73,'2018-02-10 12:06:18'),(19,78,27,'2017-12-26 23:33:10'),(20,71,59,'1995-09-04 02:57:17'),(21,28,8,'2006-02-21 11:07:33'),(22,79,62,'1983-02-04 12:36:31'),(23,25,47,'2006-11-15 14:26:25'),(24,6,44,'2019-02-27 02:52:58'),(25,24,19,'1984-08-10 21:39:50'),(26,95,61,'2008-09-21 03:38:56'),(27,90,24,'1983-11-13 22:29:15'),(28,55,60,'1986-09-13 09:35:31'),(29,56,26,'1999-03-04 17:25:45'),(30,15,74,'1993-02-07 07:28:06'),(31,92,68,'2021-03-24 13:52:47'),(32,51,24,'1993-03-03 04:08:39'),(33,21,1,'1992-09-22 08:02:21'),(34,96,99,'2003-11-19 22:10:05'),(35,27,66,'2009-08-22 23:35:41'),(36,57,54,'2017-12-06 11:52:44'),(37,74,36,'1993-06-08 07:37:50'),(38,16,99,'2011-06-27 14:25:14'),(39,82,21,'2011-07-01 09:14:04'),(40,43,6,'1970-01-12 20:07:17'),(41,40,37,'2013-09-24 10:55:18'),(42,67,30,'1995-05-27 17:23:42'),(43,60,21,'1992-08-25 13:32:11'),(44,90,15,'1997-01-19 03:15:09'),(45,47,4,'1993-09-30 06:05:52'),(46,89,38,'2015-07-27 02:37:33'),(47,72,39,'1975-05-30 06:11:28'),(48,62,92,'1983-05-02 18:24:37'),(49,39,57,'2003-01-12 07:39:56'),(50,91,66,'2006-12-01 08:26:43');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher` (
  `publisher_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (1,'quas'),(2,'sed'),(3,'ut'),(4,'sint'),(5,'facilis'),(6,'sequi'),(7,'totam'),(8,'qui'),(9,'eos'),(10,'aut');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reading_room`
--

DROP TABLE IF EXISTS `reading_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reading_room` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название зала',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reading_room`
--

LOCK TABLES `reading_room` WRITE;
/*!40000 ALTER TABLE `reading_room` DISABLE KEYS */;
INSERT INTO `reading_room` VALUES (1,'laudantium'),(2,'ut'),(3,'aliquam'),(4,'aut'),(5,'quo');
/*!40000 ALTER TABLE `reading_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_basket`
--

DROP TABLE IF EXISTS `user_basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_basket` (
  `user_id` bigint(20) unsigned NOT NULL,
  `books_id` bigint(20) unsigned NOT NULL,
  `books_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_basket`
--

LOCK TABLES `user_basket` WRITE;
/*!40000 ALTER TABLE `user_basket` DISABLE KEYS */;
INSERT INTO `user_basket` VALUES (2,45,0),(3,28,0),(4,27,0),(5,25,1),(6,3,1),(8,17,1),(9,16,1),(10,66,1),(14,88,1),(15,47,1),(16,24,0),(17,23,0),(22,76,0),(23,72,1),(26,14,1),(27,9,1),(30,45,0),(31,34,1),(32,41,0),(33,21,0),(34,53,0),(38,48,1),(39,32,1),(43,82,0),(45,31,1),(47,56,1),(48,90,1),(49,42,0),(50,46,1),(52,96,0),(55,38,1),(57,60,0),(58,73,1),(59,14,1),(61,91,0),(63,42,1),(65,64,0),(68,23,0),(73,32,0),(74,2,0),(75,67,0),(76,19,1),(78,99,0),(79,97,1),(81,84,1),(83,60,1),(84,82,0),(88,82,1),(89,70,1),(90,84,1),(91,85,0),(92,32,1),(95,30,0),(96,99,1),(97,25,1),(98,84,1);
/*!40000 ALTER TABLE `user_basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Odell','Carroll','hank.weimann@example.org',89050311728),(2,'Kylie','Frami','amani98@example.com',89235257426),(3,'Rose','Labadie','aniyah69@example.net',89776800693),(4,'Gerda','Schmidt','olga.o\'keefe@example.com',89065834814),(5,'Lane','Nicolas','ernest40@example.net',89421948001),(6,'Emmanuelle','Mayert','mfay@example.com',89646077990),(7,'Tomasa','Hammes','nquigley@example.com',89295594737),(8,'Sandra','Jenkins','tswaniawski@example.net',89544270650),(9,'Nannie','Gibson','mcglynn.earl@example.org',89225865974),(10,'Addison','Walter','rhett.steuber@example.com',89768567034),(11,'Peter','Schroeder','corkery.delfina@example.org',89146266662),(12,'Cathy','Mann','david.jones@example.com',89549615250),(13,'Karlie','Borer','cummings.joan@example.com',89304024216),(14,'Catalina','Huel','lmcclure@example.org',89235629493),(15,'Monroe','Dicki','esmeralda.kirlin@example.net',89628234329),(16,'Dolly','Dare','jenkins.danyka@example.org',89908815898),(17,'Magnolia','Collins','baby80@example.com',89147818693),(18,'Micheal','Hartmann','montana32@example.net',89282785039),(19,'Larue','Daugherty','esteban93@example.com',89781315902),(20,'Tamia','Satterfield','daphne.zulauf@example.net',89096747316),(21,'Jovanny','Nolan','bauch.lila@example.com',89186634655),(22,'Cleta','Homenick','gussie.weimann@example.com',89257742057),(23,'Ned','Blanda','willard.schoen@example.org',89099073233),(24,'Jayme','Gerhold','bergstrom.arely@example.net',89858375476),(25,'Hoyt','Flatley','wconsidine@example.net',89553122216),(26,'Maci','Abernathy','winona25@example.com',89389185271),(27,'Eliane','Hermiston','mathilde.mitchell@example.net',89596802557),(28,'Jack','Weissnat','kuhn.fae@example.com',89723669831),(29,'Alessia','Daugherty','jennie.lebsack@example.org',89018534450),(30,'Aubree','DuBuque','mherman@example.com',89762989781),(31,'Karolann','Walter','kling.caleigh@example.net',89153285706),(32,'Keara','Farrell','deven55@example.org',89288957210),(33,'Yasmine','Batz','arnulfo88@example.org',89317433200),(34,'Antonetta','Sanford','lromaguera@example.org',89055606232),(35,'Danyka','Spinka','korbin57@example.net',89552953463),(36,'Newton','Ward','tevin.bartell@example.org',89687594941),(37,'Robbie','Leuschke','wintheiser.scottie@example.net',89046068302),(38,'Rylan','Gleason','maxwell92@example.net',89743485040),(39,'Felicia','Trantow','raleigh57@example.org',89414426508),(40,'Laila','Corkery','jamal55@example.org',89489985455),(41,'Bryon','Hyatt','kaitlin59@example.com',89892787265),(42,'Tina','Wiza','pschuppe@example.org',89743732544),(43,'Brycen','Reynolds','hwillms@example.org',89303469611),(44,'Angelina','Larson','mante.tillman@example.net',89445481215),(45,'Kimberly','Halvorson','kolby.wilderman@example.org',89588573701),(46,'Anais','Yundt','dietrich.brian@example.com',89493139429),(47,'Merritt','Jast','bode.tianna@example.net',89692320730),(48,'Lexus','Powlowski','christiana.jenkins@example.com',89277429993),(49,'Wilfredo','Brown','dicki.edna@example.net',89540536657),(50,'Moises','Stoltenberg','kiel.dooley@example.net',89618272566),(51,'Electa','Senger','psenger@example.net',89362811114),(52,'Jaylan','Brakus','goyette.annette@example.com',89355780890),(53,'Vanessa','Casper','brendon.ferry@example.com',89061158966),(54,'Cassandre','Hyatt','marion98@example.com',89589134488),(55,'Keara','O\'Hara','hillard.sawayn@example.net',89355224560),(56,'Tatyana','Leffler','ahickle@example.com',89593669999),(57,'Evan','Kihn','sanford.julien@example.com',89303928722),(58,'Maiya','Skiles','bweber@example.com',89298529685),(59,'Laila','Skiles','hal.schmitt@example.com',89302103047),(60,'Florencio','Fahey','gulgowski.laurie@example.net',89614624576),(61,'Iva','Boehm','nichole.gleichner@example.net',89729052921),(62,'Saige','Hayes','purdy.jennings@example.org',89106348338),(63,'Dorthy','Hermann','aspinka@example.net',89582084659),(64,'Julio','Gislason','percy34@example.net',89870042471),(65,'Winona','Braun','bbrekke@example.org',89042266763),(66,'Jeromy','Pfeffer','zack17@example.net',89189169100),(67,'Matilde','Kassulke','yheathcote@example.com',89042065964),(68,'Merlin','Connelly','cummings.vernice@example.net',89713484706),(69,'Ahmed','Hane','jaydon.hand@example.com',89328272664),(70,'Garland','Bosco','brock96@example.org',89867630481),(71,'Muhammad','Leuschke','rfisher@example.org',89116644436),(72,'Stewart','Smith','eldon.d\'amore@example.org',89746398981),(73,'Reyna','Feil','herman.lulu@example.org',89835949802),(74,'Lacey','Rodriguez','otromp@example.net',89625138454),(75,'Aaliyah','Jacobson','hegmann.jessie@example.net',89242143632),(76,'Clara','Deckow','jbecker@example.net',89616549137),(77,'Kallie','Schaden','casimer27@example.com',89534861363),(78,'Nicola','Heaney','jarod.ratke@example.org',89438653706),(79,'Nat','Morissette','clemmie28@example.org',89421120103),(80,'Zion','Reinger','streich.saige@example.net',89858295580),(81,'Jada','Lehner','uhilll@example.com',89645977342),(82,'Merritt','Ryan','braun.arnulfo@example.net',89688627426),(83,'Nella','Kertzmann','flossie00@example.org',89333388946),(84,'Brisa','Harris','frankie.deckow@example.com',89121532496),(85,'Bulah','Rutherford','della36@example.net',89464077136),(86,'Clinton','Hessel','koss.armani@example.com',89432779916),(87,'Manley','Balistreri','altenwerth.henriette@example.org',89471111148),(88,'Frida','Aufderhar','ariel48@example.com',89382784914),(89,'Rocio','Ritchie','cortez.macejkovic@example.org',89382288970),(90,'Beulah','Barton','adella30@example.org',89127802264),(91,'Faustino','Sipes','willms.jennie@example.net',89225253546),(92,'Rodger','Wiegand','harry.hackett@example.net',89660335086),(93,'Lonie','Feil','marguerite61@example.org',89178552328),(94,'Tony','Schinner','jarrell.friesen@example.net',89790924829),(95,'Bailey','Schneider','kgrant@example.org',89746155494),(96,'Devin','Paucek','leatha16@example.org',89445080193),(97,'Zoie','Strosin','jones.kyla@example.net',89014678963),(98,'Aimee','Nienow','desmond.schoen@example.net',89814552245),(99,'Wendell','Leannon','erdman.louie@example.com',89696361506),(100,'Aliyah','Kris','lkutch@example.net',89694329681);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-08 18:03:04



