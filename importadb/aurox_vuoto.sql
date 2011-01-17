-- MySQL dump 10.11
--
-- Host: localhost    Database: aurox
-- ------------------------------------------------------
-- Server version	5.0.75-0ubuntu10.5

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `allevamentis` (
  `id` int(11) NOT NULL auto_increment,
  `ragsoc` varchar(50) NOT NULL,
  `idfisc` varchar(20) NOT NULL,
  `cod317` varchar(8) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `animals` (
  `id` int(11) NOT NULL auto_increment,
  `relaz_id` int(11) NOT NULL,
  `tipo` varchar(1) NOT NULL,
  `cm_ing` int(11) default NULL,
  `marca` varchar(14) NOT NULL,
  `specie` varchar(3) NOT NULL,
  `razza_id` int(11) NOT NULL,
  `data_nas` date NOT NULL,
  `stalla_nas` varchar(8) NOT NULL,
  `sesso` varchar(1) NOT NULL,
  `naz_orig` varchar(2) NOT NULL,
  `naz_nasprimimp` varchar(2) NOT NULL,
  `data_applm` date default NULL,
  `ilg` varchar(1) default NULL,
  `embryo` varchar(1) default NULL,
  `marca_prec` varchar(14) default NULL,
  `marca_madre` varchar(14) default NULL,
  `marca_padre` varchar(14) default NULL,
  `donatrice` varchar(14) default NULL,
  `clg` varchar(30) default NULL,
  `data_ingr` date default NULL,
  `naz_prov` varchar(2) default NULL,
  `certsan` varchar(30) default NULL,
  `rifloc` varchar(50) default NULL,
  `allevamenti_id` int(11) default NULL,
  `mod4` varchar(20) default NULL,
  `data_mod4` date default NULL,
  `cm_usc` int(11) default NULL,
  `uscita` date default NULL,
  `ditta_racc` varchar(50) default NULL,
  `trasp` varchar(50) default NULL,
  `marcasost` varchar(14) default NULL,
  `data_certsan` date default NULL,
  `naz_dest` varchar(2) default NULL,
  `macelli_id` int(11) default NULL,
  `certsanusc` varchar(20) default NULL,
  `data_certsanusc` date default NULL,
  `idcoll` int(11) default NULL COMMENT 'id del movimento collegato (se ingresso, avrà quello dell''uscita o vuoto se non è uscito, se uscita sarà l''ingresso corrispondente)',
  `uscito` int(11) NOT NULL default '0',
  `registro` tinyint(1) NOT NULL default '0',
  `file` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `animals`
--

LOCK TABLES `animals` WRITE;
/*!40000 ALTER TABLE `animals` DISABLE KEYS */;
/*!40000 ALTER TABLE `animals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contatoris`
--

DROP TABLE IF EXISTS `contatoris`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `contatoris` (
  `id` int(11) NOT NULL auto_increment,
  `mod4usc` varchar(10) NOT NULL,
  `pagregcar` varchar(10) NOT NULL,
  `pagregscar` varchar(10) NOT NULL,
  `pagreg` varchar(10) NOT NULL,
  `progreg` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `contatoris`
--

LOCK TABLES `contatoris` WRITE;
/*!40000 ALTER TABLE `contatoris` DISABLE KEYS */;
/*!40000 ALTER TABLE `contatoris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingressos`
--

DROP TABLE IF EXISTS `ingressos`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ingressos` (
  `codice` int(11) NOT NULL,
  `descr` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `luncampis` (
  `id` int(11) NOT NULL auto_increment,
  `tipo` int(20) default NULL,
  `operazione` int(20) default NULL,
  `cod317` int(20) default NULL,
  `ragsoc` int(20) default NULL,
  `tifragsoc` int(20) default NULL,
  `ifragsoc` int(20) default NULL,
  `atp` int(20) default NULL,
  `prop` int(20) default NULL,
  `tifprop` int(20) default NULL,
  `ifprop` int(20) default NULL,
  `marca` int(20) default NULL,
  `specie` int(20) default NULL,
  `razza` int(20) default NULL,
  `nascita` int(20) default NULL,
  `cod317nascita` int(20) default NULL,
  `sesso` int(20) default NULL,
  `nazorig` int(20) default NULL,
  `nazprimimp` int(20) default NULL,
  `applmarca` int(20) default NULL,
  `ilg` int(20) default NULL,
  `marcaprec` int(20) default NULL,
  `madre` int(20) default NULL,
  `padre` int(20) default NULL,
  `datapass` int(20) default NULL,
  `codmoving` int(20) default NULL,
  `dataing` int(20) default NULL,
  `cod317prov` int(20) default NULL,
  `comuneprov` int(20) default NULL,
  `nazprov` int(20) default NULL,
  `codmovusc` int(20) default NULL,
  `datausc` int(20) default NULL,
  `cod317dest` int(20) default NULL,
  `comunedest` int(20) default NULL,
  `nazdest` int(20) default NULL,
  `ragsocdest` int(20) default NULL,
  `trasportatore` int(20) default NULL,
  `comunetrasp` int(20) default NULL,
  `targatrasp` int(20) default NULL,
  `mod4` int(20) default NULL,
  `marcasost` int(20) default NULL,
  `idfiscall` int(20) default NULL,
  `datamod4` int(20) default NULL,
  `codlibgen` int(20) default NULL,
  `regmac` int(20) default NULL,
  `idfiscmac` int(20) default NULL,
  `bollomac` int(20) default NULL,
  `embryo` int(20) default NULL,
  `idfisc317nasc` int(20) default NULL,
  `dataprimoingr` int(20) default NULL,
  `madreembryotransf` int(20) default NULL,
  `rifloc` int(11) NOT NULL,
  `certsan` int(11) NOT NULL,
  `crlf` int(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `macellis` (
  `id` int(11) NOT NULL auto_increment,
  `nomemac` varchar(50) NOT NULL,
  `ifmac` varchar(24) NOT NULL,
  `bollomac` varchar(20) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `nations` (
  `id` int(11) NOT NULL auto_increment,
  `codice` varchar(2) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `tipo` int(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `props` (
  `id` int(11) NOT NULL auto_increment,
  `prop` varchar(50) NOT NULL,
  `codfisc` varchar(20) default NULL,
  `piva` varchar(20) default NULL,
  `idf` varchar(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ragsocs` (
  `id` int(11) NOT NULL auto_increment,
  `ragsoc` varchar(50) NOT NULL,
  `codfisc` varchar(20) default NULL,
  `piva` varchar(20) default NULL,
  `idf` varchar(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `razzas` (
  `id` int(11) NOT NULL auto_increment,
  `cod_razza` varchar(3) NOT NULL,
  `razza` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `regions` (
  `id` int(11) NOT NULL auto_increment,
  `codreg` varchar(3) NOT NULL,
  `regione` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `registros` (
  `id` int(11) NOT NULL auto_increment,
  `relaz_id` int(11) NOT NULL,
  `contatori_id` int(11) NOT NULL,
  `progressivo` varchar(11) NOT NULL,
  `marca` varchar(14) NOT NULL,
  `razza` varchar(3) NOT NULL,
  `sesso` varchar(1) NOT NULL,
  `madre` varchar(14) NOT NULL,
  `tipoingresso` varchar(1) NOT NULL,
  `datanascita` date NOT NULL,
  `dataingresso` date NOT NULL,
  `provenienza` varchar(50) NOT NULL,
  `tipouscita` varchar(1) default NULL,
  `datauscita` date default NULL,
  `destinazione` varchar(50) default NULL,
  `marcaprec` varchar(14) default NULL,
  `mod4ingr` varchar(20) default NULL,
  `mod4usc` varchar(20) default NULL,
  `certsaningr` varchar(30) default NULL,
  `certsanusc` varchar(30) default NULL,
  `ragsoc` varchar(50) NOT NULL,
  `stampacarico` tinyint(1) NOT NULL default '0',
  `stampascarico` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `relazs` (
  `id` int(11) NOT NULL auto_increment,
  `stalle_id` int(11) NOT NULL,
  `ragsoc_id` int(11) NOT NULL,
  `prop_id` int(11) NOT NULL,
  `contatori_id` int(11) NOT NULL,
  `atp` varchar(3) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stalles` (
  `id` int(11) NOT NULL auto_increment,
  `cod317` varchar(8) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `trasportatoris` (
  `id` int(11) NOT NULL auto_increment,
  `nometrasp` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uscites` (
  `codice` int(11) NOT NULL,
  `descr` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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

-- Dump completed on 2011-01-17 14:45:35
