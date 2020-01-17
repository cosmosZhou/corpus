CREATE TABLE `tbl_structure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(128) NOT NULL,
  `infix` varchar(2048) NOT NULL,
  `training` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE tbl_structure DISCARD TABLESPACE;
ALTER TABLE tbl_structure IMPORT TABLESPACE;  
load data local infile "D:/360/solution/mysql/tbl_structure.csv" into table `tbl_structure` character set utf8;

CREATE TABLE `tbl_paraphrase` (
  `x` varchar(64) NOT NULL,
  `y` varchar(64) NOT NULL,
  `score` int(3) NOT NULL,
  `training` tinyint(1) NOT NULL DEFAULT (1),
  UNIQUE KEY `x` (`x`,`y`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE tbl_paraphrase DISCARD TABLESPACE;
ALTER TABLE tbl_paraphrase IMPORT TABLESPACE;  

load data local infile "D:/360/solution/mysql/tbl_paraphrase.csv" into table `tbl_paraphrase` character set utf8;

CREATE TABLE `tbl_translation_copy` (
  `x` varchar(512) NOT NULL,
  `y` varchar(256) NOT NULL,
  `training` tinyint(1) NOT NULL DEFAULT (1),
  UNIQUE KEY `x` (`x`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
PARTITION BY KEY () PARTITIONS 128;

alter table tbl_translation PARTITION BY key() PARTITIONS 128;

ALTER TABLE tbl_translation DISCARD TABLESPACE;
ALTER TABLE tbl_translation IMPORT TABLESPACE;  

load data local infile "D:/360/solution/mysql/tbl_translation.csv" into table `tbl_translation` character set utf8;

CREATE TABLE `tbl_service` (
  `text` varchar(128) NOT NULL,
  `context` varchar(40) NOT NULL,
  `service` varchar(28) NOT NULL,
  `training` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`text`,`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='classification';
ALTER TABLE tbl_service DISCARD TABLESPACE;
ALTER TABLE tbl_service IMPORT TABLESPACE;  

load data local infile "D:/360/solution/mysql/tbl_service.csv" into table tbl_service character set utf8;

CREATE TABLE `tbl_intent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(64) NOT NULL,
  `intent` varchar(200) NOT NULL,
  `service` varchar(20) NOT NULL,
  `training` tinyint(1) NOT NULL DEFAULT '1',
  `code` varchar(32) DEFAULT NULL,
  `updatetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `syntactic` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE tbl_intent DISCARD TABLESPACE;
ALTER TABLE tbl_intent IMPORT TABLESPACE;  

load data local infile "D:/360/solution/mysql/tbl_intent.csv" into table tbl_intent character set utf8;

CREATE TABLE `tbl_repertoire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(64) NOT NULL,
  `service` varchar(32) NOT NULL,
  `slot` varchar(32) NOT NULL,
  `code` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `text` (`text`,`service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='repertoire for intent';
ALTER TABLE tbl_repertoire DISCARD TABLESPACE;
ALTER TABLE tbl_repertoire IMPORT TABLESPACE;  

load data local infile "D:/360/solution/mysql/tbl_repertoire.csv" into table tbl_repertoire character set utf8;

CREATE TABLE `tbl_qatype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(128) NOT NULL,
  `label` enum('QUERY','REPLY') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE tbl_qatype DISCARD TABLESPACE;
ALTER TABLE tbl_qatype IMPORT TABLESPACE;  

load data local infile "D:/360/solution/mysql/tbl_qatype.csv" into table tbl_qatype character set utf8;


CREATE TABLE `tbl_phatics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(128) NOT NULL,
  `label` enum('NEUTRAL','PERTAIN') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
ALTER TABLE tbl_phatics DISCARD TABLESPACE;
ALTER TABLE tbl_phatics IMPORT TABLESPACE;  

load data local infile "D:/360/solution/mysql/tbl_phatics.csv" into table tbl_phatics character set utf8;

CREATE TABLE `tbl_id2feature` (
  `patent_id` varchar(36) NOT NULL,
  `tcd1` varchar(512) NOT NULL,
  PRIMARY KEY (`patent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
PARTITION BY KEY () PARTITIONS 128;

ALTER TABLE tbl_phatics DISCARD TABLESPACE;
ALTER TABLE tbl_phatics IMPORT TABLESPACE;  

alter table tbl_id2feature PARTITION BY key() PARTITIONS 128;

load data local infile "/mnt/nas/vector_group/evaluation2/id_features.csv" into table tbl_id2feature character set utf8;


CREATE TABLE `tbl_semantic` (
  `s1_id` varchar(36) NOT NULL,
  `s2_id` varchar(36) NOT NULL,
  `rebut` tinyint(1) NOT NULL,
  UNIQUE KEY `patent_id` (`s1_id`,`s2_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE tbl_semantic DISCARD TABLESPACE;
ALTER TABLE tbl_semantic IMPORT TABLESPACE;  

load data local infile "/mnt/nas/vector_group/training_sample/goodcase.csv" into table tbl_semantic character set utf8;