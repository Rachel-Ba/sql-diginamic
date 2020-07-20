-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 20 juil. 2020 à 16:06
-- Version du serveur :  10.4.13-MariaDB
-- Version de PHP : 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `compta`
--
CREATE DATABASE IF NOT EXISTS `compta` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `compta`;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `REF` varchar(13) NOT NULL,
  `DESIGNATION` varchar(255) NOT NULL,
  `PRIX` decimal(7,2) NOT NULL,
  `ID_FOU` int(10) NOT NULL,
  `ID_COMPO` int(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_COMPOART` (`ID_COMPO`),
  KEY `FK_FOUART` (`ID_FOU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `bon`
--

DROP TABLE IF EXISTS `bon`;
CREATE TABLE IF NOT EXISTS `bon` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `NUMERO` int(10) NOT NULL,
  `DATE_CMDE` int(10) NOT NULL,
  `DELAI` int(10) NOT NULL,
  `ID_FOU` int(10) NOT NULL,
  `ID_COMPO` int(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_COMPOBON` (`ID_COMPO`),
  KEY `FK_FOUBON` (`ID_FOU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `compo`
--

DROP TABLE IF EXISTS `compo`;
CREATE TABLE IF NOT EXISTS `compo` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `QTE` int(10) NOT NULL,
  `ID_ART` int(10) NOT NULL,
  `ID_BON` int(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ARTBON` (`ID_BON`),
  KEY `FK_ARTCOMPO` (`ID_ART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(50) NOT NULL,
  `ID_ART` int(10) NOT NULL,
  `ID_BON` int(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_BONFOU` (`ID_BON`),
  KEY `FK_ARTFOUR` (`ID_ART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `FK_COMPOART` FOREIGN KEY (`ID_COMPO`) REFERENCES `compo` (`ID`),
  ADD CONSTRAINT `FK_FOUART` FOREIGN KEY (`ID_FOU`) REFERENCES `article` (`ID`);

--
-- Contraintes pour la table `bon`
--
ALTER TABLE `bon`
  ADD CONSTRAINT `FK_COMPOBON` FOREIGN KEY (`ID_COMPO`) REFERENCES `compo` (`ID`),
  ADD CONSTRAINT `FK_FOUBON` FOREIGN KEY (`ID_FOU`) REFERENCES `fournisseur` (`ID`);

--
-- Contraintes pour la table `compo`
--
ALTER TABLE `compo`
  ADD CONSTRAINT `FK_ARTBON` FOREIGN KEY (`ID_BON`) REFERENCES `bon` (`ID`),
  ADD CONSTRAINT `FK_ARTCOMPO` FOREIGN KEY (`ID_ART`) REFERENCES `compo` (`ID`);

--
-- Contraintes pour la table `fournisseur`
--
ALTER TABLE `fournisseur`
  ADD CONSTRAINT `FK_ARTFOUR` FOREIGN KEY (`ID_ART`) REFERENCES `article` (`ID`),
  ADD CONSTRAINT `FK_BONFOU` FOREIGN KEY (`ID_BON`) REFERENCES `bon` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
