-- phpMyAdmin SQL Dump
-- version 3.1.2deb1ubuntu0.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 12 feb, 2010 at 02:10 PM
-- Versione MySQL: 5.0.75
-- Versione PHP: 5.2.6-3ubuntu4.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `aurox_vuoto`
--
CREATE DATABASE `aurox_vuoto` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `aurox_vuoto`;

-- --------------------------------------------------------

--
-- Struttura della tabella `allevamentis`
--

CREATE TABLE IF NOT EXISTS `allevamentis` (
  `id` int(11) NOT NULL auto_increment,
  `ragsoc` varchar(50) NOT NULL,
  `if` varchar(20) NOT NULL,
  `cod317` varchar(8) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `allevamentis`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `animals`
--

CREATE TABLE IF NOT EXISTS `animals` (
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
  `uscito` int(11) NOT NULL default '0',
  `registro` tinyint(1) NOT NULL default '0',
  `file` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `animals`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `contatoris`
--

CREATE TABLE IF NOT EXISTS `contatoris` (
  `id` int(11) NOT NULL auto_increment,
  `mod4usc` varchar(10) NOT NULL,
  `pagregcar` varchar(10) NOT NULL,
  `pagregscar` varchar(10) NOT NULL,
  `progreg` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `contatoris`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `ingressos`
--

CREATE TABLE IF NOT EXISTS `ingressos` (
  `codice` int(11) NOT NULL,
  `descr` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `ingressos`
--

INSERT INTO `ingressos` (`codice`, `descr`) VALUES
(1, 'NASCITA'),
(2, 'COMPRAVENDITA'),
(19, 'CAMBIO ANAGRAFICA'),
(13, 'PRIMA IMPORTAZIONE'),
(23, 'RIENTRO PAESE ESTERO'),
(24, 'COMPRAVENDITA ENTRATA FIERA O MERCATO'),
(25, 'COMPRAVENDITA ENTRATA DA CENTRO GENETICO'),
(26, 'COMPRAVENDITA ENTRATA DA STALLA DI SOSTA'),
(32, 'PRIMA IMPORTAZIONE UE CON CEDOLA');

-- --------------------------------------------------------

--
-- Struttura della tabella `luncampis`
--

CREATE TABLE IF NOT EXISTS `luncampis` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dump dei dati per la tabella `luncampis`
--

INSERT INTO `luncampis` (`id`, `tipo`, `operazione`, `cod317`, `ragsoc`, `tifragsoc`, `ifragsoc`, `atp`, `prop`, `tifprop`, `ifprop`, `marca`, `specie`, `razza`, `nascita`, `cod317nascita`, `sesso`, `nazorig`, `nazprimimp`, `applmarca`, `ilg`, `marcaprec`, `madre`, `padre`, `datapass`, `codmoving`, `dataing`, `cod317prov`, `comuneprov`, `nazprov`, `codmovusc`, `datausc`, `cod317dest`, `comunedest`, `nazdest`, `ragsocdest`, `trasportatore`, `comunetrasp`, `targatrasp`, `mod4`, `marcasost`, `idfiscall`, `datamod4`, `codlibgen`, `regmac`, `idfiscmac`, `bollomac`, `embryo`, `idfisc317nasc`, `dataprimoingr`, `madreembryotransf`, `rifloc`, `certsan`, `crlf`) VALUES
(1, 1, 1, 8, 50, 1, 16, 3, 50, 1, 16, 14, 3, 3, 8, 8, 1, 3, 3, 8, 1, 14, 14, 14, 8, 3, 8, 8, 5, 3, 3, 8, 8, 5, 3, 50, 50, 5, 20, 30, 14, 16, 8, 8, 3, 16, 16, 1, 16, 8, 14, 20, 30, 30);

-- --------------------------------------------------------

--
-- Struttura della tabella `macellis`
--

CREATE TABLE IF NOT EXISTS `macellis` (
  `id` int(11) NOT NULL auto_increment,
  `nomemac` varchar(50) NOT NULL,
  `ifmac` varchar(24) NOT NULL,
  `bollomac` varchar(20) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `macellis`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `nations`
--

CREATE TABLE IF NOT EXISTS `nations` (
  `id` int(11) NOT NULL auto_increment,
  `codice` varchar(2) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `tipo` int(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=51 ;

--
-- Dump dei dati per la tabella `nations`
--

INSERT INTO `nations` (`id`, `codice`, `nome`, `tipo`) VALUES
(1, 'AD', 'ANDORRA', 0),
(2, 'AL', 'ALBANIA', 0),
(3, 'AM', 'ARMENIA', 0),
(4, 'AT', 'AUSTRIA', 1),
(5, 'BA', 'BOSNIA AND HERZEGOVINA', 0),
(6, 'BE', 'BELGIO', 1),
(7, 'BG', 'BULGARIA', 1),
(8, 'CH', 'SVIZZERA', 0),
(9, 'CS', 'SERBIA E MONTENEGRO', 0),
(10, 'CY', 'CIPRO', 1),
(11, 'CZ', 'REPUBBLICA CECA', 0),
(12, 'DE', 'GERMANIA', 1),
(13, 'DK', 'DANIMARCA', 1),
(14, 'EE', 'ESTONIA', 1),
(15, 'ES', 'SPAGNA', 1),
(16, 'FI', 'FINLANDIA', 1),
(17, 'FR', 'FRANCIA', 1),
(18, 'GE', 'GEORGIA', 0),
(19, 'GR', 'GRECIA', 1),
(20, 'HR', 'CROAZIA', 0),
(21, 'HU', 'UNGHERIA', 1),
(22, 'IE', 'IRLANDA', 1),
(23, 'IL', 'ISRAELE', 0),
(24, 'IT', 'ITALIA', 1),
(25, 'KG', 'KYRGYZSTAN', 0),
(26, 'KZ', 'KAZAKISTAN', 0),
(27, 'LI', 'LIECHTENSTEIN', 0),
(28, 'LT', 'LITHUANIA', 1),
(29, 'LU', 'LUSSEMBURGO', 1),
(30, 'LV', 'LETTONIA', 1),
(31, 'MD', 'MOLDAVIA', 0),
(32, 'MK', 'MACEDONIA', 0),
(33, 'MN', 'MONGOLIA', 0),
(34, 'MT', 'MALTA', 1),
(35, 'NL', 'OLANDA', 1),
(36, 'NO', 'NORVEGIA', 0),
(37, 'NZ', 'NUOVA ZELANDA', 0),
(38, 'PL', 'POLONIA', 1),
(39, 'PT', 'PORTOGALLO', 1),
(40, 'RO', 'ROMANIA', 1),
(41, 'RU', 'FEDERAZIONE RUSSA', 0),
(42, 'SE', 'SVEZIA', 1),
(43, 'SI', 'SLOVENIA', 1),
(44, 'SK', 'REPUBBLICA SLOVACCA', 1),
(45, 'SM', 'SAN MARINO', 1),
(46, 'TR', 'TURCHIA', 0),
(47, 'UA', 'UCRAINA', 0),
(48, 'UK', 'GRAN BRETAGNA', 1),
(49, 'UZ', 'UZBEKISTAN', 0),
(50, 'YU', 'YUGOSLAVIA', 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `props`
--

CREATE TABLE IF NOT EXISTS `props` (
  `id` int(11) NOT NULL auto_increment,
  `prop` varchar(50) NOT NULL,
  `codfisc` varchar(20) default NULL,
  `piva` varchar(20) default NULL,
  `if` varchar(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `props`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `ragsocs`
--

CREATE TABLE IF NOT EXISTS `ragsocs` (
  `id` int(11) NOT NULL auto_increment,
  `ragsoc` varchar(50) NOT NULL,
  `codfisc` varchar(20) default NULL,
  `piva` varchar(20) default NULL,
  `if` varchar(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `ragsocs`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `razzas`
--

CREATE TABLE IF NOT EXISTS `razzas` (
  `id` int(11) NOT NULL auto_increment,
  `cod_razza` varchar(3) NOT NULL,
  `razza` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=89 ;

--
-- Dump dei dati per la tabella `razzas`
--

INSERT INTO `razzas` (`id`, `cod_razza`, `razza`) VALUES
(1, 'AAG', 'ANGUS'),
(2, 'ABC', 'AUBRAC'),
(3, 'ABO', 'ABONDANCE'),
(4, 'AGE', 'AGEROLESE'),
(5, 'ALT', 'ALENTEJANA'),
(6, 'ANG', 'ANGLER'),
(7, 'ARM', 'ARMORICAINE'),
(8, 'ATR', 'ASTURIANA'),
(9, 'AVI', 'AVILENANEGRAIBERICA'),
(10, 'AYR', 'AYRSHIRE'),
(11, 'BAQ', 'BLONDED''ACQUITAINE/GARONNESE'),
(12, 'BBL', 'BLUBELGA'),
(13, 'BFM', 'BUFALO MEDITERRANEO'),
(14, 'BFN', 'BUFALO NON MEDITERRANEO'),
(15, 'BGW', 'BELTEDGALLOWAY'),
(16, 'BKO', 'BLAARKOP(WHITEHEADED)'),
(17, 'BRE', 'BELGIANRED'),
(18, 'BRM', 'BRAHMAN'),
(19, 'BRN', 'BRUNA'),
(20, 'BRT', 'BRETONEPIE-NOIRE'),
(21, 'BUR', 'BURLINA'),
(22, 'BVP', 'BIANCAVALPADANA/MODENESE'),
(23, 'BZD', 'BAZZADAIS'),
(24, 'CAB', 'CABANNINA'),
(25, 'CAL', 'CALVANA'),
(26, 'CAS', 'VALDOSTANACASTANA'),
(27, 'CHL', 'CHAROLAIS'),
(28, 'CIA', 'CHIANINA'),
(29, 'CIN', 'CINISARA'),
(30, 'CMG', 'CAMARGUE'),
(31, 'DEV', 'DEVON'),
(32, 'DRW', 'DANISH RED'),
(33, 'DXT', 'DEXTER'),
(34, 'FRS', 'FRISONA (HOLSTEIN)'),
(35, 'GAF', 'GARFAGNINA'),
(36, 'GCN', 'GUASCONE'),
(37, 'GLW', 'GALLOWAY'),
(38, 'GRD', 'GRIGIA VAL D''ADIGE'),
(39, 'GRL', 'GRIGIAALPINA'),
(40, 'GUS', 'GUERNSEY'),
(41, 'HEF', 'HEREFORD'),
(42, 'HER', 'HERENS'),
(43, 'HLA', 'HIGHLAND'),
(44, 'ITS', 'ITASUOMENKARJA'),
(45, 'JES', 'JERSEY'),
(46, 'LAN', 'LANSISUOMENKARJA'),
(47, 'LHO', 'LONGHORN'),
(48, 'LKV', 'LAKENVELDER'),
(49, 'LMS', 'LIMOUSINE'),
(50, 'MAJ', 'MAINEANJOU'),
(51, 'MAL', 'MALKEBORTHORN'),
(52, 'MCG', 'MARCHIGIANA'),
(53, 'MDC', 'MODICANA'),
(54, 'MDS', 'SARDO-MODICANA'),
(55, 'MRN', 'MAREMMANA'),
(56, 'MRY', 'PEZZATAROSSADELLAMOSA-RENO-YSSEL'),
(57, 'MSH', 'SHORTHORN'),
(58, 'MTL', 'MERTOLENGA'),
(59, 'MTT', 'METICCIO/INCROCIO'),
(60, 'MWF', 'MURNAU-WERDENFELSER'),
(61, 'NMD', 'NORMANNA'),
(62, 'NRD', 'NORWEGIANRED'),
(63, 'PDC', 'PODOLICA'),
(64, 'PGR', 'PINZGAUER'),
(65, 'PIS', 'PISANA'),
(66, 'PMT', 'PIEMONTESE'),
(67, 'PNR', 'ALTRE RAZZE PEZZATE NERE'),
(68, 'POH', 'POHJOISSUOMENKARJA'),
(69, 'PON', 'PONTREMOLESE'),
(70, 'PRO', 'PEZZATAROSSAD''OROPA'),
(71, 'PRP', 'PIEROUGEDESPLAINES'),
(72, 'PRS', 'ALTRERAZZEPEZZATEROSSE'),
(73, 'RBG', 'RUBIAGALLEGA'),
(74, 'REN', 'RENDENA'),
(75, 'RGG', 'REGGIANA'),
(76, 'RMG', 'ROMAGNOLA'),
(77, 'SAL', 'SALERS'),
(78, 'SIM', 'PEZZATA ROSSA ITALIANA SIMMENTAL'),
(79, 'SPT', 'SPRINZENFUSTERTALLER'),
(80, 'SRB', 'SARDO BRUNA'),
(81, 'SRW', 'SWEDISHREDANDWHITE'),
(82, 'TAR', 'TARINA'),
(83, 'UNK', 'NONINDICATA'),
(84, 'VPN', 'VALDOSTANAPEZZATANERA'),
(85, 'VPR', 'VALDOSTANAPEZZATAROSSA'),
(86, 'VTO', 'VARZESE / TORTONESE / OTTONESE'),
(87, 'WEB', 'WELSH BLACK'),
(88, 'ZZZ', 'ALTRERAZZE');

-- --------------------------------------------------------

--
-- Struttura della tabella `regions`
--

CREATE TABLE IF NOT EXISTS `regions` (
  `id` int(11) NOT NULL auto_increment,
  `codreg` varchar(3) NOT NULL,
  `regione` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dump dei dati per la tabella `regions`
--

INSERT INTO `regions` (`id`, `codreg`, `regione`) VALUES
(1, '010', 'PIEMONTE'),
(2, '020', 'VALLE D''AOSTA'),
(3, '030', 'LOMBARDIA'),
(4, '050', 'VENETO'),
(5, '060', 'FRIULI VENEZIA GIULIA'),
(6, '070', 'LIGURIA'),
(7, '080', 'EMILIA ROMAGNA'),
(8, '090', 'TOSCANA'),
(9, '100', 'UMBRIA'),
(10, '110', 'MARCHE'),
(11, '120', 'LAZIO'),
(12, '130', 'ABRUZZO'),
(13, '140', 'MOLISE'),
(14, '150', 'CAMPANIA'),
(15, '160', 'PUGLIA'),
(16, '170', 'BASILICATA'),
(17, '180', 'CALABRIA'),
(18, '190', 'SICILIA'),
(19, '200', 'SARDEGNA'),
(20, '041', 'TRENTINO - ALTO ADIGE (BZ)'),
(21, '042', 'TRENTINO - ALTO ADIGE (TN)'),
(22, '000', 'STATO ESTERO');

-- --------------------------------------------------------

--
-- Struttura della tabella `registros`
--

CREATE TABLE IF NOT EXISTS `registros` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `registros`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `relazs`
--

CREATE TABLE IF NOT EXISTS `relazs` (
  `id` int(11) NOT NULL auto_increment,
  `stalle_id` int(11) NOT NULL,
  `ragsoc_id` int(11) NOT NULL,
  `prop_id` int(11) NOT NULL,
  `contatori_id` int(11) NOT NULL,
  `atp` varchar(3) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `relazs`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `stalles`
--

CREATE TABLE IF NOT EXISTS `stalles` (
  `id` int(11) NOT NULL auto_increment,
  `cod317` varchar(8) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `stalles`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `trasportatoris`
--

CREATE TABLE IF NOT EXISTS `trasportatoris` (
  `id` int(11) NOT NULL auto_increment,
  `nometrasp` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `trasportatoris`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `uscites`
--

CREATE TABLE IF NOT EXISTS `uscites` (
  `codice` int(11) NOT NULL,
  `descr` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `uscites`
--

INSERT INTO `uscites` (`codice`, `descr`) VALUES
(3, 'COMPRAVENDITA'),
(4, 'MORTE (decesso in azienda)'),
(6, 'FURTO'),
(9, 'MACELLAZIONE'),
(20, 'CAMBIO ANAGRAFICA USCITA'),
(10, 'ABBATTIMENTO CON CONTRIBUTO'),
(11, 'ABBATTIMENTO SENZA CONTRIBUTO'),
(16, 'COMPRAVENDITA VERSO ESTERO'),
(28, 'COMPRAVENDITA USCITA VERSO FIERA O MERCATO'),
(29, 'COMPRAVENDITA USCITA VERSO CENTRO GENETICO'),
(30, 'COMPRAVENDITA USCITA VERSO STALLA DI SOSTA');
