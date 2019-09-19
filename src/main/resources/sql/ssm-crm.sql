/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.1.37-community : Database - ssm_crm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssm_crm` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssm_crm`;

/*Table structure for table `tbl_dept` */

DROP TABLE IF EXISTS `tbl_dept`;

CREATE TABLE `tbl_dept` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(20) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_dept` */

insert  into `tbl_dept`(`dept_id`,`dept_name`) values (1,'研发部'),(2,'测试部'),(3,'营销部'),(4,'人事部');

/*Table structure for table `tbl_emp` */

DROP TABLE IF EXISTS `tbl_emp`;

CREATE TABLE `tbl_emp` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(20) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `d_id` (`d_id`),
  CONSTRAINT `tbl_emp_ibfk_1` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_emp` */

insert  into `tbl_emp`(`emp_id`,`emp_name`,`gender`,`email`,`d_id`) values (1,'zhangsan','M','zhangsan@qq.com',1),(2,'lisi','M','li@qq.com',2),(3,'6148b0','M','6148b0@qq.com',1),(4,'1299a1','M','1299a1@qq.com',1),(5,'552042','M','552042@qq.com',1),(6,'dfd313','M','dfd313@qq.com',1),(7,'a092d4','M','a092d4@qq.com',1),(8,'540895','M','540895@qq.com',1),(9,'ecda66','M','ecda66@qq.com',1),(10,'152997','M','152997@qq.com',1),(11,'9e2da8','M','9e2da8@qq.com',1),(12,'203249','M','203249@qq.com',1),(13,'49f9d10','M','49f9d10@qq.com',1),(14,'7a8b711','M','7a8b711@qq.com',1),(15,'6578e12','M','6578e12@qq.com',1),(16,'ac39d13','M','ac39d13@qq.com',1),(17,'5ea1714','M','5ea1714@qq.com',1),(18,'2f22615','M','2f22615@qq.com',1),(19,'3682416','M','3682416@qq.com',1),(20,'7bd0017','M','7bd0017@qq.com',1),(21,'45fcc18','M','45fcc18@qq.com',1),(24,'123b321','F','123b321@qq.com',3),(25,'27da322','M','27da322@qq.com',1),(26,'5748323','M','5748323@qq.com',1),(27,'c0deb24','M','c0deb24@qq.com',1),(28,'348ca25','M','348ca25@qq.com',1),(29,'3cad426','M','3cad426@qq.com',1),(30,'6498c27','M','6498c27@qq.com',1),(31,'5764028','M','5764028@qq.com',1),(32,'ba9a529','M','ba9a529@qq.com',1),(33,'f5b6f30','M','f5b6f30@qq.com',1),(34,'814b931','M','814b931@qq.com',1),(35,'4e20732','M','4e20732@qq.com',1),(36,'1c94633','M','1c94633@qq.com',1),(37,'9965434','M','9965434@qq.com',1),(38,'10f3f35','M','10f3f35@qq.com',1),(39,'8c1aa36','M','8c1aa36@qq.com',1),(40,'d8bb837','M','d8bb837@qq.com',1),(41,'1d37338','M','1d37338@qq.com',1),(42,'7796639','M','7796639@qq.com',1),(43,'198c440','M','198c440@qq.com',1),(44,'bd86141','M','bd86141@qq.com',1),(45,'2096642','M','2096642@qq.com',1),(46,'0d1d743','M','0d1d743@qq.com',1),(47,'6df4d44','M','6df4d44@qq.com',1),(48,'5f17c45','M','5f17c45@qq.com',1),(49,'f99ad46','M','f99ad46@qq.com',1),(50,'9b65247','M','9b65247@qq.com',1),(51,'454bd48','M','454bd48@qq.com',1),(52,'4cc6b49','M','4cc6b49@qq.com',1),(53,'a3e9450','M','a3e9450@qq.com',1),(54,'f0baa51','M','f0baa51@qq.com',1),(55,'db6ed52','M','db6ed52@qq.com',1),(56,'4111353','M','4111353@qq.com',1),(57,'6114f54','M','6114f54@qq.com',1),(58,'568a755','M','568a755@qq.com',1),(59,'cb0a556','M','cb0a556@qq.com',1),(60,'6557e57','M','6557e57@qq.com',1),(61,'cbf6a58','M','cbf6a58@qq.com',1),(62,'fe46559','M','fe46559@qq.com',1),(63,'1171a60','M','1171a60@qq.com',1),(64,'60ae661','M','60ae661@qq.com',1),(65,'c8f1862','M','c8f1862@qq.com',1),(66,'de9be63','M','de9be63@qq.com',1),(67,'8414f64','M','8414f64@qq.com',1),(68,'8acfd65','M','8acfd65@qq.com',1),(69,'159ad66','M','159ad66@qq.com',1),(70,'ab83167','M','ab83167@qq.com',1),(71,'7123968','M','7123968@qq.com',1),(72,'833e469','M','833e469@qq.com',1),(73,'e120e70','M','e120e70@qq.com',1),(74,'04f7371','M','04f7371@qq.com',1),(75,'8c44572','M','8c44572@qq.com',1),(76,'a3d1b73','M','a3d1b73@qq.com',1),(77,'4429c74','M','4429c74@qq.com',1),(78,'e638e75','M','e638e75@qq.com',1),(79,'d72f176','M','d72f176@qq.com',1),(80,'a319477','M','a319477@qq.com',1),(81,'dd68178','M','dd68178@qq.com',1),(82,'5822079','M','5822079@qq.com',1),(83,'2673480','M','2673480@qq.com',1),(84,'15eca81','M','15eca81@qq.com',1),(85,'a055e82','M','a055e82@qq.com',1),(86,'330c283','M','330c283@qq.com',1),(87,'276c284','M','276c284@qq.com',1),(88,'c0d3c85','M','c0d3c85@qq.com',1),(89,'c986686','M','c986686@qq.com',1),(90,'8aa0e87','M','8aa0e87@qq.com',1),(91,'cdf1f88','M','cdf1f88@qq.com',1),(92,'afdb889','M','afdb889@qq.com',1),(93,'351da90','M','351da90@qq.com',1),(94,'1a6f891','M','1a6f891@qq.com',1),(95,'7699092','M','7699092@qq.com',1),(96,'dd8b793','M','dd8b793@qq.com',1),(97,'4cd8d94','M','4cd8d94@qq.com',1),(98,'0a92995','M','0a92995@qq.com',1),(99,'acc1e96','M','acc1e96@qq.com',1),(100,'0e46297','M','0e46297@qq.com',1),(101,'a985a98','M','a985a98@qq.com',1),(102,'46ff399','M','46ff399@qq.com',1),(103,'029940','M','029940@qq.com',2),(104,'c1e411','M','c1e411@qq.com',2),(105,'5edc12','M','5edc12@qq.com',2),(106,'0412c3','M','0412c3@qq.com',2),(107,'8fe264','M','8fe264@qq.com',2),(108,'9282e5','M','9282e5@qq.com',2),(109,'083996','M','083996@qq.com',2),(110,'c357d7','M','c357d7@qq.com',2),(111,'38d058','M','38d058@qq.com',2),(112,'47eca9','M','47eca9@qq.com',2),(113,'5d4e110','M','5d4e110@qq.com',2),(114,'ac2ac11','M','ac2ac11@qq.com',2),(115,'f4aad12','M','f4aad12@qq.com',2),(116,'7231513','M','7231513@qq.com',2),(117,'ac91e14','M','ac91e14@qq.com',2),(118,'ed22a15','M','ed22a15@qq.com',2),(119,'e702a16','M','e702a16@qq.com',2),(120,'6039817','M','6039817@qq.com',2),(121,'2dfa018','M','2dfa018@qq.com',2),(122,'d5e0d19','M','d5e0d19@qq.com',2),(123,'9ea1a20','M','9ea1a20@qq.com',2),(124,'71b5b21','M','71b5b21@qq.com',2),(125,'107d922','M','107d922@qq.com',2),(126,'3b81823','M','3b81823@qq.com',2),(127,'965d424','M','965d424@qq.com',2),(128,'6cf5925','M','6cf5925@qq.com',2),(129,'b978826','M','b978826@qq.com',2),(130,'de3e627','M','de3e627@qq.com',2),(131,'e67b228','M','e67b228@qq.com',2),(132,'4175429','M','4175429@qq.com',2),(133,'84a1f30','M','84a1f30@qq.com',2),(134,'d8ddc31','M','d8ddc31@qq.com',2),(135,'7bdfb32','M','7bdfb32@qq.com',2),(136,'dd34b33','M','dd34b33@qq.com',2),(137,'0a4a134','M','0a4a134@qq.com',2),(138,'62a7e35','M','62a7e35@qq.com',2),(139,'4672536','M','4672536@qq.com',2),(140,'be3f537','M','be3f537@qq.com',2),(141,'7d1e738','M','7d1e738@qq.com',2),(142,'3b53539','M','3b53539@qq.com',2),(143,'a185840','M','a185840@qq.com',2),(144,'71aa441','M','71aa441@qq.com',2),(145,'50fe942','M','50fe942@qq.com',2),(146,'f3f2a43','M','f3f2a43@qq.com',2),(147,'5799a44','M','5799a44@qq.com',2),(148,'b9e0545','M','b9e0545@qq.com',2),(149,'51e8646','M','51e8646@qq.com',2),(150,'d7bbd47','M','d7bbd47@qq.com',2),(151,'6fdc748','M','6fdc748@qq.com',2),(152,'87be049','M','87be049@qq.com',2),(153,'ae51950','M','ae51950@qq.com',2),(154,'7006551','M','7006551@qq.com',2),(155,'d590c52','M','d590c52@qq.com',2),(156,'ed78953','M','ed78953@qq.com',2),(157,'af60254','M','af60254@qq.com',2),(158,'4aa3b55','M','4aa3b55@qq.com',2),(159,'98e7e56','M','98e7e56@qq.com',2),(160,'ae26f57','M','ae26f57@qq.com',2),(161,'3b8f058','M','3b8f058@qq.com',2),(162,'3405459','M','3405459@qq.com',2),(163,'33c6660','M','33c6660@qq.com',2),(164,'7ea7561','M','7ea7561@qq.com',2),(165,'b8fd262','M','b8fd262@qq.com',2),(166,'92b6863','M','92b6863@qq.com',2),(167,'6e1e264','M','6e1e264@qq.com',2),(168,'5aa2a65','M','5aa2a65@qq.com',2),(169,'a5aa066','M','a5aa066@qq.com',2),(170,'4683a67','M','4683a67@qq.com',2),(171,'f93c568','M','f93c568@qq.com',2),(172,'5f7af69','M','5f7af69@qq.com',2),(173,'efb8570','M','efb8570@qq.com',2),(174,'fc4d671','M','fc4d671@qq.com',2),(175,'e8b9b72','M','e8b9b72@qq.com',2),(176,'949a373','M','949a373@qq.com',2),(177,'ab29274','M','ab29274@qq.com',2),(178,'6d50575','M','6d50575@qq.com',2),(179,'ef23276','M','ef23276@qq.com',2),(180,'60ed277','M','60ed277@qq.com',2),(181,'e532778','M','e532778@qq.com',2),(182,'af63b79','M','af63b79@qq.com',2),(183,'ffebb80','M','ffebb80@qq.com',2),(184,'5d75781','M','5d75781@qq.com',2),(185,'77ea082','M','77ea082@qq.com',2),(186,'622d083','M','622d083@qq.com',2),(187,'1f12f84','M','1f12f84@qq.com',2),(188,'ad42a85','M','ad42a85@qq.com',2),(189,'e9fe686','M','e9fe686@qq.com',2),(190,'e6ac787','M','e6ac787@qq.com',2),(191,'1c03288','M','1c03288@qq.com',2),(192,'f9ccd89','M','f9ccd89@qq.com',2),(193,'086d990','M','086d990@qq.com',2),(196,'cdf7693','M','cdf7693@qq.com',2),(197,'63e0194','M','63e0194@qq.com',2),(198,'3cc1b95','M','3cc1b95@qq.com',2),(199,'0707796','M','0707796@qq.com',2),(202,'73b9f99','M','73b9f99@qq.com',2),(203,'test','M',NULL,3),(204,'test','F','test@qq.com',4),(205,'test','F','test@qq.com',1),(206,'emp','M','emp@qq.com',1),(207,'aaa','F','aaa',1),(212,'zhanglong','M','zhanglong@qq.com',3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
