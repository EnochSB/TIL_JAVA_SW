/* 1. 임시테이블 생성
우편번호	
시도	
시군구	
읍면	
도로명	
건물번호본번	
건물번호부번	
시군구용건물명	
법정동명	
리명	
지번본번	
지번부번
*/
-- mariadb
CREATE TABLE IF NOT EXISTS tbl_tmp_addr (
	zipcode VARCHAR(50) NULL ,
	sido VARCHAR(50) NULL , 
	gungu VARCHAR(50) NULL , 
	eupmyun VARCHAR(50) NULL , 
	road VARCHAR(100) NULL , 
	buildingno1 VARCHAR(50) NULL , 
	buildingno2 VARCHAR(50) NULL , 
	buildingname VARCHAR(100) NULL , 
	dong VARCHAR(50) NULL , 
	ri VARCHAR(50) NULL , 
	beongi1 VARCHAR(50) NULL , 
	beongi2 VARCHAR(50) NULL  
);

-- oracle
CREATE TABLE tbl_tmp_addr (
	zipcode VARCHAR2(50) NULL ,
	sido VARCHAR2(50) NULL , 
	gungu VARCHAR2(50) NULL , 
	eupmyun VARCHAR2(50) NULL , 
	road VARCHAR2(100) NULL , 
	buildingno1 VARCHAR2(50) NULL , 
	buildingno2 VARCHAR2(50) NULL , 
	buildingname VARCHAR2(100) NULL , 
	dong VARCHAR2(50) NULL , 
	ri VARCHAR2(50) NULL , 
	beongi1 VARCHAR2(50) NULL , 
	beongi2 VARCHAR2(50) NULL  
);

-- 2. 데이터 IMPORT 
-- mariadb
load data local infile 'c:\\myTemp\\서울특별시.csv' into table tbl_tmp_addr fields terminated by ',' lines terminated by '\n';

-- 3. 업무용 테이블 만들기
-- oracle
create table tbl_addr(
	seqno number not null,
	zipcode varchar2(10) null,
	province varchar2(50) null,
	road varchar2(200) null,
	building varchar2(200) null,
	oldaddr varchar2(200) null,
	constraint pk_tbl_addr primary key(seqno)
);

CREATE SEQUENCE TBL_ADDR_SEQ
	INCREMENT BY 1
	START WITH 1 
	NOCYCLE NOCACHE NOORDER;

-- mariadb
create table tbl_addr(
	seqno int not null AUTO_INCREMENT,
	zipcode varchar(10) null,
	province varchar(50) null,
	road varchar(200) null,
	building varchar(200) null,
	oldaddr varchar(200) null,
	constraint pk_tbl_addr primary key(seqno)
);

--4. 임시용 테이블에서 업무용 테이블로 데이터 이관
-- mariadb 
INSERT INTO tbl_addr (zipcode,province,road,building,oldaddr)  
	select 
	zipcode, 
	concat(sido, ' ', gungu,' ',if(eupmyun='','',eupmyun)) AS province,
   	concat(road,' ',IF(buildingno1=0,'',buildingno1),IF(buildingno2=0,'',concat('-',buildingno2))) AS road,
	CONCAT('(',if(dong='',ri,dong),if(buildingname='','',CONCAT(',',buildingname)),')') AS building, 
	CONCAT(sido,' ',gungu,' ',if(eupmyun='','',eupmyun),' ',if(dong='',ri,dong),' ',beongi1,if(beongi2=0,'',concat('-',beongi2)), ' ',
	if(buildingname='','',CONCAT('(',buildingname,')')))  AS oldaddr 
	FROM tbl_tmp_addr ;

-- oracle 
INSERT INTO tbl_addr (seqno,zipcode,province,road,building,oldaddr)  
	select 
	tbl_board_seq.nextval,
	zipcode, 
	sido||' '||gungu||' '||nvl(eupmyun,' ') AS province,
   	road||' '||decode(buildingno1,0,'',buildingno1)||decode(buildingno2,0,'','-'||buildingno2) AS road,
    	'('||decode(dong,'',ri,dong)||decode(buildingname,'','',','||buildingname)||')' as building,
    	sido||' '||gungu||' '||decode(eupmyun,'','',eupmyun)||' '||decode(dong,'',ri,dong)||' '||beongi1||decode(beongi2,0,'','-'||beongi2)||
        	decode(buildingname,'','','('||buildingname||')') as oldaddr
    	from tbl_tmp_addr;
commit;