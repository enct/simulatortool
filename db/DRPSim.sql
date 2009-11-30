-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.41-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema drpsim
--

CREATE DATABASE IF NOT EXISTS drpsim;
USE drpsim;

--
-- Definition of table `loadprofiledata`
--

DROP TABLE IF EXISTS `loadprofiledata`;
CREATE TABLE `loadprofiledata` (
  `LoadProfileId` binary(16) NOT NULL,
  `StartTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `Consumption` double NOT NULL,
  KEY `fk_data_loadprofile` (`LoadProfileId`),
  CONSTRAINT `fk_data_loadprofile` FOREIGN KEY (`LoadProfileId`) REFERENCES `loadprofiles` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `loadprofiledata`
--

/*!40000 ALTER TABLE `loadprofiledata` DISABLE KEYS */;
/*!40000 ALTER TABLE `loadprofiledata` ENABLE KEYS */;


--
-- Definition of table `loadprofiles`
--

DROP TABLE IF EXISTS `loadprofiles`;
CREATE TABLE `loadprofiles` (
  `Id` binary(16) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` longtext,
  `AddedByUserId` binary(16) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_loadprofile_addedbyuser` (`AddedByUserId`),
  CONSTRAINT `fk_loadprofile_addedbyuser` FOREIGN KEY (`AddedByUserId`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `loadprofiles`
--

/*!40000 ALTER TABLE `loadprofiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `loadprofiles` ENABLE KEYS */;


--
-- Definition of table `userroles`
--

DROP TABLE IF EXISTS `userroles`;
CREATE TABLE `userroles` (
  `UserId` binary(16) NOT NULL,
  `Role` int(11) NOT NULL,
  KEY `fk_UserRoles_Users` (`UserId`),
  CONSTRAINT `fk_UserRoles_Users` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `userroles`
--

/*!40000 ALTER TABLE `userroles` DISABLE KEYS */;
INSERT INTO `userroles` (`UserId`,`Role`) VALUES 
 (0xB393A2E12D5A3C4699729CBF00258971,0),
 (0xB393A2E12D5A3C4699729CBF00258971,1);
/*!40000 ALTER TABLE `userroles` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
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
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`Id`,`UserName`,`Name`,`EMail`,`Password`,`PasswordSalt`,`LastSuccessfulLoginDate`,`IncorrectPasswordAttemptCount`,`LastPasswordChangeDate`,`IsLocked`,`DateCreated`,`DateUpdated`) VALUES 
 (0xB393A2E12D5A3C4699729CBF00258971,'admin','Admin','admin@admin.com','aFIaolZPE4Vbnio3pmAD+tYifME=','7QtmI2L6lZ5Mui0LGM6jkg==',NULL,0,'2009-11-19 00:00:00',0,'2009-11-19 00:00:00',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
