-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.37-1ubuntu5


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema Speech2Text
--

CREATE DATABASE IF NOT EXISTS DRPSim;
USE DRPSim;

--
-- Definition of table `DRPSim`.`UserRoles`
--

DROP TABLE IF EXISTS `DRPSim`.`UserRoles`;
CREATE TABLE  `DRPSim`.`UserRoles` (
  `UserId` binary(16) NOT NULL,
  `Role` int(11) NOT NULL,
  KEY `fk_UserRoles_Users` (`UserId`),
  CONSTRAINT `fk_UserRoles_Users` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `DRPSim`.`UserRoles`
--

/*!40000 ALTER TABLE `UserRoles` DISABLE KEYS */;
LOCK TABLES `UserRoles` WRITE;
INSERT INTO `DRPSim`.`UserRoles` VALUES  (0xB393A2E12D5A3C4699729CBF00258971,0),
 (0xB393A2E12D5A3C4699729CBF00258971,1);
UNLOCK TABLES;
/*!40000 ALTER TABLE `UserRoles` ENABLE KEYS */;


--
-- Definition of table `Speech2Text`.`Users`
--

DROP TABLE IF EXISTS `DRPSim`.`Users`;
CREATE TABLE  `DRPSim`.`Users` (
  `Id` binary(16) NOT NULL,
  `UserName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `EMail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `PasswordSalt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LastSuccessfulLoginDate` datetime DEFAULT NULL,
  `IncorrectPasswordAttemptCount` int(11) NOT NULL,
  `LastPasswordChangeDate` datetime NOT NULL,
  `IsLocked` tinyint(1) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `DRPSim`.`Users`
--

/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
LOCK TABLES `Users` WRITE;
INSERT INTO `DRPSim`.`Users` VALUES  (0xB393A2E12D5A3C4699729CBF00258971,'admin','Admin','admin@admin.com','aFIaolZPE4Vbnio3pmAD+tYifME=','7QtmI2L6lZ5Mui0LGM6jkg==',NULL,0,'2009-11-19 00:00:00',0,'2009-11-19 00:00:00',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
