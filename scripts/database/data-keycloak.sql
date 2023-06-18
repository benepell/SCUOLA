-- MariaDB dump 10.19  Distrib 10.5.18-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: vrscuola
-- ------------------------------------------------------
-- Server version	10.5.18-MariaDB-0+deb11u1

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
-- Table structure for table `ADMIN_EVENT_ENTITY`
--

DROP TABLE IF EXISTS `ADMIN_EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ADMIN_EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `ADMIN_EVENT_TIME` bigint(20) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `OPERATION_TYPE` varchar(255) DEFAULT NULL,
  `AUTH_REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_CLIENT_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `RESOURCE_PATH` text DEFAULT NULL,
  `REPRESENTATION` text DEFAULT NULL,
  `ERROR` varchar(255) DEFAULT NULL,
  `RESOURCE_TYPE` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ADMIN_EVENT_TIME` (`REALM_ID`,`ADMIN_EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADMIN_EVENT_ENTITY`
--

LOCK TABLES `ADMIN_EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` DISABLE KEYS */;
INSERT INTO `ADMIN_EVENT_ENTITY` VALUES ('5a1514b5-73db-424e-9610-2957b95e7af2',1679106763365,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE','f47dc79c-5538-4cdb-9f59-3396e016c2ce','8565077f-84ed-4a5d-a06b-be52a43d3779','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3','192.168.178.101','events/config',NULL,NULL,'REALM');
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSOCIATED_POLICY`
--

DROP TABLE IF EXISTS `ASSOCIATED_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ASSOCIATED_POLICY` (
  `POLICY_ID` varchar(36) NOT NULL,
  `ASSOCIATED_POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`POLICY_ID`,`ASSOCIATED_POLICY_ID`),
  KEY `IDX_ASSOC_POL_ASSOC_POL_ID` (`ASSOCIATED_POLICY_ID`),
  CONSTRAINT `FK_FRSR5S213XCX4WNKOG82SSRFY` FOREIGN KEY (`ASSOCIATED_POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPAS14XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSOCIATED_POLICY`
--

LOCK TABLES `ASSOCIATED_POLICY` WRITE;
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_EXECUTION`
--

DROP TABLE IF EXISTS `AUTHENTICATION_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHENTICATION_EXECUTION` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `AUTHENTICATOR` varchar(36) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `REQUIREMENT` int(11) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `AUTHENTICATOR_FLOW` bit(1) NOT NULL DEFAULT b'0',
  `AUTH_FLOW_ID` varchar(36) DEFAULT NULL,
  `AUTH_CONFIG` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_EXEC_REALM_FLOW` (`REALM_ID`,`FLOW_ID`),
  KEY `IDX_AUTH_EXEC_FLOW` (`FLOW_ID`),
  CONSTRAINT `FK_AUTH_EXEC_FLOW` FOREIGN KEY (`FLOW_ID`) REFERENCES `AUTHENTICATION_FLOW` (`ID`),
  CONSTRAINT `FK_AUTH_EXEC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_EXECUTION`
--

LOCK TABLES `AUTHENTICATION_EXECUTION` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_EXECUTION` VALUES ('05046c7a-107a-4d71-b12f-cec2d70e0d93',NULL,'idp-create-user-if-unique','f47dc79c-5538-4cdb-9f59-3396e016c2ce','f709105d-6393-4272-ba09-a12efd7648d6',2,10,'\0',NULL,'d8a00a40-92e7-44c4-882f-522c4973b000'),('099f84a3-7f93-4b50-a2ed-03e6c76a51b4',NULL,'reset-password','f47dc79c-5538-4cdb-9f59-3396e016c2ce','c29950cd-bef4-4998-b581-23b9cfa4515c',0,30,'\0',NULL,NULL),('09f6a2a1-6ba6-4b2f-b449-9ca8c7bd6c9d',NULL,'client-x509','f47dc79c-5538-4cdb-9f59-3396e016c2ce','c341a39b-d3f7-458e-b55e-b381cf58244e',2,40,'\0',NULL,NULL),('10fd635f-20ec-4c31-95e8-6235d94605a7',NULL,'idp-review-profile','f47dc79c-5538-4cdb-9f59-3396e016c2ce','d98fea61-a3da-46ae-87aa-5d85bcb1bbb4',0,10,'\0',NULL,'26dcb766-74c5-47c3-90b6-cbe24abfb6a2'),('1f25ee5d-9403-40ec-8c9d-75bacf10772b',NULL,'http-basic-authenticator','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','5c9ede42-ad2c-40ce-9028-5625938e9ed3',0,10,'\0',NULL,NULL),('1fa97e0a-558e-4b18-834d-a932218455f8',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','1d2e0851-c084-4ce6-82ad-63d70a415842',1,20,'','2557609d-ef7e-4890-a53c-25f18f03bd77',NULL),('21f0d90b-2a42-47d9-a0b5-6ff5779bffa8',NULL,'basic-auth-otp','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c9df2e6c-dbf0-426b-80bf-0f9d94ba45ca',3,20,'\0',NULL,NULL),('22599580-aabf-421f-814b-b8793ea59391',NULL,'auth-cookie','f47dc79c-5538-4cdb-9f59-3396e016c2ce','f127a896-83bc-4da2-892e-a30b7151129f',2,10,'\0',NULL,NULL),('24d8edc5-3cbb-4e04-8a34-537fa176d5af',NULL,'idp-username-password-form','f47dc79c-5538-4cdb-9f59-3396e016c2ce','ced481c2-e942-4c88-9381-0a3ad44f2bd5',0,10,'\0',NULL,NULL),('2825e286-87e5-4b5b-844f-f88fd4fe0f86',NULL,'direct-grant-validate-otp','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','6f86453f-1edd-40bc-8f69-35d2d861c654',0,20,'\0',NULL,NULL),('318a8035-db33-400c-aed5-6f489f79d8ed',NULL,'basic-auth-otp','f47dc79c-5538-4cdb-9f59-3396e016c2ce','4d50fa5a-850d-4020-be14-30a338a7b183',3,20,'\0',NULL,NULL),('31aff925-7a3b-4316-b9f0-08733e85d821',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','c29950cd-bef4-4998-b581-23b9cfa4515c',1,40,'','46a461b1-5b82-4ae0-ab21-9b6c783817d6',NULL),('3213a620-606f-4a8c-9e7c-e54e3f5f3e69',NULL,'client-secret-jwt','f47dc79c-5538-4cdb-9f59-3396e016c2ce','c341a39b-d3f7-458e-b55e-b381cf58244e',2,30,'\0',NULL,NULL),('3596e60e-4dc0-498f-b268-354248208ee2',NULL,'auth-username-password-form','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c3bc4977-d27c-4ea2-a3d3-f6bf1e83d6de',0,10,'\0',NULL,NULL),('36ece5d1-478b-4e59-85f3-88ea0abcce02',NULL,'conditional-user-configured','f47dc79c-5538-4cdb-9f59-3396e016c2ce','f13fa8fa-37e3-4f48-a42f-31e266f90012',0,10,'\0',NULL,NULL),('3c103256-e988-4d26-aed9-cfafe0005486',NULL,'auth-cookie','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','4160e42a-af89-4e84-ab6e-babd4297a1e0',2,10,'\0',NULL,NULL),('3cbb1449-8ea1-4b3a-b382-e31294ab6cf1',NULL,'client-secret','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','ddfd7846-b5e2-4732-b1ba-17792477413e',2,10,'\0',NULL,NULL),('3f1b11df-0a2c-4173-a6b9-231fb8e58b95',NULL,'auth-otp-form','f47dc79c-5538-4cdb-9f59-3396e016c2ce','f13fa8fa-37e3-4f48-a42f-31e266f90012',0,20,'\0',NULL,NULL),('409a9137-89a4-44da-abca-c4b905b07815',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7009c9c-7b6d-443c-85d2-1c1a7c20092d',2,20,'','44d0460a-fcdb-40c5-a609-ba3b208a35cc',NULL),('42c513b8-1965-4c41-ba2b-28d72dab6bd5',NULL,'registration-password-action','f47dc79c-5538-4cdb-9f59-3396e016c2ce','756cede2-d608-4882-9f3a-9943e2b17a4b',0,50,'\0',NULL,NULL),('43f25fd7-a691-4ad7-a4ca-b13a42181504',NULL,'idp-username-password-form','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','44d0460a-fcdb-40c5-a609-ba3b208a35cc',0,10,'\0',NULL,NULL),('444c9dfc-a644-410a-ad04-12fc40cbd502',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','d6772330-d8fa-4361-a604-b67090afefe2',1,30,'','4a3c0a84-262c-4ded-935a-e39dc0bafc61',NULL),('45051d86-9ae1-4c57-8073-60eb047a32e0',NULL,'reset-otp','f47dc79c-5538-4cdb-9f59-3396e016c2ce','46a461b1-5b82-4ae0-ab21-9b6c783817d6',0,20,'\0',NULL,NULL),('45a47cbc-3f01-48f4-8a51-ea4e0e3ad76c',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','44d0460a-fcdb-40c5-a609-ba3b208a35cc',1,20,'','42370f41-545a-4dd9-a8f7-b07e03bfe5bb',NULL),('46470683-cf22-4c7f-94bd-88690a228714',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c3bc4977-d27c-4ea2-a3d3-f6bf1e83d6de',1,20,'','765c9b0e-f3cb-4a3f-8ec9-379390a3a1a8',NULL),('4e4333a0-a40a-4ac8-850f-fedc7fe61a84',NULL,'docker-http-basic-authenticator','f47dc79c-5538-4cdb-9f59-3396e016c2ce','f9805f57-40d3-45e9-a2f5-148c45782c0e',0,10,'\0',NULL,NULL),('4fc37cff-09ea-426c-8792-cc626b7c87ec',NULL,'direct-grant-validate-username','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','bb8d47a9-d323-49d3-acb0-7527caad3d94',0,10,'\0',NULL,NULL),('507c8837-819c-4278-8e88-ccc5fee278a0',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','b04f39a9-9764-48b5-8332-d7a329bfc768',2,20,'','ced481c2-e942-4c88-9381-0a3ad44f2bd5',NULL),('544a02e1-cf16-4e41-8fd1-5520c81cf85a',NULL,'identity-provider-redirector','f47dc79c-5538-4cdb-9f59-3396e016c2ce','f127a896-83bc-4da2-892e-a30b7151129f',2,25,'\0',NULL,NULL),('5be394f5-0cb4-4eb5-8ec6-d0d5ec759620',NULL,'reset-credentials-choose-user','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','28d758e8-67bb-4e03-aba4-bbf0511056d0',0,10,'\0',NULL,NULL),('6144c064-3954-4ffa-9eb8-3176614e42bd',NULL,'direct-grant-validate-otp','f47dc79c-5538-4cdb-9f59-3396e016c2ce','4a3c0a84-262c-4ded-935a-e39dc0bafc61',0,20,'\0',NULL,NULL),('617a8036-1983-4e3d-903a-0df1d535270f',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','1e983e8a-d07f-4f98-b94f-3f7ca915dab4',0,20,'','afb2d687-7e75-477c-873b-c570e8288073',NULL),('69de03ad-dd34-4b35-b4e0-61cb4cf01b40',NULL,'conditional-user-configured','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','6f86453f-1edd-40bc-8f69-35d2d861c654',0,10,'\0',NULL,NULL),('6ea7bce2-6877-4882-9702-fd71bdc640cf',NULL,'registration-page-form','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','affbe6c6-5ef2-4588-8be5-f11b966b7c98',0,10,'','71422a08-1613-4b17-9806-d813619faed3',NULL),('6f4ac294-8c7d-4b86-a5a5-da74e4e0db05',NULL,'auth-otp-form','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','765c9b0e-f3cb-4a3f-8ec9-379390a3a1a8',0,20,'\0',NULL,NULL),('7264bec5-7c66-4d96-a410-d38deb1c4d00',NULL,'direct-grant-validate-password','f47dc79c-5538-4cdb-9f59-3396e016c2ce','d6772330-d8fa-4361-a604-b67090afefe2',0,20,'\0',NULL,NULL),('727bd0d0-a0cb-47ed-a0d1-572a7c723020',NULL,'client-x509','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','ddfd7846-b5e2-4732-b1ba-17792477413e',2,40,'\0',NULL,NULL),('750a0120-8848-44db-96ae-981549a74a51',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','f709105d-6393-4272-ba09-a12efd7648d6',2,20,'','90e97e77-fa35-4c15-876f-c0465426d2d9',NULL),('779c8a44-3f77-4c85-b167-24635f2329c0',NULL,'registration-recaptcha-action','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','71422a08-1613-4b17-9806-d813619faed3',3,60,'\0',NULL,NULL),('7846f8ab-2b93-4675-a5b2-8cecd3e4020c',NULL,'reset-credential-email','f47dc79c-5538-4cdb-9f59-3396e016c2ce','c29950cd-bef4-4998-b581-23b9cfa4515c',0,20,'\0',NULL,NULL),('7c46e3ac-89f6-4e92-9376-c965798d63b2',NULL,'auth-spnego','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','4160e42a-af89-4e84-ab6e-babd4297a1e0',3,20,'\0',NULL,NULL),('7dd4f31d-458d-49ca-8fb3-2684602e8ddc',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','90e97e77-fa35-4c15-876f-c0465426d2d9',0,20,'','b04f39a9-9764-48b5-8332-d7a329bfc768',NULL),('8196b75e-0143-4e19-8e4c-c92016efeeb8',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','4160e42a-af89-4e84-ab6e-babd4297a1e0',2,30,'','c3bc4977-d27c-4ea2-a3d3-f6bf1e83d6de',NULL),('81c1f5d6-62cd-480d-917c-c80b610b9429',NULL,'http-basic-authenticator','f47dc79c-5538-4cdb-9f59-3396e016c2ce','810fa82f-9ec1-4e62-a0d1-36f160e94d59',0,10,'\0',NULL,NULL),('8878a589-30e7-493f-9ee0-5a318dc16210',NULL,'reset-credentials-choose-user','f47dc79c-5538-4cdb-9f59-3396e016c2ce','c29950cd-bef4-4998-b581-23b9cfa4515c',0,10,'\0',NULL,NULL),('888b80e0-f5f1-4b64-b21f-97f92ecb4f5b',NULL,'registration-profile-action','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','71422a08-1613-4b17-9806-d813619faed3',0,40,'\0',NULL,NULL),('88efb460-706a-447f-a935-c9442c268aba',NULL,'basic-auth','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c9df2e6c-dbf0-426b-80bf-0f9d94ba45ca',0,10,'\0',NULL,NULL),('8aeddfa8-5058-457c-a3a4-cbac8987cf33',NULL,'direct-grant-validate-username','f47dc79c-5538-4cdb-9f59-3396e016c2ce','d6772330-d8fa-4361-a604-b67090afefe2',0,10,'\0',NULL,NULL),('8d816f84-6787-48d5-b83d-e2d3a711efb0',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','6928de62-2834-428a-ba01-960f345a2570',0,20,'','c7009c9c-7b6d-443c-85d2-1c1a7c20092d',NULL),('8ef88ebc-7b08-4c37-9762-9e6b35cb2d0e',NULL,'conditional-user-configured','f47dc79c-5538-4cdb-9f59-3396e016c2ce','46a461b1-5b82-4ae0-ab21-9b6c783817d6',0,10,'\0',NULL,NULL),('91c5f2eb-88cd-4988-b659-70cdb7a81580',NULL,'reset-credential-email','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','28d758e8-67bb-4e03-aba4-bbf0511056d0',0,20,'\0',NULL,NULL),('9259a1b4-b942-44f6-8b1f-ac92eacfd434',NULL,'idp-confirm-link','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','6928de62-2834-428a-ba01-960f345a2570',0,10,'\0',NULL,NULL),('95d79784-2545-4376-9d35-26cff83a356c',NULL,'direct-grant-validate-password','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','bb8d47a9-d323-49d3-acb0-7527caad3d94',0,20,'\0',NULL,NULL),('97c6021e-790b-4a0e-8812-8bd91ba808d2',NULL,'registration-page-form','f47dc79c-5538-4cdb-9f59-3396e016c2ce','5925db26-de22-4c56-ac60-f487cba11839',0,10,'','756cede2-d608-4882-9f3a-9943e2b17a4b',NULL),('9abe045d-6592-4c05-96f6-9e9b0976c586',NULL,'registration-user-creation','f47dc79c-5538-4cdb-9f59-3396e016c2ce','756cede2-d608-4882-9f3a-9943e2b17a4b',0,20,'\0',NULL,NULL),('9d91b346-05b2-4a1f-bf64-0f6e33a9e1af',NULL,'auth-username-password-form','f47dc79c-5538-4cdb-9f59-3396e016c2ce','1d2e0851-c084-4ce6-82ad-63d70a415842',0,10,'\0',NULL,NULL),('9da7e846-36be-45e9-b2c3-4292e912ce02',NULL,'client-jwt','f47dc79c-5538-4cdb-9f59-3396e016c2ce','c341a39b-d3f7-458e-b55e-b381cf58244e',2,20,'\0',NULL,NULL),('a258a5ca-9527-4a52-8704-61b0782feadc',NULL,'auth-otp-form','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','42370f41-545a-4dd9-a8f7-b07e03bfe5bb',0,20,'\0',NULL,NULL),('a4825994-405f-461f-8632-f9048d24cef3',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','66e912fc-62fd-4e30-bbd9-d7466cfc6ba4',0,20,'','c9df2e6c-dbf0-426b-80bf-0f9d94ba45ca',NULL),('a5674ef1-8c08-4240-b7e1-2969a661009e',NULL,'conditional-user-configured','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','765c9b0e-f3cb-4a3f-8ec9-379390a3a1a8',0,10,'\0',NULL,NULL),('a675eac1-e42c-4e85-9a0e-7f3648915b2c',NULL,'idp-confirm-link','f47dc79c-5538-4cdb-9f59-3396e016c2ce','90e97e77-fa35-4c15-876f-c0465426d2d9',0,10,'\0',NULL,NULL),('aa003cf5-cece-406a-965c-7f90f8e3b21f',NULL,'conditional-user-configured','f47dc79c-5538-4cdb-9f59-3396e016c2ce','4a3c0a84-262c-4ded-935a-e39dc0bafc61',0,10,'\0',NULL,NULL),('aa9d46d3-e934-45b8-9436-80dfd77e4d1f',NULL,'conditional-user-configured','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','42370f41-545a-4dd9-a8f7-b07e03bfe5bb',0,10,'\0',NULL,NULL),('acf65f93-bb53-4d81-9fce-ab2e2c9be374',NULL,'auth-otp-form','f47dc79c-5538-4cdb-9f59-3396e016c2ce','2557609d-ef7e-4890-a53c-25f18f03bd77',0,20,'\0',NULL,NULL),('ae05c62d-b317-421d-8e57-869ff5d89436',NULL,'registration-profile-action','f47dc79c-5538-4cdb-9f59-3396e016c2ce','756cede2-d608-4882-9f3a-9943e2b17a4b',0,40,'\0',NULL,NULL),('b8074bec-3568-42f6-82e7-b7032d8b50a5',NULL,'idp-email-verification','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7009c9c-7b6d-443c-85d2-1c1a7c20092d',2,10,'\0',NULL,NULL),('b861cc09-eab3-44f0-a592-a292b56f5442',NULL,'basic-auth','f47dc79c-5538-4cdb-9f59-3396e016c2ce','4d50fa5a-850d-4020-be14-30a338a7b183',0,10,'\0',NULL,NULL),('bcb0fa58-b36a-4714-a876-02255b58b833',NULL,'registration-recaptcha-action','f47dc79c-5538-4cdb-9f59-3396e016c2ce','756cede2-d608-4882-9f3a-9943e2b17a4b',3,60,'\0',NULL,NULL),('becd4b49-27d8-4f33-9ef5-93701fd41486',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','d98fea61-a3da-46ae-87aa-5d85bcb1bbb4',0,20,'','f709105d-6393-4272-ba09-a12efd7648d6',NULL),('c2162de2-bdbf-4971-8d07-769f8bc6fbe9',NULL,'idp-email-verification','f47dc79c-5538-4cdb-9f59-3396e016c2ce','b04f39a9-9764-48b5-8332-d7a329bfc768',2,10,'\0',NULL,NULL),('c5674073-cc4a-44b2-bf53-fda58cfacaaf',NULL,'idp-review-profile','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','1e983e8a-d07f-4f98-b94f-3f7ca915dab4',0,10,'\0',NULL,'c5c4fd10-46cd-48d0-87ee-848e4c0effd7'),('c5bc0fea-cafa-4321-8b7b-c17e8a59de07',NULL,'identity-provider-redirector','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','4160e42a-af89-4e84-ab6e-babd4297a1e0',2,25,'\0',NULL,NULL),('cb71d857-aec5-47a2-9873-c2874ad30f0e',NULL,'auth-spnego','f47dc79c-5538-4cdb-9f59-3396e016c2ce','f127a896-83bc-4da2-892e-a30b7151129f',3,20,'\0',NULL,NULL),('cbf29338-a306-4863-a1c5-f5056707cd33',NULL,'client-secret','f47dc79c-5538-4cdb-9f59-3396e016c2ce','c341a39b-d3f7-458e-b55e-b381cf58244e',2,10,'\0',NULL,NULL),('cd743d43-1276-4a64-9f75-31c155c016b2',NULL,'conditional-user-configured','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','8c8b6778-dea2-4917-bf35-6e539619a991',0,10,'\0',NULL,NULL),('ce7a148b-8aea-4a32-800c-fcb014182be4',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','bb8d47a9-d323-49d3-acb0-7527caad3d94',1,30,'','6f86453f-1edd-40bc-8f69-35d2d861c654',NULL),('d1281c55-f164-479c-af74-92dcfa69eb88',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','f127a896-83bc-4da2-892e-a30b7151129f',2,30,'','1d2e0851-c084-4ce6-82ad-63d70a415842',NULL),('dc24eee6-531c-4069-90c9-b419a7267881',NULL,'docker-http-basic-authenticator','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','93e96c94-2198-4369-9b91-e078ed822b47',0,10,'\0',NULL,NULL),('dcc33377-f6cf-4c8f-813a-58f3963eb78c',NULL,'auth-spnego','f47dc79c-5538-4cdb-9f59-3396e016c2ce','4d50fa5a-850d-4020-be14-30a338a7b183',3,30,'\0',NULL,NULL),('dee450a6-2d0f-43ee-b077-251482929428',NULL,'registration-password-action','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','71422a08-1613-4b17-9806-d813619faed3',0,50,'\0',NULL,NULL),('df1e823e-3b72-49a1-9690-a38895079ea6',NULL,'reset-otp','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','8c8b6778-dea2-4917-bf35-6e539619a991',0,20,'\0',NULL,NULL),('e10d72d2-6580-4045-a788-56b77fd1307f',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','ced481c2-e942-4c88-9381-0a3ad44f2bd5',1,20,'','f13fa8fa-37e3-4f48-a42f-31e266f90012',NULL),('e6e17777-483e-4a18-ac3b-94367a0c0ef2',NULL,'no-cookie-redirect','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3a42c15c-58a1-493b-ae61-1947be8f43cf',0,10,'\0',NULL,NULL),('e9d24663-8558-4bc2-82d6-a9e375c163e4',NULL,'auth-spnego','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c9df2e6c-dbf0-426b-80bf-0f9d94ba45ca',3,30,'\0',NULL,NULL),('ea3a996b-b786-445f-aece-29e89732ed32',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','afb2d687-7e75-477c-873b-c570e8288073',2,20,'','6928de62-2834-428a-ba01-960f345a2570',NULL),('ea9a957b-4d9f-4264-b23c-6777d67566e9',NULL,'idp-create-user-if-unique','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','afb2d687-7e75-477c-873b-c570e8288073',2,10,'\0',NULL,'e87ec486-802e-4c67-9a34-f699a357ef96'),('eb640dc3-e989-40bb-ae12-393f26c27ef7',NULL,'reset-password','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','28d758e8-67bb-4e03-aba4-bbf0511056d0',0,30,'\0',NULL,NULL),('ee5a126a-8a76-4d87-8821-7334b0a8d4fc',NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','3a42c15c-58a1-493b-ae61-1947be8f43cf',0,20,'','4d50fa5a-850d-4020-be14-30a338a7b183',NULL),('eea22540-43e0-4803-bcf3-086e64128935',NULL,'no-cookie-redirect','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','66e912fc-62fd-4e30-bbd9-d7466cfc6ba4',0,10,'\0',NULL,NULL),('f2dee410-3fc9-4668-be53-5056490999ef',NULL,NULL,'af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','28d758e8-67bb-4e03-aba4-bbf0511056d0',1,40,'','8c8b6778-dea2-4917-bf35-6e539619a991',NULL),('f3b21fdc-203a-4596-b6e9-d76c3592e816',NULL,'conditional-user-configured','f47dc79c-5538-4cdb-9f59-3396e016c2ce','2557609d-ef7e-4890-a53c-25f18f03bd77',0,10,'\0',NULL,NULL),('f781e2f9-543e-443d-bde1-8f1437a6a5f3',NULL,'client-jwt','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','ddfd7846-b5e2-4732-b1ba-17792477413e',2,20,'\0',NULL,NULL),('f7fb35e5-b65e-49dd-8e11-5713cf09cd50',NULL,'registration-user-creation','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','71422a08-1613-4b17-9806-d813619faed3',0,20,'\0',NULL,NULL),('f9f14ee4-3347-468a-ac4d-e41f33c13784',NULL,'client-secret-jwt','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','ddfd7846-b5e2-4732-b1ba-17792477413e',2,30,'\0',NULL,NULL);
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_FLOW`
--

DROP TABLE IF EXISTS `AUTHENTICATION_FLOW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHENTICATION_FLOW` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) NOT NULL DEFAULT 'basic-flow',
  `TOP_LEVEL` bit(1) NOT NULL DEFAULT b'0',
  `BUILT_IN` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_FLOW_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_FLOW_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_FLOW`
--

LOCK TABLES `AUTHENTICATION_FLOW` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_FLOW` VALUES ('1d2e0851-c084-4ce6-82ad-63d70a415842','forms','Username, password, otp and other auth forms.','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('1e983e8a-d07f-4f98-b94f-3f7ca915dab4','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','',''),('2557609d-ef7e-4890-a53c-25f18f03bd77','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('28d758e8-67bb-4e03-aba4-bbf0511056d0','reset credentials','Reset credentials for a user if they forgot their password or something','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','',''),('3a42c15c-58a1-493b-ae61-1947be8f43cf','http challenge','An authentication flow based on challenge-response HTTP Authentication Schemes','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','',''),('4160e42a-af89-4e84-ab6e-babd4297a1e0','browser','browser based authentication','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','',''),('42370f41-545a-4dd9-a8f7-b07e03bfe5bb','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('44d0460a-fcdb-40c5-a609-ba3b208a35cc','Verify Existing Account by Re-authentication','Reauthentication of existing account','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('46a461b1-5b82-4ae0-ab21-9b6c783817d6','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('4a3c0a84-262c-4ded-935a-e39dc0bafc61','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('4d50fa5a-850d-4020-be14-30a338a7b183','Authentication Options','Authentication options.','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('5925db26-de22-4c56-ac60-f487cba11839','registration','registration flow','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','',''),('5c9ede42-ad2c-40ce-9028-5625938e9ed3','saml ecp','SAML ECP Profile Authentication Flow','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','',''),('66e912fc-62fd-4e30-bbd9-d7466cfc6ba4','http challenge','An authentication flow based on challenge-response HTTP Authentication Schemes','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','',''),('6928de62-2834-428a-ba01-960f345a2570','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('6f86453f-1edd-40bc-8f69-35d2d861c654','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('71422a08-1613-4b17-9806-d813619faed3','registration form','registration form','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','form-flow','\0',''),('756cede2-d608-4882-9f3a-9943e2b17a4b','registration form','registration form','f47dc79c-5538-4cdb-9f59-3396e016c2ce','form-flow','\0',''),('765c9b0e-f3cb-4a3f-8ec9-379390a3a1a8','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('810fa82f-9ec1-4e62-a0d1-36f160e94d59','saml ecp','SAML ECP Profile Authentication Flow','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','',''),('8c8b6778-dea2-4917-bf35-6e539619a991','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('90e97e77-fa35-4c15-876f-c0465426d2d9','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('93e96c94-2198-4369-9b91-e078ed822b47','docker auth','Used by Docker clients to authenticate against the IDP','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','',''),('afb2d687-7e75-477c-873b-c570e8288073','User creation or linking','Flow for the existing/non-existing user alternatives','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('affbe6c6-5ef2-4588-8be5-f11b966b7c98','registration','registration flow','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','',''),('b04f39a9-9764-48b5-8332-d7a329bfc768','Account verification options','Method with which to verity the existing account','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('bb8d47a9-d323-49d3-acb0-7527caad3d94','direct grant','OpenID Connect Resource Owner Grant','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','',''),('c29950cd-bef4-4998-b581-23b9cfa4515c','reset credentials','Reset credentials for a user if they forgot their password or something','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','',''),('c341a39b-d3f7-458e-b55e-b381cf58244e','clients','Base authentication for clients','f47dc79c-5538-4cdb-9f59-3396e016c2ce','client-flow','',''),('c3bc4977-d27c-4ea2-a3d3-f6bf1e83d6de','forms','Username, password, otp and other auth forms.','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('c7009c9c-7b6d-443c-85d2-1c1a7c20092d','Account verification options','Method with which to verity the existing account','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('c9df2e6c-dbf0-426b-80bf-0f9d94ba45ca','Authentication Options','Authentication options.','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','basic-flow','\0',''),('ced481c2-e942-4c88-9381-0a3ad44f2bd5','Verify Existing Account by Re-authentication','Reauthentication of existing account','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('d6772330-d8fa-4361-a604-b67090afefe2','direct grant','OpenID Connect Resource Owner Grant','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','',''),('d98fea61-a3da-46ae-87aa-5d85bcb1bbb4','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','',''),('ddfd7846-b5e2-4732-b1ba-17792477413e','clients','Base authentication for clients','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','client-flow','',''),('f127a896-83bc-4da2-892e-a30b7151129f','browser','browser based authentication','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','',''),('f13fa8fa-37e3-4f48-a42f-31e266f90012','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('f709105d-6393-4272-ba09-a12efd7648d6','User creation or linking','Flow for the existing/non-existing user alternatives','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','\0',''),('f9805f57-40d3-45e9-a2f5-148c45782c0e','docker auth','Used by Docker clients to authenticate against the IDP','f47dc79c-5538-4cdb-9f59-3396e016c2ce','basic-flow','','');
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHENTICATOR_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_CONFIG_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG`
--

LOCK TABLES `AUTHENTICATOR_CONFIG` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG` VALUES ('26dcb766-74c5-47c3-90b6-cbe24abfb6a2','review profile config','f47dc79c-5538-4cdb-9f59-3396e016c2ce'),('c5c4fd10-46cd-48d0-87ee-848e4c0effd7','review profile config','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed'),('d8a00a40-92e7-44c4-882f-522c4973b000','create unique user config','f47dc79c-5538-4cdb-9f59-3396e016c2ce'),('e87ec486-802e-4c67-9a34-f699a357ef96','create unique user config','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG_ENTRY`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG_ENTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHENTICATOR_CONFIG_ENTRY` (
  `AUTHENTICATOR_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`AUTHENTICATOR_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG_ENTRY`
--

LOCK TABLES `AUTHENTICATOR_CONFIG_ENTRY` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG_ENTRY` VALUES ('26dcb766-74c5-47c3-90b6-cbe24abfb6a2','missing','update.profile.on.first.login'),('c5c4fd10-46cd-48d0-87ee-848e4c0effd7','missing','update.profile.on.first.login'),('d8a00a40-92e7-44c4-882f-522c4973b000','false','require.password.update.after.registration'),('e87ec486-802e-4c67-9a34-f699a357ef96','false','require.password.update.after.registration');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BROKER_LINK`
--

DROP TABLE IF EXISTS `BROKER_LINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BROKER_LINK` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  `BROKER_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BROKER_LINK`
--

LOCK TABLES `BROKER_LINK` WRITE;
/*!40000 ALTER TABLE `BROKER_LINK` DISABLE KEYS */;
/*!40000 ALTER TABLE `BROKER_LINK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT`
--

DROP TABLE IF EXISTS `CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT` (
  `ID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `FULL_SCOPE_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) DEFAULT NULL,
  `PUBLIC_CLIENT` bit(1) NOT NULL DEFAULT b'0',
  `SECRET` varchar(255) DEFAULT NULL,
  `BASE_URL` varchar(255) DEFAULT NULL,
  `BEARER_ONLY` bit(1) NOT NULL DEFAULT b'0',
  `MANAGEMENT_URL` varchar(255) DEFAULT NULL,
  `SURROGATE_AUTH_REQUIRED` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  `NODE_REREG_TIMEOUT` int(11) DEFAULT 0,
  `FRONTCHANNEL_LOGOUT` bit(1) NOT NULL DEFAULT b'0',
  `CONSENT_REQUIRED` bit(1) NOT NULL DEFAULT b'0',
  `NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `SERVICE_ACCOUNTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `CLIENT_AUTHENTICATOR_TYPE` varchar(255) DEFAULT NULL,
  `ROOT_URL` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `REGISTRATION_TOKEN` varchar(255) DEFAULT NULL,
  `STANDARD_FLOW_ENABLED` bit(1) NOT NULL DEFAULT b'1',
  `IMPLICIT_FLOW_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DIRECT_ACCESS_GRANTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `ALWAYS_DISPLAY_IN_CONSOLE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_B71CJLBENV945RB6GCON438AT` (`REALM_ID`,`CLIENT_ID`),
  KEY `IDX_CLIENT_ID` (`CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT`
--

LOCK TABLES `CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT` VALUES ('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','','\0','admin-cli',0,'',NULL,NULL,'\0',NULL,'\0','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','openid-connect',0,'\0','\0','${client_admin-cli}','\0','client-secret',NULL,NULL,NULL,'\0','\0','','\0'),('20f14d27-b1fe-493b-9c51-93721413391a','','\0','account',0,'',NULL,'/realms/scuola/account/','\0',NULL,'\0','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','openid-connect',0,'\0','\0','${client_account}','\0','client-secret','${authBaseUrl}',NULL,NULL,'','\0','\0','\0'),('3f29df46-707e-4fb1-a952-ae9a0fd553e6','','\0','scuola-realm',0,'\0',NULL,NULL,'',NULL,'\0','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL,0,'\0','\0','scuola Realm','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','','\0','account-console',0,'',NULL,'/realms/scuola/account/','\0',NULL,'\0','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','openid-connect',0,'\0','\0','${client_account-console}','\0','client-secret','${authBaseUrl}',NULL,NULL,'','\0','\0','\0'),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','','\0','security-admin-console',0,'',NULL,'/admin/scuola/console/','\0',NULL,'\0','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','openid-connect',0,'\0','\0','${client_security-admin-console}','\0','client-secret','${authAdminUrl}',NULL,NULL,'','\0','\0','\0'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','','','client',0,'\0','MizAkO7AcNiDEgsGwXIsCHWdhAlNMc2A','','\0','','\0','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','openid-connect',-1,'','\0','','\0','client-secret','','Livello scolastico: client',NULL,'','\0','','\0'),('6f8cc551-edc9-41ec-a489-a32729ef6a74','','\0','account',0,'',NULL,'/realms/master/account/','\0',NULL,'\0','f47dc79c-5538-4cdb-9f59-3396e016c2ce','openid-connect',0,'\0','\0','${client_account}','\0','client-secret','${authBaseUrl}',NULL,NULL,'','\0','\0','\0'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','','\0','account-console',0,'',NULL,'/realms/master/account/','\0',NULL,'\0','f47dc79c-5538-4cdb-9f59-3396e016c2ce','openid-connect',0,'\0','\0','${client_account-console}','\0','client-secret','${authBaseUrl}',NULL,NULL,'','\0','\0','\0'),('7deb9688-76ea-4e3b-b776-b723168f47f4','','\0','master-realm',0,'\0',NULL,NULL,'',NULL,'\0','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL,0,'\0','\0','master Realm','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('8565077f-84ed-4a5d-a06b-be52a43d3779','','\0','security-admin-console',0,'',NULL,'/admin/master/console/','\0',NULL,'\0','f47dc79c-5538-4cdb-9f59-3396e016c2ce','openid-connect',0,'\0','\0','${client_security-admin-console}','\0','client-secret','${authAdminUrl}',NULL,NULL,'','\0','\0','\0'),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','','\0','broker',0,'\0',NULL,NULL,'',NULL,'\0','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','openid-connect',0,'\0','\0','${client_broker}','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('da4ead78-5240-4e21-89b7-62d5e810cba6','','\0','broker',0,'\0',NULL,NULL,'',NULL,'\0','f47dc79c-5538-4cdb-9f59-3396e016c2ce','openid-connect',0,'\0','\0','${client_broker}','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('da7c9c79-f949-49d9-867c-2516bd03b14a','','\0','realm-management',0,'\0',NULL,NULL,'',NULL,'\0','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','openid-connect',0,'\0','\0','${client_realm-management}','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('e7035414-550c-451d-ac74-52e6070c11d7','','\0','admin-cli',0,'',NULL,NULL,'\0',NULL,'\0','f47dc79c-5538-4cdb-9f59-3396e016c2ce','openid-connect',0,'\0','\0','${client_admin-cli}','\0','client-secret',NULL,NULL,NULL,'\0','\0','','\0');
/*!40000 ALTER TABLE `CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_ATTRIBUTES` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  KEY `IDX_CLIENT_ATT_BY_NAME_VALUE` (`NAME`),
  CONSTRAINT `FK3C47C64BEACCA966` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_ATTRIBUTES`
--

LOCK TABLES `CLIENT_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_ATTRIBUTES` VALUES ('20f14d27-b1fe-493b-9c51-93721413391a','post.logout.redirect.uris','+'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','pkce.code.challenge.method','S256'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','post.logout.redirect.uris','+'),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','pkce.code.challenge.method','S256'),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','post.logout.redirect.uris','+'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','backchannel.logout.revoke.offline.tokens','false'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','backchannel.logout.session.required','true'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','client.secret.creation.time','1677414979'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','oauth2.device.authorization.grant.enabled','true'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','oidc.ciba.grant.enabled','false'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','post.logout.redirect.uris','*'),('6f8cc551-edc9-41ec-a489-a32729ef6a74','post.logout.redirect.uris','+'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','pkce.code.challenge.method','S256'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','post.logout.redirect.uris','+'),('8565077f-84ed-4a5d-a06b-be52a43d3779','pkce.code.challenge.method','S256'),('8565077f-84ed-4a5d-a06b-be52a43d3779','post.logout.redirect.uris','+');
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_AUTH_FLOW_BINDINGS`
--

DROP TABLE IF EXISTS `CLIENT_AUTH_FLOW_BINDINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_AUTH_FLOW_BINDINGS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `BINDING_NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`BINDING_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_AUTH_FLOW_BINDINGS`
--

LOCK TABLES `CLIENT_AUTH_FLOW_BINDINGS` WRITE;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_INITIAL_ACCESS`
--

DROP TABLE IF EXISTS `CLIENT_INITIAL_ACCESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_INITIAL_ACCESS` (
  `ID` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `EXPIRATION` int(11) DEFAULT NULL,
  `COUNT` int(11) DEFAULT NULL,
  `REMAINING_COUNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_INIT_ACC_REALM` (`REALM_ID`),
  CONSTRAINT `FK_CLIENT_INIT_ACC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_INITIAL_ACCESS`
--

LOCK TABLES `CLIENT_INITIAL_ACCESS` WRITE;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_NODE_REGISTRATIONS`
--

DROP TABLE IF EXISTS `CLIENT_NODE_REGISTRATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_NODE_REGISTRATIONS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` int(11) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  CONSTRAINT `FK4129723BA992F594` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_NODE_REGISTRATIONS`
--

LOCK TABLES `CLIENT_NODE_REGISTRATIONS` WRITE;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_CLI_SCOPE` (`REALM_ID`,`NAME`),
  KEY `IDX_REALM_CLSCOPE` (`REALM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE`
--

LOCK TABLES `CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE` VALUES ('12d0c4f6-a710-4a39-b9ca-232aed84e7ba','microprofile-jwt','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','Microprofile - JWT built-in scope','openid-connect'),('134afcf8-caf1-49c4-98da-90833e4da9a5','roles','f47dc79c-5538-4cdb-9f59-3396e016c2ce','OpenID Connect scope for add user roles to the access token','openid-connect'),('169c80ee-8fdc-429c-8d3d-fb13ed07641c','acr','f47dc79c-5538-4cdb-9f59-3396e016c2ce','OpenID Connect scope for add acr (authentication context class reference) to the token','openid-connect'),('20c5c4ed-a639-4a45-b103-f489206cd216','offline_access','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OpenID Connect built-in scope: offline_access','openid-connect'),('3074ee96-675f-4b63-a93a-6ed4f021518a','acr','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OpenID Connect scope for add acr (authentication context class reference) to the token','openid-connect'),('35a9832a-809b-49da-9f1f-6691ba056241','phone','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OpenID Connect built-in scope: phone','openid-connect'),('3a86c79f-d616-4587-863b-a959f530767a','address','f47dc79c-5538-4cdb-9f59-3396e016c2ce','OpenID Connect built-in scope: address','openid-connect'),('551d382e-5a57-404b-a29e-9582b44ffbf1','phone','f47dc79c-5538-4cdb-9f59-3396e016c2ce','OpenID Connect built-in scope: phone','openid-connect'),('6b03a12f-2a22-4dcd-9abf-466a4e24aa40','roles','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OpenID Connect scope for add user roles to the access token','openid-connect'),('81183c49-5ece-45bb-af80-59594c9320eb','role_list','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','SAML role list','saml'),('81d6d87e-493d-442c-8291-f47569b51ab1','web-origins','f47dc79c-5538-4cdb-9f59-3396e016c2ce','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('8d55860b-62f0-48ee-9fe9-6aa26cf3d26c','email','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OpenID Connect built-in scope: email','openid-connect'),('9c1cd945-a70a-45a8-9464-b9040e030b6b','email','f47dc79c-5538-4cdb-9f59-3396e016c2ce','OpenID Connect built-in scope: email','openid-connect'),('b5b92343-a341-4659-a627-3cd5a944b245','address','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OpenID Connect built-in scope: address','openid-connect'),('be51b110-5374-460d-9564-cf852d6ffedd','profile','f47dc79c-5538-4cdb-9f59-3396e016c2ce','OpenID Connect built-in scope: profile','openid-connect'),('c71449e0-78ed-4282-84c6-15ad23c781dc','web-origins','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('cd1cdc3a-632c-48e4-b50e-36c69e528969','role_list','f47dc79c-5538-4cdb-9f59-3396e016c2ce','SAML role list','saml'),('dafac659-546c-4633-898e-455da5e38483','profile','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OpenID Connect built-in scope: profile','openid-connect'),('ea74111f-bba8-41ed-9a6e-b7335965204b','microprofile-jwt','f47dc79c-5538-4cdb-9f59-3396e016c2ce','Microprofile - JWT built-in scope','openid-connect'),('ee1a77a1-88b4-42fe-8a0f-20fc98089644','offline_access','f47dc79c-5538-4cdb-9f59-3396e016c2ce','OpenID Connect built-in scope: offline_access','openid-connect');
/*!40000 ALTER TABLE `CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SCOPE_ATTRIBUTES` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `VALUE` text DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`NAME`),
  KEY `IDX_CLSCOPE_ATTRS` (`SCOPE_ID`),
  CONSTRAINT `FK_CL_SCOPE_ATTR_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ATTRIBUTES`
--

LOCK TABLES `CLIENT_SCOPE_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ATTRIBUTES` VALUES ('12d0c4f6-a710-4a39-b9ca-232aed84e7ba','false','display.on.consent.screen'),('12d0c4f6-a710-4a39-b9ca-232aed84e7ba','true','include.in.token.scope'),('134afcf8-caf1-49c4-98da-90833e4da9a5','${rolesScopeConsentText}','consent.screen.text'),('134afcf8-caf1-49c4-98da-90833e4da9a5','true','display.on.consent.screen'),('134afcf8-caf1-49c4-98da-90833e4da9a5','false','include.in.token.scope'),('169c80ee-8fdc-429c-8d3d-fb13ed07641c','false','display.on.consent.screen'),('169c80ee-8fdc-429c-8d3d-fb13ed07641c','false','include.in.token.scope'),('20c5c4ed-a639-4a45-b103-f489206cd216','${offlineAccessScopeConsentText}','consent.screen.text'),('20c5c4ed-a639-4a45-b103-f489206cd216','true','display.on.consent.screen'),('3074ee96-675f-4b63-a93a-6ed4f021518a','false','display.on.consent.screen'),('3074ee96-675f-4b63-a93a-6ed4f021518a','false','include.in.token.scope'),('35a9832a-809b-49da-9f1f-6691ba056241','${phoneScopeConsentText}','consent.screen.text'),('35a9832a-809b-49da-9f1f-6691ba056241','true','display.on.consent.screen'),('35a9832a-809b-49da-9f1f-6691ba056241','true','include.in.token.scope'),('3a86c79f-d616-4587-863b-a959f530767a','${addressScopeConsentText}','consent.screen.text'),('3a86c79f-d616-4587-863b-a959f530767a','true','display.on.consent.screen'),('3a86c79f-d616-4587-863b-a959f530767a','true','include.in.token.scope'),('551d382e-5a57-404b-a29e-9582b44ffbf1','${phoneScopeConsentText}','consent.screen.text'),('551d382e-5a57-404b-a29e-9582b44ffbf1','true','display.on.consent.screen'),('551d382e-5a57-404b-a29e-9582b44ffbf1','true','include.in.token.scope'),('6b03a12f-2a22-4dcd-9abf-466a4e24aa40','${rolesScopeConsentText}','consent.screen.text'),('6b03a12f-2a22-4dcd-9abf-466a4e24aa40','true','display.on.consent.screen'),('6b03a12f-2a22-4dcd-9abf-466a4e24aa40','false','include.in.token.scope'),('81183c49-5ece-45bb-af80-59594c9320eb','${samlRoleListScopeConsentText}','consent.screen.text'),('81183c49-5ece-45bb-af80-59594c9320eb','true','display.on.consent.screen'),('81d6d87e-493d-442c-8291-f47569b51ab1','','consent.screen.text'),('81d6d87e-493d-442c-8291-f47569b51ab1','false','display.on.consent.screen'),('81d6d87e-493d-442c-8291-f47569b51ab1','false','include.in.token.scope'),('8d55860b-62f0-48ee-9fe9-6aa26cf3d26c','${emailScopeConsentText}','consent.screen.text'),('8d55860b-62f0-48ee-9fe9-6aa26cf3d26c','true','display.on.consent.screen'),('8d55860b-62f0-48ee-9fe9-6aa26cf3d26c','true','include.in.token.scope'),('9c1cd945-a70a-45a8-9464-b9040e030b6b','${emailScopeConsentText}','consent.screen.text'),('9c1cd945-a70a-45a8-9464-b9040e030b6b','true','display.on.consent.screen'),('9c1cd945-a70a-45a8-9464-b9040e030b6b','true','include.in.token.scope'),('b5b92343-a341-4659-a627-3cd5a944b245','${addressScopeConsentText}','consent.screen.text'),('b5b92343-a341-4659-a627-3cd5a944b245','true','display.on.consent.screen'),('b5b92343-a341-4659-a627-3cd5a944b245','true','include.in.token.scope'),('be51b110-5374-460d-9564-cf852d6ffedd','${profileScopeConsentText}','consent.screen.text'),('be51b110-5374-460d-9564-cf852d6ffedd','true','display.on.consent.screen'),('be51b110-5374-460d-9564-cf852d6ffedd','true','include.in.token.scope'),('c71449e0-78ed-4282-84c6-15ad23c781dc','','consent.screen.text'),('c71449e0-78ed-4282-84c6-15ad23c781dc','false','display.on.consent.screen'),('c71449e0-78ed-4282-84c6-15ad23c781dc','false','include.in.token.scope'),('cd1cdc3a-632c-48e4-b50e-36c69e528969','${samlRoleListScopeConsentText}','consent.screen.text'),('cd1cdc3a-632c-48e4-b50e-36c69e528969','true','display.on.consent.screen'),('dafac659-546c-4633-898e-455da5e38483','${profileScopeConsentText}','consent.screen.text'),('dafac659-546c-4633-898e-455da5e38483','true','display.on.consent.screen'),('dafac659-546c-4633-898e-455da5e38483','true','include.in.token.scope'),('ea74111f-bba8-41ed-9a6e-b7335965204b','false','display.on.consent.screen'),('ea74111f-bba8-41ed-9a6e-b7335965204b','true','include.in.token.scope'),('ee1a77a1-88b4-42fe-8a0f-20fc98089644','${offlineAccessScopeConsentText}','consent.screen.text'),('ee1a77a1-88b4-42fe-8a0f-20fc98089644','true','display.on.consent.screen');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_CLIENT`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SCOPE_CLIENT` (
  `CLIENT_ID` varchar(255) NOT NULL,
  `SCOPE_ID` varchar(255) NOT NULL,
  `DEFAULT_SCOPE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`CLIENT_ID`,`SCOPE_ID`),
  KEY `IDX_CLSCOPE_CL` (`CLIENT_ID`),
  KEY `IDX_CL_CLSCOPE` (`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_CLIENT`
--

LOCK TABLES `CLIENT_SCOPE_CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_CLIENT` VALUES ('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','12d0c4f6-a710-4a39-b9ca-232aed84e7ba','\0'),('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','20c5c4ed-a639-4a45-b103-f489206cd216','\0'),('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','3074ee96-675f-4b63-a93a-6ed4f021518a',''),('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','35a9832a-809b-49da-9f1f-6691ba056241','\0'),('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','6b03a12f-2a22-4dcd-9abf-466a4e24aa40',''),('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','8d55860b-62f0-48ee-9fe9-6aa26cf3d26c',''),('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','b5b92343-a341-4659-a627-3cd5a944b245','\0'),('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','c71449e0-78ed-4282-84c6-15ad23c781dc',''),('1e60ff84-8e0b-413a-ab8b-801ec276a2d6','dafac659-546c-4633-898e-455da5e38483',''),('20f14d27-b1fe-493b-9c51-93721413391a','12d0c4f6-a710-4a39-b9ca-232aed84e7ba','\0'),('20f14d27-b1fe-493b-9c51-93721413391a','20c5c4ed-a639-4a45-b103-f489206cd216','\0'),('20f14d27-b1fe-493b-9c51-93721413391a','3074ee96-675f-4b63-a93a-6ed4f021518a',''),('20f14d27-b1fe-493b-9c51-93721413391a','35a9832a-809b-49da-9f1f-6691ba056241','\0'),('20f14d27-b1fe-493b-9c51-93721413391a','6b03a12f-2a22-4dcd-9abf-466a4e24aa40',''),('20f14d27-b1fe-493b-9c51-93721413391a','8d55860b-62f0-48ee-9fe9-6aa26cf3d26c',''),('20f14d27-b1fe-493b-9c51-93721413391a','b5b92343-a341-4659-a627-3cd5a944b245','\0'),('20f14d27-b1fe-493b-9c51-93721413391a','c71449e0-78ed-4282-84c6-15ad23c781dc',''),('20f14d27-b1fe-493b-9c51-93721413391a','dafac659-546c-4633-898e-455da5e38483',''),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','12d0c4f6-a710-4a39-b9ca-232aed84e7ba','\0'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','20c5c4ed-a639-4a45-b103-f489206cd216','\0'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','3074ee96-675f-4b63-a93a-6ed4f021518a',''),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','35a9832a-809b-49da-9f1f-6691ba056241','\0'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','6b03a12f-2a22-4dcd-9abf-466a4e24aa40',''),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','8d55860b-62f0-48ee-9fe9-6aa26cf3d26c',''),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','b5b92343-a341-4659-a627-3cd5a944b245','\0'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','c71449e0-78ed-4282-84c6-15ad23c781dc',''),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','dafac659-546c-4633-898e-455da5e38483',''),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','12d0c4f6-a710-4a39-b9ca-232aed84e7ba','\0'),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','20c5c4ed-a639-4a45-b103-f489206cd216','\0'),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','3074ee96-675f-4b63-a93a-6ed4f021518a',''),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','35a9832a-809b-49da-9f1f-6691ba056241','\0'),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','6b03a12f-2a22-4dcd-9abf-466a4e24aa40',''),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','8d55860b-62f0-48ee-9fe9-6aa26cf3d26c',''),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','b5b92343-a341-4659-a627-3cd5a944b245','\0'),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','c71449e0-78ed-4282-84c6-15ad23c781dc',''),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','dafac659-546c-4633-898e-455da5e38483',''),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','12d0c4f6-a710-4a39-b9ca-232aed84e7ba','\0'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','20c5c4ed-a639-4a45-b103-f489206cd216','\0'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','3074ee96-675f-4b63-a93a-6ed4f021518a',''),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','35a9832a-809b-49da-9f1f-6691ba056241','\0'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','6b03a12f-2a22-4dcd-9abf-466a4e24aa40',''),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','8d55860b-62f0-48ee-9fe9-6aa26cf3d26c',''),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','b5b92343-a341-4659-a627-3cd5a944b245','\0'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','c71449e0-78ed-4282-84c6-15ad23c781dc',''),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','dafac659-546c-4633-898e-455da5e38483',''),('6f8cc551-edc9-41ec-a489-a32729ef6a74','134afcf8-caf1-49c4-98da-90833e4da9a5',''),('6f8cc551-edc9-41ec-a489-a32729ef6a74','169c80ee-8fdc-429c-8d3d-fb13ed07641c',''),('6f8cc551-edc9-41ec-a489-a32729ef6a74','3a86c79f-d616-4587-863b-a959f530767a','\0'),('6f8cc551-edc9-41ec-a489-a32729ef6a74','551d382e-5a57-404b-a29e-9582b44ffbf1','\0'),('6f8cc551-edc9-41ec-a489-a32729ef6a74','81d6d87e-493d-442c-8291-f47569b51ab1',''),('6f8cc551-edc9-41ec-a489-a32729ef6a74','9c1cd945-a70a-45a8-9464-b9040e030b6b',''),('6f8cc551-edc9-41ec-a489-a32729ef6a74','be51b110-5374-460d-9564-cf852d6ffedd',''),('6f8cc551-edc9-41ec-a489-a32729ef6a74','ea74111f-bba8-41ed-9a6e-b7335965204b','\0'),('6f8cc551-edc9-41ec-a489-a32729ef6a74','ee1a77a1-88b4-42fe-8a0f-20fc98089644','\0'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','134afcf8-caf1-49c4-98da-90833e4da9a5',''),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','169c80ee-8fdc-429c-8d3d-fb13ed07641c',''),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','3a86c79f-d616-4587-863b-a959f530767a','\0'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','551d382e-5a57-404b-a29e-9582b44ffbf1','\0'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','81d6d87e-493d-442c-8291-f47569b51ab1',''),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','9c1cd945-a70a-45a8-9464-b9040e030b6b',''),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','be51b110-5374-460d-9564-cf852d6ffedd',''),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','ea74111f-bba8-41ed-9a6e-b7335965204b','\0'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','ee1a77a1-88b4-42fe-8a0f-20fc98089644','\0'),('7deb9688-76ea-4e3b-b776-b723168f47f4','134afcf8-caf1-49c4-98da-90833e4da9a5',''),('7deb9688-76ea-4e3b-b776-b723168f47f4','169c80ee-8fdc-429c-8d3d-fb13ed07641c',''),('7deb9688-76ea-4e3b-b776-b723168f47f4','3a86c79f-d616-4587-863b-a959f530767a','\0'),('7deb9688-76ea-4e3b-b776-b723168f47f4','551d382e-5a57-404b-a29e-9582b44ffbf1','\0'),('7deb9688-76ea-4e3b-b776-b723168f47f4','81d6d87e-493d-442c-8291-f47569b51ab1',''),('7deb9688-76ea-4e3b-b776-b723168f47f4','9c1cd945-a70a-45a8-9464-b9040e030b6b',''),('7deb9688-76ea-4e3b-b776-b723168f47f4','be51b110-5374-460d-9564-cf852d6ffedd',''),('7deb9688-76ea-4e3b-b776-b723168f47f4','ea74111f-bba8-41ed-9a6e-b7335965204b','\0'),('7deb9688-76ea-4e3b-b776-b723168f47f4','ee1a77a1-88b4-42fe-8a0f-20fc98089644','\0'),('8565077f-84ed-4a5d-a06b-be52a43d3779','134afcf8-caf1-49c4-98da-90833e4da9a5',''),('8565077f-84ed-4a5d-a06b-be52a43d3779','169c80ee-8fdc-429c-8d3d-fb13ed07641c',''),('8565077f-84ed-4a5d-a06b-be52a43d3779','3a86c79f-d616-4587-863b-a959f530767a','\0'),('8565077f-84ed-4a5d-a06b-be52a43d3779','551d382e-5a57-404b-a29e-9582b44ffbf1','\0'),('8565077f-84ed-4a5d-a06b-be52a43d3779','81d6d87e-493d-442c-8291-f47569b51ab1',''),('8565077f-84ed-4a5d-a06b-be52a43d3779','9c1cd945-a70a-45a8-9464-b9040e030b6b',''),('8565077f-84ed-4a5d-a06b-be52a43d3779','be51b110-5374-460d-9564-cf852d6ffedd',''),('8565077f-84ed-4a5d-a06b-be52a43d3779','ea74111f-bba8-41ed-9a6e-b7335965204b','\0'),('8565077f-84ed-4a5d-a06b-be52a43d3779','ee1a77a1-88b4-42fe-8a0f-20fc98089644','\0'),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','12d0c4f6-a710-4a39-b9ca-232aed84e7ba','\0'),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','20c5c4ed-a639-4a45-b103-f489206cd216','\0'),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','3074ee96-675f-4b63-a93a-6ed4f021518a',''),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','35a9832a-809b-49da-9f1f-6691ba056241','\0'),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','6b03a12f-2a22-4dcd-9abf-466a4e24aa40',''),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','8d55860b-62f0-48ee-9fe9-6aa26cf3d26c',''),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','b5b92343-a341-4659-a627-3cd5a944b245','\0'),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','c71449e0-78ed-4282-84c6-15ad23c781dc',''),('9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','dafac659-546c-4633-898e-455da5e38483',''),('da4ead78-5240-4e21-89b7-62d5e810cba6','134afcf8-caf1-49c4-98da-90833e4da9a5',''),('da4ead78-5240-4e21-89b7-62d5e810cba6','169c80ee-8fdc-429c-8d3d-fb13ed07641c',''),('da4ead78-5240-4e21-89b7-62d5e810cba6','3a86c79f-d616-4587-863b-a959f530767a','\0'),('da4ead78-5240-4e21-89b7-62d5e810cba6','551d382e-5a57-404b-a29e-9582b44ffbf1','\0'),('da4ead78-5240-4e21-89b7-62d5e810cba6','81d6d87e-493d-442c-8291-f47569b51ab1',''),('da4ead78-5240-4e21-89b7-62d5e810cba6','9c1cd945-a70a-45a8-9464-b9040e030b6b',''),('da4ead78-5240-4e21-89b7-62d5e810cba6','be51b110-5374-460d-9564-cf852d6ffedd',''),('da4ead78-5240-4e21-89b7-62d5e810cba6','ea74111f-bba8-41ed-9a6e-b7335965204b','\0'),('da4ead78-5240-4e21-89b7-62d5e810cba6','ee1a77a1-88b4-42fe-8a0f-20fc98089644','\0'),('da7c9c79-f949-49d9-867c-2516bd03b14a','12d0c4f6-a710-4a39-b9ca-232aed84e7ba','\0'),('da7c9c79-f949-49d9-867c-2516bd03b14a','20c5c4ed-a639-4a45-b103-f489206cd216','\0'),('da7c9c79-f949-49d9-867c-2516bd03b14a','3074ee96-675f-4b63-a93a-6ed4f021518a',''),('da7c9c79-f949-49d9-867c-2516bd03b14a','35a9832a-809b-49da-9f1f-6691ba056241','\0'),('da7c9c79-f949-49d9-867c-2516bd03b14a','6b03a12f-2a22-4dcd-9abf-466a4e24aa40',''),('da7c9c79-f949-49d9-867c-2516bd03b14a','8d55860b-62f0-48ee-9fe9-6aa26cf3d26c',''),('da7c9c79-f949-49d9-867c-2516bd03b14a','b5b92343-a341-4659-a627-3cd5a944b245','\0'),('da7c9c79-f949-49d9-867c-2516bd03b14a','c71449e0-78ed-4282-84c6-15ad23c781dc',''),('da7c9c79-f949-49d9-867c-2516bd03b14a','dafac659-546c-4633-898e-455da5e38483',''),('e7035414-550c-451d-ac74-52e6070c11d7','134afcf8-caf1-49c4-98da-90833e4da9a5',''),('e7035414-550c-451d-ac74-52e6070c11d7','169c80ee-8fdc-429c-8d3d-fb13ed07641c',''),('e7035414-550c-451d-ac74-52e6070c11d7','3a86c79f-d616-4587-863b-a959f530767a','\0'),('e7035414-550c-451d-ac74-52e6070c11d7','551d382e-5a57-404b-a29e-9582b44ffbf1','\0'),('e7035414-550c-451d-ac74-52e6070c11d7','81d6d87e-493d-442c-8291-f47569b51ab1',''),('e7035414-550c-451d-ac74-52e6070c11d7','9c1cd945-a70a-45a8-9464-b9040e030b6b',''),('e7035414-550c-451d-ac74-52e6070c11d7','be51b110-5374-460d-9564-cf852d6ffedd',''),('e7035414-550c-451d-ac74-52e6070c11d7','ea74111f-bba8-41ed-9a6e-b7335965204b','\0'),('e7035414-550c-451d-ac74-52e6070c11d7','ee1a77a1-88b4-42fe-8a0f-20fc98089644','\0');
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SCOPE_ROLE_MAPPING` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`ROLE_ID`),
  KEY `IDX_CLSCOPE_ROLE` (`SCOPE_ID`),
  KEY `IDX_ROLE_CLSCOPE` (`ROLE_ID`),
  CONSTRAINT `FK_CL_SCOPE_RM_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ROLE_MAPPING`
--

LOCK TABLES `CLIENT_SCOPE_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ROLE_MAPPING` VALUES ('20c5c4ed-a639-4a45-b103-f489206cd216','d46c3078-21c6-4ed1-a19e-4f53f6194328'),('ee1a77a1-88b4-42fe-8a0f-20fc98089644','1856ffd4-8181-4cae-9a93-61e659f39bb9');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION`
--

DROP TABLE IF EXISTS `CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `REDIRECT_URI` varchar(255) DEFAULT NULL,
  `STATE` varchar(255) DEFAULT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `SESSION_ID` varchar(36) DEFAULT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(36) DEFAULT NULL,
  `CURRENT_ACTION` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_SESSION_SESSION` (`SESSION_ID`),
  CONSTRAINT `FK_B4AO2VCVAT6UKAU74WBWTFQO1` FOREIGN KEY (`SESSION_ID`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION`
--

LOCK TABLES `CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_AUTH_STATUS`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_AUTH_STATUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION_AUTH_STATUS` (
  `AUTHENTICATOR` varchar(36) NOT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`AUTHENTICATOR`),
  CONSTRAINT `AUTH_STATUS_CONSTRAINT` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_AUTH_STATUS`
--

LOCK TABLES `CLIENT_SESSION_AUTH_STATUS` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51C2736` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_NOTE`
--

LOCK TABLES `CLIENT_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_PROT_MAPPER`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_PROT_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION_PROT_MAPPER` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`PROTOCOL_MAPPER_ID`),
  CONSTRAINT `FK_33A8SGQW18I532811V7O2DK89` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_PROT_MAPPER`
--

LOCK TABLES `CLIENT_SESSION_PROT_MAPPER` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_ROLE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION_ROLE` (
  `ROLE_ID` varchar(255) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`ROLE_ID`),
  CONSTRAINT `FK_11B7SGQW18I532811V7O2DV76` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_ROLE`
--

LOCK TABLES `CLIENT_SESSION_ROLE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_USER_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` text DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK_CL_USR_SES_NOTE` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_USER_SESSION_NOTE`
--

LOCK TABLES `CLIENT_USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT`
--

DROP TABLE IF EXISTS `COMPONENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMPONENT` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_TYPE` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `SUB_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPONENT_REALM` (`REALM_ID`),
  KEY `IDX_COMPONENT_PROVIDER_TYPE` (`PROVIDER_TYPE`),
  CONSTRAINT `FK_COMPONENT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT`
--

LOCK TABLES `COMPONENT` WRITE;
/*!40000 ALTER TABLE `COMPONENT` DISABLE KEYS */;
INSERT INTO `COMPONENT` VALUES ('04fe8186-575b-46db-9619-e62b021ac352','Allowed Client Scopes','f47dc79c-5538-4cdb-9f59-3396e016c2ce','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','anonymous'),('0c3fe8c3-8f18-4e06-9dd8-3ee0ec3fae1a','Trusted Hosts','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','anonymous'),('0d0fd2e6-e51d-4df8-974c-b8b19559e753','rsa-generated','f47dc79c-5538-4cdb-9f59-3396e016c2ce','rsa-generated','org.keycloak.keys.KeyProvider','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL),('17c743e5-6c29-4dd4-a0e2-2775b61cdbc7','Allowed Client Scopes','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','anonymous'),('18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','Allowed Protocol Mapper Types','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','authenticated'),('18d81900-d10a-43a9-9539-55f5dcfd3ac4','rsa-generated','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','rsa-generated','org.keycloak.keys.KeyProvider','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL),('2a16f023-6e76-4a8f-b022-a62c808593fd','aes-generated','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','aes-generated','org.keycloak.keys.KeyProvider','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL),('30f89941-4148-474d-8737-8540bdaa9e2a','aes-generated','f47dc79c-5538-4cdb-9f59-3396e016c2ce','aes-generated','org.keycloak.keys.KeyProvider','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL),('406604e0-ec24-4c73-8e84-a69dafaf6193','hmac-generated','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','hmac-generated','org.keycloak.keys.KeyProvider','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL),('6acc7e68-2dd6-4851-b4b2-2b01514e1b74','Consent Required','f47dc79c-5538-4cdb-9f59-3396e016c2ce','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','anonymous'),('6c51318e-6cf4-4e15-b0d8-bd662b4a1aab','Full Scope Disabled','f47dc79c-5538-4cdb-9f59-3396e016c2ce','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','anonymous'),('abed8210-8a8e-440e-80cd-67c17c6ca96a','Allowed Client Scopes','f47dc79c-5538-4cdb-9f59-3396e016c2ce','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','authenticated'),('ac10ba06-09b8-4128-8e5a-c287f43d92c2','Consent Required','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','anonymous'),('b19cb0cb-3767-4dbb-8aa2-c7c4589569dd','Max Clients Limit','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','anonymous'),('bb80259c-1ffc-4d82-aba1-c611c1e5e363','Allowed Protocol Mapper Types','f47dc79c-5538-4cdb-9f59-3396e016c2ce','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','authenticated'),('bd153dab-5f79-4a07-83f6-c558007e1362','Allowed Protocol Mapper Types','f47dc79c-5538-4cdb-9f59-3396e016c2ce','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','anonymous'),('c6d03e2f-72c6-43de-a5c8-be84b96f9374','rsa-enc-generated','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','rsa-enc-generated','org.keycloak.keys.KeyProvider','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL),('c72cc421-ad67-4636-9bd2-ffa35d732262','hmac-generated','f47dc79c-5538-4cdb-9f59-3396e016c2ce','hmac-generated','org.keycloak.keys.KeyProvider','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL),('c8edceae-7cad-4f98-912e-f3fd5240283b','Allowed Client Scopes','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','authenticated'),('d0d8cfb6-ea52-46c4-9865-d09261e150aa','rsa-enc-generated','f47dc79c-5538-4cdb-9f59-3396e016c2ce','rsa-enc-generated','org.keycloak.keys.KeyProvider','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL),('d82394b6-eaf3-4a91-b01d-5dbf7aaa005d','Trusted Hosts','f47dc79c-5538-4cdb-9f59-3396e016c2ce','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','anonymous'),('ed6e1259-90e2-494f-b8f7-e16756cf6890',NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','declarative-user-profile','org.keycloak.userprofile.UserProfileProvider','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL),('f3bc3056-d3db-41b8-85ce-0d86d043b344','Allowed Protocol Mapper Types','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','anonymous'),('f5015637-bec7-41a7-991d-7a39f13b65df','Max Clients Limit','f47dc79c-5538-4cdb-9f59-3396e016c2ce','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','anonymous'),('ff7bfa6f-a90d-42e2-9994-957ed0c1dfa2','Full Scope Disabled','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','anonymous');
/*!40000 ALTER TABLE `COMPONENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT_CONFIG`
--

DROP TABLE IF EXISTS `COMPONENT_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMPONENT_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `COMPONENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPO_CONFIG_COMPO` (`COMPONENT_ID`),
  CONSTRAINT `FK_COMPONENT_CONFIG` FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT_CONFIG`
--

LOCK TABLES `COMPONENT_CONFIG` WRITE;
/*!40000 ALTER TABLE `COMPONENT_CONFIG` DISABLE KEYS */;
INSERT INTO `COMPONENT_CONFIG` VALUES ('0028ab33-3e92-4fa1-a562-2dcb0d1e35f0','abed8210-8a8e-440e-80cd-67c17c6ca96a','allow-default-scopes','true'),('04bc3c02-f9ff-4227-ac10-8be800cdd467','bb80259c-1ffc-4d82-aba1-c611c1e5e363','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('0571c983-17f6-4c12-a731-40138021d881','bd153dab-5f79-4a07-83f6-c558007e1362','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('06e92a9a-1b36-4b42-93f1-0d8193773ab4','c6d03e2f-72c6-43de-a5c8-be84b96f9374','keyUse','ENC'),('09dddce6-5eef-437d-b510-b03997e62a03','18d81900-d10a-43a9-9539-55f5dcfd3ac4','priority','100'),('0a4760c9-34a2-4fab-aae0-bc43be8ee7dd','406604e0-ec24-4c73-8e84-a69dafaf6193','priority','100'),('0ae88504-7793-411f-9743-f8bf6766cb1b','18d81900-d10a-43a9-9539-55f5dcfd3ac4','privateKey','MIIEogIBAAKCAQEAvx7oqbpbBqR3JKDNa+DMN//FLr3nzMzvjsswZi8eAi5mzsiVrbiLlpMEa4hSh3pAhoHKkvsCTwB4FSDUGEgs+5dXxUXyvM0PkzJwMLiK/Isgb+HNvaSwP30fr8nJaV795S7zpO+EGv3d3NF3pSAkeWJDWEyILWOhV+KM0j7d1YaF4IfkMy5uGf5rIbTnrRn3gRHv5kxL4ku/wCPnFRkzDtHq6uaIiUBqf/1CMxTZXUlFmFvJ6yFuRT3/zRj28gUy/ZOpKDFnIJnbnzDSrBhUIlfJvZOYxcczLYFVi4oESU6Nm4eTatfYyw+eLF2uVpvqPsKQFQnzdoU4VS8gWxTcRQIDAQABAoIBABrfroEBNH/2W89xcfkfkq+0HgagyumUDoJSZWOU8AAIBMpCT7Ot/ajGUuqI8Gve35haQ0EQHQa9TuVPqKsiaPrWkM+rMoLkRbKhtr9PD7ILoRvCUUL/l43R2wUFl3Xi1solZDqWuElwVYRRiuST5LURwVz24/YX6o24TCtbDifSJGezwkdxWeGvSYMgX4nKfCuqxlrNdmTaXEMYE0pje+O6jog4owWfrCAmZWHNKJfz8JvjqkggVtgQ84kolqSWvmEUeFHodfBpiF0KtoOgBlRkNUf0fOCUDNHh42O8WIARCR1uukmkVcRqVQmQoUW2MQQoRviLu2qq8C1lIIXBBVkCgYEA8fV0bJtIp1xMo7ulPcf6yab9pdi8O/E6OR+/QvViTGVmuNmHLcBi/amvqZ1Fflt37rpS5YOyd1eFz9s8tKqHu8hZY4f+ELpfQzsLo0Wtf06bespV/ugNIQRANw8Hg74zeWlgtIz7jO1IKdR4Jo4jVtiZ87mGdnwTtC9YZUeu+d0CgYEAyjYz3bwlmxj5l36Q/TIiZU21TwfIWmInaAq/H7fhAgFdaNCJP0LiJA0pQH08xuwpigr7b1oIfeTCWFHrmVgLD7fhnyhELSubWjluazG0H5COMhiXIkHgOsqUxy8kjOhui8FQTin+yazXgXVYgnJf7bWPSgeAS2aRPsyw7m4z6YkCgYA1nUgxEK+mtiMdXOUerYN6z5ABAeej+K4IHmrJMYqYlxeN+lWj46+Lud/826acezQ2J/9acDZJj5FNH61x8x+kkp6MGYRIvKODSEAp67SoMwjsyo0HsO/H0yNPj/sATFMnohwVpe/PqHyHGFePY4udIN3sTb3n31KWaK9TsfCp2QKBgGL2iAe67wSrAmwcK0VfZeoCT/uvqWRiqTqIF+WkDmD23gpQFPt69kYCku/W2wnXxrSij0991q4WaO7kmNNhfXhh2/ASutsIfm13sgyQNMFF8/Gci0rexqi/QHUDI3Y6wu9u2qiGcQWuq4HWNk0RQNWLh+cJKMa+GdOMRgNKt+lRAoGAAjUW9r/SgmM8PMjYZ9gUqpORM+0o59CltFZA/hkrE78ImJTSXZt9nzjcwDs5Kdk7jZKIcltSjaKSKEon6tCffXL4zMuiW4YcXIbRxYqjIwaCZtzmd3b5zIcGcxlNWwfIvTWi8O/V1IsED+O77uiFWoZEcHtHv5GXXFbAxVluT4Y='),('0de1ebef-562e-47ab-862b-1b65f1e52078','18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('0dec7fe4-f32d-4577-9ddb-1ff2779aa4e1','d82394b6-eaf3-4a91-b01d-5dbf7aaa005d','host-sending-registration-request-must-match','true'),('1385c0fa-e983-464f-85b0-3862a4770bf6','f3bc3056-d3db-41b8-85ce-0d86d043b344','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('167d2b7e-f0ca-4897-91ca-1b1213a83009','bb80259c-1ffc-4d82-aba1-c611c1e5e363','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('1bf036ff-4a85-4370-bb7a-1baa12691e2c','b19cb0cb-3767-4dbb-8aa2-c7c4589569dd','max-clients','200'),('1e116d09-6251-42f0-a3b7-a7f96c451fa9','c72cc421-ad67-4636-9bd2-ffa35d732262','algorithm','HS256'),('2339ad23-edac-472f-b612-7774014f8458','f3bc3056-d3db-41b8-85ce-0d86d043b344','allowed-protocol-mapper-types','saml-role-list-mapper'),('2545c03c-21de-481d-b5e2-10c90bac3354','f5015637-bec7-41a7-991d-7a39f13b65df','max-clients','200'),('263bb4d1-8c49-4c0d-9c51-48d1efa01f81','18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','allowed-protocol-mapper-types','oidc-full-name-mapper'),('27606bf1-d3ef-469e-82bf-00ed4d3e3668','bd153dab-5f79-4a07-83f6-c558007e1362','allowed-protocol-mapper-types','saml-user-property-mapper'),('2ceaf621-3b41-47e4-962d-3286321f283e','0c3fe8c3-8f18-4e06-9dd8-3ee0ec3fae1a','client-uris-must-match','true'),('2e680800-8cbd-449e-9b40-74249c8c4a77','bd153dab-5f79-4a07-83f6-c558007e1362','allowed-protocol-mapper-types','oidc-address-mapper'),('2f3ab74c-ad16-4ba0-874a-b18b5a02b37e','30f89941-4148-474d-8737-8540bdaa9e2a','secret','r80KcBpCZL0YSVju8WRc_w'),('2fa3cc4f-594e-44d3-99db-9ea4ae8e9df2','d0d8cfb6-ea52-46c4-9865-d09261e150aa','certificate','MIICmzCCAYMCBgGGjWduMTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMjI2MTEwNTExWhcNMzMwMjI2MTEwNjUxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0jhaLsJfXitkxKiFMkqKdv4vE6wjPVoVSQH9TMe717H1kieV6DfEhnzpDXwNoihADInzyj86/DGrpwtTeo/sPNrNp1ZUs+fALB6D1em6+Og5auRT0+gPnCI3jDDtdg5XtqP4CSwPh8mMpnTAjwcHoMX390l5eBaXl72UVaSN/oTH5gRkqpBHbjrz/7W3JlOTVrZOdudJ80jnHmtlQoJr3jSKiv+L5QOJj7nfXljUd54ANvqOPxttwCkwE+Mxj/fEgmkI2LgEZnHu+jsBdrpmr5weL8+WwfRQMuW8N31cKKhcf4K16f1fKMN9lacu1s2ZL9jGFYcNGnEAE+eExjE7VAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACyu/MA5UmWGkomQQVH2uc9xjqpfNDxHWzQITNDzrUjR8Tp68VZ9ZTtTjMZThs8tEsVIfiOzD70FeRMx/B4ZkFzWP/2bPMkpjtU0eckq8yEci4qEoMiYqfAw1k1DQj8XXmG4nZdylC++qQTZOaJASwBkBrvyrKEXExOuiEoFxuoUdmErP9glQkuuDolBnQLQeb/pKgW7DcywGYW+X865vwJESv0qT530fdE/qnbCkU5zoEGzedOPfqXFlNaJH1y9FAhh6g/l9KCnBRiT4Nv/ufkNZ6QjNAitcHkzxkplkC0rowzqTTmJRq94o9p1+WEDy2GnnsN+sZjLD/9ZJHLVOms='),('3090a473-243a-467f-a2fe-949108990765','bb80259c-1ffc-4d82-aba1-c611c1e5e363','allowed-protocol-mapper-types','oidc-full-name-mapper'),('342c03b8-fea4-4cc4-842e-4233ae969926','f3bc3056-d3db-41b8-85ce-0d86d043b344','allowed-protocol-mapper-types','saml-user-property-mapper'),('360811f7-11f2-4dee-a182-f1374541809b','18d81900-d10a-43a9-9539-55f5dcfd3ac4','certificate','MIICmzCCAYMCBgGGjbWG0TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZzY3VvbGEwHhcNMjMwMjI2MTIzMDI5WhcNMzMwMjI2MTIzMjA5WjARMQ8wDQYDVQQDDAZzY3VvbGEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/HuipulsGpHckoM1r4Mw3/8UuvefMzO+OyzBmLx4CLmbOyJWtuIuWkwRriFKHekCGgcqS+wJPAHgVINQYSCz7l1fFRfK8zQ+TMnAwuIr8iyBv4c29pLA/fR+vyclpXv3lLvOk74Qa/d3c0XelICR5YkNYTIgtY6FX4ozSPt3VhoXgh+QzLm4Z/mshtOetGfeBEe/mTEviS7/AI+cVGTMO0erq5oiJQGp//UIzFNldSUWYW8nrIW5FPf/NGPbyBTL9k6koMWcgmdufMNKsGFQiV8m9k5jFxzMtgVWLigRJTo2bh5Nq19jLD54sXa5Wm+o+wpAVCfN2hThVLyBbFNxFAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAA2kSYUylDhdmKPBIcim56NApJNCkA/vXPcvvrC23Bs4WUf4P+XUY7dVCIlIT0Y6gjy+BoBvczdPeq00z4Fa2sN6q3VqtdKPa+78Yv53NN6tHrORPqPWUxaXadJuV/BNc0L4sgbhNUnaiGco0NCYvQeTrXtXfWbQRsU2/buZh33b54gzmD22tKXQSkL3onmybASFxZgM3UzSzRvTi8h2ZQh1kdnGqYVosuIRRLxlq2XQ4/8dQMtFVtpgAPzH6pI/j/2chVJ8+fluipAUsT0IE+IiQ15eu6G/sjf7FdE90kQqZxz54WnWB+XtOasFl4rx81TneciW0pznsbH51P2TF+s='),('4954843a-74b0-4a84-9a59-468dd853b43a','2a16f023-6e76-4a8f-b022-a62c808593fd','priority','100'),('4cc80b47-47af-4cfd-957c-312079eaf67f','17c743e5-6c29-4dd4-a0e2-2775b61cdbc7','allow-default-scopes','true'),('4eab993f-1394-428d-a1a0-3538626ea478','406604e0-ec24-4c73-8e84-a69dafaf6193','kid','d4a5d31d-0f44-45da-b60e-12c0da36806f'),('4fc6b959-3097-408e-b0b5-6a8e2fac72af','c6d03e2f-72c6-43de-a5c8-be84b96f9374','certificate','MIICmzCCAYMCBgGGjbWHnjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZzY3VvbGEwHhcNMjMwMjI2MTIzMDI5WhcNMzMwMjI2MTIzMjA5WjARMQ8wDQYDVQQDDAZzY3VvbGEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCrY29/REGiVnKfQbQZUziodPsKtiwQXQn2Q1yJMNrhawLL7cI0Y4lxGjtaxcwGE/tsPBn/LEJFf6mP8aeVSjNzVgiECmjJymNlzJLdtHUFDh9TXlncw5uncdwLlyXBevujhl7rAezbCKqLeDo/Enh5ImVn4BX6yCmoTnmyOxKJOc9+Uh36nCq/9FK5zQ3cnZg3LkdMtdZXWQrOZzm6Ui5Kr023UQ0NPWbfoF3J6EwflZ/4ORgYMQqIm/l2PWL2ME3gfeB58fUSAa8XZgSZX+24RgeWh6tJSfYQzEz08hra0ctO5QculLB8F+BdPOK8VUz8Eej4fElAUBFigvFf6PobAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFVCjhKPhlKfJvtemtAVjhkekBEhwhD+B0ZJqLtaH0uo1ojSmDyRKR4wsDslZCTN0sfntpvttRD2lQl8jOVnGyr3d2os81iSiEnIhr0w6CeWl1CJQnCuIbPdIVAF7f+363e5PvCZt7d1n/E6YZOQJaFM5shCb3moDWIml1ujOmrl0sTNij9MdN2fQZaZBWbLQW9q/nesJDbEBjx/Bg32NV/AhtXp/ueR0UnR3A1LKLi6qAwdppXRcdXpu4d+PjEABdEw+SQHJ7Qwdk8nQg5R1a0NYZlfJ/9bqzzuGWKCcBA60DatzZKFzx6ngYGREbBb/9sHNi4V/EgF/puAiEqI+io='),('58448a7d-dc52-4a6f-ac3f-ca505b4956d2','bb80259c-1ffc-4d82-aba1-c611c1e5e363','allowed-protocol-mapper-types','saml-user-property-mapper'),('58e369be-7d50-4982-86ec-bc30ac7cc943','0c3fe8c3-8f18-4e06-9dd8-3ee0ec3fae1a','host-sending-registration-request-must-match','true'),('5ee931a1-11bc-4290-bbca-a26ddd1ce3d9','30f89941-4148-474d-8737-8540bdaa9e2a','priority','100'),('60fcc2ff-33bf-4dd1-bd1f-184c64593a46','406604e0-ec24-4c73-8e84-a69dafaf6193','algorithm','HS256'),('62132cd4-49df-4d84-8a63-4ae47adf4baf','bd153dab-5f79-4a07-83f6-c558007e1362','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('63c558a4-aa5d-49f2-bf6d-171ed0a29220','d82394b6-eaf3-4a91-b01d-5dbf7aaa005d','client-uris-must-match','true'),('64a2c54c-d9a8-4f1c-9265-0e9bd06c9e1e','04fe8186-575b-46db-9619-e62b021ac352','allow-default-scopes','true'),('699dcb03-51a7-45b4-9935-ddc759dec5b0','d0d8cfb6-ea52-46c4-9865-d09261e150aa','algorithm','RSA-OAEP'),('6d9acde0-01f9-4602-9a33-3747be587b01','f3bc3056-d3db-41b8-85ce-0d86d043b344','allowed-protocol-mapper-types','oidc-address-mapper'),('6e0da683-cab7-4a21-b691-691d94bd1169','f3bc3056-d3db-41b8-85ce-0d86d043b344','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('73914760-cc22-4e38-b052-d0afdd5b3ae7','bb80259c-1ffc-4d82-aba1-c611c1e5e363','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('75a79924-811f-4fb7-b1e6-0d667f502cf0','bd153dab-5f79-4a07-83f6-c558007e1362','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('76819df9-cbd7-47dd-a350-9b9d41520f64','d0d8cfb6-ea52-46c4-9865-d09261e150aa','keyUse','ENC'),('79d09f21-3d92-40ac-970d-d3ea179220b5','0d0fd2e6-e51d-4df8-974c-b8b19559e753','priority','100'),('7a595a46-ff60-4fc1-88c6-356eb8da6940','18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('7f8b42ea-b223-4718-b1bb-e4e1c37133cf','c72cc421-ad67-4636-9bd2-ffa35d732262','secret','WY4aK1B2RZh6lTZ9gqkHGvsl1tsM64YZrhQh7FgXnXaN6CYd0NjfiERduGvCD1OJ4y-P1KgWE1jNnVt9ys4_hQ'),('86588099-fadf-46a3-903b-cefb77f265ed','18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','allowed-protocol-mapper-types','oidc-address-mapper'),('8d75a151-87c0-4a81-9cb4-069f0a971547','bd153dab-5f79-4a07-83f6-c558007e1362','allowed-protocol-mapper-types','saml-role-list-mapper'),('92fa183d-9bc7-461f-bbdc-7fd495f8d767','0d0fd2e6-e51d-4df8-974c-b8b19559e753','certificate','MIICmzCCAYMCBgGGjWdtCDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMjI2MTEwNTExWhcNMzMwMjI2MTEwNjUxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGHLVqALjOrXeBoouZxwy/IpCcShLxD6mnYECRaGMjEPfGFenvcKx0RVMJ2lmft4EjyAAmMOjUYX9xuskJ4QzlmeujB5oYwh5M0q0p6MDwOdlIeaA4+2PKOu6xdxvMNPx8RlWvVtkQ+vKZO3zdJikCskWKOoBxI5viZUe/6HiefuUYiX6/3evNFt3lufji9qGN0AM3M93OLb+rNG4CQQ1TgBSPd4BkbexN3FNd4sGjYA5SZr1zGTmnxKDfEox1zfKEJ+lMXRFc7iDusKymtCPqg0xYSiLYVRAACSj86K3hQQVBKvJYPqMkZ7CZNQLyUcTDMWkgTUIIpgxmnaCNYKdpAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACqcdS/YApZ+2IipXWGBvx7JBIafHJ/9rDSp7P26W5VSEVNRt73wZtyXeskods3ynKjAeEf+bUsAapxJ5SUpxY9OAUg+UBuaGI8Ub6Fqf4VJ5qxqn8RAlheerHKQmJgjRxmQPKKZoopjoDMtTI5r5I4hmBXjbZtFWqXPk+ZfJYddzkrGuzrXfMUhKpPkr+dTJVR9fwQTRJTAl1ijdFlGN5MCh/cN47IqdT3nIMDho0XOy4Ga0s50ImF/j1Nlfa4gpLZ5Dn2pRKHKHXvoDivygckmy+Reez2y9BKJDstm4GOlQ0wWqGJ9HwZE/wn/EsjBoZXLTMM7tokOHsX1V1ah0Xk='),('93df42ac-31c0-42a8-8882-3d07397ef7b2','f3bc3056-d3db-41b8-85ce-0d86d043b344','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('96ab762e-2c03-4789-9838-738c188e4cd2','f3bc3056-d3db-41b8-85ce-0d86d043b344','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('982dd98a-4a90-4c1d-8c8b-426efaf890b4','2a16f023-6e76-4a8f-b022-a62c808593fd','secret','qxoHDKR99dkmn2Lb3sHqAg'),('999f2309-25f9-422e-9d9c-3527cce6e1ae','c72cc421-ad67-4636-9bd2-ffa35d732262','priority','100'),('a360b769-3661-4dd0-86c7-ce4716857c42','18d81900-d10a-43a9-9539-55f5dcfd3ac4','keyUse','SIG'),('a453db87-609e-4e05-8479-23746f19a6e9','bb80259c-1ffc-4d82-aba1-c611c1e5e363','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('a58b32d6-5f06-4a3d-873f-96926d74aa5d','18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','allowed-protocol-mapper-types','saml-user-property-mapper'),('a5edbcc5-fd67-4b55-ad0a-7b836fe1d7ec','0d0fd2e6-e51d-4df8-974c-b8b19559e753','keyUse','SIG'),('aa59cfa6-efc9-46f5-bc57-00eb26545b94','0d0fd2e6-e51d-4df8-974c-b8b19559e753','privateKey','MIIEowIBAAKCAQEAxhy1agC4zq13gaKLmccMvyKQnEoS8Q+pp2BAkWhjIxD3xhXp73CsdEVTCdpZn7eBI8gAJjDo1GF/cbrJCeEM5ZnroweaGMIeTNKtKejA8DnZSHmgOPtjyjrusXcbzDT8fEZVr1bZEPrymTt83SYpArJFijqAcSOb4mVHv+h4nn7lGIl+v93rzRbd5bn44vahjdADNzPdzi2/qzRuAkENU4AUj3eAZG3sTdxTXeLBo2AOUma9cxk5p8Sg3xKMdc3yhCfpTF0RXO4g7rCsprQj6oNMWEoi2FUQAAko/Oit4UEFQSryWD6jJGewmTUC8lHEwzFpIE1CCKYMZp2gjWCnaQIDAQABAoIBAAI4opThR5eTPLqVXSwiN5n4Nz4PwcEC94uXrRTaryt4SAiBu/4iE0aFqHXja6UHMUl6nckDCPlCOcphDI2YM/hqQcjk9iAk8Dxuq3mQaulgNkSojtiH6QlRbW+yWC6kwXGOdrng881LvJoybCbGnY5MLv9q9hm1C00xUx0E7D7kREf7K6esdnSOOYPLtR7e5irqklBi9k4iO8g8T99b2zHPfOYU59mSMrxY2oa1SkXMNvjxmq+4L3HcNYcT440vCG07l6UZ5RuApQp2ly01zyMj8u+nkGVW3PrlBcS5Q70xpZh8WGWTDACjtovEz2r5bpSE82Me1qZGk3vBlMufIekCgYEA65uxjmkC+4OBiuoyE35mT8cj+oCP+BjJnfhb6XWNORFJ/m32xjW9/obLYItD4lAg8m9RxjixvOEDSu5LftvRGU4CdnmbebQm/ut+U3v5cgnGwfgluXoOihAJSZTbN1XgI2G8ygV4ZRO0bdhSh2468bXwB63Aa9ZnZtJBIKz+mIcCgYEA10I5wVw/yeNWK600Pa75T+Ot+XfnGvq+L5w8raKtFibMfCa6Kp4EaXoBUJ+t/9Wnoze/8nJmqemTa+3GjiI3GKqA1w76y7XTEVJXQ6LKdeboaVi4q6qfdiKV3oT1MWcUqEWZm71MUAMkbJoWvwpF8XLfBtcWdnzKyP/+GgFL7I8CgYAlEnJ1vgBCIwcXHJKUjqb6lpMKr3/3wa63tISBz4VRHW9PIW5a8cnbaspFfqRHz+PfQbTUQ8dzuNQTzjsC0wOrv6KTkb7s/3PDWLqf2Dn/v5oOm0UUUihHgQ51DX8QzepeptpVz1aKUPdq8UbLGIUd00rZanWEgk/y1dJ5mb7VsQKBgQDBY+c9l+JbQBpHzSl1DYFBS/0edqGztHgvj/9XxCIbF6p5E9YHucWe+ZS62WrawRoF4m1ZpXwkxQvEWHAdfBHh4DU2gWfCos1I76AkzNl2SYieNK5c1ELFQNdCflNHGiQN9dHGgLBR5jDQPTOYWONzw88pdw3gT8dkA9FHjcincwKBgGw82SFHA7YfNuu2z9nNKBQ46ICWKciwHdv6xYOAmoRxqJN6SANBZx6PXSFrtZH2fkxrc/Rxnf4mdC9702ItBRDzTOFueJonp3om7PbKxx+1ehs+16F5A8/nPXCLUiCXGSOr7qnBm97xt0+9xdRc1BQQBaD90Q1sKP6sVIZSeYGs'),('ac50d94e-fdab-4aa2-b9de-30626fb75879','d0d8cfb6-ea52-46c4-9865-d09261e150aa','priority','100'),('b2149406-c1d1-48d0-944f-86a88c0feb1e','c6d03e2f-72c6-43de-a5c8-be84b96f9374','priority','100'),('b66d4e1f-43ae-498a-bd1a-707cf4864e4f','18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('b76d4b26-c251-4c83-a6cd-5dc6586d8e52','f3bc3056-d3db-41b8-85ce-0d86d043b344','allowed-protocol-mapper-types','oidc-full-name-mapper'),('b8be06bc-6085-449a-94f1-924b2e50217f','c6d03e2f-72c6-43de-a5c8-be84b96f9374','algorithm','RSA-OAEP'),('baba48bc-e07f-4cfe-acdd-ccc947beb919','18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','allowed-protocol-mapper-types','saml-role-list-mapper'),('c3d90ae5-4206-48ea-97a3-6fa672c1d8fe','c8edceae-7cad-4f98-912e-f3fd5240283b','allow-default-scopes','true'),('c5ff0d79-3fce-4864-aee6-6c65be2e2b5c','c6d03e2f-72c6-43de-a5c8-be84b96f9374','privateKey','MIIEowIBAAKCAQEAq2Nvf0RBolZyn0G0GVM4qHT7CrYsEF0J9kNciTDa4WsCy+3CNGOJcRo7WsXMBhP7bDwZ/yxCRX+pj/GnlUozc1YIhApoycpjZcyS3bR1BQ4fU15Z3MObp3HcC5clwXr7o4Ze6wHs2wiqi3g6PxJ4eSJlZ+AV+sgpqE55sjsSiTnPflId+pwqv/RSuc0N3J2YNy5HTLXWV1kKzmc5ulIuSq9Nt1ENDT1m36BdyehMH5Wf+DkYGDEKiJv5dj1i9jBN4H3gefH1EgGvF2YEmV/tuEYHloerSUn2EMxM9PIa2tHLTuUHLpSwfBfgXTzivFVM/BHo+HxJQFARYoLxX+j6GwIDAQABAoIBABVxXehO2mVcqn+ZYVaPznVpGWWYMEAl29K3T9MMTT5JvLJV/2e9klsXvJhZSfLyuhCrHleKKop2c/kB84UeoPxLpcobYUvp6fC5HSDm7IMi5rFwCw8vXAChorXCheNEp0oozCRb+83Vsjy74JG2lmMVdhl+dFGJjIi1tM0jTejkIY/p8vrSPLTHl3qFzcwawAvcn+JMvEg2qhjUqToueD9sFTIue29Tm0LWtaMWq2tCwAhsUNt6lwcGZ34tFIM1wl2XUtO/m/CPAImigYprF+lC+3pg6TjDxz68VgHj9qfSbsYSwq+tYLwKrEAsvgaC7EYIKBggNTqOQq8grXq0l9ECgYEA54XqYx/Ps/ucyNpzElURQX9gkIg4FXE/y4z4UvhoZrtugjH3EWE23ehpA+s1C+IdyUDvWjnNdJwfQ3hOXh48ldSKM5tYqZ6yTAtU3FZkXsuqu+bj0XyK1uQpTFGSRhKLoxX0EMTDqibrUxQfkZJJtoh0jbO8kvfRKdwDknUuNEsCgYEAvYH/ZCj0aS9kEN7L2kgS1f0UHE1Mu7u3m6fQ11bJT7wznan7+MY8D7gSYro9V9CABnK3BgMfZdrVZRBCI9pc+sWCrAI5dGheasEqXPM9LOi9Dds+hL9GR2sXt1a+BlZgJV2QGwm7CDFhrn6M2WwUhhPQXk3HLbJmK2d7vukqj3ECgYEA0ykbjo7MBG7fH33F6Bl4JJHFg+0Jodzpf4AyWJJBvjkC4HIr0kklHp3DchSLDCyOWCkGZPdFQS7HgOTwLP1M6qav6cOsyP95xMus+U0+PAtry/cZH86EXtw4ImhfjdOKUhNKyCR+BOl8RgibhkyzOG0aSMd+nVizB4eoJmMD4iMCgYAHYpuLUbVErB4gMi6LkSd6w2QXPkPxRP2AyWdwHOe3fcQdLtSs+zy3+BpvUoa1d2Cl366WQ2Tj2UVbrOiG8SmSdEQFZAjNKowTaPe3q5sEtwU3FwY2siWQ/vFrqau6H3+btSu6ggSR6yq9XB0tE/MwznDeW/WZKEynAF9oLzoDYQKBgG6FQM/9dWECntWHdwn5IEfMlPv11phjdF9XUWQz+nV3D4DVbbs/wsUmqfn+xw7xJDIoUDPHteYFiGQnYwAnVS7ccq4qLJnwVgss4kJITfmhR6JrpMJ9sTIbSgUztSJUQc97Tlu7YZ95P52NwF4vaiFJlALdVCq80UAZ4qIkb8BX'),('c7880eeb-bf8f-4e75-88b1-10ff2b3f4786','bb80259c-1ffc-4d82-aba1-c611c1e5e363','allowed-protocol-mapper-types','saml-role-list-mapper'),('c9dfcf6c-2abe-4ff0-bbeb-519fbd3105f1','2a16f023-6e76-4a8f-b022-a62c808593fd','kid','fd6e1810-48a2-4db7-98e0-32fa456fd0b1'),('d3fab04f-62f7-4def-91df-103cbf42aec9','c72cc421-ad67-4636-9bd2-ffa35d732262','kid','348c2aea-d283-41ee-a779-9e72927945bc'),('d4ab1590-70b6-4711-9f1e-8aa7cf7bf111','bd153dab-5f79-4a07-83f6-c558007e1362','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('dc67c25d-6aee-4da6-99d4-bc85847526f6','bd153dab-5f79-4a07-83f6-c558007e1362','allowed-protocol-mapper-types','oidc-full-name-mapper'),('dd439566-4d11-46b1-95a5-526bdcb2d7c7','30f89941-4148-474d-8737-8540bdaa9e2a','kid','f39dfab7-ffc0-4838-bfa5-1a64b6acfd89'),('e27c7b13-f711-496e-99cd-8bd3c742ec22','18d2c1a1-f38b-45a8-85c0-ab7b21e4bdd8','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('e5c89007-9433-438c-9ae1-b08c91be29fc','d0d8cfb6-ea52-46c4-9865-d09261e150aa','privateKey','MIIEowIBAAKCAQEAtI4Wi7CX14rZMSohTJKinb+LxOsIz1aFUkB/UzHu9ex9ZInleg3xIZ86Q18DaIoQAyJ88o/Ovwxq6cLU3qP7DzazadWVLPnwCweg9XpuvjoOWrkU9PoD5wiN4ww7XYOV7aj+AksD4fJjKZ0wI8HB6DF9/dJeXgWl5e9lFWkjf6Ex+YEZKqQR2468/+1tyZTk1a2TnbnSfNI5x5rZUKCa940ior/i+UDiY+5315Y1HeeADb6jj8bbcApMBPjMY/3xIJpCNi4BGZx7vo7AXa6Zq+cHi/PlsH0UDLlvDd9XCioXH+Cten9XyjDfZWnLtbNmS/YxhWHDRpxABPnhMYxO1QIDAQABAoIBABvLaseWyA0vi/dQUb94rE1l7QWDm//VBSGQGbmsLGnRvcziGIAlUMs4+I5h/EOVy1i8MKljf3N0HSo+qqfabP3e0Rg3/6aklDISetIHRrCEfeyz5LjAmySv8a2z1piy9rvXAcFHHIImHuNLVhuPCoNsyQUvowTM0EjZBUHaRVNyci4P68moXCWrGCP2RhLlQSET/o9tvfvGv0r3zzfnIdRiE4YzeT4PXTEqXFq5qfmR0YsfTQ0lKOiZIK7btShn7mVERB1zQ32FVT8ySFABdg4G1jR3FTaWx1hR/e+e78z8PxP4+UUKXUB7J7p05Ma8sERMQBzUCLjnnBfqjIm8e4ECgYEA2D+zjmLVHjBJ0vulbNbf4LJLf8rXywZFTxV9oOYOBW83a4tNwnnWwOTt6749iJ3M91Mw7XrwREf28nXbIfV1FgK3CCreKpas/hUCW8mqgcGwjcLV6WVbmQwn8kwE1ESx3q+vSnoAZCsoohsbfdwUTnwrfqNqAGEBz/Y8Y6LZNIECgYEA1b6ymq6iAv0Dqu1dGHj50b3kupBCk35SbRXFZLpeEKgznSOJdeOvzbuvQ9Kz1YTpO/2Q5dGw8HGkfi58LhyFXzaCfqIUTcdLGYuXvDWGpsz6OUZ0ejLpJmzt3tc1rZmDTsGUzi2qfmTBRgKP118wXrcvJA1jABIbzGozNi794FUCgYEAjpnLPTzdTvAG7rN1TgWQUqsgcGAB12cGM3V3h6/NVTYW9LtDBtizjjYo0sl76Ggu7nWUkTX91Pkj1pVzcLxdfqtBqYgjQzBjWZXfHUoqPzDLzV/LEgL92ToT6YrJsHSwWqm9zT4Qnf176RI5GdEULwFg6Ty3vRI7ULkO76FG3IECgYB/27H1K4+IYBdokNKGiB9QYtpG63KXzhG6ZTKN/Zm1Nxig4BgjKA8K70F5PboLeJUYKKcbgqLoQeKXBHGOF8uEWBQZchTZLeTzo/ghQpeIgccQqd+VFY04SiLEkVHvxYuxecTszI5XSyf+HBw1RiCmF8ggNc3JxgtQ7RozSErffQKBgCTy7A9LJ3jHXg7RtZviYHFasUBHR63XnJblJCShquhRF3Nt0fAaMCpvwG8snX1yRlQyP9QabPIGv510XHTjr3pB5w5ZMDSsTVq0Yxg9aeE7dz4gYS8MnrbLduGCzKaHX+zuRqCQBEOeZtu2UCDh8Ecp7u/nkfCFWmgwHV6y1RY0'),('ea245d12-b18c-4d56-8565-fbc94b7add9b','406604e0-ec24-4c73-8e84-a69dafaf6193','secret','M6WjvgiW3DP4ubK33jD4mjcpZo62NAUyEduWSoADst-_gxieu3YlYLMr0Q2ZTn2wV1C25C-HAh05dx0YAKXhgQ'),('ea54d75b-5ffa-467f-88d4-be0bc65e885a','bb80259c-1ffc-4d82-aba1-c611c1e5e363','allowed-protocol-mapper-types','oidc-address-mapper');
/*!40000 ALTER TABLE `COMPONENT_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPOSITE_ROLE`
--

DROP TABLE IF EXISTS `COMPOSITE_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMPOSITE_ROLE` (
  `COMPOSITE` varchar(36) NOT NULL,
  `CHILD_ROLE` varchar(36) NOT NULL,
  PRIMARY KEY (`COMPOSITE`,`CHILD_ROLE`),
  KEY `IDX_COMPOSITE` (`COMPOSITE`),
  KEY `IDX_COMPOSITE_CHILD` (`CHILD_ROLE`),
  CONSTRAINT `FK_A63WVEKFTU8JO1PNJ81E7MCE2` FOREIGN KEY (`COMPOSITE`) REFERENCES `KEYCLOAK_ROLE` (`ID`),
  CONSTRAINT `FK_GR7THLLB9LU8Q4VQA4524JJY8` FOREIGN KEY (`CHILD_ROLE`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPOSITE_ROLE`
--

LOCK TABLES `COMPOSITE_ROLE` WRITE;
/*!40000 ALTER TABLE `COMPOSITE_ROLE` DISABLE KEYS */;
INSERT INTO `COMPOSITE_ROLE` VALUES ('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','1144aa1d-3611-415a-9fc9-143f26e32bbf'),('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','b0cf96e6-cdad-4ee1-9e01-5601feef5e1d'),('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','d0e59db6-96fe-4b8f-8e75-ac7783ddbbe8'),('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','d46c3078-21c6-4ed1-a19e-4f53f6194328'),('0f9ae058-cc2c-4178-9382-cf14d126379e','a66072df-530e-400b-ac69-16db6213815a'),('0f9ae058-cc2c-4178-9382-cf14d126379e','f973f9dd-7af0-4b52-847f-f12c9a7532f1'),('120a375f-16aa-43e9-83d3-5ec7cb785b08','193f0c58-2e7a-4e8e-b063-fc6d64b92f0b'),('120a375f-16aa-43e9-83d3-5ec7cb785b08','43daf1d5-6281-4012-b801-3f6e17511a37'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','0a2021db-294d-4a18-aa21-16ad5f6fa40f'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','0ba282e7-4a52-41b5-8a67-7ad61e62ea4c'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','0f9ae058-cc2c-4178-9382-cf14d126379e'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','2a371782-26df-4266-b9bd-a1c0bd0d6508'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','2d44c51d-25a7-4683-b4ae-e31da0074f32'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','47fe6c40-54e4-4eba-bbdd-60ffaf5bd5e1'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','54e0298f-df20-474d-9535-939853477117'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','5a82a4dd-4724-44dc-8f0e-fed377febb03'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','a4d32d73-6c50-406e-ada8-dad789e06ff2'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','a66072df-530e-400b-ac69-16db6213815a'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','aa0b251e-b1e6-486e-b12b-bef94d18f054'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','bce2c989-05c3-4302-a63a-325014ff0713'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','c22cb9fd-240b-4156-b53e-e92ff6663871'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','cb0b7b20-048a-49c9-b7ed-41c63ea06a5c'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','cb8aa9e6-76ff-4445-8b0a-a20633870bdd'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','d930309a-5693-42ff-8cf7-c6286d49c343'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','f973f9dd-7af0-4b52-847f-f12c9a7532f1'),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','fcddb7eb-3c56-434a-a3dd-2a1f9401f869'),('260e85aa-d84e-4369-bbf5-53fca4af577e','1856ffd4-8181-4cae-9a93-61e659f39bb9'),('260e85aa-d84e-4369-bbf5-53fca4af577e','18a96b32-b3d9-4536-aa22-c4d6e81fb961'),('260e85aa-d84e-4369-bbf5-53fca4af577e','48a2b595-d2cf-45c2-b0e4-ba4d87b7d52d'),('260e85aa-d84e-4369-bbf5-53fca4af577e','cc91168d-dc7f-4093-9e91-f83d8f23053f'),('30f7affa-238d-4eab-9e08-90fbe24e8ef2','8b937a54-4e9c-4dd3-ab9a-e9fb8f014277'),('37f48bdb-0c28-432f-88d0-da0a7cf4588f','1d998211-74e1-4fb9-b164-3e0ae8571609'),('5d8b6397-e372-4dcb-b5cd-ebdebfc8ebc6','a978cd2b-d210-4d70-9fbf-9d5cfd9d9657'),('5d8b6397-e372-4dcb-b5cd-ebdebfc8ebc6','b5ed1430-28d0-48c4-be04-604155dfb7ee'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','044a260c-a8b5-4ccf-9e1f-46ed5aa20a08'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','0b6da521-5b61-44e8-9c25-4b7f2efddf36'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','10fba44e-797b-4e17-8a89-a4dc7ec2bd1a'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','120a375f-16aa-43e9-83d3-5ec7cb785b08'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','193f0c58-2e7a-4e8e-b063-fc6d64b92f0b'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','1a0b6027-1d65-4479-9315-fe67b8afb89a'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','1b68accc-d4d5-4d86-8c8e-adf4a5149a0e'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','1df96405-3497-4601-b32a-150fb8304e80'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','27c4eb54-91e8-4e3e-a0c1-f0fc18624ec9'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','30f7affa-238d-4eab-9e08-90fbe24e8ef2'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','340da22c-2a33-4d28-9f3d-65ed20d89cd6'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','35cbd3d3-4833-45c7-81c5-5ac4cc1c2a33'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','370ef785-0700-4d07-9f69-423e373741db'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','42bf066b-3e60-4af3-85ce-a709a13d138f'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','43daf1d5-6281-4012-b801-3f6e17511a37'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','59b89136-b724-476c-b149-88df3fdc410b'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','5d8b6397-e372-4dcb-b5cd-ebdebfc8ebc6'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','606bf968-219b-46a8-943d-a61bb2204198'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','7668002c-3ce8-4ad4-8e03-e7333756debc'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','78ce352b-4769-4420-9c04-73c0890b9e8a'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','8003df3e-11e9-40ad-878d-6f3b0bc5a583'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','858b841b-5b14-46b0-bbbb-330cccc5a9fe'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','88cee3b1-a05d-4d1a-8ed4-7eb273e81d5b'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','8b937a54-4e9c-4dd3-ab9a-e9fb8f014277'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','a7778bcc-7aa4-4382-82d7-6d3e6bb94ac4'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','a978cd2b-d210-4d70-9fbf-9d5cfd9d9657'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','abb77f0c-b6c5-4674-b026-1a5a123bc10a'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','b5ed1430-28d0-48c4-be04-604155dfb7ee'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','b7a48db1-5f60-4bdf-86d2-065dadf80da0'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','ba14e7e4-d8fd-407c-a0a9-faadaf7f6952'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','c1209f70-879d-4532-b2ac-96a8a3a5aaf4'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','d03d25a7-44d3-43cd-911f-c3a028f4ad95'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','d3308360-e0d5-4d5d-8873-aed55b116668'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','eaf4d06d-2b40-4247-b735-67efde49a1a7'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','f4a04bc5-4d65-43a5-a945-b29380634f6f'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','f82f39d6-a853-4ad5-ba14-88ef8597c93b'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','fad7e45a-7e19-4f98-850d-9800d8eb16a1'),('b0cf96e6-cdad-4ee1-9e01-5601feef5e1d','a33921cc-df01-488a-8ff6-d22b16004aec'),('c29213d5-b36e-4257-ab9a-3143f478025a','4aff66d6-f541-4b91-acd2-045161a17865'),('cc91168d-dc7f-4093-9e91-f83d8f23053f','4763d5da-7986-49c0-85d3-6b2d495402d6'),('d03d25a7-44d3-43cd-911f-c3a028f4ad95','606bf968-219b-46a8-943d-a61bb2204198'),('fcddb7eb-3c56-434a-a3dd-2a1f9401f869','2a371782-26df-4266-b9bd-a1c0bd0d6508');
/*!40000 ALTER TABLE `COMPOSITE_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CREDENTIAL`
--

DROP TABLE IF EXISTS `CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext DEFAULT NULL,
  `CREDENTIAL_DATA` longtext DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_CREDENTIAL` (`USER_ID`),
  CONSTRAINT `FK_PFYR0GLASQYL0DEI3KL69R6V0` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CREDENTIAL`
--

LOCK TABLES `CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `CREDENTIAL` DISABLE KEYS */;
INSERT INTO `CREDENTIAL` VALUES ('7245faea-af73-4987-a163-f39056f14047',NULL,'password','7894cbc4-302f-4adf-a068-d96f796357f8',1678142963425,'My password','{\"value\":\"IVrirRiDa3L+yJfTHgd3nWvpgGbmfgu3JjGxOfz9Mss=\",\"salt\":\"BMrQoH+ESYp4MFxbcO4MzQ==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('b328e4cd-f00c-4235-88ef-72be14b5fb49',NULL,'password','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3',1677409612088,NULL,'{\"value\":\"rqkT1uVB/0kG47rNeHK/fdU8U8bQhwmyuCty9/T4OOA=\",\"salt\":\"txbRF+eSrfJE4D0bWtsRMw==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('d09e6e9b-6d62-42de-b60f-dee7751dccc2',NULL,'password','b329274b-a238-4600-9662-257cc6d50f0f',1677943128481,'My password','{\"value\":\"XsX1ps/GmhsGtdsxBfJYzLSpq5hjarq2DeMtK4mPXio=\",\"salt\":\"89EHCKl1drZLHxrpPxZ89A==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10);
/*!40000 ALTER TABLE `CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOG`
--

DROP TABLE IF EXISTS `DATABASECHANGELOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOG`
--

LOCK TABLES `DATABASECHANGELOG` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOG` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOG` VALUES ('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/jpa-changelog-1.0.0.Final.xml','2023-02-26 12:06:31',1,'EXECUTED','8:bda77d94bf90182a1e30c24f1c155ec7','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/db2-jpa-changelog-1.0.0.Final.xml','2023-02-26 12:06:31',2,'MARK_RAN','8:1ecb330f30986693d1cba9ab579fa219','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.1.0.Beta1','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Beta1.xml','2023-02-26 12:06:32',3,'EXECUTED','8:cb7ace19bc6d959f305605d255d4c843','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.1.0.Final','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Final.xml','2023-02-26 12:06:32',4,'EXECUTED','8:80230013e961310e6872e871be424a63','renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.2.0.Beta1','psilva@redhat.com','META-INF/jpa-changelog-1.2.0.Beta1.xml','2023-02-26 12:06:33',5,'EXECUTED','8:67f4c20929126adc0c8e9bf48279d244','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.2.0.Beta1','psilva@redhat.com','META-INF/db2-jpa-changelog-1.2.0.Beta1.xml','2023-02-26 12:06:33',6,'MARK_RAN','8:7311018b0b8179ce14628ab412bb6783','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.2.0.RC1','bburke@redhat.com','META-INF/jpa-changelog-1.2.0.CR1.xml','2023-02-26 12:06:34',7,'EXECUTED','8:037ba1216c3640f8785ee6b8e7c8e3c1','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.2.0.RC1','bburke@redhat.com','META-INF/db2-jpa-changelog-1.2.0.CR1.xml','2023-02-26 12:06:34',8,'MARK_RAN','8:7fe6ffe4af4df289b3157de32c624263','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.2.0.Final','keycloak','META-INF/jpa-changelog-1.2.0.Final.xml','2023-02-26 12:06:34',9,'EXECUTED','8:9c136bc3187083a98745c7d03bc8a303','update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.3.0','bburke@redhat.com','META-INF/jpa-changelog-1.3.0.xml','2023-02-26 12:06:35',10,'EXECUTED','8:b5f09474dca81fb56a97cf5b6553d331','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.4.0','bburke@redhat.com','META-INF/jpa-changelog-1.4.0.xml','2023-02-26 12:06:36',11,'EXECUTED','8:ca924f31bd2a3b219fdcfe78c82dacf4','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.4.0','bburke@redhat.com','META-INF/db2-jpa-changelog-1.4.0.xml','2023-02-26 12:06:36',12,'MARK_RAN','8:8acad7483e106416bcfa6f3b824a16cd','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.5.0','bburke@redhat.com','META-INF/jpa-changelog-1.5.0.xml','2023-02-26 12:06:36',13,'EXECUTED','8:9b1266d17f4f87c78226f5055408fd5e','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.6.1_from15','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2023-02-26 12:06:36',14,'EXECUTED','8:d80ec4ab6dbfe573550ff72396c7e910','addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.6.1_from16-pre','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2023-02-26 12:06:36',15,'MARK_RAN','8:d86eb172171e7c20b9c849b584d147b2','delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.6.1_from16','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2023-02-26 12:06:36',16,'MARK_RAN','8:5735f46f0fa60689deb0ecdc2a0dea22','dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.6.1','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2023-02-26 12:06:36',17,'EXECUTED','8:d41d8cd98f00b204e9800998ecf8427e','empty','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.7.0','bburke@redhat.com','META-INF/jpa-changelog-1.7.0.xml','2023-02-26 12:06:37',18,'EXECUTED','8:5c1a8fd2014ac7fc43b90a700f117b23','createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.8.0','mposolda@redhat.com','META-INF/jpa-changelog-1.8.0.xml','2023-02-26 12:06:37',19,'EXECUTED','8:1f6c2c2dfc362aff4ed75b3f0ef6b331','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.8.0-2','keycloak','META-INF/jpa-changelog-1.8.0.xml','2023-02-26 12:06:37',20,'EXECUTED','8:dee9246280915712591f83a127665107','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.8.0','mposolda@redhat.com','META-INF/db2-jpa-changelog-1.8.0.xml','2023-02-26 12:06:37',21,'MARK_RAN','8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.8.0-2','keycloak','META-INF/db2-jpa-changelog-1.8.0.xml','2023-02-26 12:06:37',22,'MARK_RAN','8:dee9246280915712591f83a127665107','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.9.0','mposolda@redhat.com','META-INF/jpa-changelog-1.9.0.xml','2023-02-26 12:06:38',23,'EXECUTED','8:d9fa18ffa355320395b86270680dd4fe','update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.9.1','keycloak','META-INF/jpa-changelog-1.9.1.xml','2023-02-26 12:06:38',24,'EXECUTED','8:90cff506fedb06141ffc1c71c4a1214c','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.9.1','keycloak','META-INF/db2-jpa-changelog-1.9.1.xml','2023-02-26 12:06:38',25,'MARK_RAN','8:11a788aed4961d6d29c427c063af828c','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'4.16.1',NULL,NULL,'7409588480'),('1.9.2','keycloak','META-INF/jpa-changelog-1.9.2.xml','2023-02-26 12:06:38',26,'EXECUTED','8:a4218e51e1faf380518cce2af5d39b43','createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-2.0.0','psilva@redhat.com','META-INF/jpa-changelog-authz-2.0.0.xml','2023-02-26 12:06:39',27,'EXECUTED','8:d9e9a1bfaa644da9952456050f07bbdc','createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-2.5.1','psilva@redhat.com','META-INF/jpa-changelog-authz-2.5.1.xml','2023-02-26 12:06:39',28,'EXECUTED','8:d1bf991a6163c0acbfe664b615314505','update tableName=RESOURCE_SERVER_POLICY','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.1.0-KEYCLOAK-5461','bburke@redhat.com','META-INF/jpa-changelog-2.1.0.xml','2023-02-26 12:06:40',29,'EXECUTED','8:88a743a1e87ec5e30bf603da68058a8c','createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.2.0','bburke@redhat.com','META-INF/jpa-changelog-2.2.0.xml','2023-02-26 12:06:40',30,'EXECUTED','8:c5517863c875d325dea463d00ec26d7a','addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.3.0','bburke@redhat.com','META-INF/jpa-changelog-2.3.0.xml','2023-02-26 12:06:40',31,'EXECUTED','8:ada8b4833b74a498f376d7136bc7d327','createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.4.0','bburke@redhat.com','META-INF/jpa-changelog-2.4.0.xml','2023-02-26 12:06:40',32,'EXECUTED','8:b9b73c8ea7299457f99fcbb825c263ba','customChange','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.5.0','bburke@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2023-02-26 12:06:40',33,'EXECUTED','8:07724333e625ccfcfc5adc63d57314f3','customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.5.0-unicode-oracle','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2023-02-26 12:06:40',34,'MARK_RAN','8:8b6fd445958882efe55deb26fc541a7b','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.5.0-unicode-other-dbs','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2023-02-26 12:06:41',35,'EXECUTED','8:29b29cfebfd12600897680147277a9d7','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.5.0-duplicate-email-support','slawomir@dabek.name','META-INF/jpa-changelog-2.5.0.xml','2023-02-26 12:06:41',36,'EXECUTED','8:73ad77ca8fd0410c7f9f15a471fa52bc','addColumn tableName=REALM','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.5.0-unique-group-names','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2023-02-26 12:06:41',37,'EXECUTED','8:64f27a6fdcad57f6f9153210f2ec1bdb','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.16.1',NULL,NULL,'7409588480'),('2.5.1','bburke@redhat.com','META-INF/jpa-changelog-2.5.1.xml','2023-02-26 12:06:41',38,'EXECUTED','8:27180251182e6c31846c2ddab4bc5781','addColumn tableName=FED_USER_CONSENT','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.0.0','bburke@redhat.com','META-INF/jpa-changelog-3.0.0.xml','2023-02-26 12:06:41',39,'EXECUTED','8:d56f201bfcfa7a1413eb3e9bc02978f9','addColumn tableName=IDENTITY_PROVIDER','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.2.0-fix','keycloak','META-INF/jpa-changelog-3.2.0.xml','2023-02-26 12:06:41',40,'MARK_RAN','8:91f5522bf6afdc2077dfab57fbd3455c','addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.2.0-fix-with-keycloak-5416','keycloak','META-INF/jpa-changelog-3.2.0.xml','2023-02-26 12:06:41',41,'MARK_RAN','8:0f01b554f256c22caeb7d8aee3a1cdc8','dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.2.0-fix-offline-sessions','hmlnarik','META-INF/jpa-changelog-3.2.0.xml','2023-02-26 12:06:41',42,'EXECUTED','8:ab91cf9cee415867ade0e2df9651a947','customChange','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.2.0-fixed','keycloak','META-INF/jpa-changelog-3.2.0.xml','2023-02-26 12:06:42',43,'EXECUTED','8:ceac9b1889e97d602caf373eadb0d4b7','addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.3.0','keycloak','META-INF/jpa-changelog-3.3.0.xml','2023-02-26 12:06:42',44,'EXECUTED','8:84b986e628fe8f7fd8fd3c275c5259f2','addColumn tableName=USER_ENTITY','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-3.4.0.CR1-resource-server-pk-change-part1','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-02-26 12:06:42',45,'EXECUTED','8:a164ae073c56ffdbc98a615493609a52','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-02-26 12:06:42',46,'EXECUTED','8:70a2b4f1f4bd4dbf487114bdb1810e64','customChange','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-02-26 12:06:42',47,'MARK_RAN','8:7be68b71d2f5b94b8df2e824f2860fa2','dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-02-26 12:06:43',48,'EXECUTED','8:bab7c631093c3861d6cf6144cd944982','addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authn-3.4.0.CR1-refresh-token-max-reuse','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-02-26 12:06:43',49,'EXECUTED','8:fa809ac11877d74d76fe40869916daad','addColumn tableName=REALM','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.4.0','keycloak','META-INF/jpa-changelog-3.4.0.xml','2023-02-26 12:06:44',50,'EXECUTED','8:fac23540a40208f5f5e326f6ceb4d291','addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.4.0-KEYCLOAK-5230','hmlnarik@redhat.com','META-INF/jpa-changelog-3.4.0.xml','2023-02-26 12:06:44',51,'EXECUTED','8:2612d1b8a97e2b5588c346e817307593','createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.4.1','psilva@redhat.com','META-INF/jpa-changelog-3.4.1.xml','2023-02-26 12:06:44',52,'EXECUTED','8:9842f155c5db2206c88bcb5d1046e941','modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.4.2','keycloak','META-INF/jpa-changelog-3.4.2.xml','2023-02-26 12:06:44',53,'EXECUTED','8:2e12e06e45498406db72d5b3da5bbc76','update tableName=REALM','',NULL,'4.16.1',NULL,NULL,'7409588480'),('3.4.2-KEYCLOAK-5172','mkanis@redhat.com','META-INF/jpa-changelog-3.4.2.xml','2023-02-26 12:06:44',54,'EXECUTED','8:33560e7c7989250c40da3abdabdc75a4','update tableName=CLIENT','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.0.0-KEYCLOAK-6335','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2023-02-26 12:06:44',55,'EXECUTED','8:87a8d8542046817a9107c7eb9cbad1cd','createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.0.0-CLEANUP-UNUSED-TABLE','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2023-02-26 12:06:44',56,'EXECUTED','8:3ea08490a70215ed0088c273d776311e','dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.0.0-KEYCLOAK-6228','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2023-02-26 12:06:45',57,'EXECUTED','8:2d56697c8723d4592ab608ce14b6ed68','dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.0.0-KEYCLOAK-5579-fixed','mposolda@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2023-02-26 12:06:46',58,'EXECUTED','8:3e423e249f6068ea2bbe48bf907f9d86','dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-4.0.0.CR1','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.CR1.xml','2023-02-26 12:06:46',59,'EXECUTED','8:15cabee5e5df0ff099510a0fc03e4103','createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-4.0.0.Beta3','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.Beta3.xml','2023-02-26 12:06:46',60,'EXECUTED','8:4b80200af916ac54d2ffbfc47918ab0e','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-4.2.0.Final','mhajas@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2023-02-26 12:06:47',61,'EXECUTED','8:66564cd5e168045d52252c5027485bbb','createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-4.2.0.Final-KEYCLOAK-9944','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2023-02-26 12:06:47',62,'EXECUTED','8:1c7064fafb030222be2bd16ccf690f6f','addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.2.0-KEYCLOAK-6313','wadahiro@gmail.com','META-INF/jpa-changelog-4.2.0.xml','2023-02-26 12:06:47',63,'EXECUTED','8:2de18a0dce10cdda5c7e65c9b719b6e5','addColumn tableName=REQUIRED_ACTION_PROVIDER','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.3.0-KEYCLOAK-7984','wadahiro@gmail.com','META-INF/jpa-changelog-4.3.0.xml','2023-02-26 12:06:47',64,'EXECUTED','8:03e413dd182dcbd5c57e41c34d0ef682','update tableName=REQUIRED_ACTION_PROVIDER','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.6.0-KEYCLOAK-7950','psilva@redhat.com','META-INF/jpa-changelog-4.6.0.xml','2023-02-26 12:06:47',65,'EXECUTED','8:d27b42bb2571c18fbe3fe4e4fb7582a7','update tableName=RESOURCE_SERVER_RESOURCE','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.6.0-KEYCLOAK-8377','keycloak','META-INF/jpa-changelog-4.6.0.xml','2023-02-26 12:06:47',66,'EXECUTED','8:698baf84d9fd0027e9192717c2154fb8','createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.6.0-KEYCLOAK-8555','gideonray@gmail.com','META-INF/jpa-changelog-4.6.0.xml','2023-02-26 12:06:47',67,'EXECUTED','8:ced8822edf0f75ef26eb51582f9a821a','createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.7.0-KEYCLOAK-1267','sguilhen@redhat.com','META-INF/jpa-changelog-4.7.0.xml','2023-02-26 12:06:47',68,'EXECUTED','8:f0abba004cf429e8afc43056df06487d','addColumn tableName=REALM','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.7.0-KEYCLOAK-7275','keycloak','META-INF/jpa-changelog-4.7.0.xml','2023-02-26 12:06:47',69,'EXECUTED','8:6662f8b0b611caa359fcf13bf63b4e24','renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('4.8.0-KEYCLOAK-8835','sguilhen@redhat.com','META-INF/jpa-changelog-4.8.0.xml','2023-02-26 12:06:47',70,'EXECUTED','8:9e6b8009560f684250bdbdf97670d39e','addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM','',NULL,'4.16.1',NULL,NULL,'7409588480'),('authz-7.0.0-KEYCLOAK-10443','psilva@redhat.com','META-INF/jpa-changelog-authz-7.0.0.xml','2023-02-26 12:06:47',71,'EXECUTED','8:4223f561f3b8dc655846562b57bb502e','addColumn tableName=RESOURCE_SERVER','',NULL,'4.16.1',NULL,NULL,'7409588480'),('8.0.0-adding-credential-columns','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-02-26 12:06:47',72,'EXECUTED','8:215a31c398b363ce383a2b301202f29e','addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL','',NULL,'4.16.1',NULL,NULL,'7409588480'),('8.0.0-updating-credential-data-not-oracle-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-02-26 12:06:47',73,'EXECUTED','8:83f7a671792ca98b3cbd3a1a34862d3d','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'4.16.1',NULL,NULL,'7409588480'),('8.0.0-updating-credential-data-oracle-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-02-26 12:06:47',74,'MARK_RAN','8:f58ad148698cf30707a6efbdf8061aa7','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'4.16.1',NULL,NULL,'7409588480'),('8.0.0-credential-cleanup-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-02-26 12:06:47',75,'EXECUTED','8:79e4fd6c6442980e58d52ffc3ee7b19c','dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('8.0.0-resource-tag-support','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-02-26 12:06:47',76,'EXECUTED','8:87af6a1e6d241ca4b15801d1f86a297d','addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.0-always-display-client','keycloak','META-INF/jpa-changelog-9.0.0.xml','2023-02-26 12:06:47',77,'EXECUTED','8:b44f8d9b7b6ea455305a6d72a200ed15','addColumn tableName=CLIENT','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.0-drop-constraints-for-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2023-02-26 12:06:47',78,'MARK_RAN','8:2d8ed5aaaeffd0cb004c046b4a903ac5','dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.0-increase-column-size-federated-fk','keycloak','META-INF/jpa-changelog-9.0.0.xml','2023-02-26 12:06:48',79,'EXECUTED','8:e290c01fcbc275326c511633f6e2acde','modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.0-recreate-constraints-after-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2023-02-26 12:06:48',80,'MARK_RAN','8:c9db8784c33cea210872ac2d805439f8','addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.1-add-index-to-client.client_id','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-02-26 12:06:48',81,'EXECUTED','8:95b676ce8fc546a1fcfb4c92fae4add5','createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.1-KEYCLOAK-12579-drop-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-02-26 12:06:48',82,'MARK_RAN','8:38a6b2a41f5651018b1aca93a41401e5','dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.1-KEYCLOAK-12579-add-not-null-constraint','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-02-26 12:06:48',83,'EXECUTED','8:3fb99bcad86a0229783123ac52f7609c','addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.1-KEYCLOAK-12579-recreate-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-02-26 12:06:48',84,'MARK_RAN','8:64f27a6fdcad57f6f9153210f2ec1bdb','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.16.1',NULL,NULL,'7409588480'),('9.0.1-add-index-to-events','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-02-26 12:06:48',85,'EXECUTED','8:ab4f863f39adafd4c862f7ec01890abc','createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY','',NULL,'4.16.1',NULL,NULL,'7409588480'),('map-remove-ri','keycloak','META-INF/jpa-changelog-11.0.0.xml','2023-02-26 12:06:48',86,'EXECUTED','8:13c419a0eb336e91ee3a3bf8fda6e2a7','dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9','',NULL,'4.16.1',NULL,NULL,'7409588480'),('map-remove-ri','keycloak','META-INF/jpa-changelog-12.0.0.xml','2023-02-26 12:06:48',87,'EXECUTED','8:e3fb1e698e0471487f51af1ed80fe3ac','dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('12.1.0-add-realm-localization-table','keycloak','META-INF/jpa-changelog-12.0.0.xml','2023-02-26 12:06:48',88,'EXECUTED','8:babadb686aab7b56562817e60bf0abd0','createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS','',NULL,'4.16.1',NULL,NULL,'7409588480'),('default-roles','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-02-26 12:06:48',89,'EXECUTED','8:72d03345fda8e2f17093d08801947773','addColumn tableName=REALM; customChange','',NULL,'4.16.1',NULL,NULL,'7409588480'),('default-roles-cleanup','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-02-26 12:06:48',90,'EXECUTED','8:61c9233951bd96ffecd9ba75f7d978a4','dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES','',NULL,'4.16.1',NULL,NULL,'7409588480'),('13.0.0-KEYCLOAK-16844','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-02-26 12:06:48',91,'EXECUTED','8:ea82e6ad945cec250af6372767b25525','createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION','',NULL,'4.16.1',NULL,NULL,'7409588480'),('map-remove-ri-13.0.0','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-02-26 12:06:48',92,'EXECUTED','8:d3f4a33f41d960ddacd7e2ef30d126b3','dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('13.0.0-KEYCLOAK-17992-drop-constraints','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-02-26 12:06:48',93,'MARK_RAN','8:1284a27fbd049d65831cb6fc07c8a783','dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT','',NULL,'4.16.1',NULL,NULL,'7409588480'),('13.0.0-increase-column-size-federated','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-02-26 12:06:48',94,'EXECUTED','8:9d11b619db2ae27c25853b8a37cd0dea','modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT','',NULL,'4.16.1',NULL,NULL,'7409588480'),('13.0.0-KEYCLOAK-17992-recreate-constraints','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-02-26 12:06:48',95,'MARK_RAN','8:3002bb3997451bb9e8bac5c5cd8d6327','addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('json-string-accomodation-fixed','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-02-26 12:06:48',96,'EXECUTED','8:dfbee0d6237a23ef4ccbb7a4e063c163','addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE','',NULL,'4.16.1',NULL,NULL,'7409588480'),('14.0.0-KEYCLOAK-11019','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-02-26 12:06:48',97,'EXECUTED','8:75f3e372df18d38c62734eebb986b960','createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION','',NULL,'4.16.1',NULL,NULL,'7409588480'),('14.0.0-KEYCLOAK-18286','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-02-26 12:06:48',98,'MARK_RAN','8:7fee73eddf84a6035691512c85637eef','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.16.1',NULL,NULL,'7409588480'),('14.0.0-KEYCLOAK-18286-revert','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-02-26 12:06:48',99,'MARK_RAN','8:7a11134ab12820f999fbf3bb13c3adc8','dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.16.1',NULL,NULL,'7409588480'),('14.0.0-KEYCLOAK-18286-supported-dbs','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-02-26 12:06:48',100,'EXECUTED','8:f43dfba07ba249d5d932dc489fd2b886','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.16.1',NULL,NULL,'7409588480'),('14.0.0-KEYCLOAK-18286-unsupported-dbs','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-02-26 12:06:48',101,'MARK_RAN','8:18186f0008b86e0f0f49b0c4d0e842ac','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.16.1',NULL,NULL,'7409588480'),('KEYCLOAK-17267-add-index-to-user-attributes','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-02-26 12:06:48',102,'EXECUTED','8:09c2780bcb23b310a7019d217dc7b433','createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE','',NULL,'4.16.1',NULL,NULL,'7409588480'),('KEYCLOAK-18146-add-saml-art-binding-identifier','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-02-26 12:06:48',103,'EXECUTED','8:276a44955eab693c970a42880197fff2','customChange','',NULL,'4.16.1',NULL,NULL,'7409588480'),('15.0.0-KEYCLOAK-18467','keycloak','META-INF/jpa-changelog-15.0.0.xml','2023-02-26 12:06:48',104,'EXECUTED','8:ba8ee3b694d043f2bfc1a1079d0760d7','addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...','',NULL,'4.16.1',NULL,NULL,'7409588480'),('17.0.0-9562','keycloak','META-INF/jpa-changelog-17.0.0.xml','2023-02-26 12:06:49',105,'EXECUTED','8:5e06b1d75f5d17685485e610c2851b17','createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY','',NULL,'4.16.1',NULL,NULL,'7409588480'),('18.0.0-10625-IDX_ADMIN_EVENT_TIME','keycloak','META-INF/jpa-changelog-18.0.0.xml','2023-02-26 12:06:49',106,'EXECUTED','8:4b80546c1dc550ac552ee7b24a4ab7c0','createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY','',NULL,'4.16.1',NULL,NULL,'7409588480'),('19.0.0-10135','keycloak','META-INF/jpa-changelog-19.0.0.xml','2023-02-26 12:06:49',107,'EXECUTED','8:af510cd1bb2ab6339c45372f3e491696','customChange','',NULL,'4.16.1',NULL,NULL,'7409588480'),('20.0.0-12964-supported-dbs','keycloak','META-INF/jpa-changelog-20.0.0.xml','2023-02-26 12:06:49',108,'EXECUTED','8:d00f99ed899c4d2ae9117e282badbef5','createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE','',NULL,'4.16.1',NULL,NULL,'7409588480'),('20.0.0-12964-unsupported-dbs','keycloak','META-INF/jpa-changelog-20.0.0.xml','2023-02-26 12:06:49',109,'MARK_RAN','8:314e803baf2f1ec315b3464e398b8247','createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE','',NULL,'4.16.1',NULL,NULL,'7409588480'),('client-attributes-string-accomodation-fixed','keycloak','META-INF/jpa-changelog-20.0.0.xml','2023-02-26 12:06:49',110,'EXECUTED','8:56e4677e7e12556f70b604c573840100','addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES','',NULL,'4.16.1',NULL,NULL,'7409588480');
/*!40000 ALTER TABLE `DATABASECHANGELOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOGLOCK`
--

LOCK TABLES `DATABASECHANGELOGLOCK` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOGLOCK` VALUES (1,'\0',NULL,NULL),(1000,'\0',NULL,NULL),(1001,'\0',NULL,NULL);
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEFAULT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `DEFAULT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEFAULT_CLIENT_SCOPE` (
  `REALM_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  `DEFAULT_SCOPE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`REALM_ID`,`SCOPE_ID`),
  KEY `IDX_DEFCLS_REALM` (`REALM_ID`),
  KEY `IDX_DEFCLS_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_R_DEF_CLI_SCOPE_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEFAULT_CLIENT_SCOPE`
--

LOCK TABLES `DEFAULT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `DEFAULT_CLIENT_SCOPE` VALUES ('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','12d0c4f6-a710-4a39-b9ca-232aed84e7ba','\0'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20c5c4ed-a639-4a45-b103-f489206cd216','\0'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3074ee96-675f-4b63-a93a-6ed4f021518a',''),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','35a9832a-809b-49da-9f1f-6691ba056241','\0'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','6b03a12f-2a22-4dcd-9abf-466a4e24aa40',''),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','81183c49-5ece-45bb-af80-59594c9320eb',''),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','8d55860b-62f0-48ee-9fe9-6aa26cf3d26c',''),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','b5b92343-a341-4659-a627-3cd5a944b245','\0'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c71449e0-78ed-4282-84c6-15ad23c781dc',''),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','dafac659-546c-4633-898e-455da5e38483',''),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','134afcf8-caf1-49c4-98da-90833e4da9a5',''),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','169c80ee-8fdc-429c-8d3d-fb13ed07641c',''),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','3a86c79f-d616-4587-863b-a959f530767a','\0'),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','551d382e-5a57-404b-a29e-9582b44ffbf1','\0'),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','81d6d87e-493d-442c-8291-f47569b51ab1',''),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','9c1cd945-a70a-45a8-9464-b9040e030b6b',''),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','be51b110-5374-460d-9564-cf852d6ffedd',''),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','cd1cdc3a-632c-48e4-b50e-36c69e528969',''),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','ea74111f-bba8-41ed-9a6e-b7335965204b','\0'),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','ee1a77a1-88b4-42fe-8a0f-20fc98089644','\0');
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EVENT_ENTITY`
--

DROP TABLE IF EXISTS `EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON` text DEFAULT NULL,
  `ERROR` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `SESSION_ID` varchar(255) DEFAULT NULL,
  `EVENT_TIME` bigint(20) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_EVENT_TIME` (`REALM_ID`,`EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EVENT_ENTITY`
--

LOCK TABLES `EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `EVENT_ENTITY` DISABLE KEYS */;
INSERT INTO `EVENT_ENTITY` VALUES ('007a743d-6229-4e8a-98ef-8c191e6bfd9e','client','{\"token_id\":\"ece0ff5c-f8ab-4db2-87c9-6041314646f9\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"b6433f18-a103-4cf0-9090-92f6126a4fce\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679143184080,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('01082e32-98be-48ac-b5b1-fb7c3c57e155','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679149129067,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('028ac1f8-b6af-4427-a7d8-0dcddea6813d','client','{\"token_id\":\"77881641-5cc7-471f-a6e3-480e621006cc\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"f95d6edb-8683-46ca-a858-2aa514a16aba\",\"code_id\":\"7e2c6e59-101e-410f-9a6c-b883d83e7bdf\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','7e2c6e59-101e-410f-9a6c-b883d83e7bdf',1679183583844,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('08177681-85f1-4f29-b150-73d87920afcf','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"3d38fa93-f22d-476e-adec-e9201d7e3836\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3d38fa93-f22d-476e-adec-e9201d7e3836',1679249659395,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('0906d02a-3988-4f2b-ae81-58dfef80aea6','client','{\"token_id\":\"c801a265-d2f3-47ae-8085-07d36a1b9f4e\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"d0608606-89c3-4577-a0dd-fa0db8e8d25a\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679149129131,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('09457474-ad91-472b-8c14-33f55dcf5c76','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"e7ae345e-c8e0-48c4-9ebd-711dc09bcc60\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','e7ae345e-c8e0-48c4-9ebd-711dc09bcc60',1679140548726,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('0acbd0f7-2030-4689-905b-9ec8095433b9','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679142644878,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('10c823e1-2ad5-46a9-8172-5631c8c8f36e','client','{\"token_id\":\"a63a6763-65bc-42c2-bc70-29182cf36477\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"32180f13-4309-46d3-9cd8-00115cb2a1e5\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679143857021,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('131c40fe-6543-4fdb-a413-ff9818e20df4','client','{\"token_id\":\"47198ba9-2c5c-4065-82d6-ffd7e9be4491\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"6717c30e-6d5d-4595-b9f3-0b2b66fde1dd\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679149342724,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('13a19534-c165-47d4-b78f-b6976c7671a7','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"50249a10-d105-491b-8f62-0c9d00bb5276\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','50249a10-d105-491b-8f62-0c9d00bb5276',1679135651068,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('152c117f-0e83-4710-a3d7-e3e6f14913f4','client','{\"token_id\":\"9af35b4e-9784-4c15-9716-c0a6e5409584\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"6975549f-6c93-4fbc-aee9-c25d09485d00\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679143378616,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('1a1e096b-cdb8-45b6-9f2a-ae8bb0418a0f','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679141393106,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('1a44c07c-8c48-4312-a6e3-00c7b1e0646f','client','{\"token_id\":\"a301fddf-2234-4487-aecf-c76b9bd5f2b7\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"962be409-664d-49c3-8225-778f4f50d4bc\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679142217632,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('1d6fb5e1-b8c9-458c-841a-b4d28ed3f4d1','client','{\"token_id\":\"2dec985d-6d13-4ab5-a606-fbe547cf291a\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"48d6b31f-9d42-4e6a-8057-20bee29e51df\",\"code_id\":\"f8050e67-ede6-4eab-b464-32509f65532d\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f8050e67-ede6-4eab-b464-32509f65532d',1679317535659,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('2f3e32a4-c7c3-4820-af9b-bcc03d98b146','client','{\"token_id\":\"aa9420ef-a8bc-4525-9113-04ba074f8e8b\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"522c3dd5-159a-4d2d-adf2-e4f8d67f2bb6\",\"code_id\":\"50249a10-d105-491b-8f62-0c9d00bb5276\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','50249a10-d105-491b-8f62-0c9d00bb5276',1679135651184,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('31f4bd1d-3503-4f95-9cd1-60cbe0c2e836','client','{\"token_id\":\"4fc96fa1-a8c6-4f7b-a325-6105a293c72d\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"78a59c9b-7efd-4995-a9d5-e983386c5aaf\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679141089870,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('33466009-6a43-44d2-880f-78f6f1f8785f','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679142163573,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('38a5f418-c125-47f1-b5e7-5aeb0b229643','client','{\"token_id\":\"51529198-a6f0-4ac2-b289-9731f9beee08\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"3c184a7f-8c39-4b56-886a-bdf8487c0bff\",\"code_id\":\"9e6a2601-88f1-45ff-8448-0864ecd4b5f2\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','9e6a2601-88f1-45ff-8448-0864ecd4b5f2',1679183298621,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('3b16e739-6d2d-4c2b-9777-349eebf776ff','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679142351932,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('3b9c912f-bef9-4346-9446-5082a7ca6eb6','client','{\"token_id\":\"beb83095-5cf6-4482-87da-a96f252186a7\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"5ab7ca69-8263-4990-aad5-12dcde05056e\",\"code_id\":\"9e6a2601-88f1-45ff-8448-0864ecd4b5f2\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','9e6a2601-88f1-45ff-8448-0864ecd4b5f2',1679183082067,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('3c02ebcf-d0d1-4737-b215-e9b704e08adc','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679143184021,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('3fc28c9b-ef19-41a5-b5fc-3abb7dcb2630','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"5f120aea-b3eb-46ef-b308-2a37a57b5c20\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','5f120aea-b3eb-46ef-b308-2a37a57b5c20',1679230150089,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('4045eccf-aed6-4de9-b23a-25471c9e2936','client','{\"token_id\":\"78d9b2c2-6316-4fb9-85ca-3683a09f40b3\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"96dc1864-c46a-424b-9a5c-c601b9a283aa\",\"code_id\":\"5f120aea-b3eb-46ef-b308-2a37a57b5c20\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','5f120aea-b3eb-46ef-b308-2a37a57b5c20',1679230150158,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('440ad582-4a71-44bf-b51a-91d6158557d5','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"9e6a2601-88f1-45ff-8448-0864ecd4b5f2\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','9e6a2601-88f1-45ff-8448-0864ecd4b5f2',1679183298546,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('468266ed-d832-4ce2-96fb-a49a138993ea','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"f6510d8c-8f06-4869-83f3-bd1a0836d522\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f6510d8c-8f06-4869-83f3-bd1a0836d522',1679355821705,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('468efdf0-4841-4cb6-9b54-647322adfff4','client','{\"token_id\":\"dba3dd72-dd95-4d50-879f-5b526717b8a6\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"c7474c0e-99af-40ca-9f97-444bd6c49884\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679142163659,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('46f944d7-452b-4b30-b6f2-3d7586a67b25','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679143133696,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('48bfad51-cf44-4cc2-916c-ba83580e8883','client','{\"token_id\":\"03e7df76-650c-4180-8cbb-9443a7947eaa\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"f471aca4-98c0-41ec-a1b9-69d8f25b1fbe\",\"code_id\":\"75e34432-fb20-4fa0-abfa-d565ea5d005a\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','75e34432-fb20-4fa0-abfa-d565ea5d005a',1679228134357,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('49dcd01b-525a-44bb-a38f-503d6d9836fc','client','{\"token_id\":\"415c46e7-ff51-4763-8001-95b122919417\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"cb1907ea-e0ce-4a3e-b010-994ad5589369\",\"code_id\":\"cfb62d06-f1a6-4ef1-af36-f3f1e5d76e7e\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','cfb62d06-f1a6-4ef1-af36-f3f1e5d76e7e',1679249148390,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('4a2569e5-8a7e-441b-a684-6dc8baed7f71','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"cfb62d06-f1a6-4ef1-af36-f3f1e5d76e7e\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','cfb62d06-f1a6-4ef1-af36-f3f1e5d76e7e',1679249148217,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('4b9264fc-8ec3-4ca1-855f-5f03f6449b18','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679143567651,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('4c5dc632-c864-4eb0-9434-5ff250e3a398','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"079b358b-fdc1-4abd-8aaf-b5a8d64d787c\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','079b358b-fdc1-4abd-8aaf-b5a8d64d787c',1679183880831,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('54b0ecab-2bb2-464c-8afe-72c5a18ac7f4','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"7e2c6e59-101e-410f-9a6c-b883d83e7bdf\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','7e2c6e59-101e-410f-9a6c-b883d83e7bdf',1679185040368,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('54d4268c-85fe-47f0-8f00-57d1151f79c8','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"3d38fa93-f22d-476e-adec-e9201d7e3836\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3d38fa93-f22d-476e-adec-e9201d7e3836',1679250055132,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('56077c45-10a7-4cb9-9847-ffa4d60592cd','client','{\"token_id\":\"319d7fae-dd3a-4ac3-9f2f-3570668d20b1\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"5e3e21ef-9233-4acb-909e-02b653ef2c55\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'127.0.0.1','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679140964280,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('586b5ad3-9d32-4eef-8ab2-08492dea9063','client','{\"token_id\":\"23bde765-abe6-4f16-839b-12616c68368e\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"256d14ba-0200-4a48-85ac-818aa5acf4dd\",\"code_id\":\"f6510d8c-8f06-4869-83f3-bd1a0836d522\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f6510d8c-8f06-4869-83f3-bd1a0836d522',1679354703747,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('59e36ab0-e866-4418-a92e-57e2349f9df1','client','{\"token_id\":\"7ce6fa9b-76ef-4331-8643-41cdc9173862\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"a587451d-fb75-403f-a957-bf3037382c1a\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679141393236,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('5b4a1513-1a76-4c03-a58c-a2d4d40470d6','client','{\"token_id\":\"62edf4da-31bb-4a3d-9435-35492d1c686b\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"bd7140c0-dce4-497c-8243-f5b057fef8e3\",\"code_id\":\"e7ae345e-c8e0-48c4-9ebd-711dc09bcc60\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','e7ae345e-c8e0-48c4-9ebd-711dc09bcc60',1679140548770,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('61286b5a-f913-4a11-aba4-72d4565135c5','client','{\"token_id\":\"e15836aa-43de-4d7a-ae11-1246edb350a0\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"eeb1b417-ac1d-451c-8989-0c61538a46a6\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679147740488,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('61770684-f802-4f5c-ba2a-0cfac48db85e','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"75e34432-fb20-4fa0-abfa-d565ea5d005a\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','75e34432-fb20-4fa0-abfa-d565ea5d005a',1679228134247,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('61dfda11-1a9f-4d06-ab20-df19b1a67c69','client','{\"token_id\":\"4def957c-65ce-4b0d-90dc-c247dd89bada\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"cc7e2839-3b03-4c19-a21f-3460ba9967f5\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679143939631,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('656747d6-a81a-4f5a-8d47-155b8f39f7cc','client','{\"token_id\":\"3e39bfe7-186d-4b75-b82d-3c483ce763e2\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"6f1a8ff0-988b-4a65-980f-883cc2a792a5\",\"code_id\":\"7e2c6e59-101e-410f-9a6c-b883d83e7bdf\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','7e2c6e59-101e-410f-9a6c-b883d83e7bdf',1679185040444,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('66b11339-2f8c-44dd-84eb-4b0593259fc9','client','{\"token_id\":\"14bbd686-177e-4b81-bb28-6d77ee5ea02a\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"a7f61ab2-ddf5-4578-9155-6e5174c15cdb\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679143917744,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('693d5bd0-5160-44c4-8784-2a808828df6d','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"7e2c6e59-101e-410f-9a6c-b883d83e7bdf\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','7e2c6e59-101e-410f-9a6c-b883d83e7bdf',1679183583706,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('69e0ca51-4c3f-4f9b-9ade-172ef93309cb','client','{\"token_id\":\"e4d149a3-1d8d-4e77-8a2f-902738696c64\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"fce7f14a-cc0e-4af7-bfbf-273cfc732938\",\"code_id\":\"7e2c6e59-101e-410f-9a6c-b883d83e7bdf\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','7e2c6e59-101e-410f-9a6c-b883d83e7bdf',1679185091758,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('6a1ea5b6-6d56-491f-8d39-7917a608d978','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679147833557,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('6a8868c9-026e-438a-9639-9b335c925d48','client','{\"token_id\":\"e77a61d3-bed3-4c99-a458-f6deb238f8e3\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"b7e680b0-13ff-449a-b0b5-6703888e55cf\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679143133783,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('6f2dd285-525b-4d2c-a04f-4dcd6b679dbc','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679143856951,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('75d8eb24-553d-48ea-8266-994acdc9d9e5','client','{\"token_id\":\"231a23be-1c00-4780-a5fe-7b2ec4fe3810\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"96f61249-c035-4165-b4c8-b4c86489e014\",\"code_id\":\"f6e83080-c9e1-45cc-a801-1a5b97fd6cb6\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f6e83080-c9e1-45cc-a801-1a5b97fd6cb6',1679149761529,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('76cf7c2f-5724-47e3-b642-a94f5594660a','client','{\"token_id\":\"13eb3e8b-a301-47c9-8f56-c32df4a3a9c5\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"de39b6e8-09b1-4305-b353-8885869ec44a\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679148302391,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('78be45c3-4e11-4f22-80f9-363e8ab98b1f','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"9e6a2601-88f1-45ff-8448-0864ecd4b5f2\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','9e6a2601-88f1-45ff-8448-0864ecd4b5f2',1679183081373,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('7904c36b-748c-4915-b88e-16ec83703145','client','{\"token_id\":\"b346d793-1669-4611-8716-80d57e9604a6\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"1f226918-8f78-40ad-bb30-e56518613f70\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679141807090,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('7a70e195-e4b9-4ef9-abab-4c507090a58f','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"cfb62d06-f1a6-4ef1-af36-f3f1e5d76e7e\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','cfb62d06-f1a6-4ef1-af36-f3f1e5d76e7e',1679250047076,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('7b360f13-6dcc-4715-8564-5dd6a82c2324','client','{\"token_id\":\"5f2ddc11-0d1c-42bd-a544-7ec508fc24e4\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"7f0c6b70-1d2b-4d8c-8976-456bdda62408\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679143516266,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('7f858992-761a-422f-bc02-85478e3b0cd8','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://keycloak.vrscuola.it:9443/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679140964157,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('8089936e-fa71-4a0a-8f4b-0c29f0e109a1','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679142217538,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('81137ee2-faeb-4392-a1c2-33be398521a4','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"e7ae345e-c8e0-48c4-9ebd-711dc09bcc60\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','e7ae345e-c8e0-48c4-9ebd-711dc09bcc60',1679140655572,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('82bcce78-2285-4791-844f-40566ce2a045','client','{\"token_id\":\"49411454-e196-4a3d-bfac-7674989e94bb\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"dcacdc46-88e6-4f42-9a7b-6ddb1877facc\",\"code_id\":\"f6510d8c-8f06-4869-83f3-bd1a0836d522\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f6510d8c-8f06-4869-83f3-bd1a0836d522',1679355129881,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('8668289a-2b8d-4f95-9f2a-5111edf6995d','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"3001fff3-bd23-4be9-908f-4a7eb58c9d4f\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3001fff3-bd23-4be9-908f-4a7eb58c9d4f',1679355717234,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('8e58c20f-3a21-40f8-80db-a4a06d101a85','client','{\"token_id\":\"3ecf8ec7-4ace-4842-be9e-5f7164e4ec68\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"a48ca789-aa93-4a15-929a-002024a695ae\",\"code_id\":\"3d38fa93-f22d-476e-adec-e9201d7e3836\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3d38fa93-f22d-476e-adec-e9201d7e3836',1679249659509,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('90d488d9-ff07-4f40-9d64-390564abd0d3','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679148302287,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('93909834-7a9a-4620-a753-b98ddacc6596','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679141807020,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('9714253e-c89d-409c-b91d-b18dceacd71a','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"https://keycloak.vrscuola.it:9443/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"50249a10-d105-491b-8f62-0c9d00bb5276\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','50249a10-d105-491b-8f62-0c9d00bb5276',1679136063823,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('97613c10-6964-4dad-b7a1-768290d3f71f','client','{\"token_id\":\"664b892a-0e22-4c67-bbd9-569cc2dd6391\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"69c43c08-547a-4dcc-8f12-462ff74feb3e\",\"code_id\":\"cfb62d06-f1a6-4ef1-af36-f3f1e5d76e7e\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','cfb62d06-f1a6-4ef1-af36-f3f1e5d76e7e',1679250047175,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('9e6a0a5d-e906-42b7-8d0c-41dd8ea7d66b','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"7e2c6e59-101e-410f-9a6c-b883d83e7bdf\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','7e2c6e59-101e-410f-9a6c-b883d83e7bdf',1679183415679,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('a1d2ff5c-66c5-4339-adc4-cf1d35ace681','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"d66497df-5f09-4359-bdf8-c85d2ba7846d\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d66497df-5f09-4359-bdf8-c85d2ba7846d',1679355165490,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('a2fe7e4f-f3aa-42b0-bd6d-9b4333202cf2','client','{\"token_id\":\"a17e728e-84f2-46aa-8068-1117dc6f23f0\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"9204be87-3ebe-4bf2-8060-003de4ad6592\",\"code_id\":\"f6510d8c-8f06-4869-83f3-bd1a0836d522\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f6510d8c-8f06-4869-83f3-bd1a0836d522',1679355821808,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('a4470f21-8df6-432a-b008-4fe9457adad5','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679149178026,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('a61fe0b6-396c-4d79-a034-b308b9f43715','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"51c91446-2ec5-4877-9efa-87b576a8b807\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','51c91446-2ec5-4877-9efa-87b576a8b807',1679317601251,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('a6261397-ace8-4fd4-95fb-1a8c72d7de5e','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"f6510d8c-8f06-4869-83f3-bd1a0836d522\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f6510d8c-8f06-4869-83f3-bd1a0836d522',1679355129711,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('ac7eef16-6ecd-4297-8d70-92c33ac65fbc','client','{\"token_id\":\"565203b0-3c97-4f32-8391-6244fac7908b\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"e38a202e-c03f-4392-bda5-3d27af428fef\",\"code_id\":\"3d38fa93-f22d-476e-adec-e9201d7e3836\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3d38fa93-f22d-476e-adec-e9201d7e3836',1679250055238,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('ae982295-0020-4150-9ed6-4d5108301ca3','client','{\"token_id\":\"8a4cec6a-7799-414c-98ad-9c196a5594be\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"1e2e0d3f-edd1-4639-8d67-aff778da3988\",\"code_id\":\"3001fff3-bd23-4be9-908f-4a7eb58c9d4f\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3001fff3-bd23-4be9-908f-4a7eb58c9d4f',1679355398628,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('b1fa2997-3c3c-4186-8ade-1a4e42123844','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"079b358b-fdc1-4abd-8aaf-b5a8d64d787c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','079b358b-fdc1-4abd-8aaf-b5a8d64d787c',1679185007819,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('b6668450-897e-4ace-85da-c2a8d3d5952a','client','{\"token_id\":\"b8e782db-4be0-4b31-b3ab-12bec160d03f\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"2cdb3f93-f400-4a07-b337-dfdaf4d6ebbf\",\"code_id\":\"3001fff3-bd23-4be9-908f-4a7eb58c9d4f\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3001fff3-bd23-4be9-908f-4a7eb58c9d4f',1679355717326,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('c2861dec-aa3f-4c46-80a6-e3888ce51706','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"09497d52-4ed5-447e-ba95-5fdbf7ad6a91\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','09497d52-4ed5-447e-ba95-5fdbf7ad6a91',1679183136967,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('c8866421-1b51-4dc9-b98c-a3c579a94f74','client','{\"token_id\":\"d79058c8-d50c-4201-ae25-6fb39beb5a95\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"108481bb-7f02-4686-8785-86a9681b9e91\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679149178129,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('c8bb0ea5-f2ce-4f6e-88dc-a34dfd5538a4','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679147740413,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('c97486aa-7f47-480d-bfc8-50acfaf83960','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679143516193,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('cc4cb767-5454-40c3-9c05-5a894b904132','client','{\"token_id\":\"5b8a7ce0-15e3-4627-b00e-2c8a017a1980\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"fb77e78e-4559-40cb-aad6-8d8998a0591f\",\"code_id\":\"d66497df-5f09-4359-bdf8-c85d2ba7846d\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d66497df-5f09-4359-bdf8-c85d2ba7846d',1679355165618,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('cd6d41ab-cf9d-4b6f-abe6-5419c21e9878','client','{\"token_id\":\"30915d1a-4728-4caa-bba2-23cac004dfff\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"3bf992ea-9e39-4bdc-8a58-9deba382d982\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679147631489,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('cdf4921f-12b7-45b4-8932-a48e22e1b1d1','client','{\"token_id\":\"f469ca5f-f3d6-4c77-8dcd-17b73d6838bf\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"1b1b608d-f4fe-4851-a26c-aabad54f99e6\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679144144145,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('ce420f0e-1fff-4710-acd8-e3788e41d18f','client','{\"token_id\":\"ac419da5-55c0-4b95-b11d-c869825d1dd6\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"cfd56440-03f5-49bd-8a56-c2bbef528185\",\"code_id\":\"7e2c6e59-101e-410f-9a6c-b883d83e7bdf\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','7e2c6e59-101e-410f-9a6c-b883d83e7bdf',1679183415864,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('cf95642e-a020-492e-9b3a-8c239ffaf6ee','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679147631424,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('d7f4dc4e-4095-487b-bda8-a7e8c0155e96','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"f6510d8c-8f06-4869-83f3-bd1a0836d522\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f6510d8c-8f06-4869-83f3-bd1a0836d522',1679354703147,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('d9282554-b1a7-4c5c-8582-52f2e13527de','client','{\"token_id\":\"45241d9c-e6af-40a6-9155-a039a3abb7ac\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"8ebc45d3-5160-4932-b4b5-ed544e21d27e\",\"code_id\":\"51c91446-2ec5-4877-9efa-87b576a8b807\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','51c91446-2ec5-4877-9efa-87b576a8b807',1679317601423,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('d93b7043-f39c-4bb5-9724-9554c332620d','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679143378526,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('d9ec05cf-0643-4802-86bd-58544ca67382','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"f6e83080-c9e1-45cc-a801-1a5b97fd6cb6\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f6e83080-c9e1-45cc-a801-1a5b97fd6cb6',1679149761373,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('db42cbd9-8fe7-471d-a79b-bb59754a8969','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679144144033,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('dbb5ed9d-02c8-4d09-91ea-b7a6a2cb06cd','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"3001fff3-bd23-4be9-908f-4a7eb58c9d4f\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','3001fff3-bd23-4be9-908f-4a7eb58c9d4f',1679355398501,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('dc194fa0-bcd5-469e-ab58-5a97fda3a09a','client','{\"token_id\":\"f4e8130d-8e32-425b-87d7-e69aa097fe28\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"556b1eff-5bda-4631-9211-dc469f84732f\",\"code_id\":\"079b358b-fdc1-4abd-8aaf-b5a8d64d787c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','079b358b-fdc1-4abd-8aaf-b5a8d64d787c',1679183880983,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('dc797c51-4495-441d-865a-0ea9905f5dc5','client','{\"token_id\":\"ea6e3957-5510-4bbb-9d94-f604093c1023\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"e80198ac-3a33-477c-ac5b-ce65a3eba4e7\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679143567745,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('dd292840-5383-47fe-8160-745104283bd1','client','{\"token_id\":\"07759227-5b1f-4f61-92b1-3990ae644b22\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"f960b68c-00ee-4348-8762-ed981c0d2a4f\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679142352020,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('dd57ea17-dd95-4423-aae2-122f6c2e908b','client','{\"token_id\":\"a879fd52-9fcc-4d9d-a0fe-d9ad3a748b5b\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"2e7e76d6-b5a6-44d8-82e0-bb2c82d9f9a1\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679147833615,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('debb8bcb-0244-4d73-9b40-6e658df78e86','client','{\"token_id\":\"50438ce9-218e-433a-b2ed-2dd0da0c2f27\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"a0fdd4bf-16db-4230-9f26-0a26c2d3ba39\",\"code_id\":\"e7ae345e-c8e0-48c4-9ebd-711dc09bcc60\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','e7ae345e-c8e0-48c4-9ebd-711dc09bcc60',1679140655649,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('dfd275a1-212a-4510-b32d-5611ebd68894','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"7e2c6e59-101e-410f-9a6c-b883d83e7bdf\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','7e2c6e59-101e-410f-9a6c-b883d83e7bdf',1679185091684,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('e648d591-10ae-4a13-b3be-115d5decc77b','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"redirect_uri\":\"https://scuola.vrscuola.it/api/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"f8050e67-ede6-4eab-b464-32509f65532d\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','f8050e67-ede6-4eab-b464-32509f65532d',1679317535397,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('e89b3207-5bbe-464b-92e3-350186c52ba7','client','{\"token_id\":\"0b6717f2-20c6-4084-9d02-17a5d4068c5e\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"5480b6d2-9fda-4b00-b167-4b730de29ed0\",\"code_id\":\"50249a10-d105-491b-8f62-0c9d00bb5276\",\"client_auth_method\":\"client-secret\"}',NULL,'127.0.0.1','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','50249a10-d105-491b-8f62-0c9d00bb5276',1679136064070,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('e9cd6567-b1b1-4e9f-abc6-ee6c1cb1ecac','client','{\"token_id\":\"f9301155-e85b-4430-a53c-ecb55db771c2\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"6110f1ec-ebc6-40ce-aaf7-3b114fc0bc68\",\"code_id\":\"079b358b-fdc1-4abd-8aaf-b5a8d64d787c\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','079b358b-fdc1-4abd-8aaf-b5a8d64d787c',1679185007923,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('f36b6567-f545-451c-97c3-13ba57b05b76','client','{\"token_id\":\"1090cf30-84fa-4fcd-a5e7-f6e703359dae\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"4841bcce-224b-42d0-b943-37d21617a959\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679142644975,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('f5214155-b9c9-4f69-aaaa-f0b57d7e98b3',NULL,'null','invalid_request','192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,1679258963826,'LOGIN_ERROR',NULL),('f80adecf-705b-4d0a-8dcc-147484783a5c','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"c7e6cac1-4d2e-40cf-a073-cb460006e5c3\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','c7e6cac1-4d2e-40cf-a073-cb460006e5c3',1679143939561,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('f90bfa19-414d-4cfe-af60-2a0949c64911','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"d073ddb2-2e4c-4e5c-9429-03c7395fa921\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','d073ddb2-2e4c-4e5c-9429-03c7395fa921',1679149342629,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('f9316c1a-3ca9-485f-9204-c310b2aa509a','client','{\"token_id\":\"d75dd1a4-5621-4d12-aab8-7c6eb209dd26\",\"grant_type\":\"authorization_code\",\"refresh_token_type\":\"Refresh\",\"scope\":\"openid email profile\",\"refresh_token_id\":\"0e575d2f-37f0-4c08-94ce-376cd088b0bd\",\"code_id\":\"09497d52-4ed5-447e-ba95-5fdbf7ad6a91\",\"client_auth_method\":\"client-secret\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','09497d52-4ed5-447e-ba95-5fdbf7ad6a91',1679183137089,'CODE_TO_TOKEN','b329274b-a238-4600-9662-257cc6d50f0f'),('fabe12a6-8d92-4fab-b4b4-152ae7b823db','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679141089767,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f'),('fe971a83-e07a-400f-ac53-b58a9c7ab242','client','{\"auth_method\":\"openid-connect\",\"auth_type\":\"code\",\"response_type\":\"code\",\"redirect_uri\":\"http://localhost:8080/sso/login\",\"consent\":\"no_consent_required\",\"code_id\":\"372269cf-4654-4cdd-b34c-7d4bdba35a9c\",\"response_mode\":\"query\",\"username\":\"benepell\"}',NULL,'192.168.178.101','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','372269cf-4654-4cdd-b34c-7d4bdba35a9c',1679143917634,'LOGIN','b329274b-a238-4600-9662-257cc6d50f0f');
/*!40000 ALTER TABLE `EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_IDENTITY`
--

DROP TABLE IF EXISTS `FEDERATED_IDENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FEDERATED_IDENTITY` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FEDERATED_USER_ID` varchar(255) DEFAULT NULL,
  `FEDERATED_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`),
  KEY `IDX_FEDIDENTITY_USER` (`USER_ID`),
  KEY `IDX_FEDIDENTITY_FEDUSER` (`FEDERATED_USER_ID`),
  CONSTRAINT `FK404288B92EF007A6` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_IDENTITY`
--

LOCK TABLES `FEDERATED_IDENTITY` WRITE;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_USER`
--

DROP TABLE IF EXISTS `FEDERATED_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FEDERATED_USER` (
  `ID` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_USER`
--

LOCK TABLES `FEDERATED_USER` WRITE;
/*!40000 ALTER TABLE `FEDERATED_USER` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `FED_USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `VALUE` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_ATTRIBUTE` (`USER_ID`,`REALM_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ATTRIBUTE`
--

LOCK TABLES `FED_USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint(20) DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CONSENT` (`USER_ID`,`CLIENT_ID`),
  KEY `IDX_FU_CONSENT_RU` (`REALM_ID`,`USER_ID`),
  KEY `IDX_FU_CNSNT_EXT` (`USER_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT`
--

LOCK TABLES `FED_USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT_CL_SCOPE`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT_CL_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_CONSENT_CL_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT_CL_SCOPE`
--

LOCK TABLES `FED_USER_CONSENT_CL_SCOPE` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CREDENTIAL`
--

DROP TABLE IF EXISTS `FED_USER_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext DEFAULT NULL,
  `CREDENTIAL_DATA` longtext DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CREDENTIAL` (`USER_ID`,`TYPE`),
  KEY `IDX_FU_CREDENTIAL_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CREDENTIAL`
--

LOCK TABLES `FED_USER_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `FED_USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP` (`USER_ID`,`GROUP_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `FED_USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `FED_USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_REQUIRED_ACTION` (
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_FU_REQUIRED_ACTION` (`USER_ID`,`REQUIRED_ACTION`),
  KEY `IDX_FU_REQUIRED_ACTION_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_REQUIRED_ACTION`
--

LOCK TABLES `FED_USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `FED_USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_FU_ROLE_MAPPING` (`USER_ID`,`ROLE_ID`),
  KEY `IDX_FU_ROLE_MAPPING_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ROLE_MAPPING`
--

LOCK TABLES `FED_USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ATTRIBUTE`
--

DROP TABLE IF EXISTS `GROUP_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GROUP_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_GROUP_ATTR_GROUP` (`GROUP_ID`),
  KEY `IDX_GROUP_ATT_BY_NAME_VALUE` (`NAME`,`VALUE`),
  CONSTRAINT `FK_GROUP_ATTRIBUTE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ATTRIBUTE`
--

LOCK TABLES `GROUP_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `GROUP_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GROUP_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`GROUP_ID`),
  KEY `IDX_GROUP_ROLE_MAPP_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK_GROUP_ROLE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ROLE_MAPPING`
--

LOCK TABLES `GROUP_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `GROUP_ROLE_MAPPING` VALUES ('517ed924-aaa0-4801-86f8-b0402ce100d7','f7bb5df2-d829-4cd4-b1ef-a1dee794c13a'),('7eaa3f2d-dfa4-4b51-b3c3-aced331e7f01','c5828018-7f2c-47a7-bd43-3e84a2b47e01'),('8973e0cd-6a4a-4a39-9466-ea53fbf92385','6a629359-fa6e-4a9b-b3b4-d767040b57a7'),('8973e0cd-6a4a-4a39-9466-ea53fbf92385','f33fe273-da4d-4de1-beb9-be9808c9074f'),('fd49155a-e786-465b-8ce1-a7ead471850e','6a629359-fa6e-4a9b-b3b4-d767040b57a7');
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IDENTITY_PROVIDER` (
  `INTERNAL_ID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `PROVIDER_ALIAS` varchar(255) DEFAULT NULL,
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `STORE_TOKEN` bit(1) NOT NULL DEFAULT b'0',
  `AUTHENTICATE_BY_DEFAULT` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ADD_TOKEN_ROLE` bit(1) NOT NULL DEFAULT b'1',
  `TRUST_EMAIL` bit(1) NOT NULL DEFAULT b'0',
  `FIRST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `POST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `LINK_ONLY` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`INTERNAL_ID`),
  UNIQUE KEY `UK_2DAELWNIBJI49AVXSRTUF6XJ33` (`PROVIDER_ALIAS`,`REALM_ID`),
  KEY `IDX_IDENT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK2B4EBC52AE5C3B34` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER`
--

LOCK TABLES `IDENTITY_PROVIDER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_CONFIG`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IDENTITY_PROVIDER_CONFIG` (
  `IDENTITY_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FKDC4897CF864C4E43` FOREIGN KEY (`IDENTITY_PROVIDER_ID`) REFERENCES `IDENTITY_PROVIDER` (`INTERNAL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_CONFIG`
--

LOCK TABLES `IDENTITY_PROVIDER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_MAPPER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IDENTITY_PROVIDER_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `IDP_ALIAS` varchar(255) NOT NULL,
  `IDP_MAPPER_NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ID_PROV_MAPP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_IDPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_MAPPER`
--

LOCK TABLES `IDENTITY_PROVIDER_MAPPER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDP_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `IDP_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IDP_MAPPER_CONFIG` (
  `IDP_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDP_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_IDPMCONFIG` FOREIGN KEY (`IDP_MAPPER_ID`) REFERENCES `IDENTITY_PROVIDER_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDP_MAPPER_CONFIG`
--

LOCK TABLES `IDP_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_GROUP`
--

DROP TABLE IF EXISTS `KEYCLOAK_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `KEYCLOAK_GROUP` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `PARENT_GROUP` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SIBLING_NAMES` (`REALM_ID`,`PARENT_GROUP`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_GROUP`
--

LOCK TABLES `KEYCLOAK_GROUP` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` DISABLE KEYS */;
INSERT INTO `KEYCLOAK_GROUP` VALUES ('f7bb5df2-d829-4cd4-b1ef-a1dee794c13a','allievi',' ','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed'),('f33fe273-da4d-4de1-beb9-be9808c9074f','dirigenti',' ','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed'),('c5828018-7f2c-47a7-bd43-3e84a2b47e01','docenti',' ','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed'),('6a629359-fa6e-4a9b-b3b4-d767040b57a7','sistemista',' ','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed');
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_ROLE`
--

DROP TABLE IF EXISTS `KEYCLOAK_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `KEYCLOAK_ROLE` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_REALM_CONSTRAINT` varchar(255) DEFAULT NULL,
  `CLIENT_ROLE` bit(1) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `CLIENT` varchar(36) DEFAULT NULL,
  `REALM` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_J3RWUVD56ONTGSUHOGM184WW2-2` (`NAME`,`CLIENT_REALM_CONSTRAINT`),
  KEY `IDX_KEYCLOAK_ROLE_CLIENT` (`CLIENT`),
  KEY `IDX_KEYCLOAK_ROLE_REALM` (`REALM`),
  CONSTRAINT `FK_6VYQFE4CN4WLQ8R6KT5VDSJ5C` FOREIGN KEY (`REALM`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_ROLE`
--

LOCK TABLES `KEYCLOAK_ROLE` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` DISABLE KEYS */;
INSERT INTO `KEYCLOAK_ROLE` VALUES ('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','${role_default-roles}','default-roles-scuola','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL),('044a260c-a8b5-4ccf-9e1f-46ed5aa20a08','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_manage-identity-providers}','manage-identity-providers','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('0a2021db-294d-4a18-aa21-16ad5f6fa40f','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_manage-events}','manage-events','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('0b6da521-5b61-44e8-9c25-4b7f2efddf36','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_view-realm}','view-realm','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('0ba282e7-4a52-41b5-8a67-7ad61e62ea4c','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_manage-authorization}','manage-authorization','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('0f9ae058-cc2c-4178-9382-cf14d126379e','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_view-users}','view-users','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('10fba44e-797b-4e17-8a89-a4dc7ec2bd1a','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_manage-realm}','manage-realm','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('1144aa1d-3611-415a-9fc9-143f26e32bbf','20f14d27-b1fe-493b-9c51-93721413391a','','${role_view-profile}','view-profile','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20f14d27-b1fe-493b-9c51-93721413391a',NULL),('120a375f-16aa-43e9-83d3-5ec7cb785b08','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_view-users}','view-users','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('125c8d1b-f897-4f65-b0ea-1005bc6729d0','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_realm-admin}','realm-admin','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('1856ffd4-8181-4cae-9a93-61e659f39bb9','f47dc79c-5538-4cdb-9f59-3396e016c2ce','\0','${role_offline-access}','offline_access','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL,NULL),('18a96b32-b3d9-4536-aa22-c4d6e81fb961','f47dc79c-5538-4cdb-9f59-3396e016c2ce','\0','${role_uma_authorization}','uma_authorization','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL,NULL),('193f0c58-2e7a-4e8e-b063-fc6d64b92f0b','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_query-users}','query-users','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('1a0b6027-1d65-4479-9315-fe67b8afb89a','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_query-realms}','query-realms','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('1b68accc-d4d5-4d86-8c8e-adf4a5149a0e','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_manage-users}','manage-users','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('1d998211-74e1-4fb9-b164-3e0ae8571609','20f14d27-b1fe-493b-9c51-93721413391a','','${role_view-consent}','view-consent','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20f14d27-b1fe-493b-9c51-93721413391a',NULL),('1df96405-3497-4601-b32a-150fb8304e80','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_manage-authorization}','manage-authorization','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('260e85aa-d84e-4369-bbf5-53fca4af577e','f47dc79c-5538-4cdb-9f59-3396e016c2ce','\0','${role_default-roles}','default-roles-master','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL,NULL),('27c4eb54-91e8-4e3e-a0c1-f0fc18624ec9','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_query-realms}','query-realms','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('2a371782-26df-4266-b9bd-a1c0bd0d6508','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_query-clients}','query-clients','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('2d44c51d-25a7-4683-b4ae-e31da0074f32','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_manage-users}','manage-users','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('2db2a1d7-2cea-4b91-9ddc-ef0a2d858dea','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','','guests','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL),('30f7affa-238d-4eab-9e08-90fbe24e8ef2','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_view-clients}','view-clients','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('340da22c-2a33-4d28-9f3d-65ed20d89cd6','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_create-client}','create-client','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('35cbd3d3-4833-45c7-81c5-5ac4cc1c2a33','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_impersonation}','impersonation','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('370ef785-0700-4d07-9f69-423e373741db','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_impersonation}','impersonation','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('37f48bdb-0c28-432f-88d0-da0a7cf4588f','20f14d27-b1fe-493b-9c51-93721413391a','','${role_manage-consent}','manage-consent','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20f14d27-b1fe-493b-9c51-93721413391a',NULL),('3cb61a76-fd22-4775-a5fb-b2de69f9436a','9de772ef-43ef-431b-bfd4-f7dbac5a8ca0','','${role_read-token}','read-token','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','9de772ef-43ef-431b-bfd4-f7dbac5a8ca0',NULL),('42bf066b-3e60-4af3-85ce-a709a13d138f','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_manage-realm}','manage-realm','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('43daf1d5-6281-4012-b801-3f6e17511a37','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_query-groups}','query-groups','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('4763d5da-7986-49c0-85d3-6b2d495402d6','6f8cc551-edc9-41ec-a489-a32729ef6a74','','${role_manage-account-links}','manage-account-links','f47dc79c-5538-4cdb-9f59-3396e016c2ce','6f8cc551-edc9-41ec-a489-a32729ef6a74',NULL),('47fe6c40-54e4-4eba-bbdd-60ffaf5bd5e1','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_query-realms}','query-realms','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('48a2b595-d2cf-45c2-b0e4-ba4d87b7d52d','6f8cc551-edc9-41ec-a489-a32729ef6a74','','${role_view-profile}','view-profile','f47dc79c-5538-4cdb-9f59-3396e016c2ce','6f8cc551-edc9-41ec-a489-a32729ef6a74',NULL),('4aff66d6-f541-4b91-acd2-045161a17865','6f8cc551-edc9-41ec-a489-a32729ef6a74','','${role_view-consent}','view-consent','f47dc79c-5538-4cdb-9f59-3396e016c2ce','6f8cc551-edc9-41ec-a489-a32729ef6a74',NULL),('517ed924-aaa0-4801-86f8-b0402ce100d7','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','','users','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL),('54e0298f-df20-474d-9535-939853477117','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_create-client}','create-client','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('59b89136-b724-476c-b149-88df3fdc410b','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_manage-events}','manage-events','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('5a82a4dd-4724-44dc-8f0e-fed377febb03','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_view-authorization}','view-authorization','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('5d8b6397-e372-4dcb-b5cd-ebdebfc8ebc6','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_view-users}','view-users','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('606bf968-219b-46a8-943d-a61bb2204198','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_query-clients}','query-clients','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('6368fc66-2cdc-4e5d-8f9b-88266a04b578','20f14d27-b1fe-493b-9c51-93721413391a','','${role_view-groups}','view-groups','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20f14d27-b1fe-493b-9c51-93721413391a',NULL),('64fb13e9-07af-4bc0-9c09-0b2ca3312a3f','20f14d27-b1fe-493b-9c51-93721413391a','','${role_view-applications}','view-applications','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20f14d27-b1fe-493b-9c51-93721413391a',NULL),('7668002c-3ce8-4ad4-8e03-e7333756debc','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_view-authorization}','view-authorization','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('78ce352b-4769-4420-9c04-73c0890b9e8a','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_create-client}','create-client','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('7eaa3f2d-dfa4-4b51-b3c3-aced331e7f01','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','','power_users','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL),('8003df3e-11e9-40ad-878d-6f3b0bc5a583','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_view-events}','view-events','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('858b841b-5b14-46b0-bbbb-330cccc5a9fe','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_manage-authorization}','manage-authorization','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('88cee3b1-a05d-4d1a-8ed4-7eb273e81d5b','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_manage-users}','manage-users','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('8973e0cd-6a4a-4a39-9466-ea53fbf92385','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','','admins','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL),('8b937a54-4e9c-4dd3-ab9a-e9fb8f014277','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_query-clients}','query-clients','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('8bf4f7c5-a978-440a-8430-eba9cb484a1a','6f8cc551-edc9-41ec-a489-a32729ef6a74','','${role_view-applications}','view-applications','f47dc79c-5538-4cdb-9f59-3396e016c2ce','6f8cc551-edc9-41ec-a489-a32729ef6a74',NULL),('8cce6fd2-e27d-4342-8873-8518f16d4e10','f47dc79c-5538-4cdb-9f59-3396e016c2ce','\0','${role_admin}','admin','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL,NULL),('8d745bc0-87b9-4b7d-b348-1188cf91353c','da4ead78-5240-4e21-89b7-62d5e810cba6','','${role_read-token}','read-token','f47dc79c-5538-4cdb-9f59-3396e016c2ce','da4ead78-5240-4e21-89b7-62d5e810cba6',NULL),('8f63bca5-7278-4bc7-8f8e-9b28e27d5326','6f8cc551-edc9-41ec-a489-a32729ef6a74','','${role_view-groups}','view-groups','f47dc79c-5538-4cdb-9f59-3396e016c2ce','6f8cc551-edc9-41ec-a489-a32729ef6a74',NULL),('a33921cc-df01-488a-8ff6-d22b16004aec','20f14d27-b1fe-493b-9c51-93721413391a','','${role_manage-account-links}','manage-account-links','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20f14d27-b1fe-493b-9c51-93721413391a',NULL),('a4d32d73-6c50-406e-ada8-dad789e06ff2','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_view-events}','view-events','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('a66072df-530e-400b-ac69-16db6213815a','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_query-groups}','query-groups','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('a7778bcc-7aa4-4382-82d7-6d3e6bb94ac4','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_manage-clients}','manage-clients','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('a978cd2b-d210-4d70-9fbf-9d5cfd9d9657','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_query-users}','query-users','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('aa0b251e-b1e6-486e-b12b-bef94d18f054','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_manage-clients}','manage-clients','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('abb77f0c-b6c5-4674-b026-1a5a123bc10a','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_view-identity-providers}','view-identity-providers','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('b0cf96e6-cdad-4ee1-9e01-5601feef5e1d','20f14d27-b1fe-493b-9c51-93721413391a','','${role_manage-account}','manage-account','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20f14d27-b1fe-493b-9c51-93721413391a',NULL),('b5ed1430-28d0-48c4-be04-604155dfb7ee','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_query-groups}','query-groups','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('b7a48db1-5f60-4bdf-86d2-065dadf80da0','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_manage-events}','manage-events','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('b8ff8164-ee48-4ae0-bf8d-4b2284c7daf3','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','Setup Gui and Oculus VR','configs','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL),('ba14e7e4-d8fd-407c-a0a9-faadaf7f6952','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_view-identity-providers}','view-identity-providers','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('bce2c989-05c3-4302-a63a-325014ff0713','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_view-realm}','view-realm','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('c1209f70-879d-4532-b2ac-96a8a3a5aaf4','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_view-realm}','view-realm','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('c22cb9fd-240b-4156-b53e-e92ff6663871','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_impersonation}','impersonation','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('c29213d5-b36e-4257-ab9a-3143f478025a','6f8cc551-edc9-41ec-a489-a32729ef6a74','','${role_manage-consent}','manage-consent','f47dc79c-5538-4cdb-9f59-3396e016c2ce','6f8cc551-edc9-41ec-a489-a32729ef6a74',NULL),('cb0b7b20-048a-49c9-b7ed-41c63ea06a5c','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_manage-realm}','manage-realm','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('cb8aa9e6-76ff-4445-8b0a-a20633870bdd','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_view-identity-providers}','view-identity-providers','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('cc91168d-dc7f-4093-9e91-f83d8f23053f','6f8cc551-edc9-41ec-a489-a32729ef6a74','','${role_manage-account}','manage-account','f47dc79c-5538-4cdb-9f59-3396e016c2ce','6f8cc551-edc9-41ec-a489-a32729ef6a74',NULL),('d03d25a7-44d3-43cd-911f-c3a028f4ad95','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_view-clients}','view-clients','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('d0e59db6-96fe-4b8f-8e75-ac7783ddbbe8','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','${role_uma_authorization}','uma_authorization','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL),('d3308360-e0d5-4d5d-8873-aed55b116668','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_manage-clients}','manage-clients','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('d46c3078-21c6-4ed1-a19e-4f53f6194328','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','${role_offline-access}','offline_access','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL),('d930309a-5693-42ff-8cf7-c6286d49c343','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_manage-identity-providers}','manage-identity-providers','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('e3360c73-4dc6-44b1-8bac-437596a1ea19','6f8cc551-edc9-41ec-a489-a32729ef6a74','','${role_delete-account}','delete-account','f47dc79c-5538-4cdb-9f59-3396e016c2ce','6f8cc551-edc9-41ec-a489-a32729ef6a74',NULL),('e8d4959d-32b4-4ded-bc81-365f3e968b0a','20f14d27-b1fe-493b-9c51-93721413391a','','${role_delete-account}','delete-account','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','20f14d27-b1fe-493b-9c51-93721413391a',NULL),('eaf4d06d-2b40-4247-b735-67efde49a1a7','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_view-events}','view-events','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('f4a04bc5-4d65-43a5-a945-b29380634f6f','3f29df46-707e-4fb1-a952-ae9a0fd553e6','','${role_view-authorization}','view-authorization','f47dc79c-5538-4cdb-9f59-3396e016c2ce','3f29df46-707e-4fb1-a952-ae9a0fd553e6',NULL),('f82f39d6-a853-4ad5-ba14-88ef8597c93b','f47dc79c-5538-4cdb-9f59-3396e016c2ce','\0','${role_create-realm}','create-realm','f47dc79c-5538-4cdb-9f59-3396e016c2ce',NULL,NULL),('f973f9dd-7af0-4b52-847f-f12c9a7532f1','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_query-users}','query-users','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('fad7e45a-7e19-4f98-850d-9800d8eb16a1','7deb9688-76ea-4e3b-b776-b723168f47f4','','${role_manage-identity-providers}','manage-identity-providers','f47dc79c-5538-4cdb-9f59-3396e016c2ce','7deb9688-76ea-4e3b-b776-b723168f47f4',NULL),('fcddb7eb-3c56-434a-a3dd-2a1f9401f869','da7c9c79-f949-49d9-867c-2516bd03b14a','','${role_view-clients}','view-clients','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','da7c9c79-f949-49d9-867c-2516bd03b14a',NULL),('fd49155a-e786-465b-8ce1-a7ead471850e','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','','backups','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',NULL,NULL);
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MIGRATION_MODEL`
--

DROP TABLE IF EXISTS `MIGRATION_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MIGRATION_MODEL` (
  `ID` varchar(36) NOT NULL,
  `VERSION` varchar(36) DEFAULT NULL,
  `UPDATE_TIME` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `IDX_UPDATE_TIME` (`UPDATE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MIGRATION_MODEL`
--

LOCK TABLES `MIGRATION_MODEL` WRITE;
/*!40000 ALTER TABLE `MIGRATION_MODEL` DISABLE KEYS */;
INSERT INTO `MIGRATION_MODEL` VALUES ('iry5u','21.0.0',1677409609);
/*!40000 ALTER TABLE `MIGRATION_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_CLIENT_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OFFLINE_CLIENT_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `DATA` longtext DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) NOT NULL DEFAULT 'local',
  `EXTERNAL_CLIENT_ID` varchar(255) NOT NULL DEFAULT 'local',
  PRIMARY KEY (`USER_SESSION_ID`,`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`OFFLINE_FLAG`),
  KEY `IDX_US_SESS_ID_ON_CL_SESS` (`USER_SESSION_ID`),
  KEY `IDX_OFFLINE_CSS_PRELOAD` (`CLIENT_ID`,`OFFLINE_FLAG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_CLIENT_SESSION`
--

LOCK TABLES `OFFLINE_CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` DISABLE KEYS */;
INSERT INTO `OFFLINE_CLIENT_SESSION` VALUES ('06119e2c-4382-405f-8780-3f1e68d110d1','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678132651,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678132651\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"53dec7ad1bd41f3b5f13f657f227c122\"}}','local','local'),('0a2795a1-ad51-4853-b447-434bb4223e0c','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678213148,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678213148\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"65115a215ff0d7190d311aec30d19c6d\"}}','local','local'),('0a84c258-abca-4f79-87b0-5af20eb4ef48','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678742737,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678742737\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"f6631c3d29d5ffce1b53ae814536a325\"}}','local','local'),('0e63771b-f351-4696-9946-65de13bbe4b9','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678787928,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678787928\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"4e0a0e58d6925f20a44d3522a6754d8e\"}}','local','local'),('0f47e046-ac6b-41f1-bf51-33388a9e8028','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678128127,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"SSO_AUTH\":\"true\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678128095\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"b7875fd6c45eec8dabad499200cde0de\"}}','local','local'),('0f877bf3-17e3-45a3-b136-c4497e9f9372','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678117670,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678117670\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"ef191ca8775fddedeaedfa72e45d8ac9\"}}','local','local'),('12811cd2-d3c6-4a21-b3d1-39a7845bf32a','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678127027,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678127027\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"1d2db218b81e45585cd2067c31b9206b\"}}','local','local'),('15ee8ddb-e7b9-4eae-9fc2-c79b27938206','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678740424,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678740424\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"59c9c5f259559144335047dc98bad5ec\"}}','local','local'),('191a8e20-5a0f-4926-aa90-fc5b0f1609c2','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678118124,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678118124\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"a963588423357d46a3e6123370dff4f9\"}}','local','local'),('1f32c51a-dca3-42f5-859f-2330a5565727','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678740675,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678740675\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"a16e78cb577a00fde9492f8e1ad081c1\"}}','local','local'),('21690fb3-28cb-49f1-a523-29456632e8b9','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678741259,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678741259\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"dc888cd545821b3f4cd3dcb8a340fb4a\"}}','local','local'),('21eec545-23c4-4291-975e-80978410e540','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678198343,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678198343\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"514fd057d56a40172d5c321609066a65\"}}','local','local'),('23e15d24-ea92-416b-8243-4924b832edf7','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678654388,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678654388\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"ddd26d985fe879e3cacdde7330482f49\"}}','local','local'),('2c40c61c-b62e-437f-9dae-2e5bc988fc5d','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678107952,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678107952\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"453dcd32a8ccde5ba72d9639c0a69d08\"}}','local','local'),('3308c716-68c5-49b4-a3c0-b55b62904c63','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678742070,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678742070\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"11e50e557ce16f23ba0d405190b77034\"}}','local','local'),('40dc6a16-6983-4947-8987-845bf3b220b8','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678132847,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678132847\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"1d9d83a6dbc86fb697e1ae6620fe9cfd\"}}','local','local'),('45607994-2e74-4eb3-aab5-9e36d0f20deb','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678744878,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678744878\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"3fb1ad6ec99b81875e171b86a1e838e8\"}}','local','local'),('4ba7ab44-41e0-4cc4-b2f3-bdfe9fa93094','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678741353,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678741353\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"d8212ee33142ee0c9536352fa516a457\"}}','local','local'),('50af761a-7bad-4e7f-a2f4-c6696d73aeba','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678704797,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678704797\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"52ba14a3f603a76ff81fae73205bd593\"}}','local','local'),('565a5169-c93f-4230-bff9-7b3969b71cc6','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678739368,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678739368\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"960935f9d52cacb80799c7e27483426c\"}}','local','local'),('5dd901be-4b9c-48f6-bc2e-4e443e067b72','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678742031,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678742031\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"b479ef7a623f0115f145d1eb53bd7eae\"}}','local','local'),('5f58bb73-a250-4384-8ff2-0e5537cea95b','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678118463,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678118463\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"3cb40a8b92a295260a0a6106cf132290\"}}','local','local'),('6148bba0-4df8-41f0-a207-c5fc1807efdc','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678131142,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678131142\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"039664fcc64c16aa3b1b2dc716e807b9\"}}','local','local'),('670cd4e4-7708-4016-a16f-46e173039d9b','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678742760,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678742760\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"0e106bfab4c24b3dc39d71ea640c1595\"}}','local','local'),('6a4dd5ff-32e2-45d7-8bda-e73bad5296e0','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678107416,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678107416\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"9e6f0fedd03cb3c085f2a5d173c93aaa\"}}','local','local'),('6e1f8307-3055-4c66-8556-2e8894c7814b','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678128030,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"SSO_AUTH\":\"true\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678127963\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"55d7691af1a8da5ba00603f9d7a0b827\"}}','local','local'),('6e47c66d-a7ad-407f-816f-d34b5807ead2','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678118686,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678118686\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"e59259e75161e148eb2e68fb2c15c96b\"}}','local','local'),('729072da-1ac5-4aca-a576-dc31f81157f8','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678198998,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678198998\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"302890b65d4bb6369fd76c90c8dddd7e\"}}','local','local'),('75d78054-379b-4a48-8113-8309f3fb33f5','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678743645,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678743645\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"225e24cbce1b80d24769bd59c5611c38\"}}','local','local'),('7b643cae-04dd-495f-bf83-987857403581','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678143212,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678143212\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"a5a38909a9b07de73f84df7bedfe5042\"}}','local','local'),('7b7daf0d-e2cb-4905-ad95-e4e23f43660b','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678744906,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678744906\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"6ec317b9ccc782d7c1bffdccf4271efa\"}}','local','local'),('7c5e7ab5-98a9-4ae6-984b-5d46bb141997','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678143021,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678143021\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"00ee991c8e16992a53de41751d790a82\"}}','local','local'),('80af841f-6058-4f72-bdb1-f7dfffa88817','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678742406,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678742406\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"1c25d31fcba1a7c1ed1f11b3d0d87f54\"}}','local','local'),('8422bb20-15ff-409e-9f07-f947d7883fc4','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678745003,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678745003\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"9e9ad6604e286f1e85f70b7db4c0d04c\"}}','local','local'),('84a79e42-5a1d-48ed-a0a7-f29040a714dc','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678135037,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678135037\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"e929d388b449ab3bc56cc190bac1b08e\"}}','local','local'),('8578f9a5-bfbc-4328-9d24-6b61cba3a7d2','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678744248,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678744248\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"fe450e04493ecf755e515138a496628d\"}}','local','local'),('8bc9504a-b8c8-4815-afa3-364d8f68a45c','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678740455,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678740455\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"2ec7004ceb9efd57488dd6fd31c275e2\"}}','local','local'),('9205e5c0-4b70-45ff-b4de-a9709ef4184d','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678265445,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678265445\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"00c187d787be59795d563e77babeec90\"}}','local','local'),('942e3484-896e-42fd-9120-43d2b0496187','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678317019,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678317019\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"d1ba1e3c0d85b206f529f34e35257277\"}}','local','local'),('9fb35ed8-b9d0-453c-9ccb-31ebe257bcee','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678118319,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678118319\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"bfadb26dfe20b7a4848c06a7df6638ed\"}}','local','local'),('a0ac3e4e-40a2-4e13-862f-4cc899c437a6','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678127451,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678127451\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"84e5ccb03b68924b5dfbd1a5bb85b4c0\"}}','local','local'),('a13a0dcc-a18c-484f-b852-171955c1a1cb','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678116762,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678116762\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"c50b2f58ed36a850d6f86d96ba438601\"}}','local','local'),('ba1f52c8-248e-48c0-b925-9ea2b9d29344','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678117748,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678117748\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"6a149d8efde1239e0943fb58deaa6b1f\"}}','local','local'),('bd09e8d1-bae6-48c2-a189-f89e58a4d1dc','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678746319,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678746319\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"09a0fd84cd394119b3a8aabfca356bc2\"}}','local','local'),('ca4b5586-afaf-4470-8e41-604eab2830a3','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678739402,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678739402\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"34bb0170744d83d2ba667cb1e33aaddb\"}}','local','local'),('cc787482-a68c-47fc-9617-15b515b82bc5','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678745378,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678745378\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"8a3500e3c7e0c5880c64c170cb3c62f6\"}}','local','local'),('d28fafee-0d21-45dc-9cfa-31dc70dc803c','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678740606,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678740606\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"8b790b490a34f12b95d0e2b741c08d30\"}}','local','local'),('d8fd04c0-216b-45d2-8ef6-1b8e236085c7','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678743078,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678743078\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"ed47ae58a99d800903e60d587fb7c613\"}}','local','local'),('da3f1103-3868-4288-a521-32462f06b4c1','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678741308,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678741308\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"f7aff0f9193af3e66c2a96193735d440\"}}','local','local'),('dcfad482-a834-4762-a47a-3bcc4676d6d4','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678746250,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"SSO_AUTH\":\"true\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678746242\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"89c362d5a8ff416eec952066d42b4c45\"}}','local','local'),('ddd4cf74-fae0-466e-9d86-d1dcc1e4114f','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678745407,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678745407\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"6ae6069afea73bd0a7963a9663635556\"}}','local','local'),('e22bd51e-990a-4f56-808b-b33af25087c3','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678129073,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"SSO_AUTH\":\"true\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678128813\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"674fa34f22aa80a2fec33f5fcfe0188c\"}}','local','local'),('e2d90a69-0cdd-4774-a0d9-17ab912163da','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678181171,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678181171\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"42ae9560f701d4bae5ff0879141058e9\"}}','local','local'),('eba9090f-4abf-4e70-a444-ec2e9e9278d4','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678108542,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678108542\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"d5985a84d00a4a6a17c13e92a6065d89\"}}','local','local'),('f131e4f0-75e7-4da5-a4f0-dc2bf4ef35ce','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678787962,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678787962\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"2a3ccbafb0fa0b2e30a438b14acadee4\"}}','local','local'),('f388e79f-f9f9-42db-9db8-880f317e6966','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678180276,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678180276\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"https://scuola.vrscuola.it:8443/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"6e0e28628e1039ce0e2704aaafd5dabe\"}}','local','local'),('fa8f6034-1ca9-4ae3-bdec-a951347be894','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678741005,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678741005\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"aba444733e13c052ee231720b2eb8d19\"}}','local','local'),('fe29d4ea-54dd-4df3-8388-771db7164def','6f78fdcf-596a-49c4-94cf-2416a9e2050c','1',1678740825,'{\"authMethod\":\"openid-connect\",\"redirectUri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"notes\":{\"scope\":\"email profile openid offline_access roles\",\"iss\":\"https://keycloak.vrscuola.it/realms/scuola\",\"startedAt\":\"1678740825\",\"response_type\":\"code\",\"level-of-authentication\":\"-1\",\"redirect_uri\":\"http://localhost:8080/wordpress/wp-admin/admin-ajax.php?action=openid-connect-authorize\",\"state\":\"add678ed298d894a27b85c8d8521c5cf\"}}','local','local');
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_USER_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OFFLINE_USER_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `CREATED_ON` int(11) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `DATA` longtext DEFAULT NULL,
  `LAST_SESSION_REFRESH` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`USER_SESSION_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_CREATEDON` (`CREATED_ON`),
  KEY `IDX_OFFLINE_USS_PRELOAD` (`OFFLINE_FLAG`,`CREATED_ON`,`USER_SESSION_ID`),
  KEY `IDX_OFFLINE_USS_BY_USER` (`USER_ID`,`REALM_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_BY_USERSESS` (`REALM_ID`,`OFFLINE_FLAG`,`USER_SESSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_USER_SESSION`
--

LOCK TABLES `OFFLINE_USER_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` DISABLE KEYS */;
INSERT INTO `OFFLINE_USER_SESSION` VALUES ('06119e2c-4382-405f-8780-3f1e68d110d1','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678132651,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678132651\"},\"state\":\"LOGGED_IN\"}',1678132689),('0a2795a1-ad51-4853-b447-434bb4223e0c','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678213148,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678213148\"},\"state\":\"LOGGED_IN\"}',1678214055),('0a84c258-abca-4f79-87b0-5af20eb4ef48','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678742737,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678742737\"},\"state\":\"LOGGED_IN\"}',1678742737),('0e63771b-f351-4696-9946-65de13bbe4b9','7894cbc4-302f-4adf-a068-d96f796357f8','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678787928,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678787928\"},\"state\":\"LOGGED_IN\"}',1678787930),('0f47e046-ac6b-41f1-bf51-33388a9e8028','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678128095,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678128095\"},\"state\":\"LOGGED_IN\"}',1678128127),('0f877bf3-17e3-45a3-b136-c4497e9f9372','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678117670,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678117670\"},\"state\":\"LOGGED_IN\"}',1678117670),('12811cd2-d3c6-4a21-b3d1-39a7845bf32a','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678127027,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678127027\"},\"state\":\"LOGGED_IN\"}',1678127027),('15ee8ddb-e7b9-4eae-9fc2-c79b27938206','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678740424,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678740424\"},\"state\":\"LOGGED_IN\"}',1678740424),('191a8e20-5a0f-4926-aa90-fc5b0f1609c2','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678118124,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJGaXJlZm94LzExMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==\",\"AUTH_TIME\":\"1678118124\"},\"state\":\"LOGGED_IN\"}',1678118124),('1f32c51a-dca3-42f5-859f-2330a5565727','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678740675,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678740675\"},\"state\":\"LOGGED_IN\"}',1678740675),('21690fb3-28cb-49f1-a523-29456632e8b9','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678741259,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678741259\"},\"state\":\"LOGGED_IN\"}',1678741259),('21eec545-23c4-4291-975e-80978410e540','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678198343,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678198343\"},\"state\":\"LOGGED_IN\"}',1678198343),('23e15d24-ea92-416b-8243-4924b832edf7','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678654388,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6Ik1hYyBPUyBYIiwib3NWZXJzaW9uIjoiMTAuMTUuNyIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik1hYyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9\",\"AUTH_TIME\":\"1678654388\"},\"state\":\"LOGGED_IN\"}',1678654388),('2c40c61c-b62e-437f-9dae-2e5bc988fc5d','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678107952,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678107952\"},\"state\":\"LOGGED_IN\"}',1678107952),('3308c716-68c5-49b4-a3c0-b55b62904c63','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678742070,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678742070\"},\"state\":\"LOGGED_IN\"}',1678742070),('40dc6a16-6983-4947-8987-845bf3b220b8','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678132847,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678132847\"},\"state\":\"LOGGED_IN\"}',1678134069),('45607994-2e74-4eb3-aab5-9e36d0f20deb','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678744878,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678744878\"},\"state\":\"LOGGED_IN\"}',1678744878),('4ba7ab44-41e0-4cc4-b2f3-bdfe9fa93094','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678741353,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678741353\"},\"state\":\"LOGGED_IN\"}',1678741648),('50af761a-7bad-4e7f-a2f4-c6696d73aeba','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678704796,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678704797\"},\"state\":\"LOGGED_IN\"}',1678705405),('565a5169-c93f-4230-bff9-7b3969b71cc6','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678739368,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678739368\"},\"state\":\"LOGGED_IN\"}',1678739368),('5dd901be-4b9c-48f6-bc2e-4e443e067b72','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678742031,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678742031\"},\"state\":\"LOGGED_IN\"}',1678742031),('5f58bb73-a250-4384-8ff2-0e5537cea95b','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678118463,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJGaXJlZm94LzExMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==\",\"AUTH_TIME\":\"1678118463\"},\"state\":\"LOGGED_IN\"}',1678119548),('6148bba0-4df8-41f0-a207-c5fc1807efdc','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678131142,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678131142\"},\"state\":\"LOGGED_IN\"}',1678131729),('670cd4e4-7708-4016-a16f-46e173039d9b','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678742760,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678742760\"},\"state\":\"LOGGED_IN\"}',1678743028),('6a4dd5ff-32e2-45d7-8bda-e73bad5296e0','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678107416,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678107416\"},\"state\":\"LOGGED_IN\"}',1678107787),('6e1f8307-3055-4c66-8556-2e8894c7814b','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678127963,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678127963\"},\"state\":\"LOGGED_IN\"}',1678128030),('6e47c66d-a7ad-407f-816f-d34b5807ead2','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678118686,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678118686\"},\"state\":\"LOGGED_IN\"}',1678118686),('729072da-1ac5-4aca-a576-dc31f81157f8','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678198998,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJGaXJlZm94LzExMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==\",\"AUTH_TIME\":\"1678198998\"},\"state\":\"LOGGED_IN\"}',1678203134),('75d78054-379b-4a48-8113-8309f3fb33f5','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678743645,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678743645\"},\"state\":\"LOGGED_IN\"}',1678744168),('7b643cae-04dd-495f-bf83-987857403581','7894cbc4-302f-4adf-a068-d96f796357f8','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678143212,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678143212\"},\"state\":\"LOGGED_IN\"}',1678143910),('7b7daf0d-e2cb-4905-ad95-e4e23f43660b','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678744906,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678744906\"},\"state\":\"LOGGED_IN\"}',1678744906),('7c5e7ab5-98a9-4ae6-984b-5d46bb141997','7894cbc4-302f-4adf-a068-d96f796357f8','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678143021,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678143021\"},\"state\":\"LOGGED_IN\"}',1678143070),('80af841f-6058-4f72-bdb1-f7dfffa88817','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678742406,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678742406\"},\"state\":\"LOGGED_IN\"}',1678742668),('8422bb20-15ff-409e-9f07-f947d7883fc4','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678745003,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678745003\"},\"state\":\"LOGGED_IN\"}',1678745003),('84a79e42-5a1d-48ed-a0a7-f29040a714dc','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678135037,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJGaXJlZm94LzExMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==\",\"AUTH_TIME\":\"1678135037\"},\"state\":\"LOGGED_IN\"}',1678136529),('8578f9a5-bfbc-4328-9d24-6b61cba3a7d2','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678744248,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678744248\"},\"state\":\"LOGGED_IN\"}',1678744248),('8bc9504a-b8c8-4815-afa3-364d8f68a45c','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678740455,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678740455\"},\"state\":\"LOGGED_IN\"}',1678740455),('9205e5c0-4b70-45ff-b4de-a9709ef4184d','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678265445,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678265445\"},\"state\":\"LOGGED_IN\"}',1678265718),('942e3484-896e-42fd-9120-43d2b0496187','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678317019,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678317019\"},\"state\":\"LOGGED_IN\"}',1678318762),('9fb35ed8-b9d0-453c-9ccb-31ebe257bcee','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678118319,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJGaXJlZm94LzExMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==\",\"AUTH_TIME\":\"1678118319\"},\"state\":\"LOGGED_IN\"}',1678118319),('a0ac3e4e-40a2-4e13-862f-4cc899c437a6','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678127451,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678127451\"},\"state\":\"LOGGED_IN\"}',1678127451),('a13a0dcc-a18c-484f-b852-171955c1a1cb','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678116762,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678116762\"},\"state\":\"LOGGED_IN\"}',1678116762),('ba1f52c8-248e-48c0-b925-9ea2b9d29344','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678117748,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678117748\"},\"state\":\"LOGGED_IN\"}',1678117748),('bd09e8d1-bae6-48c2-a189-f89e58a4d1dc','7894cbc4-302f-4adf-a068-d96f796357f8','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678746319,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678746319\"},\"state\":\"LOGGED_IN\"}',1678746319),('ca4b5586-afaf-4470-8e41-604eab2830a3','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678739402,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678739402\"},\"state\":\"LOGGED_IN\"}',1678740328),('cc787482-a68c-47fc-9617-15b515b82bc5','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678745378,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678745378\"},\"state\":\"LOGGED_IN\"}',1678745378),('d28fafee-0d21-45dc-9cfa-31dc70dc803c','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678740606,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678740606\"},\"state\":\"LOGGED_IN\"}',1678740606),('d8fd04c0-216b-45d2-8ef6-1b8e236085c7','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678743078,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678743078\"},\"state\":\"LOGGED_IN\"}',1678743328),('da3f1103-3868-4288-a521-32462f06b4c1','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678741308,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678741308\"},\"state\":\"LOGGED_IN\"}',1678741308),('dcfad482-a834-4762-a47a-3bcc4676d6d4','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678746242,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678746242\"},\"state\":\"LOGGED_IN\"}',1678746268),('ddd4cf74-fae0-466e-9d86-d1dcc1e4114f','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678745407,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678745407\"},\"state\":\"LOGGED_IN\"}',1678745407),('e22bd51e-990a-4f56-808b-b33af25087c3','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678128813,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678128813\"},\"state\":\"LOGGED_IN\"}',1678129029),('e2d90a69-0cdd-4774-a0d9-17ab912163da','7894cbc4-302f-4adf-a068-d96f796357f8','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678181171,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678181171\"},\"state\":\"LOGGED_IN\"}',1678182852),('eba9090f-4abf-4e70-a444-ec2e9e9278d4','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678108542,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678108542\"},\"state\":\"LOGGED_IN\"}',1678108542),('f131e4f0-75e7-4da5-a4f0-dc2bf4ef35ce','7894cbc4-302f-4adf-a068-d96f796357f8','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678787961,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678787962\"},\"state\":\"LOGGED_IN\"}',1678787961),('f388e79f-f9f9-42db-9db8-880f317e6966','7894cbc4-302f-4adf-a068-d96f796357f8','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678180276,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTEwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678180276\"},\"state\":\"LOGGED_IN\"}',1678180276),('fa8f6034-1ca9-4ae3-bdec-a951347be894','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678741005,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678741005\"},\"state\":\"LOGGED_IN\"}',1678741168),('fe29d4ea-54dd-4df3-8388-771db7164def','b329274b-a238-4600-9662-257cc6d50f0f','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',1678740825,'1','{\"ipAddress\":\"192.168.178.101\",\"authMethod\":\"openid-connect\",\"rememberMe\":false,\"started\":0,\"notes\":{\"KC_DEVICE_NOTE\":\"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE3OC4xMDEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTExLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=\",\"AUTH_TIME\":\"1678740825\"},\"state\":\"LOGGED_IN\"}',1678740825);
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `POLICY_CONFIG`
--

DROP TABLE IF EXISTS `POLICY_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `POLICY_CONFIG` (
  `POLICY_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  PRIMARY KEY (`POLICY_ID`,`NAME`),
  CONSTRAINT `FKDC34197CF864C4E43` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `POLICY_CONFIG`
--

LOCK TABLES `POLICY_CONFIG` WRITE;
/*!40000 ALTER TABLE `POLICY_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `POLICY_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROTOCOL_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `PROTOCOL` varchar(255) NOT NULL,
  `PROTOCOL_MAPPER_NAME` varchar(255) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `CLIENT_SCOPE_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_PROTOCOL_MAPPER_CLIENT` (`CLIENT_ID`),
  KEY `IDX_CLSCOPE_PROTMAP` (`CLIENT_SCOPE_ID`),
  CONSTRAINT `FK_CLI_SCOPE_MAPPER` FOREIGN KEY (`CLIENT_SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`),
  CONSTRAINT `FK_PCM_REALM` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER`
--

LOCK TABLES `PROTOCOL_MAPPER` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER` VALUES ('007e53e0-e95c-4952-82d9-c5bd84b7891d','given name','openid-connect','oidc-usermodel-property-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('03e015a1-6705-4bce-870a-28da2c2fcea7','role list','saml','saml-role-list-mapper',NULL,'81183c49-5ece-45bb-af80-59594c9320eb'),('05574731-3cfc-4713-bd3e-f1ddc071a506','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('05e963de-66b1-41c6-98b5-f370acf75c07','username','openid-connect','oidc-usermodel-property-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('07d87e6f-eaea-4226-9e75-dabf278a4d64','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'12d0c4f6-a710-4a39-b9ca-232aed84e7ba'),('1084f2a5-812d-46ff-a42a-0688627d20a4','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'551d382e-5a57-404b-a29e-9582b44ffbf1'),('111eb0d0-284f-405f-b790-2497bc35b1d3','audience resolve','openid-connect','oidc-audience-resolve-mapper','715ea213-bdb4-4ebc-8e0a-355920ff63eb',NULL),('12766178-0a05-46be-92dd-3c929c137ddf','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'ea74111f-bba8-41ed-9a6e-b7335965204b'),('13f3dfb6-2acb-47c2-963f-ed27bf496b45','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('196eb14b-4ac6-4adc-afd7-9eaa927a3f6e','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','address','openid-connect','oidc-address-mapper',NULL,'3a86c79f-d616-4587-863b-a959f530767a'),('22f58cb1-8230-48d8-9d50-6f6e7b635c14','full name','openid-connect','oidc-full-name-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('24860199-0be6-403e-b1d3-9c71ffb04493','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('24e29037-3aff-41df-8df3-1978ec3c9003','given name','openid-connect','oidc-usermodel-property-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('25e1cabc-24a5-44e8-8cf6-c242fcacf76c','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'551d382e-5a57-404b-a29e-9582b44ffbf1'),('26dc22e8-a88c-49dc-b4fb-562ffb42f487','acr loa level','openid-connect','oidc-acr-mapper',NULL,'3074ee96-675f-4b63-a93a-6ed4f021518a'),('3053aa45-3bd0-4966-a2b4-c33a458caea4','locale','openid-connect','oidc-usermodel-attribute-mapper','8565077f-84ed-4a5d-a06b-be52a43d3779',NULL),('33bacbb1-7a64-4318-9681-02383d2963a2','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'35a9832a-809b-49da-9f1f-6691ba056241'),('348c50a8-6fa1-4828-b5dd-59391a36be1b','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'35a9832a-809b-49da-9f1f-6691ba056241'),('435404dc-b457-4996-b952-719b62654b1a','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'134afcf8-caf1-49c4-98da-90833e4da9a5'),('495d75df-8595-41e9-af06-a09d11f62b05','upn','openid-connect','oidc-usermodel-property-mapper',NULL,'12d0c4f6-a710-4a39-b9ca-232aed84e7ba'),('4ce05b99-4f85-48d6-a02f-91d6bef3bbf0','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('533b1961-4607-4c63-a4b4-4fb14b96c6a9','acr loa level','openid-connect','oidc-acr-mapper',NULL,'169c80ee-8fdc-429c-8d3d-fb13ed07641c'),('5ffe03f5-cabc-494c-b0b1-d72838516c82','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('61295c57-cc0d-415b-8218-880b73c5d19f','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('6e727bdb-9ac2-42d0-8a01-214439adbd75','email','openid-connect','oidc-usermodel-property-mapper',NULL,'8d55860b-62f0-48ee-9fe9-6aa26cf3d26c'),('72f2d9b8-c3f0-4177-8af2-c40f912ccfc5','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('7879d103-8e80-4fc3-bbdc-44718f97b6f5','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('7a472b55-e68c-4077-9bd4-d0e7e2907467','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'134afcf8-caf1-49c4-98da-90833e4da9a5'),('80de36ae-58f8-4fa7-9a0c-07f0a4976a34','email','openid-connect','oidc-usermodel-property-mapper',NULL,'9c1cd945-a70a-45a8-9464-b9040e030b6b'),('85426e55-d56f-4a3e-9b1c-b58d3bea8b9f','upn','openid-connect','oidc-usermodel-property-mapper',NULL,'ea74111f-bba8-41ed-9a6e-b7335965204b'),('883b4dac-5c8f-4c3d-9040-30be09abccf3','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('8a0d8f11-83ea-40ed-9b94-c4759c6c0896','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('8da18287-81f9-4ffa-8cc6-6899f8d1c2db','family name','openid-connect','oidc-usermodel-property-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('94dfcca4-cb2d-4830-a334-d1ea58cfcaf6','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('97eff8d8-9c3d-4ea1-ab87-556229812ed6','audience resolve','openid-connect','oidc-audience-resolve-mapper','4093f22a-5a4d-4c5f-bcaf-28647c3676c8',NULL),('9acaddbd-d234-4097-90ef-5ebbc738a303','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('9d34b3d1-ad17-480a-a8db-9f8307abba10','family name','openid-connect','oidc-usermodel-property-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('a4c17ec6-80dc-4d1b-8fbb-faeec95796e5','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('af0db596-c636-4f4f-9dd8-0da7f9b54740','username','openid-connect','oidc-usermodel-property-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('b48bf3de-195b-43c2-aab2-e41664156fe1','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'134afcf8-caf1-49c4-98da-90833e4da9a5'),('c7e6f80f-7d74-4fda-b07c-ad59952b1882','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('c8bdb938-46ec-41a3-a275-0a9d3fd8c91f','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('cef551ac-6e6d-4306-b4e4-62354e42d350','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('d8d6869c-b634-44c4-9d32-b6b7789a0214','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'6b03a12f-2a22-4dcd-9abf-466a4e24aa40'),('e0744f6b-13f0-4d47-a6a8-1440020db582','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'9c1cd945-a70a-45a8-9464-b9040e030b6b'),('e101a14e-56b8-4579-a2e7-dfa11c2fd0ab','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'6b03a12f-2a22-4dcd-9abf-466a4e24aa40'),('e17d3fed-bf67-46bb-9410-7acb48262c7f','locale','openid-connect','oidc-usermodel-attribute-mapper','69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad',NULL),('e3b60725-ec67-46e6-b50f-822333823b0b','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('ea48233c-1490-45b5-bc3f-c34cf508ad51','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'c71449e0-78ed-4282-84c6-15ad23c781dc'),('eb69931c-0c3f-4bf4-bef6-743b02be3c99','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'81d6d87e-493d-442c-8291-f47569b51ab1'),('ee814e66-93f2-4eac-8968-315eb4471934','role list','saml','saml-role-list-mapper',NULL,'cd1cdc3a-632c-48e4-b50e-36c69e528969'),('f22040b3-7924-4579-a809-5b72dd9acb5d','full name','openid-connect','oidc-full-name-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('f70ca270-52bd-4c34-839e-5a4155877905','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'be51b110-5374-460d-9564-cf852d6ffedd'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','address','openid-connect','oidc-address-mapper',NULL,'b5b92343-a341-4659-a627-3cd5a944b245'),('fa6e154e-6fdb-431a-b0e8-ed9e1b56bdcb','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'6b03a12f-2a22-4dcd-9abf-466a4e24aa40'),('faa03abd-9e93-4c74-a27f-501bbf0c9532','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'dafac659-546c-4633-898e-455da5e38483'),('ff9a0378-1245-4e7d-98f4-d3adc10eb047','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'8d55860b-62f0-48ee-9fe9-6aa26cf3d26c');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROTOCOL_MAPPER_CONFIG` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`PROTOCOL_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_PMCONFIG` FOREIGN KEY (`PROTOCOL_MAPPER_ID`) REFERENCES `PROTOCOL_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER_CONFIG`
--

LOCK TABLES `PROTOCOL_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER_CONFIG` VALUES ('007e53e0-e95c-4952-82d9-c5bd84b7891d','true','access.token.claim'),('007e53e0-e95c-4952-82d9-c5bd84b7891d','given_name','claim.name'),('007e53e0-e95c-4952-82d9-c5bd84b7891d','true','id.token.claim'),('007e53e0-e95c-4952-82d9-c5bd84b7891d','String','jsonType.label'),('007e53e0-e95c-4952-82d9-c5bd84b7891d','firstName','user.attribute'),('007e53e0-e95c-4952-82d9-c5bd84b7891d','true','userinfo.token.claim'),('03e015a1-6705-4bce-870a-28da2c2fcea7','Role','attribute.name'),('03e015a1-6705-4bce-870a-28da2c2fcea7','Basic','attribute.nameformat'),('03e015a1-6705-4bce-870a-28da2c2fcea7','false','single'),('05574731-3cfc-4713-bd3e-f1ddc071a506','true','access.token.claim'),('05574731-3cfc-4713-bd3e-f1ddc071a506','locale','claim.name'),('05574731-3cfc-4713-bd3e-f1ddc071a506','true','id.token.claim'),('05574731-3cfc-4713-bd3e-f1ddc071a506','String','jsonType.label'),('05574731-3cfc-4713-bd3e-f1ddc071a506','locale','user.attribute'),('05574731-3cfc-4713-bd3e-f1ddc071a506','true','userinfo.token.claim'),('05e963de-66b1-41c6-98b5-f370acf75c07','true','access.token.claim'),('05e963de-66b1-41c6-98b5-f370acf75c07','preferred_username','claim.name'),('05e963de-66b1-41c6-98b5-f370acf75c07','true','id.token.claim'),('05e963de-66b1-41c6-98b5-f370acf75c07','String','jsonType.label'),('05e963de-66b1-41c6-98b5-f370acf75c07','username','user.attribute'),('05e963de-66b1-41c6-98b5-f370acf75c07','true','userinfo.token.claim'),('07d87e6f-eaea-4226-9e75-dabf278a4d64','true','access.token.claim'),('07d87e6f-eaea-4226-9e75-dabf278a4d64','groups','claim.name'),('07d87e6f-eaea-4226-9e75-dabf278a4d64','true','id.token.claim'),('07d87e6f-eaea-4226-9e75-dabf278a4d64','String','jsonType.label'),('07d87e6f-eaea-4226-9e75-dabf278a4d64','true','multivalued'),('07d87e6f-eaea-4226-9e75-dabf278a4d64','foo','user.attribute'),('1084f2a5-812d-46ff-a42a-0688627d20a4','true','access.token.claim'),('1084f2a5-812d-46ff-a42a-0688627d20a4','phone_number_verified','claim.name'),('1084f2a5-812d-46ff-a42a-0688627d20a4','true','id.token.claim'),('1084f2a5-812d-46ff-a42a-0688627d20a4','boolean','jsonType.label'),('1084f2a5-812d-46ff-a42a-0688627d20a4','phoneNumberVerified','user.attribute'),('1084f2a5-812d-46ff-a42a-0688627d20a4','true','userinfo.token.claim'),('12766178-0a05-46be-92dd-3c929c137ddf','true','access.token.claim'),('12766178-0a05-46be-92dd-3c929c137ddf','groups','claim.name'),('12766178-0a05-46be-92dd-3c929c137ddf','true','id.token.claim'),('12766178-0a05-46be-92dd-3c929c137ddf','String','jsonType.label'),('12766178-0a05-46be-92dd-3c929c137ddf','true','multivalued'),('12766178-0a05-46be-92dd-3c929c137ddf','foo','user.attribute'),('13f3dfb6-2acb-47c2-963f-ed27bf496b45','true','access.token.claim'),('13f3dfb6-2acb-47c2-963f-ed27bf496b45','picture','claim.name'),('13f3dfb6-2acb-47c2-963f-ed27bf496b45','true','id.token.claim'),('13f3dfb6-2acb-47c2-963f-ed27bf496b45','String','jsonType.label'),('13f3dfb6-2acb-47c2-963f-ed27bf496b45','picture','user.attribute'),('13f3dfb6-2acb-47c2-963f-ed27bf496b45','true','userinfo.token.claim'),('196eb14b-4ac6-4adc-afd7-9eaa927a3f6e','true','access.token.claim'),('196eb14b-4ac6-4adc-afd7-9eaa927a3f6e','birthdate','claim.name'),('196eb14b-4ac6-4adc-afd7-9eaa927a3f6e','true','id.token.claim'),('196eb14b-4ac6-4adc-afd7-9eaa927a3f6e','String','jsonType.label'),('196eb14b-4ac6-4adc-afd7-9eaa927a3f6e','birthdate','user.attribute'),('196eb14b-4ac6-4adc-afd7-9eaa927a3f6e','true','userinfo.token.claim'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','true','access.token.claim'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','true','id.token.claim'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','country','user.attribute.country'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','formatted','user.attribute.formatted'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','locality','user.attribute.locality'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','postal_code','user.attribute.postal_code'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','region','user.attribute.region'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','street','user.attribute.street'),('208a8a80-7433-4517-8e80-cae5f28ea1ab','true','userinfo.token.claim'),('22f58cb1-8230-48d8-9d50-6f6e7b635c14','true','access.token.claim'),('22f58cb1-8230-48d8-9d50-6f6e7b635c14','true','id.token.claim'),('22f58cb1-8230-48d8-9d50-6f6e7b635c14','true','userinfo.token.claim'),('24860199-0be6-403e-b1d3-9c71ffb04493','true','access.token.claim'),('24860199-0be6-403e-b1d3-9c71ffb04493','updated_at','claim.name'),('24860199-0be6-403e-b1d3-9c71ffb04493','true','id.token.claim'),('24860199-0be6-403e-b1d3-9c71ffb04493','long','jsonType.label'),('24860199-0be6-403e-b1d3-9c71ffb04493','updatedAt','user.attribute'),('24860199-0be6-403e-b1d3-9c71ffb04493','true','userinfo.token.claim'),('24e29037-3aff-41df-8df3-1978ec3c9003','true','access.token.claim'),('24e29037-3aff-41df-8df3-1978ec3c9003','given_name','claim.name'),('24e29037-3aff-41df-8df3-1978ec3c9003','true','id.token.claim'),('24e29037-3aff-41df-8df3-1978ec3c9003','String','jsonType.label'),('24e29037-3aff-41df-8df3-1978ec3c9003','firstName','user.attribute'),('24e29037-3aff-41df-8df3-1978ec3c9003','true','userinfo.token.claim'),('25e1cabc-24a5-44e8-8cf6-c242fcacf76c','true','access.token.claim'),('25e1cabc-24a5-44e8-8cf6-c242fcacf76c','phone_number','claim.name'),('25e1cabc-24a5-44e8-8cf6-c242fcacf76c','true','id.token.claim'),('25e1cabc-24a5-44e8-8cf6-c242fcacf76c','String','jsonType.label'),('25e1cabc-24a5-44e8-8cf6-c242fcacf76c','phoneNumber','user.attribute'),('25e1cabc-24a5-44e8-8cf6-c242fcacf76c','true','userinfo.token.claim'),('26dc22e8-a88c-49dc-b4fb-562ffb42f487','true','access.token.claim'),('26dc22e8-a88c-49dc-b4fb-562ffb42f487','true','id.token.claim'),('3053aa45-3bd0-4966-a2b4-c33a458caea4','true','access.token.claim'),('3053aa45-3bd0-4966-a2b4-c33a458caea4','locale','claim.name'),('3053aa45-3bd0-4966-a2b4-c33a458caea4','true','id.token.claim'),('3053aa45-3bd0-4966-a2b4-c33a458caea4','String','jsonType.label'),('3053aa45-3bd0-4966-a2b4-c33a458caea4','locale','user.attribute'),('3053aa45-3bd0-4966-a2b4-c33a458caea4','true','userinfo.token.claim'),('33bacbb1-7a64-4318-9681-02383d2963a2','true','access.token.claim'),('33bacbb1-7a64-4318-9681-02383d2963a2','phone_number','claim.name'),('33bacbb1-7a64-4318-9681-02383d2963a2','true','id.token.claim'),('33bacbb1-7a64-4318-9681-02383d2963a2','String','jsonType.label'),('33bacbb1-7a64-4318-9681-02383d2963a2','phoneNumber','user.attribute'),('33bacbb1-7a64-4318-9681-02383d2963a2','true','userinfo.token.claim'),('348c50a8-6fa1-4828-b5dd-59391a36be1b','true','access.token.claim'),('348c50a8-6fa1-4828-b5dd-59391a36be1b','phone_number_verified','claim.name'),('348c50a8-6fa1-4828-b5dd-59391a36be1b','true','id.token.claim'),('348c50a8-6fa1-4828-b5dd-59391a36be1b','boolean','jsonType.label'),('348c50a8-6fa1-4828-b5dd-59391a36be1b','phoneNumberVerified','user.attribute'),('348c50a8-6fa1-4828-b5dd-59391a36be1b','true','userinfo.token.claim'),('435404dc-b457-4996-b952-719b62654b1a','true','access.token.claim'),('435404dc-b457-4996-b952-719b62654b1a','realm_access.roles','claim.name'),('435404dc-b457-4996-b952-719b62654b1a','String','jsonType.label'),('435404dc-b457-4996-b952-719b62654b1a','true','multivalued'),('435404dc-b457-4996-b952-719b62654b1a','foo','user.attribute'),('495d75df-8595-41e9-af06-a09d11f62b05','true','access.token.claim'),('495d75df-8595-41e9-af06-a09d11f62b05','upn','claim.name'),('495d75df-8595-41e9-af06-a09d11f62b05','true','id.token.claim'),('495d75df-8595-41e9-af06-a09d11f62b05','String','jsonType.label'),('495d75df-8595-41e9-af06-a09d11f62b05','username','user.attribute'),('495d75df-8595-41e9-af06-a09d11f62b05','true','userinfo.token.claim'),('4ce05b99-4f85-48d6-a02f-91d6bef3bbf0','true','access.token.claim'),('4ce05b99-4f85-48d6-a02f-91d6bef3bbf0','birthdate','claim.name'),('4ce05b99-4f85-48d6-a02f-91d6bef3bbf0','true','id.token.claim'),('4ce05b99-4f85-48d6-a02f-91d6bef3bbf0','String','jsonType.label'),('4ce05b99-4f85-48d6-a02f-91d6bef3bbf0','birthdate','user.attribute'),('4ce05b99-4f85-48d6-a02f-91d6bef3bbf0','true','userinfo.token.claim'),('533b1961-4607-4c63-a4b4-4fb14b96c6a9','true','access.token.claim'),('533b1961-4607-4c63-a4b4-4fb14b96c6a9','true','id.token.claim'),('5ffe03f5-cabc-494c-b0b1-d72838516c82','true','access.token.claim'),('5ffe03f5-cabc-494c-b0b1-d72838516c82','zoneinfo','claim.name'),('5ffe03f5-cabc-494c-b0b1-d72838516c82','true','id.token.claim'),('5ffe03f5-cabc-494c-b0b1-d72838516c82','String','jsonType.label'),('5ffe03f5-cabc-494c-b0b1-d72838516c82','zoneinfo','user.attribute'),('5ffe03f5-cabc-494c-b0b1-d72838516c82','true','userinfo.token.claim'),('61295c57-cc0d-415b-8218-880b73c5d19f','true','access.token.claim'),('61295c57-cc0d-415b-8218-880b73c5d19f','gender','claim.name'),('61295c57-cc0d-415b-8218-880b73c5d19f','true','id.token.claim'),('61295c57-cc0d-415b-8218-880b73c5d19f','String','jsonType.label'),('61295c57-cc0d-415b-8218-880b73c5d19f','gender','user.attribute'),('61295c57-cc0d-415b-8218-880b73c5d19f','true','userinfo.token.claim'),('6e727bdb-9ac2-42d0-8a01-214439adbd75','true','access.token.claim'),('6e727bdb-9ac2-42d0-8a01-214439adbd75','email','claim.name'),('6e727bdb-9ac2-42d0-8a01-214439adbd75','true','id.token.claim'),('6e727bdb-9ac2-42d0-8a01-214439adbd75','String','jsonType.label'),('6e727bdb-9ac2-42d0-8a01-214439adbd75','email','user.attribute'),('6e727bdb-9ac2-42d0-8a01-214439adbd75','true','userinfo.token.claim'),('72f2d9b8-c3f0-4177-8af2-c40f912ccfc5','true','access.token.claim'),('72f2d9b8-c3f0-4177-8af2-c40f912ccfc5','updated_at','claim.name'),('72f2d9b8-c3f0-4177-8af2-c40f912ccfc5','true','id.token.claim'),('72f2d9b8-c3f0-4177-8af2-c40f912ccfc5','long','jsonType.label'),('72f2d9b8-c3f0-4177-8af2-c40f912ccfc5','updatedAt','user.attribute'),('72f2d9b8-c3f0-4177-8af2-c40f912ccfc5','true','userinfo.token.claim'),('7879d103-8e80-4fc3-bbdc-44718f97b6f5','true','access.token.claim'),('7879d103-8e80-4fc3-bbdc-44718f97b6f5','zoneinfo','claim.name'),('7879d103-8e80-4fc3-bbdc-44718f97b6f5','true','id.token.claim'),('7879d103-8e80-4fc3-bbdc-44718f97b6f5','String','jsonType.label'),('7879d103-8e80-4fc3-bbdc-44718f97b6f5','zoneinfo','user.attribute'),('7879d103-8e80-4fc3-bbdc-44718f97b6f5','true','userinfo.token.claim'),('7a472b55-e68c-4077-9bd4-d0e7e2907467','true','access.token.claim'),('7a472b55-e68c-4077-9bd4-d0e7e2907467','resource_access.${client_id}.roles','claim.name'),('7a472b55-e68c-4077-9bd4-d0e7e2907467','String','jsonType.label'),('7a472b55-e68c-4077-9bd4-d0e7e2907467','true','multivalued'),('7a472b55-e68c-4077-9bd4-d0e7e2907467','foo','user.attribute'),('80de36ae-58f8-4fa7-9a0c-07f0a4976a34','true','access.token.claim'),('80de36ae-58f8-4fa7-9a0c-07f0a4976a34','email','claim.name'),('80de36ae-58f8-4fa7-9a0c-07f0a4976a34','true','id.token.claim'),('80de36ae-58f8-4fa7-9a0c-07f0a4976a34','String','jsonType.label'),('80de36ae-58f8-4fa7-9a0c-07f0a4976a34','email','user.attribute'),('80de36ae-58f8-4fa7-9a0c-07f0a4976a34','true','userinfo.token.claim'),('85426e55-d56f-4a3e-9b1c-b58d3bea8b9f','true','access.token.claim'),('85426e55-d56f-4a3e-9b1c-b58d3bea8b9f','upn','claim.name'),('85426e55-d56f-4a3e-9b1c-b58d3bea8b9f','true','id.token.claim'),('85426e55-d56f-4a3e-9b1c-b58d3bea8b9f','String','jsonType.label'),('85426e55-d56f-4a3e-9b1c-b58d3bea8b9f','username','user.attribute'),('85426e55-d56f-4a3e-9b1c-b58d3bea8b9f','true','userinfo.token.claim'),('883b4dac-5c8f-4c3d-9040-30be09abccf3','true','access.token.claim'),('883b4dac-5c8f-4c3d-9040-30be09abccf3','profile','claim.name'),('883b4dac-5c8f-4c3d-9040-30be09abccf3','true','id.token.claim'),('883b4dac-5c8f-4c3d-9040-30be09abccf3','String','jsonType.label'),('883b4dac-5c8f-4c3d-9040-30be09abccf3','profile','user.attribute'),('883b4dac-5c8f-4c3d-9040-30be09abccf3','true','userinfo.token.claim'),('8a0d8f11-83ea-40ed-9b94-c4759c6c0896','true','access.token.claim'),('8a0d8f11-83ea-40ed-9b94-c4759c6c0896','nickname','claim.name'),('8a0d8f11-83ea-40ed-9b94-c4759c6c0896','true','id.token.claim'),('8a0d8f11-83ea-40ed-9b94-c4759c6c0896','String','jsonType.label'),('8a0d8f11-83ea-40ed-9b94-c4759c6c0896','nickname','user.attribute'),('8a0d8f11-83ea-40ed-9b94-c4759c6c0896','true','userinfo.token.claim'),('8da18287-81f9-4ffa-8cc6-6899f8d1c2db','true','access.token.claim'),('8da18287-81f9-4ffa-8cc6-6899f8d1c2db','family_name','claim.name'),('8da18287-81f9-4ffa-8cc6-6899f8d1c2db','true','id.token.claim'),('8da18287-81f9-4ffa-8cc6-6899f8d1c2db','String','jsonType.label'),('8da18287-81f9-4ffa-8cc6-6899f8d1c2db','lastName','user.attribute'),('8da18287-81f9-4ffa-8cc6-6899f8d1c2db','true','userinfo.token.claim'),('94dfcca4-cb2d-4830-a334-d1ea58cfcaf6','true','access.token.claim'),('94dfcca4-cb2d-4830-a334-d1ea58cfcaf6','nickname','claim.name'),('94dfcca4-cb2d-4830-a334-d1ea58cfcaf6','true','id.token.claim'),('94dfcca4-cb2d-4830-a334-d1ea58cfcaf6','String','jsonType.label'),('94dfcca4-cb2d-4830-a334-d1ea58cfcaf6','nickname','user.attribute'),('94dfcca4-cb2d-4830-a334-d1ea58cfcaf6','true','userinfo.token.claim'),('9acaddbd-d234-4097-90ef-5ebbc738a303','true','access.token.claim'),('9acaddbd-d234-4097-90ef-5ebbc738a303','picture','claim.name'),('9acaddbd-d234-4097-90ef-5ebbc738a303','true','id.token.claim'),('9acaddbd-d234-4097-90ef-5ebbc738a303','String','jsonType.label'),('9acaddbd-d234-4097-90ef-5ebbc738a303','picture','user.attribute'),('9acaddbd-d234-4097-90ef-5ebbc738a303','true','userinfo.token.claim'),('9d34b3d1-ad17-480a-a8db-9f8307abba10','true','access.token.claim'),('9d34b3d1-ad17-480a-a8db-9f8307abba10','family_name','claim.name'),('9d34b3d1-ad17-480a-a8db-9f8307abba10','true','id.token.claim'),('9d34b3d1-ad17-480a-a8db-9f8307abba10','String','jsonType.label'),('9d34b3d1-ad17-480a-a8db-9f8307abba10','lastName','user.attribute'),('9d34b3d1-ad17-480a-a8db-9f8307abba10','true','userinfo.token.claim'),('a4c17ec6-80dc-4d1b-8fbb-faeec95796e5','true','access.token.claim'),('a4c17ec6-80dc-4d1b-8fbb-faeec95796e5','gender','claim.name'),('a4c17ec6-80dc-4d1b-8fbb-faeec95796e5','true','id.token.claim'),('a4c17ec6-80dc-4d1b-8fbb-faeec95796e5','String','jsonType.label'),('a4c17ec6-80dc-4d1b-8fbb-faeec95796e5','gender','user.attribute'),('a4c17ec6-80dc-4d1b-8fbb-faeec95796e5','true','userinfo.token.claim'),('af0db596-c636-4f4f-9dd8-0da7f9b54740','true','access.token.claim'),('af0db596-c636-4f4f-9dd8-0da7f9b54740','preferred_username','claim.name'),('af0db596-c636-4f4f-9dd8-0da7f9b54740','true','id.token.claim'),('af0db596-c636-4f4f-9dd8-0da7f9b54740','String','jsonType.label'),('af0db596-c636-4f4f-9dd8-0da7f9b54740','username','user.attribute'),('af0db596-c636-4f4f-9dd8-0da7f9b54740','true','userinfo.token.claim'),('c7e6f80f-7d74-4fda-b07c-ad59952b1882','true','access.token.claim'),('c7e6f80f-7d74-4fda-b07c-ad59952b1882','profile','claim.name'),('c7e6f80f-7d74-4fda-b07c-ad59952b1882','true','id.token.claim'),('c7e6f80f-7d74-4fda-b07c-ad59952b1882','String','jsonType.label'),('c7e6f80f-7d74-4fda-b07c-ad59952b1882','profile','user.attribute'),('c7e6f80f-7d74-4fda-b07c-ad59952b1882','true','userinfo.token.claim'),('c8bdb938-46ec-41a3-a275-0a9d3fd8c91f','true','access.token.claim'),('c8bdb938-46ec-41a3-a275-0a9d3fd8c91f','middle_name','claim.name'),('c8bdb938-46ec-41a3-a275-0a9d3fd8c91f','true','id.token.claim'),('c8bdb938-46ec-41a3-a275-0a9d3fd8c91f','String','jsonType.label'),('c8bdb938-46ec-41a3-a275-0a9d3fd8c91f','middleName','user.attribute'),('c8bdb938-46ec-41a3-a275-0a9d3fd8c91f','true','userinfo.token.claim'),('cef551ac-6e6d-4306-b4e4-62354e42d350','true','access.token.claim'),('cef551ac-6e6d-4306-b4e4-62354e42d350','locale','claim.name'),('cef551ac-6e6d-4306-b4e4-62354e42d350','true','id.token.claim'),('cef551ac-6e6d-4306-b4e4-62354e42d350','String','jsonType.label'),('cef551ac-6e6d-4306-b4e4-62354e42d350','locale','user.attribute'),('cef551ac-6e6d-4306-b4e4-62354e42d350','true','userinfo.token.claim'),('d8d6869c-b634-44c4-9d32-b6b7789a0214','true','access.token.claim'),('d8d6869c-b634-44c4-9d32-b6b7789a0214','resource_access.${client_id}.roles','claim.name'),('d8d6869c-b634-44c4-9d32-b6b7789a0214','String','jsonType.label'),('d8d6869c-b634-44c4-9d32-b6b7789a0214','true','multivalued'),('d8d6869c-b634-44c4-9d32-b6b7789a0214','foo','user.attribute'),('e0744f6b-13f0-4d47-a6a8-1440020db582','true','access.token.claim'),('e0744f6b-13f0-4d47-a6a8-1440020db582','email_verified','claim.name'),('e0744f6b-13f0-4d47-a6a8-1440020db582','true','id.token.claim'),('e0744f6b-13f0-4d47-a6a8-1440020db582','boolean','jsonType.label'),('e0744f6b-13f0-4d47-a6a8-1440020db582','emailVerified','user.attribute'),('e0744f6b-13f0-4d47-a6a8-1440020db582','true','userinfo.token.claim'),('e101a14e-56b8-4579-a2e7-dfa11c2fd0ab','true','access.token.claim'),('e101a14e-56b8-4579-a2e7-dfa11c2fd0ab','realm_access.roles','claim.name'),('e101a14e-56b8-4579-a2e7-dfa11c2fd0ab','String','jsonType.label'),('e101a14e-56b8-4579-a2e7-dfa11c2fd0ab','true','multivalued'),('e101a14e-56b8-4579-a2e7-dfa11c2fd0ab','foo','user.attribute'),('e17d3fed-bf67-46bb-9410-7acb48262c7f','true','access.token.claim'),('e17d3fed-bf67-46bb-9410-7acb48262c7f','locale','claim.name'),('e17d3fed-bf67-46bb-9410-7acb48262c7f','true','id.token.claim'),('e17d3fed-bf67-46bb-9410-7acb48262c7f','String','jsonType.label'),('e17d3fed-bf67-46bb-9410-7acb48262c7f','locale','user.attribute'),('e17d3fed-bf67-46bb-9410-7acb48262c7f','true','userinfo.token.claim'),('e3b60725-ec67-46e6-b50f-822333823b0b','true','access.token.claim'),('e3b60725-ec67-46e6-b50f-822333823b0b','website','claim.name'),('e3b60725-ec67-46e6-b50f-822333823b0b','true','id.token.claim'),('e3b60725-ec67-46e6-b50f-822333823b0b','String','jsonType.label'),('e3b60725-ec67-46e6-b50f-822333823b0b','website','user.attribute'),('e3b60725-ec67-46e6-b50f-822333823b0b','true','userinfo.token.claim'),('ee814e66-93f2-4eac-8968-315eb4471934','Role','attribute.name'),('ee814e66-93f2-4eac-8968-315eb4471934','Basic','attribute.nameformat'),('ee814e66-93f2-4eac-8968-315eb4471934','false','single'),('f22040b3-7924-4579-a809-5b72dd9acb5d','true','access.token.claim'),('f22040b3-7924-4579-a809-5b72dd9acb5d','true','id.token.claim'),('f22040b3-7924-4579-a809-5b72dd9acb5d','true','userinfo.token.claim'),('f70ca270-52bd-4c34-839e-5a4155877905','true','access.token.claim'),('f70ca270-52bd-4c34-839e-5a4155877905','website','claim.name'),('f70ca270-52bd-4c34-839e-5a4155877905','true','id.token.claim'),('f70ca270-52bd-4c34-839e-5a4155877905','String','jsonType.label'),('f70ca270-52bd-4c34-839e-5a4155877905','website','user.attribute'),('f70ca270-52bd-4c34-839e-5a4155877905','true','userinfo.token.claim'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','true','access.token.claim'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','true','id.token.claim'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','country','user.attribute.country'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','formatted','user.attribute.formatted'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','locality','user.attribute.locality'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','postal_code','user.attribute.postal_code'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','region','user.attribute.region'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','street','user.attribute.street'),('f74a01b6-f1a0-4f50-ab13-3c74e411cba1','true','userinfo.token.claim'),('faa03abd-9e93-4c74-a27f-501bbf0c9532','true','access.token.claim'),('faa03abd-9e93-4c74-a27f-501bbf0c9532','middle_name','claim.name'),('faa03abd-9e93-4c74-a27f-501bbf0c9532','true','id.token.claim'),('faa03abd-9e93-4c74-a27f-501bbf0c9532','String','jsonType.label'),('faa03abd-9e93-4c74-a27f-501bbf0c9532','middleName','user.attribute'),('faa03abd-9e93-4c74-a27f-501bbf0c9532','true','userinfo.token.claim'),('ff9a0378-1245-4e7d-98f4-d3adc10eb047','true','access.token.claim'),('ff9a0378-1245-4e7d-98f4-d3adc10eb047','email_verified','claim.name'),('ff9a0378-1245-4e7d-98f4-d3adc10eb047','true','id.token.claim'),('ff9a0378-1245-4e7d-98f4-d3adc10eb047','boolean','jsonType.label'),('ff9a0378-1245-4e7d-98f4-d3adc10eb047','emailVerified','user.attribute'),('ff9a0378-1245-4e7d-98f4-d3adc10eb047','true','userinfo.token.claim');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM`
--

DROP TABLE IF EXISTS `REALM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM` (
  `ID` varchar(36) NOT NULL,
  `ACCESS_CODE_LIFESPAN` int(11) DEFAULT NULL,
  `USER_ACTION_LIFESPAN` int(11) DEFAULT NULL,
  `ACCESS_TOKEN_LIFESPAN` int(11) DEFAULT NULL,
  `ACCOUNT_THEME` varchar(255) DEFAULT NULL,
  `ADMIN_THEME` varchar(255) DEFAULT NULL,
  `EMAIL_THEME` varchar(255) DEFAULT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EVENTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EVENTS_EXPIRATION` bigint(20) DEFAULT NULL,
  `LOGIN_THEME` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) DEFAULT NULL,
  `PASSWORD_POLICY` text DEFAULT NULL,
  `REGISTRATION_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `REMEMBER_ME` bit(1) NOT NULL DEFAULT b'0',
  `RESET_PASSWORD_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `SOCIAL` bit(1) NOT NULL DEFAULT b'0',
  `SSL_REQUIRED` varchar(255) DEFAULT NULL,
  `SSO_IDLE_TIMEOUT` int(11) DEFAULT NULL,
  `SSO_MAX_LIFESPAN` int(11) DEFAULT NULL,
  `UPDATE_PROFILE_ON_SOC_LOGIN` bit(1) NOT NULL DEFAULT b'0',
  `VERIFY_EMAIL` bit(1) NOT NULL DEFAULT b'0',
  `MASTER_ADMIN_CLIENT` varchar(36) DEFAULT NULL,
  `LOGIN_LIFESPAN` int(11) DEFAULT NULL,
  `INTERNATIONALIZATION_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DEFAULT_LOCALE` varchar(255) DEFAULT NULL,
  `REG_EMAIL_AS_USERNAME` bit(1) NOT NULL DEFAULT b'0',
  `ADMIN_EVENTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `ADMIN_EVENTS_DETAILS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EDIT_USERNAME_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `OTP_POLICY_COUNTER` int(11) DEFAULT 0,
  `OTP_POLICY_WINDOW` int(11) DEFAULT 1,
  `OTP_POLICY_PERIOD` int(11) DEFAULT 30,
  `OTP_POLICY_DIGITS` int(11) DEFAULT 6,
  `OTP_POLICY_ALG` varchar(36) DEFAULT 'HmacSHA1',
  `OTP_POLICY_TYPE` varchar(36) DEFAULT 'totp',
  `BROWSER_FLOW` varchar(36) DEFAULT NULL,
  `REGISTRATION_FLOW` varchar(36) DEFAULT NULL,
  `DIRECT_GRANT_FLOW` varchar(36) DEFAULT NULL,
  `RESET_CREDENTIALS_FLOW` varchar(36) DEFAULT NULL,
  `CLIENT_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `OFFLINE_SESSION_IDLE_TIMEOUT` int(11) DEFAULT 0,
  `REVOKE_REFRESH_TOKEN` bit(1) NOT NULL DEFAULT b'0',
  `ACCESS_TOKEN_LIFE_IMPLICIT` int(11) DEFAULT 0,
  `LOGIN_WITH_EMAIL_ALLOWED` bit(1) NOT NULL DEFAULT b'1',
  `DUPLICATE_EMAILS_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `DOCKER_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `REFRESH_TOKEN_MAX_REUSE` int(11) DEFAULT 0,
  `ALLOW_USER_MANAGED_ACCESS` bit(1) NOT NULL DEFAULT b'0',
  `SSO_MAX_LIFESPAN_REMEMBER_ME` int(11) NOT NULL,
  `SSO_IDLE_TIMEOUT_REMEMBER_ME` int(11) NOT NULL,
  `DEFAULT_ROLE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_ORVSDMLA56612EAEFIQ6WL5OI` (`NAME`),
  KEY `IDX_REALM_MASTER_ADM_CLI` (`MASTER_ADMIN_CLIENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM`
--

LOCK TABLES `REALM` WRITE;
/*!40000 ALTER TABLE `REALM` DISABLE KEYS */;
INSERT INTO `REALM` VALUES ('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',60,300,300,'keycloak.v2','keycloak.v2','keycloak','','',0,'keycloak','scuola',0,NULL,'\0','\0','\0','\0','EXTERNAL',1800,36000,'\0','','3f29df46-707e-4fb1-a952-ae9a0fd553e6',1800,'','it','\0','','\0','',0,1,30,6,'HmacSHA1','totp','4160e42a-af89-4e84-ab6e-babd4297a1e0','affbe6c6-5ef2-4588-8be5-f11b966b7c98','bb8d47a9-d323-49d3-acb0-7527caad3d94','28d758e8-67bb-4e03-aba4-bbf0511056d0','ddfd7846-b5e2-4732-b1ba-17792477413e',2592000,'\0',900,'\0','','93e96c94-2198-4369-9b91-e078ed822b47',0,'\0',0,0,'00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01'),('f47dc79c-5538-4cdb-9f59-3396e016c2ce',60,300,60,'keycloak.v2','keycloak.v2','keycloak','','\0',0,'keycloak','master',0,NULL,'\0','\0','\0','\0','EXTERNAL',1800,36000,'\0','\0','7deb9688-76ea-4e3b-b776-b723168f47f4',1800,'\0',NULL,'\0','\0','\0','\0',0,1,30,6,'HmacSHA1','totp','f127a896-83bc-4da2-892e-a30b7151129f','5925db26-de22-4c56-ac60-f487cba11839','d6772330-d8fa-4361-a604-b67090afefe2','c29950cd-bef4-4998-b581-23b9cfa4515c','c341a39b-d3f7-458e-b55e-b381cf58244e',2592000,'\0',900,'','\0','f9805f57-40d3-45e9-a2f5-148c45782c0e',0,'\0',0,0,'260e85aa-d84e-4369-bbf5-53fca4af577e');
/*!40000 ALTER TABLE `REALM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ATTRIBUTE`
--

DROP TABLE IF EXISTS `REALM_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`NAME`,`REALM_ID`),
  KEY `IDX_REALM_ATTR_REALM` (`REALM_ID`),
  CONSTRAINT `FK_8SHXD6L3E9ATQUKACXGPFFPTW` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ATTRIBUTE`
--

LOCK TABLES `REALM_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` DISABLE KEYS */;
INSERT INTO `REALM_ATTRIBUTE` VALUES ('acr.loa.map','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','{}'),('actionTokenGeneratedByAdminLifespan','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','43200'),('actionTokenGeneratedByAdminLifespan','f47dc79c-5538-4cdb-9f59-3396e016c2ce','43200'),('actionTokenGeneratedByUserLifespan','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','300'),('actionTokenGeneratedByUserLifespan','f47dc79c-5538-4cdb-9f59-3396e016c2ce','300'),('adminEventsExpiration','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',''),('bruteForceProtected','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','false'),('bruteForceProtected','f47dc79c-5538-4cdb-9f59-3396e016c2ce','false'),('cibaAuthRequestedUserHint','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','login_hint'),('cibaAuthRequestedUserHint','f47dc79c-5538-4cdb-9f59-3396e016c2ce','login_hint'),('cibaBackchannelTokenDeliveryMode','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','poll'),('cibaBackchannelTokenDeliveryMode','f47dc79c-5538-4cdb-9f59-3396e016c2ce','poll'),('cibaExpiresIn','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','120'),('cibaExpiresIn','f47dc79c-5538-4cdb-9f59-3396e016c2ce','120'),('cibaInterval','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','5'),('cibaInterval','f47dc79c-5538-4cdb-9f59-3396e016c2ce','5'),('client-policies.policies','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','{\"policies\":[]}'),('client-policies.policies','f47dc79c-5538-4cdb-9f59-3396e016c2ce','{\"policies\":[]}'),('client-policies.profiles','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','{\"profiles\":[]}'),('client-policies.profiles','f47dc79c-5538-4cdb-9f59-3396e016c2ce','{\"profiles\":[]}'),('clientOfflineSessionIdleTimeout','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','0'),('clientOfflineSessionIdleTimeout','f47dc79c-5538-4cdb-9f59-3396e016c2ce','0'),('clientOfflineSessionMaxLifespan','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','0'),('clientOfflineSessionMaxLifespan','f47dc79c-5538-4cdb-9f59-3396e016c2ce','0'),('clientSessionIdleTimeout','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','0'),('clientSessionIdleTimeout','f47dc79c-5538-4cdb-9f59-3396e016c2ce','0'),('clientSessionMaxLifespan','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','0'),('clientSessionMaxLifespan','f47dc79c-5538-4cdb-9f59-3396e016c2ce','0'),('defaultSignatureAlgorithm','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','RS256'),('defaultSignatureAlgorithm','f47dc79c-5538-4cdb-9f59-3396e016c2ce','RS256'),('displayName','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','MetaScuola'),('displayName','f47dc79c-5538-4cdb-9f59-3396e016c2ce','Keycloak'),('displayNameHtml','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',''),('displayNameHtml','f47dc79c-5538-4cdb-9f59-3396e016c2ce','<div class=\"kc-logo-text\"><span>Keycloak</span></div>'),('failureFactor','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','30'),('failureFactor','f47dc79c-5538-4cdb-9f59-3396e016c2ce','30'),('frontendUrl','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',''),('maxDeltaTimeSeconds','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','43200'),('maxDeltaTimeSeconds','f47dc79c-5538-4cdb-9f59-3396e016c2ce','43200'),('maxFailureWaitSeconds','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','900'),('maxFailureWaitSeconds','f47dc79c-5538-4cdb-9f59-3396e016c2ce','900'),('minimumQuickLoginWaitSeconds','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','60'),('minimumQuickLoginWaitSeconds','f47dc79c-5538-4cdb-9f59-3396e016c2ce','60'),('oauth2DeviceCodeLifespan','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','600'),('oauth2DeviceCodeLifespan','f47dc79c-5538-4cdb-9f59-3396e016c2ce','600'),('oauth2DevicePollingInterval','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','5'),('oauth2DevicePollingInterval','f47dc79c-5538-4cdb-9f59-3396e016c2ce','5'),('offlineSessionMaxLifespan','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','5184000'),('offlineSessionMaxLifespan','f47dc79c-5538-4cdb-9f59-3396e016c2ce','5184000'),('offlineSessionMaxLifespanEnabled','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','false'),('offlineSessionMaxLifespanEnabled','f47dc79c-5538-4cdb-9f59-3396e016c2ce','false'),('parRequestUriLifespan','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','60'),('parRequestUriLifespan','f47dc79c-5538-4cdb-9f59-3396e016c2ce','60'),('permanentLockout','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','false'),('permanentLockout','f47dc79c-5538-4cdb-9f59-3396e016c2ce','false'),('quickLoginCheckMilliSeconds','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','1000'),('quickLoginCheckMilliSeconds','f47dc79c-5538-4cdb-9f59-3396e016c2ce','1000'),('realmReusableOtpCode','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','false'),('realmReusableOtpCode','f47dc79c-5538-4cdb-9f59-3396e016c2ce','false'),('waitIncrementSeconds','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','60'),('waitIncrementSeconds','f47dc79c-5538-4cdb-9f59-3396e016c2ce','60'),('webAuthnPolicyAttestationConveyancePreference','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','not specified'),('webAuthnPolicyAttestationConveyancePreference','f47dc79c-5538-4cdb-9f59-3396e016c2ce','not specified'),('webAuthnPolicyAttestationConveyancePreferencePasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','not specified'),('webAuthnPolicyAttestationConveyancePreferencePasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','not specified'),('webAuthnPolicyAuthenticatorAttachment','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','not specified'),('webAuthnPolicyAuthenticatorAttachment','f47dc79c-5538-4cdb-9f59-3396e016c2ce','not specified'),('webAuthnPolicyAuthenticatorAttachmentPasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','not specified'),('webAuthnPolicyAuthenticatorAttachmentPasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','not specified'),('webAuthnPolicyAvoidSameAuthenticatorRegister','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','false'),('webAuthnPolicyAvoidSameAuthenticatorRegister','f47dc79c-5538-4cdb-9f59-3396e016c2ce','false'),('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','false'),('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','false'),('webAuthnPolicyCreateTimeout','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','0'),('webAuthnPolicyCreateTimeout','f47dc79c-5538-4cdb-9f59-3396e016c2ce','0'),('webAuthnPolicyCreateTimeoutPasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','0'),('webAuthnPolicyCreateTimeoutPasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','0'),('webAuthnPolicyRequireResidentKey','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','not specified'),('webAuthnPolicyRequireResidentKey','f47dc79c-5538-4cdb-9f59-3396e016c2ce','not specified'),('webAuthnPolicyRequireResidentKeyPasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','not specified'),('webAuthnPolicyRequireResidentKeyPasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','not specified'),('webAuthnPolicyRpEntityName','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','keycloak'),('webAuthnPolicyRpEntityName','f47dc79c-5538-4cdb-9f59-3396e016c2ce','keycloak'),('webAuthnPolicyRpEntityNamePasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','keycloak'),('webAuthnPolicyRpEntityNamePasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','keycloak'),('webAuthnPolicyRpId','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',''),('webAuthnPolicyRpId','f47dc79c-5538-4cdb-9f59-3396e016c2ce',''),('webAuthnPolicyRpIdPasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',''),('webAuthnPolicyRpIdPasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce',''),('webAuthnPolicySignatureAlgorithms','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','ES256'),('webAuthnPolicySignatureAlgorithms','f47dc79c-5538-4cdb-9f59-3396e016c2ce','ES256'),('webAuthnPolicySignatureAlgorithmsPasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','ES256'),('webAuthnPolicySignatureAlgorithmsPasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','ES256'),('webAuthnPolicyUserVerificationRequirement','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','not specified'),('webAuthnPolicyUserVerificationRequirement','f47dc79c-5538-4cdb-9f59-3396e016c2ce','not specified'),('webAuthnPolicyUserVerificationRequirementPasswordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','not specified'),('webAuthnPolicyUserVerificationRequirementPasswordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','not specified'),('_browser_header.contentSecurityPolicy','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),('_browser_header.contentSecurityPolicy','f47dc79c-5538-4cdb-9f59-3396e016c2ce','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),('_browser_header.contentSecurityPolicyReportOnly','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed',''),('_browser_header.contentSecurityPolicyReportOnly','f47dc79c-5538-4cdb-9f59-3396e016c2ce',''),('_browser_header.strictTransportSecurity','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','max-age=31536000; includeSubDomains'),('_browser_header.strictTransportSecurity','f47dc79c-5538-4cdb-9f59-3396e016c2ce','max-age=31536000; includeSubDomains'),('_browser_header.xContentTypeOptions','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','nosniff'),('_browser_header.xContentTypeOptions','f47dc79c-5538-4cdb-9f59-3396e016c2ce','nosniff'),('_browser_header.xFrameOptions','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','SAMEORIGIN'),('_browser_header.xFrameOptions','f47dc79c-5538-4cdb-9f59-3396e016c2ce','SAMEORIGIN'),('_browser_header.xRobotsTag','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','none'),('_browser_header.xRobotsTag','f47dc79c-5538-4cdb-9f59-3396e016c2ce','none'),('_browser_header.xXSSProtection','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','1; mode=block'),('_browser_header.xXSSProtection','f47dc79c-5538-4cdb-9f59-3396e016c2ce','1; mode=block');
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_DEFAULT_GROUPS`
--

DROP TABLE IF EXISTS `REALM_DEFAULT_GROUPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_DEFAULT_GROUPS` (
  `REALM_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`GROUP_ID`),
  UNIQUE KEY `CON_GROUP_ID_DEF_GROUPS` (`GROUP_ID`),
  KEY `IDX_REALM_DEF_GRP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_DEF_GROUPS_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_DEFAULT_GROUPS`
--

LOCK TABLES `REALM_DEFAULT_GROUPS` WRITE;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ENABLED_EVENT_TYPES`
--

DROP TABLE IF EXISTS `REALM_ENABLED_EVENT_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_ENABLED_EVENT_TYPES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_TYPES_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NWEDRF5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ENABLED_EVENT_TYPES`
--

LOCK TABLES `REALM_ENABLED_EVENT_TYPES` WRITE;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` DISABLE KEYS */;
INSERT INTO `REALM_ENABLED_EVENT_TYPES` VALUES ('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','AUTHREQID_TO_TOKEN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','AUTHREQID_TO_TOKEN_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_DELETE'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_DELETE_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_INITIATED_ACCOUNT_LINKING'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_INITIATED_ACCOUNT_LINKING_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_LOGIN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_LOGIN_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_REGISTER'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_REGISTER_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_UPDATE'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CLIENT_UPDATE_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CODE_TO_TOKEN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CODE_TO_TOKEN_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CUSTOM_REQUIRED_ACTION'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','CUSTOM_REQUIRED_ACTION_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','DELETE_ACCOUNT'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','DELETE_ACCOUNT_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','EXECUTE_ACTIONS'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','EXECUTE_ACTIONS_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','EXECUTE_ACTION_TOKEN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','EXECUTE_ACTION_TOKEN_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','FEDERATED_IDENTITY_LINK'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','FEDERATED_IDENTITY_LINK_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','GRANT_CONSENT'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','GRANT_CONSENT_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','IDENTITY_PROVIDER_FIRST_LOGIN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','IDENTITY_PROVIDER_FIRST_LOGIN_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','IDENTITY_PROVIDER_LINK_ACCOUNT'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','IDENTITY_PROVIDER_POST_LOGIN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','IDENTITY_PROVIDER_POST_LOGIN_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','IMPERSONATE'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','IMPERSONATE_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','LOGIN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','LOGIN_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','LOGOUT'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','LOGOUT_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OAUTH2_DEVICE_AUTH'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OAUTH2_DEVICE_AUTH_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OAUTH2_DEVICE_CODE_TO_TOKEN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OAUTH2_DEVICE_CODE_TO_TOKEN_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OAUTH2_DEVICE_VERIFY_USER_CODE'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','OAUTH2_DEVICE_VERIFY_USER_CODE_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','PERMISSION_TOKEN'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','REGISTER'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','REGISTER_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','REMOVE_FEDERATED_IDENTITY'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','REMOVE_FEDERATED_IDENTITY_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','REMOVE_TOTP'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','REMOVE_TOTP_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','RESET_PASSWORD'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','RESET_PASSWORD_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','RESTART_AUTHENTICATION'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','RESTART_AUTHENTICATION_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','REVOKE_GRANT'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','REVOKE_GRANT_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','SEND_IDENTITY_PROVIDER_LINK'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','SEND_IDENTITY_PROVIDER_LINK_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','SEND_RESET_PASSWORD'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','SEND_RESET_PASSWORD_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','SEND_VERIFY_EMAIL'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','SEND_VERIFY_EMAIL_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','TOKEN_EXCHANGE'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','TOKEN_EXCHANGE_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_CONSENT'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_CONSENT_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_EMAIL'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_EMAIL_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_PASSWORD'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_PASSWORD_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_PROFILE'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_PROFILE_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_TOTP'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','UPDATE_TOTP_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','VERIFY_EMAIL'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','VERIFY_EMAIL_ERROR'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','VERIFY_PROFILE'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','VERIFY_PROFILE_ERROR');
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_EVENTS_LISTENERS`
--

DROP TABLE IF EXISTS `REALM_EVENTS_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_EVENTS_LISTENERS` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_LIST_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NXEV9F5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_EVENTS_LISTENERS`
--

LOCK TABLES `REALM_EVENTS_LISTENERS` WRITE;
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` DISABLE KEYS */;
INSERT INTO `REALM_EVENTS_LISTENERS` VALUES ('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','jboss-logging'),('f47dc79c-5538-4cdb-9f59-3396e016c2ce','jboss-logging');
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_LOCALIZATIONS`
--

DROP TABLE IF EXISTS `REALM_LOCALIZATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_LOCALIZATIONS` (
  `REALM_ID` varchar(255) NOT NULL,
  `LOCALE` varchar(255) NOT NULL,
  `TEXTS` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`REALM_ID`,`LOCALE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_LOCALIZATIONS`
--

LOCK TABLES `REALM_LOCALIZATIONS` WRITE;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_REQUIRED_CREDENTIAL`
--

DROP TABLE IF EXISTS `REALM_REQUIRED_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_REQUIRED_CREDENTIAL` (
  `TYPE` varchar(255) NOT NULL,
  `FORM_LABEL` varchar(255) DEFAULT NULL,
  `INPUT` bit(1) NOT NULL DEFAULT b'0',
  `SECRET` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`TYPE`),
  CONSTRAINT `FK_5HG65LYBEVAVKQFKI3KPONH9V` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_REQUIRED_CREDENTIAL`
--

LOCK TABLES `REALM_REQUIRED_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` DISABLE KEYS */;
INSERT INTO `REALM_REQUIRED_CREDENTIAL` VALUES ('password','password','','','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed'),('password','password','','','f47dc79c-5538-4cdb-9f59-3396e016c2ce');
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SMTP_CONFIG`
--

DROP TABLE IF EXISTS `REALM_SMTP_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_SMTP_CONFIG` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`NAME`),
  CONSTRAINT `FK_70EJ8XDXGXD0B9HH6180IRR0O` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SMTP_CONFIG`
--

LOCK TABLES `REALM_SMTP_CONFIG` WRITE;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SUPPORTED_LOCALES`
--

DROP TABLE IF EXISTS `REALM_SUPPORTED_LOCALES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_SUPPORTED_LOCALES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_SUPP_LOCAL_REALM` (`REALM_ID`),
  CONSTRAINT `FK_SUPPORTED_LOCALES_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SUPPORTED_LOCALES`
--

LOCK TABLES `REALM_SUPPORTED_LOCALES` WRITE;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` DISABLE KEYS */;
INSERT INTO `REALM_SUPPORTED_LOCALES` VALUES ('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','en'),('af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','it');
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REDIRECT_URIS`
--

DROP TABLE IF EXISTS `REDIRECT_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REDIRECT_URIS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_REDIR_URI_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_1BURS8PB4OUJ97H5WUPPAHV9F` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REDIRECT_URIS`
--

LOCK TABLES `REDIRECT_URIS` WRITE;
/*!40000 ALTER TABLE `REDIRECT_URIS` DISABLE KEYS */;
INSERT INTO `REDIRECT_URIS` VALUES ('20f14d27-b1fe-493b-9c51-93721413391a','/realms/scuola/account/*'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','/realms/scuola/account/*'),('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','/admin/scuola/console/*'),('6f78fdcf-596a-49c4-94cf-2416a9e2050c','*'),('6f8cc551-edc9-41ec-a489-a32729ef6a74','/realms/master/account/*'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','/realms/master/account/*'),('8565077f-84ed-4a5d-a06b-be52a43d3779','/admin/master/console/*');
/*!40000 ALTER TABLE `REDIRECT_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_CONFIG`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REQUIRED_ACTION_CONFIG` (
  `REQUIRED_ACTION_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REQUIRED_ACTION_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_CONFIG`
--

LOCK TABLES `REQUIRED_ACTION_CONFIG` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_PROVIDER`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REQUIRED_ACTION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DEFAULT_ACTION` bit(1) NOT NULL DEFAULT b'0',
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_REQ_ACT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_REQ_ACT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_PROVIDER`
--

LOCK TABLES `REQUIRED_ACTION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` DISABLE KEYS */;
INSERT INTO `REQUIRED_ACTION_PROVIDER` VALUES ('014236f1-c5d6-40b9-b7a4-95dea60b2d1a','TERMS_AND_CONDITIONS','Terms and Conditions','f47dc79c-5538-4cdb-9f59-3396e016c2ce','\0','\0','TERMS_AND_CONDITIONS',20),('0c7b13ef-e431-4274-80a2-26ef1a3f1fa4','CONFIGURE_TOTP','Configure OTP','f47dc79c-5538-4cdb-9f59-3396e016c2ce','','\0','CONFIGURE_TOTP',10),('120620de-a981-4ee9-818b-73aa6e949d4e','VERIFY_EMAIL','Verify Email','f47dc79c-5538-4cdb-9f59-3396e016c2ce','','\0','VERIFY_EMAIL',50),('35e26b3e-0d7d-4511-b0df-3b1ce82dc377','update_user_locale','Update User Locale','f47dc79c-5538-4cdb-9f59-3396e016c2ce','','\0','update_user_locale',1000),('475befe5-8412-4037-a171-c6d738ecdafc','update_user_locale','Update User Locale','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','','\0','update_user_locale',1000),('4de3ae9e-08ce-4cc2-bd82-9688d1a30c3c','webauthn-register','Webauthn Register','f47dc79c-5538-4cdb-9f59-3396e016c2ce','','\0','webauthn-register',70),('536bda7a-f374-4464-831b-ca2332ac910e','delete_account','Delete Account','f47dc79c-5538-4cdb-9f59-3396e016c2ce','\0','\0','delete_account',60),('593ce59f-f693-4105-89d4-2bcaf582d198','UPDATE_PROFILE','Update Profile','f47dc79c-5538-4cdb-9f59-3396e016c2ce','','\0','UPDATE_PROFILE',40),('5a768f22-37a6-4247-b7b5-1713dbc35bf6','TERMS_AND_CONDITIONS','Terms and Conditions','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','\0','TERMS_AND_CONDITIONS',20),('63e26673-d55e-4773-adb5-779c6677e05d','CONFIGURE_TOTP','Configure OTP','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','\0','CONFIGURE_TOTP',10),('654b8cd7-2cd0-481f-aa30-c893f0ae27ea','VERIFY_EMAIL','Verify Email','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','\0','VERIFY_EMAIL',50),('66c954d2-e540-49bb-8642-da386318c3cf','webauthn-register-passwordless','Webauthn Register Passwordless','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','','\0','webauthn-register-passwordless',80),('745b03ba-20f7-4e65-9053-051ccfabf129','UPDATE_PROFILE','Update Profile','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','','\0','UPDATE_PROFILE',40),('7883dfbf-c061-4ad7-b400-058cc016dcdd','delete_account','Delete Account','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','\0','delete_account',60),('7b020cac-0101-42e6-8d2a-583e916f1fc4','UPDATE_PASSWORD','Update Password','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','\0','\0','UPDATE_PASSWORD',30),('95e4ee3e-860c-42a0-8a7f-5841326dda3b','UPDATE_PASSWORD','Update Password','f47dc79c-5538-4cdb-9f59-3396e016c2ce','','\0','UPDATE_PASSWORD',30),('e818caaf-2364-4e35-b0c5-09e4caf408f7','webauthn-register-passwordless','Webauthn Register Passwordless','f47dc79c-5538-4cdb-9f59-3396e016c2ce','','\0','webauthn-register-passwordless',80),('ec604d8a-32ff-42e8-b43c-7d6e0bacb2b6','webauthn-register','Webauthn Register','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','','\0','webauthn-register',70);
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `RESOURCE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_5HRM2VLF9QL5FU022KQEPOVBR` (`RESOURCE_ID`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU022KQEPOVBR` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_ATTRIBUTE`
--

LOCK TABLES `RESOURCE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_POLICY` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`POLICY_ID`),
  KEY `IDX_RES_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRPOS53XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPP213XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_POLICY`
--

LOCK TABLES `RESOURCE_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SCOPE` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`SCOPE_ID`),
  KEY `IDX_RES_SCOPE_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_FRSRPOS13XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPS213XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SCOPE`
--

LOCK TABLES `RESOURCE_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER` (
  `ID` varchar(36) NOT NULL,
  `ALLOW_RS_REMOTE_MGMT` bit(1) NOT NULL DEFAULT b'0',
  `POLICY_ENFORCE_MODE` varchar(15) NOT NULL,
  `DECISION_STRATEGY` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER`
--

LOCK TABLES `RESOURCE_SERVER` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_PERM_TICKET`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_PERM_TICKET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER_PERM_TICKET` (
  `ID` varchar(36) NOT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `REQUESTER` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint(20) NOT NULL,
  `GRANTED_TIMESTAMP` bigint(20) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5PMT` (`OWNER`,`REQUESTER`,`RESOURCE_SERVER_ID`,`RESOURCE_ID`,`SCOPE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG82SSPMT` (`RESOURCE_SERVER_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG83SSPMT` (`RESOURCE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG84SSPMT` (`SCOPE_ID`),
  KEY `FK_FRSRPO2128CX4WNKOG82SSRFY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSPMT` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG83SSPMT` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG84SSPMT` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`),
  CONSTRAINT `FK_FRSRPO2128CX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_PERM_TICKET`
--

LOCK TABLES `RESOURCE_SERVER_PERM_TICKET` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER_POLICY` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `TYPE` varchar(255) NOT NULL,
  `DECISION_STRATEGY` varchar(20) DEFAULT NULL,
  `LOGIC` varchar(20) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRPT700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SERV_POL_RES_SERV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRPO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_POLICY`
--

LOCK TABLES `RESOURCE_SERVER_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_RESOURCE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_RESOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER_RESOURCE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER_MANAGED_ACCESS` bit(1) NOT NULL DEFAULT b'0',
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5HA6` (`NAME`,`OWNER`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_RES_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_RESOURCE`
--

LOCK TABLES `RESOURCE_SERVER_RESOURCE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRST700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_SCOPE_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRSO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_SCOPE`
--

LOCK TABLES `RESOURCE_SERVER_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_URIS`
--

DROP TABLE IF EXISTS `RESOURCE_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_URIS` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`VALUE`),
  CONSTRAINT `FK_RESOURCE_SERVER_URIS` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_URIS`
--

LOCK TABLES `RESOURCE_URIS` WRITE;
/*!40000 ALTER TABLE `RESOURCE_URIS` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ROLE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `ROLE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ROLE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ROLE_ATTRIBUTE` (`ROLE_ID`),
  CONSTRAINT `FK_ROLE_ATTRIBUTE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ROLE_ATTRIBUTE`
--

LOCK TABLES `ROLE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_MAPPING`
--

DROP TABLE IF EXISTS `SCOPE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCOPE_MAPPING` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`ROLE_ID`),
  KEY `IDX_SCOPE_MAPPING_ROLE` (`ROLE_ID`),
  CONSTRAINT `FK_OUSE064PLMLR732LXJCN1Q5F1` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_MAPPING`
--

LOCK TABLES `SCOPE_MAPPING` WRITE;
/*!40000 ALTER TABLE `SCOPE_MAPPING` DISABLE KEYS */;
INSERT INTO `SCOPE_MAPPING` VALUES ('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','6368fc66-2cdc-4e5d-8f9b-88266a04b578'),('4093f22a-5a4d-4c5f-bcaf-28647c3676c8','b0cf96e6-cdad-4ee1-9e01-5601feef5e1d'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','8f63bca5-7278-4bc7-8f8e-9b28e27d5326'),('715ea213-bdb4-4ebc-8e0a-355920ff63eb','cc91168d-dc7f-4093-9e91-f83d8f23053f');
/*!40000 ALTER TABLE `SCOPE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_POLICY`
--

DROP TABLE IF EXISTS `SCOPE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCOPE_POLICY` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`POLICY_ID`),
  KEY `IDX_SCOPE_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRASP13XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPASS3XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_POLICY`
--

LOCK TABLES `SCOPE_POLICY` WRITE;
/*!40000 ALTER TABLE `SCOPE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `SCOPE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERNAME_LOGIN_FAILURE`
--

DROP TABLE IF EXISTS `USERNAME_LOGIN_FAILURE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERNAME_LOGIN_FAILURE` (
  `REALM_ID` varchar(36) NOT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FAILED_LOGIN_NOT_BEFORE` int(11) DEFAULT NULL,
  `LAST_FAILURE` bigint(20) DEFAULT NULL,
  `LAST_IP_FAILURE` varchar(255) DEFAULT NULL,
  `NUM_FAILURES` int(11) DEFAULT NULL,
  PRIMARY KEY (`REALM_ID`,`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERNAME_LOGIN_FAILURE`
--

LOCK TABLES `USERNAME_LOGIN_FAILURE` WRITE;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_ATTRIBUTE` (`USER_ID`),
  KEY `IDX_USER_ATTRIBUTE_NAME` (`NAME`,`VALUE`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU043KQEPOVBR` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ATTRIBUTE`
--

LOCK TABLES `USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `USER_ATTRIBUTE` DISABLE KEYS */;
INSERT INTO `USER_ATTRIBUTE` VALUES ('roles','admins','b329274b-a238-4600-9662-257cc6d50f0f','38c7dbb0-d8b6-4f97-a1a7-ae5f187d9888'),('locale','it','b329274b-a238-4600-9662-257cc6d50f0f','fce6904a-7db2-4c01-a0bc-def5cee835a5');
/*!40000 ALTER TABLE `USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT`
--

DROP TABLE IF EXISTS `USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint(20) DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_JKUWUVD56ONTGSUHOGM8UEWRT` (`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`USER_ID`),
  KEY `IDX_USER_CONSENT` (`USER_ID`),
  CONSTRAINT `FK_GRNTCSNT_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT`
--

LOCK TABLES `USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `USER_CONSENT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_CONSENT_CLIENT_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`),
  KEY `IDX_USCONSENT_CLSCOPE` (`USER_CONSENT_ID`),
  CONSTRAINT `FK_GRNTCSNT_CLSC_USC` FOREIGN KEY (`USER_CONSENT_ID`) REFERENCES `USER_CONSENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT_CLIENT_SCOPE`
--

LOCK TABLES `USER_CONSENT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ENTITY`
--

DROP TABLE IF EXISTS `USER_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `EMAIL_CONSTRAINT` varchar(255) DEFAULT NULL,
  `EMAIL_VERIFIED` bit(1) NOT NULL DEFAULT b'0',
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `FEDERATION_LINK` varchar(255) DEFAULT NULL,
  `FIRST_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `LAST_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint(20) DEFAULT NULL,
  `SERVICE_ACCOUNT_CLIENT_LINK` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_DYKN684SL8UP1CRFEI6ECKHD7` (`REALM_ID`,`EMAIL_CONSTRAINT`),
  UNIQUE KEY `UK_RU8TT6T700S9V50BU18WS5HA6` (`REALM_ID`,`USERNAME`),
  KEY `IDX_USER_EMAIL` (`EMAIL`),
  KEY `IDX_USER_SERVICE_ACCOUNT` (`REALM_ID`,`SERVICE_ACCOUNT_CLIENT_LINK`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ENTITY`
--

LOCK TABLES `USER_ENTITY` WRITE;
/*!40000 ALTER TABLE `USER_ENTITY` DISABLE KEYS */;
INSERT INTO `USER_ENTITY` VALUES ('67d52ad5-8e97-4044-8078-ef5eaa0985e7',NULL,'8d12a37f-e467-456b-9d9b-e8741cb7f2b2','\0','',NULL,'Benedetto','Pellerito','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','2-c-ben-pel',1679102121433,NULL,0),('7894cbc4-302f-4adf-a068-d96f796357f8','benedettopellerito@gmail.com','benedettopellerito@gmail.com','','',NULL,'Benedetto','Pellerito','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','a_benepell',1678142940511,NULL,0),('a2fdf69a-78ce-4d9c-8472-0c60ef6743b3',NULL,'7f3d35d6-a113-44bc-9c00-23e8aa193ce3','\0','',NULL,NULL,NULL,'f47dc79c-5538-4cdb-9f59-3396e016c2ce','admin',1677409611906,NULL,0),('b329274b-a238-4600-9662-257cc6d50f0f','admin@vrscuola.it','admin@vrscuola.it','','',NULL,'benedetto','Pellerito','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','benepell',1677943095100,NULL,0),('fc797963-ad05-41c0-b089-ea028b11f784',NULL,'6c24ee15-ea6b-469d-9e88-9e0bd82ff5d2','','',NULL,'Benedetto','Pellerito','af7245cf-0c98-4ecf-bc6c-5a57e07d64ed','1-a-benedetto-pellerito',1679097578692,NULL,0);
/*!40000 ALTER TABLE `USER_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FEDERATION_CONFIG` (
  `USER_FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FK_T13HPU1J94R2EBPEKR39X5EU5` FOREIGN KEY (`USER_FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_CONFIG`
--

LOCK TABLES `USER_FEDERATION_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FEDERATION_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `FEDERATION_MAPPER_TYPE` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_MAP_FED_PRV` (`FEDERATION_PROVIDER_ID`),
  KEY `IDX_USR_FED_MAP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_FEDMAPPERPM_FEDPRV` FOREIGN KEY (`FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`),
  CONSTRAINT `FK_FEDMAPPERPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER`
--

LOCK TABLES `USER_FEDERATION_MAPPER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FEDERATION_MAPPER_CONFIG` (
  `USER_FEDERATION_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_FEDMAPPER_CFG` FOREIGN KEY (`USER_FEDERATION_MAPPER_ID`) REFERENCES `USER_FEDERATION_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER_CONFIG`
--

LOCK TABLES `USER_FEDERATION_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_PROVIDER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FEDERATION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `CHANGED_SYNC_PERIOD` int(11) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `FULL_SYNC_PERIOD` int(11) DEFAULT NULL,
  `LAST_SYNC` int(11) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `PROVIDER_NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_PRV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_1FJ32F6PTOLW2QY60CD8N01E8` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_PROVIDER`
--

LOCK TABLES `USER_FEDERATION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_USER_GROUP_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_USER_GROUP_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
INSERT INTO `USER_GROUP_MEMBERSHIP` VALUES ('f7bb5df2-d829-4cd4-b1ef-a1dee794c13a','fc797963-ad05-41c0-b089-ea028b11f784');
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_REQUIRED_ACTION` (
  `USER_ID` varchar(36) NOT NULL,
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_USER_REQACTIONS` (`USER_ID`),
  CONSTRAINT `FK_6QJ3W1JW9CVAFHE19BWSIUVMD` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_REQUIRED_ACTION`
--

LOCK TABLES `USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(255) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_USER_ROLE_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_C4FQV34P1MBYLLOXANG7B1Q3L` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ROLE_MAPPING`
--

LOCK TABLES `USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `USER_ROLE_MAPPING` VALUES ('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','67d52ad5-8e97-4044-8078-ef5eaa0985e7'),('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','7894cbc4-302f-4adf-a068-d96f796357f8'),('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','b329274b-a238-4600-9662-257cc6d50f0f'),('00b0b8bc-2cf1-4207-a4f8-f91ec43cfb01','fc797963-ad05-41c0-b089-ea028b11f784'),('044a260c-a8b5-4ccf-9e1f-46ed5aa20a08','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('0b6da521-5b61-44e8-9c25-4b7f2efddf36','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('1a0b6027-1d65-4479-9315-fe67b8afb89a','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('1b68accc-d4d5-4d86-8c8e-adf4a5149a0e','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('260e85aa-d84e-4369-bbf5-53fca4af577e','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('2db2a1d7-2cea-4b91-9ddc-ef0a2d858dea','b329274b-a238-4600-9662-257cc6d50f0f'),('30f7affa-238d-4eab-9e08-90fbe24e8ef2','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('42bf066b-3e60-4af3-85ce-a709a13d138f','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('517ed924-aaa0-4801-86f8-b0402ce100d7','b329274b-a238-4600-9662-257cc6d50f0f'),('5d8b6397-e372-4dcb-b5cd-ebdebfc8ebc6','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('78ce352b-4769-4420-9c04-73c0890b9e8a','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('7eaa3f2d-dfa4-4b51-b3c3-aced331e7f01','b329274b-a238-4600-9662-257cc6d50f0f'),('8003df3e-11e9-40ad-878d-6f3b0bc5a583','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('858b841b-5b14-46b0-bbbb-330cccc5a9fe','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('8973e0cd-6a4a-4a39-9466-ea53fbf92385','7894cbc4-302f-4adf-a068-d96f796357f8'),('8973e0cd-6a4a-4a39-9466-ea53fbf92385','b329274b-a238-4600-9662-257cc6d50f0f'),('8b937a54-4e9c-4dd3-ab9a-e9fb8f014277','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('8cce6fd2-e27d-4342-8873-8518f16d4e10','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('a978cd2b-d210-4d70-9fbf-9d5cfd9d9657','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('abb77f0c-b6c5-4674-b026-1a5a123bc10a','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('b5ed1430-28d0-48c4-be04-604155dfb7ee','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('b7a48db1-5f60-4bdf-86d2-065dadf80da0','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('b8ff8164-ee48-4ae0-bf8d-4b2284c7daf3','b329274b-a238-4600-9662-257cc6d50f0f'),('d0e59db6-96fe-4b8f-8e75-ac7783ddbbe8','b329274b-a238-4600-9662-257cc6d50f0f'),('d3308360-e0d5-4d5d-8873-aed55b116668','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('d46c3078-21c6-4ed1-a19e-4f53f6194328','b329274b-a238-4600-9662-257cc6d50f0f'),('f4a04bc5-4d65-43a5-a945-b29380634f6f','a2fdf69a-78ce-4d9c-8472-0c60ef6743b3'),('fd49155a-e786-465b-8ce1-a7ead471850e','b329274b-a238-4600-9662-257cc6d50f0f');
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION`
--

DROP TABLE IF EXISTS `USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_SESSION` (
  `ID` varchar(36) NOT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `LAST_SESSION_REFRESH` int(11) DEFAULT NULL,
  `LOGIN_USERNAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `REMEMBER_ME` bit(1) NOT NULL DEFAULT b'0',
  `STARTED` int(11) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `USER_SESSION_STATE` int(11) DEFAULT NULL,
  `BROKER_SESSION_ID` varchar(255) DEFAULT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION`
--

LOCK TABLES `USER_SESSION` WRITE;
/*!40000 ALTER TABLE `USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_SESSION_NOTE` (
  `USER_SESSION` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` text DEFAULT NULL,
  PRIMARY KEY (`USER_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51D3472` FOREIGN KEY (`USER_SESSION`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION_NOTE`
--

LOCK TABLES `USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WEB_ORIGINS`
--

DROP TABLE IF EXISTS `WEB_ORIGINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WEB_ORIGINS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_WEB_ORIG_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_LOJPHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WEB_ORIGINS`
--

LOCK TABLES `WEB_ORIGINS` WRITE;
/*!40000 ALTER TABLE `WEB_ORIGINS` DISABLE KEYS */;
INSERT INTO `WEB_ORIGINS` VALUES ('69d9293e-0b5e-443e-a4d0-5e2c12ddd2ad','+'),('8565077f-84ed-4a5d-a06b-be52a43d3779','+');
/*!40000 ALTER TABLE `WEB_ORIGINS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-22 11:29:44
