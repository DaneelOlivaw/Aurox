-- MySQL dump 10.13  Distrib 5.1.62, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: aurox
-- ------------------------------------------------------
-- Server version	5.1.62-0ubuntu0.11.04.1-log

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
-- Table structure for table `allevamentis`
--

DROP TABLE IF EXISTS `allevamentis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allevamentis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ragsoc` varchar(50) NOT NULL,
  `idfisc` varchar(20) NOT NULL,
  `cod317` varchar(8) NOT NULL,
  `via` varchar(50) DEFAULT NULL,
  `comune` varchar(50) DEFAULT NULL,
  `provincia` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allevamentis`
--

LOCK TABLES `allevamentis` WRITE;
/*!40000 ALTER TABLE `allevamentis` DISABLE KEYS */;
/*!40000 ALTER TABLE `allevamentis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animals`
--

DROP TABLE IF EXISTS `animals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relaz_id` int(11) NOT NULL,
  `tipo` varchar(1) NOT NULL,
  `cm_ing` int(11) DEFAULT NULL,
  `marca` varchar(14) NOT NULL,
  `specie` varchar(3) NOT NULL,
  `razza_id` int(11) NOT NULL,
  `data_nas` date NOT NULL,
  `stalla_nas` varchar(8) NOT NULL,
  `sesso` varchar(1) NOT NULL,
  `naz_orig` varchar(2) NOT NULL,
  `naz_nasprimimp` varchar(2) NOT NULL,
  `data_applm` date DEFAULT NULL,
  `ilg` varchar(1) DEFAULT NULL,
  `embryo` varchar(1) DEFAULT NULL,
  `marca_prec` varchar(14) DEFAULT NULL,
  `marca_madre` varchar(14) DEFAULT NULL,
  `marca_padre` varchar(14) DEFAULT NULL,
  `donatrice` varchar(14) DEFAULT NULL,
  `clg` varchar(30) DEFAULT NULL,
  `data_ingr` date DEFAULT NULL,
  `naz_prov` varchar(2) DEFAULT NULL,
  `certsan` varchar(30) DEFAULT NULL,
  `rifloc` varchar(50) DEFAULT NULL,
  `allevamenti_id` int(11) DEFAULT NULL,
  `mod4` varchar(20) DEFAULT NULL,
  `data_mod4` date DEFAULT NULL,
  `cm_usc` int(11) DEFAULT NULL,
  `uscita` date DEFAULT NULL,
  `ditta_racc` varchar(50) DEFAULT NULL,
  `trasp` varchar(50) DEFAULT NULL,
  `marcasost` varchar(14) DEFAULT NULL,
  `data_certsan` date DEFAULT NULL,
  `naz_dest` varchar(2) DEFAULT NULL,
  `macelli_id` int(11) DEFAULT NULL,
  `certsanusc` varchar(20) DEFAULT NULL,
  `data_certsanusc` date DEFAULT NULL,
  `idcoll` int(11) DEFAULT NULL COMMENT 'id del movimento collegato (se ingresso, avrÃ  quello dell''uscita o vuoto se non Ã¨ uscito, se uscita sarÃ  l''ingresso corrispondente)',
  `uscito` int(11) NOT NULL DEFAULT '0',
  `registro` tinyint(1) NOT NULL DEFAULT '0',
  `file` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animals`
--

LOCK TABLES `animals` WRITE;
/*!40000 ALTER TABLE `animals` DISABLE KEYS */;
/*!40000 ALTER TABLE `animals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detentoris`
--

DROP TABLE IF EXISTS `detentoris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detentoris` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detentore` varchar(50) NOT NULL,
  `codfisc` varchar(20) DEFAULT NULL,
  `piva` varchar(20) DEFAULT NULL,
  `idf` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detentoris`
--

LOCK TABLES `detentoris` WRITE;
/*!40000 ALTER TABLE `detentoris` DISABLE KEYS */;
/*!40000 ALTER TABLE `detentoris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingressos`
--

DROP TABLE IF EXISTS `ingressos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingressos` (
  `codice` int(11) NOT NULL,
  `descr` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingressos`
--

LOCK TABLES `ingressos` WRITE;
/*!40000 ALTER TABLE `ingressos` DISABLE KEYS */;
INSERT INTO `ingressos` VALUES (1,'NASCITA'),(2,'COMPRAVENDITA'),(19,'CAMBIO ANAGRAFICA'),(13,'PRIMA IMPORTAZIONE'),(23,'RIENTRO PAESE ESTERO'),(24,'COMPRAVENDITA ENTRATA FIERA O MERCATO'),(25,'COMPRAVENDITA ENTRATA DA CENTRO GENETICO'),(26,'COMPRAVENDITA ENTRATA DA STALLA DI SOSTA'),(32,'PRIMA IMPORTAZIONE UE CON CEDOLA');
/*!40000 ALTER TABLE `ingressos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `luncampis`
--

DROP TABLE IF EXISTS `luncampis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `luncampis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` int(20) DEFAULT NULL,
  `operazione` int(20) DEFAULT NULL,
  `cod317` int(20) DEFAULT NULL,
  `ragsoc` int(20) DEFAULT NULL,
  `tifragsoc` int(20) DEFAULT NULL,
  `ifragsoc` int(20) DEFAULT NULL,
  `atp` int(20) DEFAULT NULL,
  `prop` int(20) DEFAULT NULL,
  `tifprop` int(20) DEFAULT NULL,
  `ifprop` int(20) DEFAULT NULL,
  `marca` int(20) DEFAULT NULL,
  `specie` int(20) DEFAULT NULL,
  `razza` int(20) DEFAULT NULL,
  `nascita` int(20) DEFAULT NULL,
  `cod317nascita` int(20) DEFAULT NULL,
  `sesso` int(20) DEFAULT NULL,
  `nazorig` int(20) DEFAULT NULL,
  `nazprimimp` int(20) DEFAULT NULL,
  `applmarca` int(20) DEFAULT NULL,
  `ilg` int(20) DEFAULT NULL,
  `marcaprec` int(20) DEFAULT NULL,
  `madre` int(20) DEFAULT NULL,
  `padre` int(20) DEFAULT NULL,
  `datapass` int(20) DEFAULT NULL,
  `codmoving` int(20) DEFAULT NULL,
  `dataing` int(20) DEFAULT NULL,
  `cod317prov` int(20) DEFAULT NULL,
  `comuneprov` int(20) DEFAULT NULL,
  `nazprov` int(20) DEFAULT NULL,
  `codmovusc` int(20) DEFAULT NULL,
  `datausc` int(20) DEFAULT NULL,
  `cod317dest` int(20) DEFAULT NULL,
  `comunedest` int(20) DEFAULT NULL,
  `nazdest` int(20) DEFAULT NULL,
  `ragsocdest` int(20) DEFAULT NULL,
  `trasportatore` int(20) DEFAULT NULL,
  `comunetrasp` int(20) DEFAULT NULL,
  `targatrasp` int(20) DEFAULT NULL,
  `mod4` int(20) DEFAULT NULL,
  `marcasost` int(20) DEFAULT NULL,
  `idfiscall` int(20) DEFAULT NULL,
  `datamod4` int(20) DEFAULT NULL,
  `codlibgen` int(20) DEFAULT NULL,
  `regmac` int(20) DEFAULT NULL,
  `idfiscmac` int(20) DEFAULT NULL,
  `bollomac` int(20) DEFAULT NULL,
  `embryo` int(20) DEFAULT NULL,
  `idfisc317nasc` int(20) DEFAULT NULL,
  `dataprimoingr` int(20) DEFAULT NULL,
  `madreembryotransf` int(20) DEFAULT NULL,
  `rifloc` int(11) NOT NULL,
  `certsan` int(11) NOT NULL,
  `crlf` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luncampis`
--

LOCK TABLES `luncampis` WRITE;
/*!40000 ALTER TABLE `luncampis` DISABLE KEYS */;
INSERT INTO `luncampis` VALUES (1,1,1,8,50,1,16,3,50,1,16,14,3,3,8,8,1,3,3,8,1,14,14,14,8,3,8,8,5,3,3,8,8,5,3,50,50,5,20,30,14,16,8,8,3,16,16,1,16,8,14,30,30,2);
/*!40000 ALTER TABLE `luncampis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `macellis`
--

DROP TABLE IF EXISTS `macellis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `macellis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomemac` varchar(50) NOT NULL,
  `ifmac` varchar(24) NOT NULL,
  `bollomac` varchar(20) NOT NULL,
  `region_id` int(11) NOT NULL,
  `via` varchar(50) DEFAULT NULL,
  `comune` varchar(50) DEFAULT NULL,
  `provincia` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `macellis`
--

LOCK TABLES `macellis` WRITE;
/*!40000 ALTER TABLE `macellis` DISABLE KEYS */;
/*!40000 ALTER TABLE `macellis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nations`
--

DROP TABLE IF EXISTS `nations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codice` varchar(2) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `tipo` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nations`
--

LOCK TABLES `nations` WRITE;
/*!40000 ALTER TABLE `nations` DISABLE KEYS */;
INSERT INTO `nations` VALUES (1,'AD','ANDORRA',0),(2,'AL','ALBANIA',0),(3,'AM','ARMENIA',0),(4,'AT','AUSTRIA',1),(5,'BA','BOSNIA AND HERZEGOVINA',0),(6,'BE','BELGIO',1),(7,'BG','BULGARIA',1),(8,'CH','SVIZZERA',0),(9,'CS','SERBIA E MONTENEGRO',0),(10,'CY','CIPRO',1),(11,'CZ','REPUBBLICA CECA',0),(12,'DE','GERMANIA',1),(13,'DK','DANIMARCA',1),(14,'EE','ESTONIA',1),(15,'ES','SPAGNA',1),(16,'FI','FINLANDIA',1),(17,'FR','FRANCIA',1),(18,'GE','GEORGIA',0),(19,'GR','GRECIA',1),(20,'HR','CROAZIA',0),(21,'HU','UNGHERIA',1),(22,'IE','IRLANDA',1),(23,'IL','ISRAELE',0),(24,'IT','ITALIA',1),(25,'KG','KYRGYZSTAN',0),(26,'KZ','KAZAKISTAN',0),(27,'LI','LIECHTENSTEIN',0),(28,'LT','LITHUANIA',1),(29,'LU','LUSSEMBURGO',1),(30,'LV','LETTONIA',1),(31,'MD','MOLDAVIA',0),(32,'MK','MACEDONIA',0),(33,'MN','MONGOLIA',0),(34,'MT','MALTA',1),(35,'NL','OLANDA',1),(36,'NO','NORVEGIA',0),(37,'NZ','NUOVA ZELANDA',0),(38,'PL','POLONIA',1),(39,'PT','PORTOGALLO',1),(40,'RO','ROMANIA',1),(41,'RU','FEDERAZIONE RUSSA',0),(42,'SE','SVEZIA',1),(43,'SI','SLOVENIA',1),(44,'SK','REPUBBLICA SLOVACCA',1),(45,'SM','SAN MARINO',1),(46,'TR','TURCHIA',0),(47,'UA','UCRAINA',0),(48,'UK','GRAN BRETAGNA',1),(49,'UZ','UZBEKISTAN',0),(50,'YU','YUGOSLAVIA',0);
/*!40000 ALTER TABLE `nations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `props`
--

DROP TABLE IF EXISTS `props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `props` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prop` varchar(50) NOT NULL,
  `codfisc` varchar(20) DEFAULT NULL,
  `piva` varchar(20) DEFAULT NULL,
  `idf` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `props`
--

LOCK TABLES `props` WRITE;
/*!40000 ALTER TABLE `props` DISABLE KEYS */;
/*!40000 ALTER TABLE `props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ragsocs`
--

DROP TABLE IF EXISTS `ragsocs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ragsocs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ragsoc` varchar(50) NOT NULL,
  `codfisc` varchar(20) DEFAULT NULL,
  `piva` varchar(20) DEFAULT NULL,
  `idf` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ragsocs`
--

LOCK TABLES `ragsocs` WRITE;
/*!40000 ALTER TABLE `ragsocs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ragsocs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `razzas`
--

DROP TABLE IF EXISTS `razzas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `razzas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cod_razza` varchar(3) NOT NULL,
  `razza` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `razzas`
--

LOCK TABLES `razzas` WRITE;
/*!40000 ALTER TABLE `razzas` DISABLE KEYS */;
INSERT INTO `razzas` VALUES (1,'AAG','ANGUS'),(2,'ABC','AUBRAC'),(3,'ABO','ABONDANCE'),(4,'AGE','AGEROLESE'),(5,'ALT','ALENTEJANA'),(6,'ANG','ANGLER'),(7,'ARM','ARMORICAINE'),(8,'ATR','ASTURIANA'),(9,'AVI','AVILENA NEGRA IBERICA'),(10,'AYR','AYRSHIRE'),(11,'BAQ','BLONDE D\'ACQUITAINE / GARONNESE'),(12,'BBL','BLU BELGA'),(13,'BFM','BUFALO MEDITERRANEO'),(14,'BFN','BUFALO NON MEDITERRANEO'),(15,'BGW','BELTED GALLOWAY'),(16,'BKO','BLAARKOP (WHITEHEADED)'),(17,'BRE','BELGIAN RED'),(18,'BRM','BRAHMAN'),(19,'BRN','BRUNA'),(20,'BRT','BRETONE PIE-NOIRE'),(21,'BUR','BURLINA'),(22,'BVP','BIANCA VALPADANA / MODENESE'),(23,'BZD','BAZZADAIS'),(24,'CAB','CABANNINA'),(25,'CAL','CALVANA'),(26,'CAS','VALDOSTANA CASTANA'),(27,'CHL','CHAROLAIS'),(28,'CIA','CHIANINA'),(29,'CIN','CINISARA'),(30,'CMG','CAMARGUE'),(31,'DEV','DEVON'),(32,'DRW','DANISH RED'),(33,'DXT','DEXTER'),(34,'FRS','FRISONA (HOLSTEIN)'),(35,'GAF','GARFAGNINA'),(36,'GCN','GUASCONE'),(37,'GLW','GALLOWAY'),(38,'GRD','GRIGIA VAL D\'ADIGE'),(39,'GRL','GRIGIA ALPINA'),(40,'GUS','GUERNSEY'),(41,'HEF','HEREFORD'),(42,'HER','HERENS'),(43,'HLA','HIGHLAND'),(44,'ITS','ITASUOMENKARJA'),(45,'JES','JERSEY'),(46,'LAN','LANSISUOMENKARJA'),(47,'LHO','LONGHORN'),(48,'LKV','LAKENVELDER'),(49,'LMS','LIMOUSINE'),(50,'MAJ','MAINEANJOU'),(51,'MAL','MALKEBORTHORN'),(52,'MCG','MARCHIGIANA'),(53,'MDC','MODICANA'),(54,'MDS','SARDO-MODICANA'),(55,'MRN','MAREMMANA'),(56,'MRY','PEZZATA ROSSA DELLA MOSA-RENO-YSSEL'),(57,'MSH','SHORTHORN'),(58,'MTL','MERTOLENGA'),(59,'MTT','METICCIO / INCROCIO'),(60,'MWF','MURNAU-WERDENFELSER'),(61,'NMD','NORMANNA'),(62,'NRD','NORWEGIAN RED'),(63,'PDC','PODOLICA'),(64,'PGR','PINZGAUER'),(65,'PIS','PISANA'),(66,'PMT','PIEMONTESE'),(67,'PNR','ALTRE RAZZE PEZZATE NERE'),(68,'POH','POHJOISSUOMENKARJA'),(69,'PON','PONTREMOLESE'),(70,'PRO','PEZZATA ROSSA D\'OROPA'),(71,'PRP','PIE ROUGE DES PLAINES'),(72,'PRS','ALTRE RAZZE PEZZATE ROSSE'),(73,'RBG','RUBIA GALLEGA'),(74,'REN','RENDENA'),(75,'RGG','REGGIANA'),(76,'RMG','ROMAGNOLA'),(77,'SAL','SALERS'),(78,'SIM','PEZZATA ROSSA ITALIANA SIMMENTAL'),(79,'SPT','SPRINZEN FUSTERTALLER'),(80,'SRB','SARDO BRUNA'),(81,'SRW','SWEDISH RED AND WHITE'),(82,'TAR','TARINA'),(83,'UNK','NON INDICATA'),(84,'VPN','VALDOSTANA PEZZATA NERA'),(85,'VPR','VALDOSTANA PEZZATA ROSSA'),(86,'VTO','VARZESE / TORTONESE / OTTONESE'),(87,'WEB','WELSH BLACK'),(88,'ZZZ','ALTRE RAZZE');
/*!40000 ALTER TABLE `razzas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codreg` varchar(3) NOT NULL,
  `regione` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES (1,'010','PIEMONTE'),(2,'020','VALLE D\'AOSTA'),(3,'030','LOMBARDIA'),(4,'050','VENETO'),(5,'060','FRIULI VENEZIA GIULIA'),(6,'070','LIGURIA'),(7,'080','EMILIA ROMAGNA'),(8,'090','TOSCANA'),(9,'100','UMBRIA'),(10,'110','MARCHE'),(11,'120','LAZIO'),(12,'130','ABRUZZO'),(13,'140','MOLISE'),(14,'150','CAMPANIA'),(15,'160','PUGLIA'),(16,'170','BASILICATA'),(17,'180','CALABRIA'),(18,'190','SICILIA'),(19,'200','SARDEGNA'),(20,'041','TRENTINO - ALTO ADIGE (BZ)'),(21,'042','TRENTINO - ALTO ADIGE (TN)'),(22,'000','STATO ESTERO');
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registros`
--

DROP TABLE IF EXISTS `registros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relaz_id` int(11) NOT NULL,
  `progressivo` varchar(11) NOT NULL,
  `marca` varchar(14) NOT NULL,
  `razza` varchar(3) NOT NULL,
  `sesso` varchar(1) NOT NULL,
  `madre` varchar(14) NOT NULL,
  `tipoingresso` varchar(1) NOT NULL,
  `datanascita` date NOT NULL,
  `dataingresso` date NOT NULL,
  `provenienza` varchar(50) NOT NULL,
  `tipouscita` varchar(1) DEFAULT NULL,
  `datauscita` date DEFAULT NULL,
  `destinazione` varchar(50) DEFAULT NULL,
  `marcaprec` varchar(14) DEFAULT NULL,
  `mod4ingr` varchar(20) DEFAULT NULL,
  `mod4usc` varchar(20) DEFAULT NULL,
  `certsaningr` varchar(30) DEFAULT NULL,
  `certsanusc` varchar(30) DEFAULT NULL,
  `ragsoc` varchar(50) NOT NULL,
  `stampacarico` tinyint(1) NOT NULL DEFAULT '0',
  `stampascarico` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registros`
--

LOCK TABLES `registros` WRITE;
/*!40000 ALTER TABLE `registros` DISABLE KEYS */;
/*!40000 ALTER TABLE `registros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relazs`
--

DROP TABLE IF EXISTS `relazs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relazs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stalle_id` int(11) NOT NULL,
  `ragsoc_id` int(11) NOT NULL,
  `detentori_id` int(11) NOT NULL DEFAULT '0',
  `prop_id` int(11) NOT NULL,
  `atp` varchar(3) NOT NULL,
  `mod4usc` varchar(10) NOT NULL DEFAULT '0/00',
  `progreg` varchar(10) NOT NULL DEFAULT '0/00',
  `ultimoreg` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relazs`
--

LOCK TABLES `relazs` WRITE;
/*!40000 ALTER TABLE `relazs` DISABLE KEYS */;
/*!40000 ALTER TABLE `relazs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stalles`
--

DROP TABLE IF EXISTS `stalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stalles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cod317` varchar(8) NOT NULL,
  `via` varchar(50) DEFAULT NULL,
  `comune` varchar(50) DEFAULT NULL,
  `provincia` varchar(2) DEFAULT NULL,
  `region_id` int(11) NOT NULL,
  `ulss` int(11) NOT NULL,
  `citta_ulss` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stalles`
--

LOCK TABLES `stalles` WRITE;
/*!40000 ALTER TABLE `stalles` DISABLE KEYS */;
/*!40000 ALTER TABLE `stalles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trasportatoris`
--

DROP TABLE IF EXISTS `trasportatoris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trasportatoris` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nometrasp` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trasportatoris`
--

LOCK TABLES `trasportatoris` WRITE;
/*!40000 ALTER TABLE `trasportatoris` DISABLE KEYS */;
/*!40000 ALTER TABLE `trasportatoris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uscites`
--

DROP TABLE IF EXISTS `uscites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uscites` (
  `codice` int(11) NOT NULL,
  `descr` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uscites`
--

LOCK TABLES `uscites` WRITE;
/*!40000 ALTER TABLE `uscites` DISABLE KEYS */;
INSERT INTO `uscites` VALUES (3,'COMPRAVENDITA'),(4,'MORTE (decesso in azienda)'),(6,'FURTO'),(9,'MACELLAZIONE'),(20,'CAMBIO ANAGRAFICA USCITA'),(10,'ABBATTIMENTO CON CONTRIBUTO'),(11,'ABBATTIMENTO SENZA CONTRIBUTO'),(16,'COMPRAVENDITA VERSO ESTERO'),(28,'COMPRAVENDITA USCITA VERSO FIERA O MERCATO'),(29,'COMPRAVENDITA USCITA VERSO CENTRO GENETICO'),(30,'COMPRAVENDITA USCITA VERSO STALLA DI SOSTA');
/*!40000 ALTER TABLE `uscites` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-01-17 10:05:27
