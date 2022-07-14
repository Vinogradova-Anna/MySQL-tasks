/* 1. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице).*/



-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_22
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
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'velit',1),(2,'consectetur',2),(3,'quisquam',3),(4,'aut',4),(5,'eos',5),(6,'corporis',6),(7,'est',7),(8,'ratione',8),(9,'voluptas',9),(10,'voluptatem',10),(11,'aut',11),(12,'eum',12),(13,'ut',13),(14,'magni',14),(15,'ut',15),(16,'esse',16),(17,'eius',17),(18,'debitis',18),(19,'ut',19),(20,'sed',20);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests` (
  `iniator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`iniator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`iniator_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,1,'requested','1982-05-25 03:01:38','1970-06-04 22:29:36'),(3,15,'declined','1976-07-13 02:04:52','1998-01-15 04:32:10'),(4,8,'requested','2002-01-14 04:54:35','1999-02-07 07:14:10'),(5,7,'approved','1992-02-16 00:02:38','1971-12-19 15:02:02'),(5,14,'unfriended','2009-07-23 14:46:32','1981-05-12 12:06:56'),(6,15,'requested','2016-12-21 08:19:25','2019-10-30 07:29:28'),(8,5,'unfriended','2012-02-24 10:46:36','2003-05-12 11:06:38'),(9,3,'approved','1971-05-21 20:42:58','2020-01-26 21:03:29'),(10,1,'requested','1999-06-27 01:17:39','2003-08-26 13:27:41'),(10,11,'unfriended','2014-11-26 06:19:34','1998-04-07 01:56:55'),(12,13,'requested','1982-06-03 22:12:15','2003-07-06 16:49:14'),(13,19,'declined','2011-09-05 16:03:01','2005-01-02 09:38:14'),(15,17,'declined','1991-04-03 13:50:59','2002-07-08 15:15:09'),(15,18,'approved','2008-04-12 22:47:50','1972-08-03 09:39:38'),(16,13,'unfriended','2016-02-27 00:30:30','1983-09-20 03:55:59'),(16,19,'declined','1998-10-10 03:52:18','1970-03-18 14:27:33'),(17,9,'declined','2012-08-22 04:28:49','1974-08-26 05:08:45'),(20,11,'declined','2022-02-24 05:10:11','1999-07-09 03:19:16'),(20,20,'requested','1998-08-24 21:02:56','1997-09-27 15:53:31');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
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
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,1,1,'1984-07-08 06:42:57'),(2,2,2,'1996-09-04 17:35:35'),(3,3,3,'2007-11-27 12:34:17'),(4,4,4,'2005-02-05 01:49:52'),(5,5,5,'2014-09-17 21:28:19'),(6,6,6,'2009-08-08 02:43:11'),(7,7,7,'1986-09-16 19:09:02'),(8,8,8,'2001-10-03 23:37:52'),(9,9,9,'1998-08-07 10:24:34'),(10,10,10,'1971-12-29 21:49:19'),(11,11,11,'2019-10-06 10:46:38'),(12,12,12,'2006-08-22 08:20:25'),(13,13,13,'2016-12-16 03:49:40'),(14,14,14,'2008-05-26 07:20:19'),(15,15,15,'1987-09-17 13:22:39'),(16,16,16,'1979-08-26 04:38:57'),(17,17,17,'2019-01-24 03:17:16'),(18,18,18,'1979-06-05 18:25:41'),(19,19,19,'1988-01-02 23:17:33'),(20,20,20,'1971-12-28 16:50:45');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,1,'Et quia voluptatibus dicta sed laudantium quia aliquid. Similique fuga voluptate quia et magnam enim suscipit. Dolore rem consequatur labore.','fugit',834665449,NULL,'1978-07-16 18:27:26','1975-05-13 06:23:32'),(2,2,2,'Odio quaerat blanditiis velit explicabo et. Quidem doloremque eveniet iste. Autem esse et et at cumque. Quis distinctio quas inventore mollitia quo.','praesentium',9785020,NULL,'1996-03-03 02:21:42','2019-04-03 02:54:53'),(3,3,3,'Possimus laboriosam harum dolores minima saepe eum. Ut velit expedita qui. Similique et voluptatem molestiae culpa accusantium est aut.','dignissimos',29601984,NULL,'1988-01-15 22:57:13','1975-12-10 23:33:35'),(4,4,4,'Repudiandae eum minus voluptatem et blanditiis in eos iure. Voluptas ut commodi molestias placeat aspernatur aut reprehenderit. Aperiam id qui quia dicta ex possimus maiores. Consequatur minus aut est quisquam tempora.','odio',877,NULL,'2012-08-08 02:11:29','2010-10-28 21:44:47'),(5,1,5,'Sed voluptatem voluptas in pariatur perspiciatis. Vel animi quis dicta voluptates commodi non impedit. Quo dignissimos earum distinctio delectus distinctio quia.','libero',826969309,NULL,'1993-02-15 15:59:08','2006-07-09 09:39:43'),(6,2,6,'Dolor consectetur quis pariatur eligendi minima repudiandae labore nihil. Pariatur omnis omnis est sed consequatur nemo. Dolorem nisi dolor rerum expedita ipsa et. Dolore veritatis fuga et sit eius beatae.','quia',24559,NULL,'1998-05-30 18:27:54','1982-07-31 17:27:31'),(7,3,7,'Tempora rerum voluptatem id minima eligendi. Molestiae autem impedit aliquid dolore. Deleniti saepe nihil aut aut unde atque. Aut omnis ut fuga provident ipsam. Libero doloremque est aut eum explicabo eos rerum.','architecto',9845,NULL,'1984-09-11 05:37:18','2011-10-02 07:53:58'),(8,4,8,'Quidem amet explicabo inventore quo facilis sunt. Tempora dolor voluptatum nam tenetur. Dicta saepe qui sit nihil. Sed commodi aliquid ipsa libero. Dolor non laborum molestiae sunt et autem et vitae.','nihil',51748,NULL,'2012-11-12 11:59:25','1989-09-20 20:43:35'),(9,1,9,'Repellendus consectetur veritatis laudantium eius sed architecto cupiditate. Iusto consequuntur atque fugiat autem facilis quod. Aspernatur eos ipsam enim in incidunt.','consequatur',7483,NULL,'1973-11-08 19:41:01','1970-09-07 08:35:31'),(10,2,10,'Consectetur rerum dignissimos pariatur consequuntur. Unde ad minima possimus amet. Sapiente esse excepturi ea placeat eligendi laudantium qui repellendus.','non',845,NULL,'1983-02-28 02:53:33','1991-09-16 06:39:32'),(11,3,11,'Et nesciunt sunt temporibus neque ipsam similique qui. Qui dolorem harum illo voluptas. Maxime est minus laboriosam molestias ut.','in',776,NULL,'1983-06-11 02:13:09','1971-08-03 19:24:57'),(12,4,12,'Ipsa sit rerum soluta aut qui vitae et. Ut sunt similique voluptatem vitae quis eveniet ipsum. Corporis quia enim aut sint. Similique ut quibusdam quia autem.','ut',2445,NULL,'2002-01-04 09:54:55','2010-08-30 11:49:08'),(13,1,13,'Ad nisi omnis possimus dignissimos. Inventore cum accusantium vel dolorem ea. Et vitae harum quia mollitia delectus. Reiciendis quisquam neque assumenda adipisci est eligendi at.','veritatis',481901595,NULL,'2005-03-13 15:29:39','2000-04-25 01:09:13'),(14,2,14,'Eligendi illo incidunt et quae sed laboriosam. Veniam qui culpa sed sed autem natus. Corporis ratione consectetur eos et saepe. Mollitia atque iusto nisi expedita.','iste',300752,NULL,'1992-10-04 11:45:42','2011-08-28 15:15:35'),(15,3,15,'Iure commodi occaecati animi voluptatum et aut ex dicta. Possimus eligendi enim ipsa quia maxime. Sit dolor praesentium sed repellat magnam illum quia. Est harum aut debitis ipsam sed perspiciatis officia rem.','sapiente',0,NULL,'1987-04-11 14:14:30','1996-10-14 11:51:48'),(16,4,16,'Dicta eligendi velit atque cupiditate voluptas non et. Error sunt occaecati molestiae eum ea fugiat. Voluptatum enim sapiente iusto nostrum ad quo sint accusantium.','cum',8595638,NULL,'2014-01-22 10:13:19','1978-11-29 08:18:22'),(17,1,17,'Consequuntur facilis sint atque rerum alias maiores commodi eum. Error eaque doloremque aperiam esse voluptatem tempore. Saepe magnam ea aut aut. Odio eveniet eius aut accusamus. Officia mollitia officiis vel dolor est accusantium assumenda.','dolorum',404032,NULL,'2022-05-03 08:20:06','1971-05-05 14:15:27'),(18,2,18,'Architecto aut voluptatem et ab qui harum ipsum. Dolor aspernatur quibusdam et. Unde maiores occaecati nihil accusantium illo labore pariatur. Sequi et est tempore in expedita omnis harum excepturi.','amet',586762390,NULL,'2015-04-18 00:10:52','2013-03-29 02:49:23'),(19,3,19,'Repellendus blanditiis dolores sint rem. Omnis et voluptatem rerum in. Architecto officiis omnis repellat quibusdam qui error et. Assumenda ut voluptatem vel nihil.','repellat',2,NULL,'1994-11-25 22:06:14','1991-06-02 00:33:32'),(20,4,20,'Temporibus ipsa nam esse ipsum sapiente voluptas soluta. Distinctio aut recusandae fugiat repudiandae excepturi sed qui. Odio culpa laborum non et. Corporis sit ullam est earum. Quidem voluptatem aut sit tempora.','quas',4,NULL,'1985-04-13 15:34:08','1994-06-10 22:55:45');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'ullam','2014-11-07 11:28:45','2000-05-05 11:58:52'),(2,'quos','1999-01-22 19:30:01','1999-10-23 06:25:12'),(3,'et','2004-12-04 08:06:21','1974-01-18 12:43:02'),(4,'id','1981-11-20 12:42:17','1994-06-27 09:55:51');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,20,16,'Et qui repudiandae totam veniam vel. Cupiditate provident commodi doloribus rerum est. Inventore enim iure pariatur. Ullam ipsum eum nulla unde qui minus molestiae.','1978-01-31 11:13:50'),(2,8,9,'Eos architecto impedit eos est sit voluptas harum. Repellat nam quis aspernatur dolor aperiam. Dolorem itaque repudiandae alias. Architecto voluptates enim officiis ut soluta.','2010-05-08 23:52:24'),(3,15,16,'Quasi autem est eius maiores similique porro dolorem. Qui et dolor quis expedita. Temporibus quia quos velit tempore fuga saepe tenetur. Quos minus fuga quae qui perferendis.','1994-11-01 11:09:45'),(4,9,2,'Sed repudiandae delectus soluta voluptates beatae quis. Aut quis rerum totam aut eum. Rerum consequatur facilis perferendis tenetur facere voluptas ut.','2017-07-05 06:04:39'),(5,10,3,'Nesciunt occaecati commodi sint quisquam. Qui aut nobis ab qui rem itaque pariatur. Molestiae vero accusantium neque modi excepturi aspernatur. Eos atque ut accusamus rem assumenda.','1983-06-15 20:25:33'),(6,13,6,'Aut est soluta aut dicta dolorem. Cum veritatis dolor consequatur doloremque nemo ut reprehenderit. Culpa et mollitia voluptates. Et exercitationem voluptatibus aut dolore tempore et sed.','2009-06-06 02:25:03'),(7,12,11,'Facere vitae velit nemo et expedita ducimus repellat. Ullam est ducimus sapiente neque officiis. Dolorem nulla incidunt doloribus eligendi eveniet sit sequi. Nemo aperiam non illo esse quam quae.','1986-06-07 22:43:43'),(8,5,5,'Dicta ea esse dicta provident. Ut est nostrum at deserunt tempore ipsa. Quia sequi sequi eos aliquid sed sed quos est.','1970-04-27 05:55:08'),(9,10,19,'Alias est qui et. Qui ea rem dicta aspernatur. Iste itaque beatae rerum nesciunt quibusdam at. Temporibus deserunt suscipit corrupti quaerat rem hic totam nisi.','1992-08-27 07:45:20'),(10,12,15,'Nemo asperiores et cum corporis. Eum architecto vel sequi omnis maiores velit qui. Alias voluptas ea possimus magnam quia. Et incidunt itaque debitis enim consectetur iste perspiciatis quibusdam.','2021-06-14 03:28:54'),(11,15,4,'Facilis ducimus adipisci qui voluptatem nobis ad aliquid ratione. Officiis quis soluta dolores voluptas iure. Et sint repellat et vitae voluptatibus.','1992-06-23 14:31:19'),(12,12,4,'Repellat ducimus officiis odio ab. Iure quis et sint quia ratione.','2014-04-16 23:31:26'),(13,2,16,'Dolorem modi non in itaque quo dolore. Exercitationem qui iusto quasi autem rerum ut. Qui enim dolore omnis eos eius non sunt id. Occaecati et quae doloremque sed. Rerum voluptatibus et deserunt vero et eos harum.','2017-03-10 12:16:51'),(14,17,4,'Possimus et consequatur illo placeat sint est atque et. Nobis ratione earum maiores et. Officia voluptatem officiis sed tempore sequi neque cum. Omnis sit doloribus unde earum dolores.','2013-05-15 02:16:18'),(15,18,1,'Molestias incidunt tempora laudantium et qui saepe. A nisi nulla nihil. Accusamus et laudantium eius eligendi et culpa totam.','1974-09-09 16:00:17'),(16,19,18,'Consequuntur ab soluta perferendis. Iure fugit laborum quia ex assumenda. Ducimus et et pariatur suscipit sed enim maiores. Delectus accusantium voluptas exercitationem omnis.','1988-07-15 21:25:13'),(17,16,6,'Maiores distinctio sunt aut doloremque ut. Iure et voluptatibus asperiores et ut totam labore.','1991-10-22 16:13:22'),(18,7,10,'Sint qui quidem omnis ut est. Accusantium quia itaque totam ut. Accusamus quis ratione totam vitae et eum est. Vitae nihil delectus sit voluptatem.','2001-03-11 13:24:20'),(19,1,15,'Minus non amet et soluta. Facilis nam quaerat ad. Sunt ut neque laborum unde.','2021-12-19 08:54:13'),(20,11,11,'Rerum modi hic corrupti ut sequi. Delectus vero sed aut laboriosam voluptatibus voluptates iure. Nihil reprehenderit quos nesciunt occaecati.','2017-06-27 23:54:05');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'reiciendis',9),(2,'nisi',9),(3,'omnis',20),(4,'mollitia',14),(5,'ea',2),(6,'asperiores',16),(7,'reiciendis',1),(8,'ut',12),(9,'corrupti',2),(10,'ipsa',8),(11,'consectetur',5),(12,'assumenda',5),(13,'iusto',9),(14,'consectetur',8),(15,'debitis',13),(16,'distinctio',9),(17,'perspiciatis',10),(18,'iure',17),(19,'dicta',11),(20,'enim',1);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),(11,11,11),(12,12,12),(13,13,13),(14,14,14),(15,15,15),(16,16,16),(17,17,17),(18,18,18),(19,19,19),(20,20,20);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_photo_id` (`photo_id`),
  CONSTRAINT `fk_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,NULL,'2010-02-03',1,'1994-01-08 02:01:44',NULL),(2,NULL,'1973-10-05',2,'1987-02-16 04:59:18',NULL),(3,NULL,'1991-11-15',3,'2020-01-22 03:41:12',NULL),(4,NULL,'1993-09-10',4,'2020-11-26 02:00:42',NULL),(5,NULL,'2014-10-21',5,'1998-03-25 21:26:33',NULL),(6,NULL,'1975-02-10',6,'2018-06-06 22:23:50',NULL),(7,NULL,'2001-07-05',7,'1993-02-14 02:46:52',NULL),(8,NULL,'1978-07-02',8,'2014-03-02 02:47:24',NULL),(9,NULL,'1981-11-08',9,'1974-09-17 14:09:22',NULL),(10,NULL,'2014-01-23',10,'2017-10-06 05:21:30',NULL),(11,NULL,'2020-01-17',11,'2017-12-31 21:59:10',NULL),(12,NULL,'2001-11-08',12,'2006-07-06 08:06:31',NULL),(13,NULL,'1982-01-28',13,'2012-01-10 04:40:21',NULL),(14,NULL,'1972-02-13',14,'1986-09-05 23:15:25',NULL),(15,NULL,'2003-08-19',15,'1991-03-06 12:15:19',NULL),(16,NULL,'1997-02-16',16,'1992-04-22 07:51:09',NULL),(17,NULL,'2004-12-26',17,'1977-02-28 19:17:53',NULL),(18,NULL,'2005-06-05',18,'2009-07-14 14:08:36',NULL),(19,NULL,'2017-08-04',19,'1975-01-10 12:46:30',NULL),(20,NULL,'1977-03-13',20,'2005-08-12 18:54:57',NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
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
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Р¤Р°РјРёР»РёСЏ',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Freeman','Jast','west.corrine@example.com','fa7b5a981233c276292d68dfbc8c6954ceedb7dc',9407447146,'\0'),(2,'Unique','Howe','raynor.archibald@example.com','f566deee4847e0db1e1f3066fc3ce99829bd604b',9929972190,''),(3,'Xander','Daniel','schmeler.cyrus@example.org','dd32f87257cc8420aff1f907d0543d9432b791dd',9671115235,'\0'),(4,'Whitney','Williamson','bo.donnelly@example.net','edb41a5e9914f84c3a2d0ea1a328c7a8c695d3e7',9162004050,''),(5,'Howell','Dietrich','gheller@example.org','efb4036c4578f1637d14bcba4e5a1bd5608711b7',9172604008,'\0'),(6,'Christy','McGlynn','margarett.o\'hara@example.net','6477f4091cbb1b1789db6a47aefa2842761844ac',9431771245,'\0'),(7,'Melvin','Wehner','parisian.nyah@example.com','62a7f23f50d7fdcef54cc438d0c31431b33cb9bf',9102381568,'\0'),(8,'Randal','Haag','marilyne.schoen@example.org','ae7a12111e22d54488bc9c392aab702a11781def',9309707345,'\0'),(9,'Orpha','Auer','kutch.leanne@example.org','c52d02d847b2984ee84e18e2a5c09a275121a966',9988383061,''),(10,'Jesus','Schmidt','shane.hilpert@example.org','d3a32a73c588bb82eb0c21ead18a7760149f05b1',9919958023,'\0'),(11,'Jaquan','Corwin','aaron36@example.net','c8dd11bb8602141284df699fb6b84f194eda2de3',9737287370,''),(12,'Amalia','Nolan','lane26@example.com','904e8d5b716172d35f099db4148cbbb4f283079d',9488221806,''),(13,'Alfonzo','Koch','violette49@example.org','55adbedf44b072d011b349f5bc22863531ee8614',9678517463,''),(14,'Sandra','Metz','mo\'hara@example.net','277639359555108cdf249c030a97cd717ac73f11',9546348070,''),(15,'Sallie','Quigley','marcus.abshire@example.net','0e6c3abd9a88814ef3b113bdf9a06733e64a36cb',9566314766,'\0'),(16,'Daphnee','Zboncak','maude.marquardt@example.org','114f403cb3fe5a5404be66df35d9ae6a8fae39c9',9788791150,'\0'),(17,'Ethyl','Rosenbaum','koepp.abdullah@example.org','59a5f3804c2f895728562b44220767fef09ef57f',9456234663,'\0'),(18,'Betty','Glover','erica81@example.org','102450473b936d1af2e11d66cecef7fa37d18bed',9845168802,''),(19,'Gudrun','Paucek','jaydon95@example.com','2a19d220f34847ccd900922d430ddbdfc4fc4170',9345138306,'\0'),(20,'Trenton','Leuschke','collin26@example.com','ad5b42d7765825547d4c3d2a5f83ce570eda057c',9177019581,'');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (4,8),(4,11),(5,4),(5,9),(7,9),(8,14),(9,14),(9,15),(10,15),(12,17),(15,9),(17,11),(17,12),(18,1),(18,7),(19,7),(19,12),(20,10),(20,16);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-09 16:35:00
