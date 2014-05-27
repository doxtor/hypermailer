-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hyper_mailer
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.13.10.2

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
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaigns` (
  `campaign_id` int(11) NOT NULL AUTO_INCREMENT,
  `datasource_view_id` int(11) DEFAULT NULL,
  `mg_campaign_id` varchar(16) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `date_started` date DEFAULT NULL,
  `domain` varchar(64) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES (13,2,'ceqxu','Golf Card May Newsleter','Test Using the May Newsleter from responsys','2014-05-14',NULL,'golfcard.com',6,'  <p>Dear Kirk,</p>\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <br/>\r\n        <img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/thank_you.jpg\" alt=\"Thank You\" style=\"width:130px;height:130px;border:none;padding:0 0 0 12px;float:right;\">\r\n        <span style=\"font-family:Lucida Calligraphy,Brush Script MT;color:#0066CC;font-weight:bold;font-size:14pt;\">\r\n            This Month’s Newsletter is dedicated to the men and women serving our country and to the memory of those that paid the ultimate sacrifice for our freedom. Thank You!\r\n        </span>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p style=\"text-align:left\">\r\n            In this month’s Newsletter, we will explain some of the benefits of being a Golf Card member. Every month the Newsletter will feature new courses and any information\r\n            or new benefit that may pertain to your Golf Card Players Card. If there is something you wish to have added to the Newsletter or if you have an idea on how it can be improved,\r\n            please do not hesitate to contact us.  We value your membership and appreciate any suggestions you may have. Please feel free to email them to <a href=\"mailto:office@golfcard.com\" target=\"_blank\">office@golfcard.com</a>.\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;\">\r\n        <p style=\"color:green;text-align:center;font-size:28pt;font-weight:bold;\">New Courses:</p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p>\r\n            <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSS&_ei_=EgOSPfqfcHS9vB5gwtNSBis.\" target=\"_blank\" style=\"font-size:16pt;font-weight:bold;text-decoration:none;\">\r\n            <strong>The Ranch Golf Club – Southwick, MA</strong></a><br>\r\n            413-569-9333<br><br>\r\n            <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSS&_ei_=EgOSPfqfcHS9vB5gwtNSBis.\" target=\"_blank\"><img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/ranch_golf_club.jpg\" alt=\"The Ranch Golf Club – Southwick, MA\" style=\"border: none;padding: 4px 12px 4px 4px;width: 200px;height: 150px;text-align: right;float: left;\"></a>\r\n            A spectacular golf course built on a beautiful piece of land. The Ranch Golf Club was voted by Golf Digest as the best public golf course in Massachusetts\r\n            in 07-08 and is currently ranked as the 47th best public golf course in America. This is such a great course, with a great offer for our members. Fantastic May offers.\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p>\r\n            <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBST&_ei_=EvvpbfVCw_zCnTSw6oao2YY.\" target=\"_blank\" style=\"font-family:Calibri,Palatino Linotype,Book Antiqua,Palatino,serif;font-size:18pt;font-weight:bold;text-decoration:none;\">\r\n            <strong>Blackstone Golf Course – Mossy Head, FL</strong></a><br>\r\n            850-520-4670<br><br>\r\n            <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBST&_ei_=EvvpbfVCw_zCnTSw6oao2YY.\" target=\"_blank\"><img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/blackstone.jpg\" alt=\"Blackstone Golf Course – Mossy Head, FL\" style=\"border: none;padding: 4px 4px 4px 12px;width: 200px;height: 150px;text-align: right;float: right;\"></a>\r\n            Blackstone Golf Course is the new player friendly Golf Course in Walton County. The course is carved through rolling terrain giving golfers a unique experience that\r\n            they will not soon forget. The course architect, Bill Ammick, Designed the course to provide an enjoyable experience to all skill levels of golfers. We know when you\r\n            come experience a round at Blackstone Golf Course, you will be back to play again.\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;\">\r\n        <p>\r\n            You can also <a href=\"http://www.golfcard.com/courses/new_courses\" target=\"_blank\"><span style=\"color:blue;font-weight:bold;text-decoration:none;\">Click Here</span></a> to see all of Golf Card International newest Golf Courses.\r\n            This page is being updated regularly with exciting new courses that are bringing more value to Golf Card members.\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;\">\r\n        <p style=\"color:green;text-align:center;font-size:28pt;font-weight:bold;margin-bottom:0;\">May Special:</p>\r\n        <p style=\"color:#36c;text-align:center;font-size:18pt;font-weight:bold;\">\r\n            Mondays $25 and Two Pin Tuesdays $30 (cart included).<br/>\r\n            Please ask for Brian Boyle!\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p>\r\n            <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSW&_ei_=ErU6qiygAzcfNe7R05PhamA.\" target=\"_blank\" style=\"font-size:16pt;font-weight:bold;text-decoration:none;\">\r\n            <strong>Skytop Lodge – Skytop, PA</strong></a><br>\r\n            570-595-8910<br><br>\r\n            <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSW&_ei_=ErU6qiygAzcfNe7R05PhamA.\" target=\"_blank\"><img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/skytop_lodge.jpg\" alt=\"Skytop Lodge – Skytop, PA\" style=\"border: none;padding: 4px 12px 4px 4px;width: 200px;height: 150px;text-align: right;float: left;\"></a>\r\n            Rated 4.5 stars by Golf Digest and a proud partner of Preferred Golf Club. Our Pocono Golf Course is a mountain-style track that plays over rolling terrain,\r\n            with wide, tree-lined fairways and small greens that are challenging and above average in speed. Water comes into play on two holes and there is plenty of\r\n            strategically placed bunkers to challenge all players. Absolutely stunning .. A MUST PLAY!\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:center;float:left;\">\r\n        <p style=\"font-family:Lucida Calligraphy,script,serif;font-size:24pt;color:#36c;margin-bottom:0;\">\r\n            Benefits of Being a Golf Card Member\r\n        </p>\r\n    </div>\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;\">\r\n        <p>\r\n            <h1 style=\"color:#f00\">The <u>All NEW</u> Golf Card App</h1>\r\n            Our new App was just released and is available in both Apple iTunes App store and Google’s Play store. Just search for the Golf Card International App and look\r\n            for our logo. It is <strong>FREE</strong> and amazing. <span style=\"font-size:10pt;\">($29 value)</span>\r\n        </p>\r\n        <img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/phone_app.png\" style=\"float:right;width:175px;height:200px;margin:2px 20px;\" alt=\"Golf Card Phone App\" />\r\n        <ul>\r\n            <li>Takes our website and mobilizes it into a smart phone App with complete course listings closest to your home and while you are away. Also, check regular and GCI rates, course description and pictures.</li>\r\n            <li>Book tee times at over 1,000 of GCI courses for FREE right from the App.</li>\r\n            <li><span style=\"font-weight:bold;font-size:14pt;\">Golf GPS</span> - App is now loaded with premier Golf GPS for nearly all of our courses. Just turn on the App, find the course and hit the PLAY button on the bottom of the screen.\r\n                <span style=\"font-size:10pt;\">($29 value)</span></li>\r\n        </ul>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p>\r\n            <h1><span style=\"color:#f00\">US</span><span style=\"color:#0201c7\">GA</span> <span style=\"color:green\">Official Handicap</span></h1>\r\n            <img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/usga_card.png\" style=\"float:left;width:125px;height:125px;margin:2px 20px;\" alt=\"USGA Official Handicap\" />\r\n            <br/>Our members receive an official USGA handicap thru Golf Card. You will be assigned a club near your home with an index number allowing you to post all scores\r\n            along with other benefits. If you have not signed up for your card, please contact our office at <strong>1.800.321.8269</strong>. <span style=\"font-size:10pt;\">($25 annual value)</span>\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p>\r\n            <h1><span style=\"color:green\">Warrior Golf</span></h1>\r\n        </p>\r\n        <a href=\"http://www.warriorgolfplatinum.com\" target=\"_blank\"><img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/warrior_golf.jpg\" style=\"float:right;width:250px;height:50px;margin:0 0 0 10px;border:none;\" alt=\"Warrior Golf\" /></a>\r\n        <p>\r\n            15 Free Rounds to all Golf Card members at all Warrior Golf managed Properties. Simply <a href=\"http://www.warriorgolfplatinum.com\" target=\"_blank\"><span style=\"color:blue;font-weight:bold;text-decoration:none;\">Click Here</span></a> and visit all of the Warrior Golf Courses.\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p>\r\n            <h1><span style=\"color:green\">Golf Digest Subscription</span></h1>\r\n            <img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/golf_digest.jpg\" style=\"float:left;width:125px;height:150px;margin:2px 20px;border:none;\" alt=\"Golf Digest Magazine\" />\r\n            Free one year (12 issues) subscription to Golf Digest Magazine included with all memberships. If you are a Golf Card member who purchased our card with this benefit and have not received your\r\n            first edition, please call our toll free number and speak with a customer service representative at <strong>1.800.321.8269</strong>. Please have your membership number handy if possible.\r\n            <span style=\"font-size:10pt;\">($10 value)</span>\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p>\r\n            <h1><span style=\"color:green\">Worldwide Golf Shops Online Store</span></h1>\r\n        </p>\r\n        <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSA&_ei_=Et4OQEqMDCh6P_YB7QnJKLA.\" target=\"_blank\"><img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/wwgs.jpg\" style=\"float:right;width:175px;height:133px;margin:-25px 0 0 10px;border:none;\" alt=\"Warrior Golf\" /></a>\r\n        <p>\r\n            As a member you receive 10% off on over 4,000 golf products and free shipping (purchases over $100) thru our partnership with Worldwide Golf\'s Online store.\r\n            Simply go to <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSA&_ei_=Et4OQEqMDCh6P_YB7QnJKLA.\" target=\"_blank\"><span style=\"color:blue;font-weight:bold;text-decoration:none;\">www.worldwidegolfshops.com</span></a> and make sure you enter in the promotional code <span style=\"font-size:14pt;font-weight:bold;\">GCIWWG</span> to receive your discount.\r\n        </p>\r\n    </div>\r\n\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p style=\"text-align:left\">\r\n        </p><h1><span style=\"color:green\">Ask Our Pro</span></h1>\r\n        <img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/jay_the_golfer.jpg\" style=\"float: left;width: 120px;height: 140px;margin: 2px 20px;border:none\" alt=\"Jay The Golfer\"/>\r\n        Jay Miller, Director at Golf Card is a past professional, past golf course owner (2011 National Golf Course of the Year), past President of the California Golf Course\r\n        Owners Association, tournament player and collegiate scholarship golfer at Purdue University. He can assist all golf courses in operational & managerial questions,\r\n        plus all our members’ golf swing questions, golf course reviews and especially golf travel related inquiries. Claim to fame is being blessed with playing Augusta\r\n        National over 100 times. Please email Jay Miller at <a href=\"mailto:jaythegolfer@cox.net\" target=\"_blank\"><span style=\"color:blue;font-weight:bold;\">Jaythegolfer@cox.net</span></a>.\r\n\r\n    </div>\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p style=\"text-align:left\">\r\n            <br/></p><h2><span style=\"color:green\">Know a Golf Course that you frequently visit or one that you just happen to visit that does not participate with the Golf Card program?</span></h2>\r\n        Refer them to us! Golf Card is committed to adding new, quality courses to its nationwide network. If there is a course you would like to see accept The Golf Card,\r\n        please let us know by either you or the course emailing <a href=\"mailto:info@golfcard.com\" target=\"_blank\"><span style=\"color:blue;font-weight:bold;\">info@golfcard.com</span></a> or calling us at <strong>1.800.321.8269</strong>.\r\n\r\n    </div>\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p style=\"text-align:left\">\r\n        </p><h2><span style=\"color:green\">Looking for a way to Earn Extra Money? <span style=\"font-weight:bold;font-size:24pt;\">Refer-A-Buddy</span></span></h2>\r\n        Refer-A-Buddy and receive $20.00 PLUS SIX months FREE from Golf Card! This is our way of saying ‘Thank you’ for helping us grow. Your Buddy will receive free\r\n        or reduced Green Fees at nearly 3,000 courses from the Fastest Growing and most Exciting Golf network.\r\n        <br/><br/>\r\n        You must supply your Buddy with your membership number\r\n        and name to receive credit for their membership and it must be provided at signup. Please contact us for more information. New members can signup online at\r\n        <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSY&_ei_=Eh5aJQVA3FE9Z1GlrnIjuCc.\" target=\"_blank\"><span style=\"color:blue;font-weight:bold;text-decoration:none;\">www.golfcard.com</span></a> or by calling <strong>1.800.321.8269</strong>.\r\n\r\n    </div>\r\n\r\n    <div style=\"width:100%;text-align:left;float:left;margin-bottom:20px;\">\r\n        <p class=\"lucida_calligraphy1 color_light_blue center\" style=\"text-align: center;font-family: Lucida Calligraphy, script, serif;font-size: 20pt;color: #36c\">Helping keep RVers lifestyle affordable, so they can make their dreams a reality!</p>\r\n        <p style=\"text-align:left\">\r\n            <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSB&_ei_=Ek4obLCGLPbvgK91adoL524.\" target=\"_blank\"><img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/passport_america.jpg\" style=\"float: right;width: 175px;height: 175px;margin: 2px 20px;border: none\" alt=\"Passport America\"/></a><span class=\"color_light_blue bold\" style=\"font-weight: bold;color: #36c\">Passport America</span> invented the 50% Discount Camping Club in 1992 and has continued to improve on that great concept. That\'s right, 50% off at every park.\r\n            Nearly 1900 campgrounds across the US, Canada and Mexico are currently participating in the Passport America Program, with new parks joining daily. Although\r\n            our concept has often been imitated, Passport America is still the best value, lowest price, and the World\'s Largest network of Quality Campgrounds of its kind.\r\n            To learn more about Passport America and its wonderful program <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSB&_ei_=Ek4obLCGLPbvgK91adoL524.\" target=\"_blank\"><span style=\"color:blue;font-weight:bold;text-decoration:none;\">Click Here</span></a>!!\r\n        </p>\r\n    </div>'),(14,3,'cet18','Golf Card New Test','Testing Golfcard again working on design','2014-05-15',NULL,'golfcard.com',NULL,NULL);
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datasources`
--

DROP TABLE IF EXISTS `datasources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datasources` (
  `datasource_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `database_name` varchar(32) NOT NULL,
  PRIMARY KEY (`datasource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datasources`
--

LOCK TABLES `datasources` WRITE;
/*!40000 ALTER TABLE `datasources` DISABLE KEYS */;
INSERT INTO `datasources` VALUES (4,'Golf Card','localhost','root','root','golf_card'),(5,'Passport America','localhost','root','root','sitedb'),(6,'Production Golf Card','166.78.142.213','root','Absb@01m','golf_card');
/*!40000 ALTER TABLE `datasources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails` (
  `email_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `database_view_id` int(10) unsigned NOT NULL,
  `template_id` int(10) unsigned DEFAULT NULL,
  `content` text,
  `date_created` datetime NOT NULL,
  `date_started` datetime DEFAULT NULL,
  `date_finished` datetime DEFAULT NULL,
  PRIMARY KEY (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formatted_views`
--

DROP TABLE IF EXISTS `formatted_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formatted_views` (
  `formatted_view_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datasource_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `query` text NOT NULL,
  PRIMARY KEY (`formatted_view_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formatted_views`
--

LOCK TABLES `formatted_views` WRITE;
/*!40000 ALTER TABLE `formatted_views` DISABLE KEYS */;
INSERT INTO `formatted_views` VALUES (1,0,'1','members'),(2,4,'hm_get_members_limit_100','SELECT first_name, last_name, primary_email from members LIMIT 100;'),(3,5,'hm_passportamerica_100','SELECT * FROM dealers LIMIT 100;');
/*!40000 ALTER TABLE `formatted_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templates` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `header` text,
  `footer` text,
  `name` varchar(32) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` VALUES (5,'Header','Footer','Template test 1',NULL),(6,' <div style=\"text-align:center;\">\r\n        <img src=\"http://www.golfcard.com/img/email/new/GolfCard_Newsletter_Header.jpg\" width=\"650\"  alt=\"Golf Card International\" title=\"Golf Card International\" style=\"border:none\"/></div>\r\n\r\n    <p style=\"text-align:center;background-color:green;color:#fff;padding:5px;font-size:1.1em;font-weight:bold;\">Golf Card eNewsletter, May 2014</p>','<div style=\"width:100%;text-align:center;float:left;\">\r\n        <br/><br/>\r\n        <img src=\"https://responsys.hs.llnwd.net/i5/responsysimages/golfc/GolfCard/GC_Newsletter_2014_05/save_more_play_more1.png\" style=\"width:600px;height:250px;border: none\" alt=\"Golf Card - Save More, Play More\"/>\r\n    </div>\r\n\r\n    <div class=\"div_newsletter_area center\" style=\"width: 100%;text-align: center;float: left;margin-bottom: 20px\">\r\n        <br/><p>As always, we welcome your comments! <a href=\"mailto:info@golfcard.com\"><span style=\"color:blue;font-weight:bold;text-decoration:none;\">Contact Us</span></a></p>\r\n        <p>If you are interested in advertising your product or service, please contact us at <a href=\"mailto:info@golfcard.com\"><span style=\"color:blue;font-weight:bold;\">info@golfcard.com</span></a>.</p>\r\n        <hr/><p>Copyright &copy; Simmons Venture Group, LLC - Discounted Tee Times at Nearly 3,000 Courses</p>\r\n        <p>UNSUBSCRIBE: To unsubscribe from golfcard.com email, please click here <a href=\"https://email.golfcard.com/pub/cc?_ri_=X0Gzc2X%3DWQpglLjHJlYQGkhkNiOzc6rgKzeY3D6XqIzgwT0sKsymdhDVXtpKX%3DUBSC&_ei_=EiqWAlGWBQmK3fh47jC5oAg.\"><span style=\"color:blue;font-weight:bold;text-decoration:none;\">Unsubscribe</span></a></p>\r\n    </div>','Template Test 2',NULL),(7,'Header3','Footer3','Template Test3',NULL);
/*!40000 ALTER TABLE `templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Brian','brian@golfcard.com','$2a$08$o0bY0709gnPfbSB91dmZSutLKgnKIF9TTCE9V5pVU5LMMQKLTK0A.');
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

-- Dump completed on 2014-05-15 10:07:28
