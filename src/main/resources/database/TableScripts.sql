CREATE TABLE `ChannelUserLocationReport` (
  `UserLocRptID` bigint(20) DEFAULT NULL,
  `FKtoUserIncLocDtlID` bigint(20) DEFAULT NULL,
  `furnishOtherLocationDetails` text,
  `Txt` text,
  KEY `FK_ChUserIncRpt_FKUserIncLocDtlID_idx` (`FKtoUserIncLocDtlID`),
  KEY `FK_ChUserLocRpt_FKUserIncLocDtlID_idx` (`FKtoUserIncLocDtlID`),
  CONSTRAINT `FK_ChUserLocRpt_FKUserIncLocDtlID` FOREIGN KEY (`FKtoUserIncLocDtlID`) REFERENCES `ChannelUserIncidentAndLocation` (`ChannelUserIncAndLocID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ChannelUserDetails` (
  `ChannelUserDetailsID` bigint(20) NOT NULL,
  `FKUserID` bigint(20) DEFAULT NULL,
  `UserChannelLoginID` text,
  `FKChannelID` bigint(20) DEFAULT NULL,
  `UserChannelFirstName` text,
  `UserChannelLastName` bigint(20) DEFAULT NULL,
  `CreatedDate` date DEFAULT NULL,
  `ReportingASID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ChannelUserDetailsID`),
  KEY `FK_ChannelUserDetails_FKUserID_idx` (`FKUserID`),
  KEY `FK_ChannelUserDetails_FKChannelID_idx` (`FKChannelID`),
  KEY `FK_ChannelUserDetails_ReportingASID_idx` (`ReportingASID`),
  CONSTRAINT `FK_ChannelUserDetails_FKChannelID` FOREIGN KEY (`FKChannelID`) REFERENCES `Channels` (`ChannelID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChannelUserDetails_FKUserID` FOREIGN KEY (`FKUserID`) REFERENCES `User` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChannelUserDetails_ReportingASID` FOREIGN KEY (`ReportingASID`) REFERENCES `UserType` (`UserTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ChannelUserIncidentAndLocation` (
  `ChannelUserIncAndLocID` bigint(20) NOT NULL,
  `FKtoChannelUserDtlID` bigint(20) DEFAULT NULL,
  `FKtoIncidentTypeID` bigint(20) DEFAULT NULL,
  `UserReportedSeverity` int(11) DEFAULT NULL,
  `UserReportedPriority` int(11) DEFAULT NULL,
  `LocationLatitude` decimal(11,8) DEFAULT NULL,
  `LocationLangitude` decimal(11,8) DEFAULT NULL,
  `LocationName` text,
  `LocationDesc` text,
  `LocationGoogleMapDesc` text,
  `FKIncidcentCovTypeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ChannelUserIncAndLocID`),
  KEY `FK_ChannelUserIncAndLoc_FKtoChannelUserDtlID_idx` (`FKtoChannelUserDtlID`),
  KEY `FK_ChannelUserIncAndLoc_FKtoIncidentTypeID_idx` (`FKtoIncidentTypeID`),
  KEY `FK_ChannelUserIncAndLoc_FKIncidcentCovTypeID_idx` (`FKIncidcentCovTypeID`),
  CONSTRAINT `FK_ChannelUserIncAndLoc_FKIncidcentCovTypeID` FOREIGN KEY (`FKIncidcentCovTypeID`) REFERENCES `IncidentCoverageType` (`IncCoverageID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChannelUserIncAndLoc_FKtoChannelUserDtlID` FOREIGN KEY (`FKtoChannelUserDtlID`) REFERENCES `ChannelUserDetails` (`ChannelUserDetailsID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChannelUserIncAndLoc_FKtoIncidentTypeID` FOREIGN KEY (`FKtoIncidentTypeID`) REFERENCES `Incident` (`IncId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ChannelUserIncidentReport` (
  `UserIncRptID` bigint(20) NOT NULL,
  `FKUserIncLocDtlID` bigint(20) DEFAULT NULL,
  `VictimFirstName` varchar(45) DEFAULT NULL,
  `VictimLastName` varchar(45) DEFAULT NULL,
  `IdentificationDetails` varchar(45) DEFAULT NULL,
  `HospitalName` varchar(45) DEFAULT NULL,
  `PoliceStationName` varchar(45) DEFAULT NULL,
  `DoctorName` varchar(45) DEFAULT NULL,
  `AuthorityName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UserIncRptID`),
  KEY `FK_ChUserIncRpt_FKUserIncLocDtlID_idx` (`FKUserIncLocDtlID`),
  CONSTRAINT `FK_ChUserIncRpt_FKUserIncLocDtlID` FOREIGN KEY (`FKUserIncLocDtlID`) REFERENCES `ChannelUserIncidentAndLocation` (`ChannelUserIncAndLocID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Channels` (
  `ChannelID` bigint(20) NOT NULL,
  `ChannelName` bigint(20) DEFAULT NULL,
  `ChannelDesc` text,
  PRIMARY KEY (`ChannelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `City` (
  `CityID` bigint(20) NOT NULL AUTO_INCREMENT,
  `cityName` varchar(45) DEFAULT NULL,
  `FKStateID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`CityID`),
  UNIQUE KEY `CityID_UNIQUE` (`CityID`),
  KEY `FK_State_ID_idx` (`FKStateID`),
  CONSTRAINT `FK_State_ID` FOREIGN KEY (`FKStateID`) REFERENCES `State` (`StateID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Country` (
  `CountryID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CountryName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CountryID`),
  UNIQUE KEY `CountryID_UNIQUE` (`CountryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Incident` (
  `IncId` bigint(20) NOT NULL,
  `IncidentTypeName` text COMMENT 'Accident/Fire/',
  `IncidentSeverity` int(11) DEFAULT NULL,
  `IncidentPriority` int(11) DEFAULT NULL,
  PRIMARY KEY (`IncId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `IncidentCoverageType` (
  `IncCoverageID` int(11) NOT NULL,
  `IncCoveragereTypeName` text COMMENT 'City/State/National/Street/Area/Building',
  PRIMARY KEY (`IncCoverageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `State` (
  `StateID` bigint(20) NOT NULL,
  `StateName` varchar(45) DEFAULT NULL,
  `FKCountryID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`StateID`),
  KEY `FK_Country_ID_idx` (`FKCountryID`),
  CONSTRAINT `FK_Country_ID` FOREIGN KEY (`FKCountryID`) REFERENCES `Country` (`CountryID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `User` (
  `UserId` bigint(20) NOT NULL,
  `UserFirstName` char(1) DEFAULT NULL,
  `UserLastName` char(1) DEFAULT NULL,
  `UserMobileNumber` text,
  `UserPriContactPer` text,
  `UserSecContacctPer` text,
  `isUserRegistered` tinyint(1) DEFAULT NULL,
  `FKUserTypeID` int(11) DEFAULT NULL,
  `FKCityID` bigint(20) DEFAULT NULL,
  `FKStateID` bigint(20) DEFAULT NULL,
  `FKCountryID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`UserId`),
  KEY `FK_USER_UserTypeID_idx` (`FKUserTypeID`),
  KEY `FK_User_FKCityID_idx` (`FKCityID`),
  KEY `FK_User_FKStateID_idx` (`FKStateID`),
  KEY `FK_User_FKCountryID_idx` (`FKCountryID`),
  CONSTRAINT `FK_USER_UserTypeID` FOREIGN KEY (`FKUserTypeID`) REFERENCES `UserType` (`UserTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_User_FKCityID` FOREIGN KEY (`FKCityID`) REFERENCES `City` (`CityID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_User_FKCountryID` FOREIGN KEY (`FKCountryID`) REFERENCES `Country` (`CountryID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_User_FKStateID` FOREIGN KEY (`FKStateID`) REFERENCES `State` (`StateID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `UserType` (
  `UserTypeId` int(11) NOT NULL,
  `UserTypeName` text COMMENT 'Victim/Reporter/Admin/System',
  PRIMARY KEY (`UserTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

