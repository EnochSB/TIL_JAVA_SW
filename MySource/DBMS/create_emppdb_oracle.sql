-- sql plus / as sysdba
-- alter session set container=EMPPDB
-- show con_name   

create pluggable database "EMPPDB" admin user "EMPADMIN" identified by "12345" roles=(dba) file_name_convert = ('pdbseed','EMPPDB') ;

alter pluggable database "EMPPDB" open read write; 
alter pluggable database "EMPPDB" save state ;

alter session set container = "EMPPDB";  
grant resource, dba to "EMPADMIN"; 

conn EMPADMIN/12345@localhost/EMPPDB as sysdba 
CREATE tablespace emptbls 
datafile 'c:\oracle\data\emptbls.dbf' size 64M autoextend on; 

CREATE USER scott IDENTIFIED BY tiger default tablespace emptbls ;
alter user SCOTT quota unlimited on emptbls ;
GRANT connect, resource, dba TO scott ;


connect scott/tiger@localhost/emppdb

CREATE TABLE DEPT (
 DEPTNO              number(2,0) NOT NULL,
 DNAME               VARCHAR2(14),
 LOC                 VARCHAR2(13),
 CONSTRAINT DEPT_PRIMARY_KEY PRIMARY KEY (DEPTNO));

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE EMP (
 EMPNO               number(4,0) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 number(4,0),
 HIREDATE            DATE,
 SAL                 number(7,2),
 COMM                number(7,2),
 DEPTNO              number(2,0) NOT NULL,
 CONSTRAINT EMP_SELF_KEY       FOREIGN KEY  (MGR) REFERENCES EMP(EMPNO),
 CONSTRAINT EMP_FOREIGN_KEY FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO),
 CONSTRAINT EMP_PRIMARY_KEY PRIMARY KEY (EMPNO));

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,to_date('1981-11-17', 'yyyy-mm-dd'),5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,to_date('1981-5-1', 'yyyy-mm-dd'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,to_date('1981-6-9', 'yyyy-mm-dd'),2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,to_date('1981-4-2', 'yyyy-mm-dd'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,to_date('1981-8-28', 'yyyy-mm-dd'),1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,to_date('1981-2-20', 'yyyy-mm-dd'),1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,to_date('1981-8-8', 'yyyy-mm-dd'),1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,to_date('1981-12-3', 'yyyy-mm-dd'),950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,to_date('1981-2-22', 'yyyy-mm-dd'),1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,to_date('1981-12-3', 'yyyy-mm-dd'),3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,to_date('1980-12-17', 'yyyy-mm-dd'),800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,to_date('1982-12-9', 'yyyy-mm-dd'),3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,to_date('1983-1-12', 'yyyy-mm-dd'),1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,to_date('1982-1-23', 'yyyy-mm-dd'),1300,NULL,10);

commit ;


--------------------------------------------------------
--  DDL for Table CITY
--------------------------------------------------------

  CREATE TABLE "CITY" 
   (	"ID" NUMBER(5), 
	"NAME" VARCHAR2(50), 
	"COUNTRYCODE" CHAR(3) DEFAULT NULL, 
	"DISTRICT" VARCHAR2(50), 
	"POPULATION" NUMBER(8) DEFAULT NULL
   ) TABLESPACE "EMPTBLS" ;
--------------------------------------------------------
--  DDL for Table COUNTRY
--------------------------------------------------------

  CREATE TABLE "COUNTRY" 
   (	"CODE" CHAR(3), 
	"NAME" VARCHAR2(50), 
	"SURFACEAREA" NUMBER(8) DEFAULT NULL, 
	"POPULATION" NUMBER(8) DEFAULT NULL, 
	"LIFEEXPECTANCY" NUMBER(4,1) DEFAULT NULL, 
	"GNP" NUMBER(10) DEFAULT NULL, 
	"CAPITAL" NUMBER(8) DEFAULT NULL
   ) TABLESPACE "EMPTBLS" ;
--------------------------------------------------------
--  DDL for Table COUNTRYLANGUAGE
--------------------------------------------------------

  CREATE TABLE "COUNTRYLANGUAGE" 
   (	"COUNTRYCODE" CHAR(3), 
	"LANGUAGE" VARCHAR2(50), 
	"PERCENTAGE" NUMBER(4,1) DEFAULT NULL
   ) TABLESPACE "EMPTBLS" ;
--------------------------------------------------------
--  DDL for View EMP_HIGH_SALARY
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "SCOTT"."EMP_HIGH_SALARY" ("EMPNO", "ENAME", "DEPTNO", "SAL") AS 
  SELECT empno, ename, deptno, sal 
   FROM emp
   WHERE sal >= 2500
;
REM INSERTING into CITY
SET DEFINE OFF;
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3602,'Vladivostok','RUS','Primorje',606200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3603,'Irkutsk','RUS','Irkutsk',593700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3604,'Barnaul','RUS','Altai',580100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3605,'Novokuznetsk','RUS','Kemerovo',561600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3606,'Penza','RUS','Penza',532200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3607,'Rjazan','RUS','Rjazan',529900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3608,'Orenburg','RUS','Orenburg',523600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3609,'Lipetsk','RUS','Lipetsk',521000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3611,'Tula','RUS','Tula',506100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3612,'Tjumen','RUS','Tjumen',503400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3613,'Kemerovo','RUS','Kemerovo',492700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3614,'Astrahan','RUS','Astrahan',486100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3615,'Tomsk','RUS','Tomsk',482100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3616,'Kirov','RUS','Kirov',466200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3617,'Ivanovo','RUS','Ivanovo',459200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3619,'Brjansk','RUS','Brjansk',457400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3620,'Tver','RUS','Tver',454900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3621,'Kursk','RUS','Kursk',443500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3623,'Kaliningrad','RUS','Kaliningrad',424400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3624,'Nizni Tagil','RUS','Sverdlovsk',390900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3625,'Murmansk','RUS','Murmansk',376300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3626,'Ulan-Ude','RUS','Burjatia',370400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3627,'Kurgan','RUS','Kurgan',364700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3628,'Arkangeli','RUS','Arkangeli',361800);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3629,'Sot횂큄i','RUS','Krasnodar',358600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3630,'Smolensk','RUS','Smolensk',353400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3631,'Orjol','RUS','Orjol',344500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3632,'Stavropol','RUS','Stavropol',343300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3633,'Belgorod','RUS','Belgorod',342000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3634,'Kaluga','RUS','Kaluga',339300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3635,'Vladimir','RUS','Vladimir',337100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3642,'Vologda','RUS','Vologda',302500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3643,'Veliki Novgorod','RUS','Novgorod',299500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3644,'Komsomolsk-na-Amure','RUS','Habarovsk',291600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3645,'Kostroma','RUS','Kostroma',288100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3646,'Volzski','RUS','Volgograd',286900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3647,'Taganrog','RUS','Rostov-na-Donu',284400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3648,'Petroskoi','RUS','Karjala',282100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3649,'Bratsk','RUS','Irkutsk',277600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3650,'Dzerzinsk','RUS','Nizni Novgorod',277100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3651,'Surgut','RUS','Hanti-Mansia',274900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3652,'Orsk','RUS','Orenburg',273900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3654,'Angarsk','RUS','Irkutsk',264700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3656,'Rybinsk','RUS','Jaroslavl',239600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3657,'Prokopjevsk','RUS','Kemerovo',237300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3658,'Niznevartovsk','RUS','Hanti-Mansia',233900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3660,'Syktyvkar','RUS','Komi',229700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3661,'Severodvinsk','RUS','Arkangeli',229300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3667,'Zelenograd','RUS','Moscow (City)',207100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3668,'Balakovo','RUS','Saratov',206000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3669,'Novorossijsk','RUS','Krasnodar',203300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3670,'Pihkova','RUS','Pihkova',201500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3672,'Jakutsk','RUS','Saha (Jakutia)',195400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3673,'Podolsk','RUS','Moskova',194300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3680,'Berezniki','RUS','Perm',181900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3681,'Juzno-Sahalinsk','RUS','Sahalin',179200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3682,'Volgodonsk','RUS','Rostov-na-Donu',178200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3683,'Abakan','RUS','Hakassia',169200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3684,'Maikop','RUS','Adygea',167300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3686,'Armavir','RUS','Krasnodar',164900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3687,'Ljubertsy','RUS','Moskova',163900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3688,'Rubtsovsk','RUS','Altai',162600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3689,'Kovrov','RUS','Vladimir',159900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3690,'Nahodka','RUS','Primorje',157700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3691,'Ussurijsk','RUS','Primorje',157300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3694,'Kolomna','RUS','Moskova',150700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3695,'Elektrostal','RUS','Moskova',147000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3696,'Murom','RUS','Vladimir',142400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3697,'Kolpino','RUS','Pietari',141200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3698,'Norilsk','RUS','Krasnojarsk',140800);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3699,'Almetjevsk','RUS','Tatarstan',140700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3700,'Novomoskovsk','RUS','Tula',138100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3701,'Dimitrovgrad','RUS','Uljanovsk',137000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3702,'Pervouralsk','RUS','Sverdlovsk',136100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3703,'Himki','RUS','Moskova',133700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3705,'Nevinnomyssk','RUS','Stavropol',132600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3706,'Pjatigorsk','RUS','Stavropol',132500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3707,'Korolev','RUS','Moskova',132400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3708,'Serpuhov','RUS','Moskova',132000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3709,'Odintsovo','RUS','Moskova',127400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3710,'Orehovo-Zujevo','RUS','Moskova',124900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3726,'Sergijev Posad','RUS','Moskova',111100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3727,'Arzamas','RUS','Nizni Novgorod',110700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3728,'Kiseljovsk','RUS','Kemerovo',110000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3729,'Novotroitsk','RUS','Orenburg',109600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3730,'Obninsk','RUS','Kaluga',108300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3731,'Kansk','RUS','Krasnojarsk',107400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3732,'Glazov','RUS','Udmurtia',106300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3733,'Solikamsk','RUS','Perm',106000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3734,'Sarapul','RUS','Udmurtia',105700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3735,'Ust-Ilimsk','RUS','Irkutsk',105200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3741,'Votkinsk','RUS','Udmurtia',101700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3742,'Kyzyl','RUS','Tyva',101100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3743,'Serov','RUS','Sverdlovsk',100400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3744,'Zelenodolsk','RUS','Tatarstan',100200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3745,'Zeleznodoroznyi','RUS','Moskova',100100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3747,'Kuznetsk','RUS','Penza',98200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3748,'Uhta','RUS','Komi',98000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3749,'Jessentuki','RUS','Stavropol',97900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3750,'Tobolsk','RUS','Tjumen',97600);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3751,'Neftejugansk','RUS','Hanti-Mansia',97400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3752,'Bataisk','RUS','Rostov-na-Donu',97300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3753,'Nojabrsk','RUS','Yamalin Nenetsia',97300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3755,'Zeleznogorsk','RUS','Kursk',96900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3756,'Zukovski','RUS','Moskova',96500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3757,'Anzero-Sudzensk','RUS','Kemerovo',96100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3758,'Bugulma','RUS','Tatarstan',94100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3759,'Zeleznogorsk','RUS','Krasnojarsk',94000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3760,'Novouralsk','RUS','Sverdlovsk',93300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3213,'Maribor','SVN','Podravska',115532);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3048,'Stockholm','SWE','Lisboa',750348);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3448,'Dniprodzerzynsk','UKR','Dnipropetrovsk',270000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3449,'Kirovograd','UKR','Kirovograd',265000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3450,'Hmelnytskyi','UKR','Hmelnytskyi',262000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3452,'Rivne','UKR','Rivne',245000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3454,'Ivano-Frankivsk','UKR','Ivano-Frankivsk',237000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3455,'Ternopil','UKR','Ternopil',236000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3456,'Lutsk','UKR','Volynia',217000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3457,'Bila Tserkva','UKR','Kiova',215000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3458,'Kramatorsk','UKR','Donetsk',186000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3459,'Melitopol','UKR','Zaporizzja',169000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3461,'Nikopol','UKR','Dnipropetrovsk',149000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3462,'Berdjansk','UKR','Zaporizzja',130000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3463,'Pavlograd','UKR','Dnipropetrovsk',127000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3464,'Sjeverodonetsk','UKR','Lugansk',127000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3465,'Slovjansk','UKR','Donetsk',127000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3466,'Uzgorod','UKR','Taka-Karpatia',127000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1792,'Beograd','YUG','Central Serbia',1204000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1793,'Novi Sad','YUG','Vojvodina',179626);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1796,'Kragujevac','YUG','Central Serbia',147305);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1797,'Podgorica','YUG','Montenegro',135000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1798,'Subotica','YUG','Vojvodina',100386);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1799,'Prizren','YUG','Kosovo and Metohija',92303);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (34,'Tirana','ALB','Tirana',270000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (55,'Andorra la Vella','AND','Andorra la Vella',21189);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1523,'Wien','AUT','Wien',1608144);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1524,'Graz','AUT','Steiermark',240967);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1525,'Linz','AUT','North Austria',188022);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1526,'Salzburg','AUT','Salzburg',144247);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1527,'Innsbruck','AUT','Tiroli',111752);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1528,'Klagenfurt','AUT','K횄짚rnten',91141);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (175,'Antwerpen','BEL','Antwerpen',446525);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (176,'Gent','BEL','East Flanderi',224180);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (177,'Charleroi','BEL','Hainaut',200827);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (179,'Bruxelles [Brussel]','BEL','Bryssel',133859);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (180,'Brugge','BEL','West Flanderi',116246);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (181,'Schaerbeek','BEL','Bryssel',105692);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (182,'Namur','BEL','Namur',105419);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (183,'Mons','BEL','Hainaut',90935);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (539,'Sofija','BGR','Grad Sofija',1122302);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (540,'Plovdiv','BGR','Plovdiv',342584);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (541,'Varna','BGR','Varna',299801);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (542,'Burgas','BGR','Burgas',195255);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (543,'Ruse','BGR','Ruse',166467);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (544,'Stara Zagora','BGR','Haskovo',147939);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (545,'Pleven','BGR','Lovec',121952);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (546,'Sliven','BGR','Burgas',105530);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (547,'Dobric','BGR','Varna',100399);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (548,'횂힋umen','BGR','Varna',94686);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (201,'Sarajevo','BIH','Federaatio',360000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (202,'Banja Luka','BIH','Republika Srpska',143079);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (203,'Zenica','BIH','Federaatio',96027);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3520,'Minsk','BLR','Horad Minsk',1674000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3521,'Gomel','BLR','Gomel',475000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3522,'Mogiljov','BLR','Mogiljov',356000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3523,'Vitebsk','BLR','Vitebsk',340000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3524,'Grodno','BLR','Grodno',302000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3525,'Brest','BLR','Brest',286000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3526,'Bobruisk','BLR','Mogiljov',221000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3528,'Borisov','BLR','Minsk',151000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3529,'Pinsk','BLR','Brest',130000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3531,'Mozyr','BLR','Gomel',110000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3532,'Novopolotsk','BLR','Vitebsk',106000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3533,'Lida','BLR','Grodno',101000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3534,'Soligorsk','BLR','Minsk',101000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3246,'Geneve','CHE','Geneve',173500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3247,'Basel','CHE','Basel-Stadt',166700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3248,'Bern','CHE','Bern',122700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3249,'Lausanne','CHE','Vaud',114500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3068,'Berlin','DEU','Berliini',3386667);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3069,'Hamburg','DEU','Hamburg',1704735);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3073,'Essen','DEU','Nordrhein-Westfalen',599515);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3074,'Dortmund','DEU','Nordrhein-Westfalen',590213);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3077,'Bremen','DEU','Bremen',540330);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3078,'Duisburg','DEU','Nordrhein-Westfalen',519793);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3079,'Hannover','DEU','Niedersachsen',514718);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3080,'Leipzig','DEU','Saksi',489532);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3082,'Dresden','DEU','Saksi',476668);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3083,'Bochum','DEU','Nordrhein-Westfalen',392830);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3084,'Wuppertal','DEU','Nordrhein-Westfalen',368993);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3085,'Bielefeld','DEU','Nordrhein-Westfalen',321125);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3087,'Bonn','DEU','Nordrhein-Westfalen',301048);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3088,'Gelsenkirchen','DEU','Nordrhein-Westfalen',281979);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3090,'Wiesbaden','DEU','Hessen',268716);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3093,'Chemnitz','DEU','Saksi',263222);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3094,'Augsburg','DEU','Baijeri',254867);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3095,'Halle/Saale','DEU','Anhalt Sachsen',254360);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3096,'Braunschweig','DEU','Niedersachsen',246322);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3097,'Aachen','DEU','Nordrhein-Westfalen',243825);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3098,'Krefeld','DEU','Nordrhein-Westfalen',241769);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3099,'Magdeburg','DEU','Anhalt Sachsen',235073);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3100,'Kiel','DEU','Schleswig-Holstein',233795);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3101,'Oberhausen','DEU','Nordrhein-Westfalen',222349);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3103,'Hagen','DEU','Nordrhein-Westfalen',205201);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3104,'Rostock','DEU','Mecklenburg-Vorpomme',203279);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3109,'Mainz','DEU','Rheinland-Pfalz',183134);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3110,'Hamm','DEU','Nordrhein-Westfalen',181804);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3111,'Herne','DEU','Nordrhein-Westfalen',175661);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3115,'Ludwigshafen am Rhein','DEU','Rheinland-Pfalz',163771);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3116,'Leverkusen','DEU','Nordrhein-Westfalen',160841);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3117,'Oldenburg','DEU','Niedersachsen',154125);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3118,'Neuss','DEU','Nordrhein-Westfalen',149702);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3120,'Darmstadt','DEU','Hessen',137776);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3121,'Paderborn','DEU','Nordrhein-Westfalen',137647);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3122,'Potsdam','DEU','Brandenburg',128983);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3124,'Regensburg','DEU','Baijeri',125236);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3125,'Recklinghausen','DEU','Nordrhein-Westfalen',125022);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3127,'Bremerhaven','DEU','Bremen',122735);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3128,'Wolfsburg','DEU','Niedersachsen',121954);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3129,'Bottrop','DEU','Nordrhein-Westfalen',121097);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3130,'Remscheid','DEU','Nordrhein-Westfalen',120125);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3137,'Salzgitter','DEU','Niedersachsen',112934);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3138,'Cottbus','DEU','Brandenburg',110894);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3141,'Siegen','DEU','Nordrhein-Westfalen',109225);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3142,'Koblenz','DEU','Rheinland-Pfalz',108003);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3143,'Moers','DEU','Nordrhein-Westfalen',106837);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3144,'Bergisch Gladbach','DEU','Nordrhein-Westfalen',106150);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3145,'Zwickau','DEU','Saksi',104146);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3146,'Hildesheim','DEU','Niedersachsen',104013);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3147,'Witten','DEU','Nordrhein-Westfalen',103384);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3148,'Schwerin','DEU','Mecklenburg-Vorpomme',102878);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3149,'Erlangen','DEU','Baijeri',100750);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3150,'Kaiserslautern','DEU','Rheinland-Pfalz',100025);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3151,'Trier','DEU','Rheinland-Pfalz',99891);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3153,'Iserlohn','DEU','Nordrhein-Westfalen',99474);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3155,'Marl','DEU','Nordrhein-Westfalen',93735);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3317,'Odense','DNK','Fyn',183912);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3318,'Aalborg','DNK','Nordjylland',161161);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3319,'Frederiksberg','DNK','Frederiksberg',90327);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (653,'Madrid','ESP','Madrid',2879052);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (654,'Barcelona','ESP','Katalonia',1503451);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (655,'Valencia','ESP','Valencia',739412);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (656,'Sevilla','ESP','Andalusia',701927);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (657,'Zaragoza','ESP','Aragonia',603367);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (659,'Bilbao','ESP','Baskimaa',357589);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (660,'Las Palmas de Gran Canaria','ESP','Canary Islands',354757);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (661,'Murcia','ESP','Murcia',353504);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (665,'Vigo','ESP','Galicia',283670);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (666,'Alicante [Alacant]','ESP','Valencia',272432);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (671,'Vitoria-Gasteiz','ESP','Baskimaa',217154);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (672,'Santa Cruz de Tenerife','ESP','Canary Islands',213050);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (673,'Badalona','ESP','Katalonia',209635);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (674,'Oviedo','ESP','Asturia',200453);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (676,'Elche [Elx]','ESP','Valencia',193174);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (677,'Sabadell','ESP','Katalonia',184859);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (678,'Santander','ESP','Cantabria',184165);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (679,'Jerez de la Frontera','ESP','Andalusia',182660);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3791,'Tallinn','EST','Harjumaa',403981);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3792,'Tartu','EST','Tartumaa',101246);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3236,'Helsinki [Helsingfors]','FIN','Newmaa',555474);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3237,'Espoo','FIN','Newmaa',213271);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3238,'Tampere','FIN','Pirkanmaa',195468);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3239,'Vantaa','FIN','Newmaa',178471);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2979,'Nantes','FRA','Pays de la Loire',270251);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2980,'Strasbourg','FRA','Alsace',264115);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2981,'Montpellier','FRA','Languedoc-Roussillon',225392);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2982,'Bordeaux','FRA','Aquitaine',215363);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2983,'Rennes','FRA','Haute-Normandie',206229);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2984,'Le Havre','FRA','Champagne-Ardenne',190905);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2985,'Reims','FRA','Nord-Pas-de-Calais',187206);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2990,'Angers','FRA','Pays de la Loire',151279);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2991,'Dijon','FRA','Bourgogne',149867);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2992,'Brest','FRA','Bretagne',149634);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2993,'Le Mans','FRA','Pays de la Loire',146105);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2994,'Clermont-Ferrand','FRA','Auvergne',137140);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3008,'Perpignan','FRA','Languedoc-Roussillon',105115);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (456,'London','GBR','England',7285000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (457,'Birmingham','GBR','England',1013000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (458,'Glasgow','GBR','Scotland',619680);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (459,'Liverpool','GBR','England',461000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (460,'Edinburgh','GBR','Scotland',450180);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (461,'Sheffield','GBR','England',431607);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (462,'Manchester','GBR','England',430000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (463,'Leeds','GBR','England',424194);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (464,'Bristol','GBR','England',402000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (465,'Cardiff','GBR','Wales',321000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (466,'Coventry','GBR','England',304000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (467,'Leicester','GBR','England',294000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (468,'Bradford','GBR','England',289376);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (469,'Belfast','GBR','North Ireland',287500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (470,'Nottingham','GBR','England',287000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (471,'Kingston upon Hull','GBR','England',262000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (472,'Plymouth','GBR','England',253000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (473,'Stoke-on-Trent','GBR','England',252000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (474,'Wolverhampton','GBR','England',242000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (475,'Derby','GBR','England',236000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (476,'Swansea','GBR','Wales',230000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (477,'Southampton','GBR','England',216000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (478,'Aberdeen','GBR','Scotland',213070);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (479,'Northampton','GBR','England',196000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (480,'Dudley','GBR','England',192171);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (481,'Portsmouth','GBR','England',190000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (482,'Newcastle upon Tyne','GBR','England',189150);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (483,'Sunderland','GBR','England',183310);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (484,'Luton','GBR','England',183000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (485,'Swindon','GBR','England',180000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (486,'Southend-on-Sea','GBR','England',176000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (487,'Walsall','GBR','England',174739);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (488,'Bournemouth','GBR','England',162000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (489,'Peterborough','GBR','England',156000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (490,'Brighton','GBR','England',156124);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (491,'Blackpool','GBR','England',151000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (492,'Dundee','GBR','Scotland',146690);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (493,'West Bromwich','GBR','England',146386);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (494,'Reading','GBR','England',148000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (495,'Oldbury/Smethwick (Warley)','GBR','England',145542);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (496,'Middlesbrough','GBR','England',145000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (497,'Huddersfield','GBR','England',143726);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (498,'Oxford','GBR','England',144000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (499,'Poole','GBR','England',141000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (500,'Bolton','GBR','England',139020);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (501,'Blackburn','GBR','England',140000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (502,'Newport','GBR','Wales',139000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (503,'Preston','GBR','England',135000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (504,'Stockport','GBR','England',132813);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (505,'Norwich','GBR','England',124000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (506,'Rotherham','GBR','England',121380);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (507,'Cambridge','GBR','England',121000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (508,'Watford','GBR','England',113080);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (509,'Ipswich','GBR','England',114000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (510,'Slough','GBR','England',112000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (511,'Exeter','GBR','England',111000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (512,'Cheltenham','GBR','England',106000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (513,'Gloucester','GBR','England',107000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (514,'Saint Helens','GBR','England',106293);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (515,'Sutton Coldfield','GBR','England',106001);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (516,'York','GBR','England',104425);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (517,'Oldham','GBR','England',103931);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (518,'Basildon','GBR','England',100924);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (519,'Worthing','GBR','England',100000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (520,'Chelmsford','GBR','England',97451);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (521,'Colchester','GBR','England',96063);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (522,'Crawley','GBR','England',97000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (523,'Gillingham','GBR','England',92000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (524,'Solihull','GBR','England',94531);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (525,'Rochdale','GBR','England',94313);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (526,'Birkenhead','GBR','England',93087);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (527,'Worcester','GBR','England',95000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (528,'Hartlepool','GBR','England',92000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (529,'Halifax','GBR','England',91069);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (530,'Woking/Byfleet','GBR','England',92000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (531,'Southport','GBR','England',90959);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (532,'Maidstone','GBR','England',90878);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (533,'Eastbourne','GBR','England',90000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (534,'Grimsby','GBR','England',89000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (535,'Saint Helier','GBR','Jersey',27523);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2401,'Athenai','GRC','Attika',772072);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2402,'Thessaloniki','GRC','Central Macedonia',383967);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2403,'Pireus','GRC','Attika',182671);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2404,'Patras','GRC','West Greece',153344);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2405,'Peristerion','GRC','Attika',137288);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2406,'Herakleion','GRC','Crete',116178);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2407,'Kallithea','GRC','Attika',114233);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2408,'Larisa','GRC','Thessalia',113090);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2409,'Zagreb','HRV','Grad Zagreb',706770);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2410,'Split','HRV','Split-Dalmatia',189388);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2411,'Rijeka','HRV','Primorje-Gorski Kota',167964);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2412,'Osijek','HRV','Osijek-Baranja',104761);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1465,'Milano','ITA','Lombardia',1300977);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1466,'Napoli','ITA','Campania',1002619);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1467,'Torino','ITA','Piemonte',903705);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1468,'Palermo','ITA','Sisilia',683794);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1469,'Genova','ITA','Liguria',636104);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1470,'Bologna','ITA','Emilia-Romagna',381161);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1471,'Firenze','ITA','Toscana',376662);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1472,'Catania','ITA','Sisilia',337862);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1473,'Bari','ITA','Apulia',331848);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1474,'Venezia','ITA','Veneto',277305);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1475,'Messina','ITA','Sisilia',259156);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1476,'Verona','ITA','Veneto',255268);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1477,'Trieste','ITA','Friuli-Venezia Giuli',216459);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1478,'Padova','ITA','Veneto',211391);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1479,'Taranto','ITA','Apulia',208214);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1480,'Brescia','ITA','Lombardia',191317);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1481,'Reggio di Calabria','ITA','Calabria',179617);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1482,'Modena','ITA','Emilia-Romagna',176022);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1483,'Prato','ITA','Toscana',172473);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1484,'Parma','ITA','Emilia-Romagna',168717);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1485,'Cagliari','ITA','Sardinia',165926);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1486,'Livorno','ITA','Toscana',161673);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1487,'Perugia','ITA','Umbria',156673);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1488,'Foggia','ITA','Apulia',154891);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1490,'Salerno','ITA','Campania',142055);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1491,'Ravenna','ITA','Emilia-Romagna',138418);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1492,'Ferrara','ITA','Emilia-Romagna',132127);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1493,'Rimini','ITA','Emilia-Romagna',131062);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1494,'Syrakusa','ITA','Sisilia',126282);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1495,'Sassari','ITA','Sardinia',120803);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1496,'Monza','ITA','Lombardia',119516);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1497,'Bergamo','ITA','Lombardia',117837);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1498,'Pescara','ITA','Abruzzit',115698);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1499,'Latina','ITA','Latium',114099);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1500,'Vicenza','ITA','Veneto',109738);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1501,'Terni','ITA','Umbria',107770);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1503,'Trento','ITA','Trentino-Alto Adige',104906);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1504,'Novara','ITA','Piemonte',102037);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1505,'Piacenza','ITA','Emilia-Romagna',98384);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1506,'Ancona','ITA','Marche',98329);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1507,'Lecce','ITA','Apulia',98208);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1508,'Bolzano','ITA','Trentino-Alto Adige',97232);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1509,'Catanzaro','ITA','Calabria',96700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1510,'La Spezia','ITA','Liguria',95504);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1511,'Udine','ITA','Friuli-Venezia Giuli',94932);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1512,'Torre del Greco','ITA','Campania',94505);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1513,'Andria','ITA','Apulia',94443);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1514,'Brindisi','ITA','Apulia',93454);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1515,'Giugliano in Campania','ITA','Campania',93286);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1516,'Pisa','ITA','Toscana',92379);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1517,'Barletta','ITA','Apulia',91904);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1518,'Arezzo','ITA','Toscana',91729);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1519,'Alessandria','ITA','Piemonte',90289);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1520,'Cesena','ITA','Emilia-Romagna',89852);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (1521,'Pesaro','ITA','Marche',88987);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2445,'Schaan','LIE','Schaan',5346);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2446,'Vaduz','LIE','Vaduz',5043);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2447,'Vilnius','LTU','Vilna',577969);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2448,'Kaunas','LTU','Kaunas',412639);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2449,'Klaipeda','LTU','Klaipeda',202451);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2460,'Skopje','MKD','Skopje',444299);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2483,'Birkirkara','MLT','Outer Harbour',21445);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2484,'Valletta','MLT','Inner Harbour',7073);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (5,'Amsterdam','NLD','Noord-Holland',731200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (6,'Rotterdam','NLD','Zuid-Holland',593321);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (7,'Haag','NLD','Zuid-Holland',440900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (8,'Utrecht','NLD','Utrecht',234323);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (9,'Eindhoven','NLD','Noord-Brabant',201843);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (10,'Tilburg','NLD','Noord-Brabant',193238);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (11,'Groningen','NLD','Groningen',172701);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (12,'Breda','NLD','Noord-Brabant',160398);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (13,'Apeldoorn','NLD','Gelderland',153491);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (14,'Nijmegen','NLD','Gelderland',152463);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (15,'Enschede','NLD','Overijssel',149544);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (16,'Haarlem','NLD','Noord-Holland',148772);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (17,'Almere','NLD','Flevoland',142465);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (18,'Arnhem','NLD','Gelderland',138020);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (19,'Zaanstad','NLD','Noord-Holland',135621);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (21,'Amersfoort','NLD','Utrecht',126270);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (22,'Maastricht','NLD','Limburg',122087);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (23,'Dordrecht','NLD','Zuid-Holland',119811);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (24,'Leiden','NLD','Zuid-Holland',117196);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (25,'Haarlemmermeer','NLD','Noord-Holland',110722);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (26,'Zoetermeer','NLD','Zuid-Holland',110214);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (27,'Emmen','NLD','Drenthe',105853);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (28,'Zwolle','NLD','Overijssel',105819);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (29,'Ede','NLD','Gelderland',101574);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (30,'Delft','NLD','Zuid-Holland',95268);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (31,'Heerlen','NLD','Limburg',95052);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (32,'Alkmaar','NLD','Noord-Holland',92713);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2807,'Oslo','NOR','Oslo',508726);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2808,'Bergen','NOR','Hordaland',230948);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2932,'Poznan','POL','Wielkopolskie',576899);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2933,'Gdansk','POL','Pomorskie',458988);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2934,'Szczecin','POL','Zachodnio-Pomorskie',416988);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2935,'Bydgoszcz','POL','Kujawsko-Pomorskie',386855);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2936,'Lublin','POL','Lubelskie',356251);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2937,'Katowice','POL','Slaskie',345934);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2938,'Bialystok','POL','Podlaskie',283937);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2939,'Czestochowa','POL','Slaskie',257812);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2940,'Gdynia','POL','Pomorskie',253521);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2941,'Sosnowiec','POL','Slaskie',244102);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2942,'Radom','POL','Mazowieckie',232262);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2943,'Kielce','POL','Swietokrzyskie',212383);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2944,'Gliwice','POL','Slaskie',212164);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2945,'Torun','POL','Kujawsko-Pomorskie',206158);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2946,'Bytom','POL','Slaskie',205560);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2947,'Zabrze','POL','Slaskie',200177);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2948,'Bielsko-Biala','POL','Slaskie',180307);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2964,'Koszalin','POL','Zachodnio-Pomorskie',112375);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2965,'Legnica','POL','Dolnoslaskie',109335);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2966,'Kalisz','POL','Wielkopolskie',106641);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2967,'Grudziadz','POL','Kujawsko-Pomorskie',102434);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2968,'Slupsk','POL','Pomorskie',102370);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (2918,'Braga','PRT','Braga',90535);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3018,'Bucuresti','ROM','Bukarest',2016131);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3019,'Iasi','ROM','Iasi',348070);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3020,'Constanta','ROM','Constanta',342264);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3021,'Cluj-Napoca','ROM','Cluj',332498);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3022,'Galati','ROM','Galati',330276);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3023,'Timisoara','ROM','Timis',324304);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3024,'Brasov','ROM','Brasov',314225);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3025,'Craiova','ROM','Dolj',313530);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3026,'Ploiesti','ROM','Prahova',251348);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3027,'Braila','ROM','Braila',233756);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3028,'Oradea','ROM','Bihor',222239);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3029,'Bacau','ROM','Bacau',209235);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3030,'Pitesti','ROM','Arges',187170);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3031,'Arad','ROM','Arad',184408);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3032,'Sibiu','ROM','Sibiu',169611);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3035,'Buzau','ROM','Buzau',148372);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3036,'Satu Mare','ROM','Satu Mare',130059);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3037,'Botosani','ROM','Botosani',128730);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3038,'Piatra Neamt','ROM','Neamt',125070);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3045,'Tulcea','ROM','Tulcea',96278);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3046,'Resita','ROM','Caras-Severin',93976);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3580,'Moscow','RUS','Moscow (City)',8389200);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3581,'St Petersburg','RUS','Pietari',4694000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3582,'Novosibirsk','RUS','Novosibirsk',1398800);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3583,'Nizni Novgorod','RUS','Nizni Novgorod',1357000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3584,'Jekaterinburg','RUS','Sverdlovsk',1266300);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3585,'Samara','RUS','Samara',1156100);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3586,'Omsk','RUS','Omsk',1148900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3587,'Kazan','RUS','Tatarstan',1101000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3591,'Perm','RUS','Perm',1009700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3592,'Volgograd','RUS','Volgograd',993400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3593,'Voronez','RUS','Voronez',907700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3594,'Krasnojarsk','RUS','Krasnojarsk',875500);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3595,'Saratov','RUS','Saratov',874000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3596,'Toljatti','RUS','Samara',722900);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3597,'Uljanovsk','RUS','Uljanovsk',667400);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3598,'Izevsk','RUS','Udmurtia',652800);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3599,'Krasnodar','RUS','Krasnodar',639000);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3600,'Jaroslavl','RUS','Jaroslavl',616700);
Insert into  CITY (ID,NAME,COUNTRYCODE,DISTRICT,POPULATION) values (3601,'Habarovsk','RUS','Habarovsk',609400);
REM INSERTING into  COUNTRY
SET DEFINE OFF;
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('ALB','Albania',28748,3401200,71.6,3205,34);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('AND','Andorra',468,78000,83.5,1630,55);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('AUT','Austria',83859,8091800,77.7,211860,1523);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('BEL','Belgium',30518,10239000,77.8,249704,179);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('BGR','Bulgaria',110994,8190900,70.9,12178,539);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('BIH','Bosnia and Herzegovina',51197,3972000,71.5,2841,201);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('BLR','Belarus',207600,10236000,68,13714,3520);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('CHE','Switzerland',41284,7160400,79.6,264478,3248);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('CZE','Czech Republic',78866,10278100,74.5,55017,3339);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('DEU','Germany',357022,82164700,77.4,2133367,3068);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('DNK','Denmark',43094,5330000,76.5,174099,3315);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('ESP','Spain',505992,39441700,78.8,553233,653);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('EST','Estonia',45227,1439200,69.5,5328,3791);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('FIN','Finland',338145,5171300,77.4,121914,3236);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('FRA','France',551500,59225700,78.8,1424285,2974);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('FRO','Faroe Islands',1399,43000,78.4,0,901);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('GBR','United Kingdom',242900,59623400,77.7,1378330,456);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('GIB','Gibraltar',6,25000,79,258,915);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('GRC','Greece',131626,10545700,78.4,120724,2401);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('HRV','Croatia',56538,4473000,73.7,20208,2409);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('HUN','Hungary',93030,10043200,71.4,48267,3483);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('IRL','Ireland',70273,3775100,76.8,75921,1447);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('ISL','Iceland',103000,279000,79.4,8255,1449);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('ITA','Italy',301316,57680000,79,1161755,1464);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('LIE','Liechtenstein',160,32300,78.8,1119,2446);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('LTU','Lithuania',65301,3698500,69.1,10692,2447);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('LUX','Luxembourg',2586,435700,77.1,16321,2452);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('LVA','Latvia',64589,2424200,68.4,6398,2434);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('MCO','Monaco',2,34000,78.8,776,2695);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('MDA','Moldova',33851,4380000,64.5,1579,2690);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('MKD','Macedonia',25713,2024000,73.8,1694,2460);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('MLT','Malta',316,380200,77.9,3512,2484);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('NLD','Netherlands',41526,15864000,78.3,371362,5);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('NOR','Norway',323877,4478500,78.7,145895,2807);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('POL','Poland',323250,38653600,73.2,151697,2928);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('PRT','Portugal',91982,9997600,75.8,105954,2914);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('ROM','Romania',238391,22455500,69.9,38158,3018);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('RUS','Russian Federation',17075400,146934000,67.2,276608,3580);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('SJM','Svalbard and Jan Mayen',62422,3200,null,0,938);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('SMR','San Marino',61,27000,81.1,510,3171);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('SVK','Slovakia',49012,5398700,73.7,20594,3209);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('SVN','Slovenia',20256,1987800,74.9,19756,3212);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('SWE','Sweden',449964,8861400,79.6,226492,3048);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('UKR','Ukraine',603700,50456000,66,42168,3426);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('VAT','Holy See (Vatican City State)',0,1000,null,9,3538);
Insert into  COUNTRY (CODE,NAME,SURFACEAREA,POPULATION,LIFEEXPECTANCY,GNP,CAPITAL) values ('YUG','Yugoslavia',102173,10640000,72.4,17000,1792);
REM INSERTING into  COUNTRYLANGUAGE
SET DEFINE OFF;
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ALB','Albaniana',97.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ALB','Greek',1.8);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ALB','Macedonian',0.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AND','Catalan',32.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AND','French',6.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AND','Portuguese',10.8);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AND','Spanish',44.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AUT','Czech',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AUT','German',92);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AUT','Hungarian',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AUT','Polish',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AUT','Romanian',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AUT','Serbo-Croatian',2.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AUT','Slovene',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('AUT','Turkish',1.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BEL','Arabic',1.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BEL','Dutch',59.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BEL','French',32.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BEL','German',1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BEL','Italian',2.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BEL','Turkish',0.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BGR','Bulgariana',83.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BGR','Macedonian',2.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BGR','Romani',3.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BGR','Turkish',9.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BIH','Serbo-Croatian',99.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BLR','Belorussian',65.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BLR','Polish',0.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BLR','Russian',32);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('BLR','Ukrainian',1.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CHE','French',19.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CHE','German',63.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CHE','Italian',7.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CHE','Romansh',0.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CZE','Czech',81.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CZE','German',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CZE','Hungarian',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CZE','Moravian',12.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CZE','Polish',0.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CZE','Romani',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CZE','Silesiana',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('CZE','Slovak',3.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DEU','German',91.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DEU','Greek',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DEU','Italian',0.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DEU','Polish',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DEU','Southern Slavic Languages',1.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DEU','Turkish',2.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DNK','Arabic',0.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DNK','Danish',93.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DNK','English',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DNK','German',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DNK','Norwegian',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DNK','Swedish',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('DNK','Turkish',0.8);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ESP','Basque',1.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ESP','Catalan',16.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ESP','Galecian',6.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ESP','Spanish',74.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('EST','Belorussian',1.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('EST','Estonian',65.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('EST','Finnish',0.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('EST','Russian',27.8);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('EST','Ukrainian',2.8);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FIN','Estonian',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FIN','Finnish',92.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FIN','Russian',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FIN','Saame',0);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FIN','Swedish',5.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FRA','Arabic',2.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FRA','French',93.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FRA','Italian',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FRA','Portuguese',1.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FRA','Spanish',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FRA','Turkish',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FRO','Danish',0);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('FRO','Faroese',100);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('GBR','English',97.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('GBR','Gaeli',0.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('GBR','Kymri',0.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('GIB','Arabic',7.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('GIB','English',88.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('GRC','Greek',98.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('GRC','Turkish',0.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('HRV','Serbo-Croatian',95.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('HRV','Slovene',0);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('HUN','German',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('HUN','Hungarian',98.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('HUN','Romani',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('HUN','Romanian',0.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('HUN','Serbo-Croatian',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('HUN','Slovak',0.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('IRL','English',98.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('IRL','Irish',1.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ISL','English',0);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ISL','Icelandic',95.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ITA','Albaniana',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ITA','French',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ITA','Friuli',1.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ITA','German',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ITA','Italian',94.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ITA','Romani',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ITA','Sardinian',2.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ITA','Slovene',0.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LIE','German',89);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LIE','Italian',2.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LIE','Turkish',2.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LTU','Belorussian',1.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LTU','Lithuanian',81.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LTU','Polish',7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LTU','Russian',8.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LTU','Ukrainian',1.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LUX','French',4.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LUX','German',2.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LUX','Italian',4.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LUX','Luxembourgish',64.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LUX','Portuguese',13);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LVA','Belorussian',4.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LVA','Latvian',55.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LVA','Lithuanian',1.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LVA','Polish',2.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LVA','Russian',32.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('LVA','Ukrainian',2.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MCO','English',6.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MCO','French',41.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MCO','Italian',16.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MCO','Monegasque',16.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MDA','Bulgariana',1.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MDA','Gagauzi',3.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MDA','Romanian',61.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MDA','Russian',23.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MDA','Ukrainian',8.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MKD','Albaniana',22.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MKD','Macedonian',66.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MKD','Romani',2.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MKD','Serbo-Croatian',2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MKD','Turkish',4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MLT','English',2.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('MLT','Maltese',95.8);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NLD','Arabic',0.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NLD','Dutch',95.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NLD','Fries',3.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NLD','Turkish',0.8);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NOR','Danish',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NOR','English',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NOR','Norwegian',96.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NOR','Saame',0);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('NOR','Swedish',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('POL','Belorussian',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('POL','German',1.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('POL','Polish',97.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('POL','Ukrainian',0.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('PRT','Portuguese',99);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ROM','German',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ROM','Hungarian',7.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ROM','Romani',0.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ROM','Romanian',90.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ROM','Serbo-Croatian',0.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('ROM','Ukrainian',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Avarian',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Bashkir',0.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Belorussian',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Chechen',0.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Chuvash',0.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Kazakh',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Mari',0.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Mordva',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Russian',86.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Tatar',3.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Udmur',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('RUS','Ukrainian',1.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SJM','Norwegian',0);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SJM','Russian',0);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SMR','Italian',100);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SVK','Czech and Moravian',1.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SVK','Hungarian',10.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SVK','Romani',1.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SVK','Slovak',85.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SVK','Ukrainian and Russian',0.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SVN','Hungarian',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SVN','Serbo-Croatian',7.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SVN','Slovene',87.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SWE','Arabic',0.8);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SWE','Finnish',2.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SWE','Norwegian',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SWE','Southern Slavic Languages',1.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SWE','Spanish',0.6);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('SWE','Swedish',89.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('UKR','Belorussian',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('UKR','Bulgariana',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('UKR','Hungarian',0.3);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('UKR','Polish',0.1);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('UKR','Romanian',0.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('UKR','Russian',32.9);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('UKR','Ukrainian',64.7);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('VAT','Italian',0);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('YUG','Albaniana',16.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('YUG','Hungarian',3.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('YUG','Macedonian',0.5);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('YUG','Romani',1.4);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('YUG','Serbo-Croatian',75.2);
Insert into  COUNTRYLANGUAGE (COUNTRYCODE,LANGUAGE,PERCENTAGE) values ('YUG','Slovak',0.7);


--------------------------------------------------------
--  Constraints for Table CITY
--------------------------------------------------------

  ALTER TABLE "CITY" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "CITY" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EMPTBLS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COUNTRY
--------------------------------------------------------

  ALTER TABLE "COUNTRY" MODIFY ("CODE" NOT NULL ENABLE);
  ALTER TABLE "COUNTRY" ADD PRIMARY KEY ("CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EMPTBLS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COUNTRYLANGUAGE
--------------------------------------------------------

  ALTER TABLE "COUNTRYLANGUAGE" MODIFY ("COUNTRYCODE" NOT NULL ENABLE);
  ALTER TABLE "COUNTRYLANGUAGE" MODIFY ("LANGUAGE" NOT NULL ENABLE);
  ALTER TABLE "COUNTRYLANGUAGE" ADD PRIMARY KEY ("COUNTRYCODE", "LANGUAGE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EMPTBLS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CITY
--------------------------------------------------------
  DELETE FROM CITY WHERE COUNTRYCODE NOT IN (SELECT CODE FROM COUNTRY);
  COMMIT ;
  ALTER TABLE "CITY" ADD CONSTRAINT "FK_CITY_COUNTRY_CODE" FOREIGN KEY ("COUNTRYCODE")
	  REFERENCES "COUNTRY" ("CODE") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COUNTRYLANGUAGE
--------------------------------------------------------
  DELETE FROM COUNTRYLANGUAGE WHERE COUNTRYCODE NOT IN (SELECT CODE FROM COUNTRY);
  COMMIT ;

  ALTER TABLE "COUNTRYLANGUAGE" ADD CONSTRAINT "FK_CL_COUNTRY_CODE" FOREIGN KEY ("COUNTRYCODE")
	  REFERENCES "COUNTRY" ("CODE") ENABLE;

commit;





