CREATE TABLE tbl_board (
	seqno NUMBER NOT NULL,
	writer NVARCHAR2(50) NOT NULL,
	title NVARCHAR2(200) NOT NULL,
	content NVARCHAR2(2000) NOT NULL,
	regdate DATE NOT NULL,
	userid VARCHAR2(50) NOT NULL,
	hitno NUMBER NULL,
	likecnt NUMBER NULL,
	dislikecnt NUMBER NULL,
	CONSTRAINT pk_tbl_board PRIMARY KEY (seqno) 
);

CREATE SEQUENCE TBL_BOARD_SEQ
	INCREMENT BY 1
	START WITH 1 
	NOCYCLE NOCACHE NOORDER;

CREATE TABLE tbl_file (
	fileseqno NUMBER NOT NULL,
	seqno NUMBER NOT NULL,
	org_filename NVARCHAR2(200) NOT NULL ,
	stored_filename VARCHAR2(200) NOT NULL ,
	filesize NUMBER NOT NULL,
	userid VARCHAR2(50) NOT NULL ,
	checkfile VARCHAR2(2) NOT NULL ,
	CONSTRAINT pk_tbl_file PRIMARY KEY (fileseqno)
);

CREATE SEQUENCE TBL_FILE_SEQ
	INCREMENT BY 1
	START WITH 1 
	NOCYCLE NOCACHE NOORDER;

CREATE TABLE tbl_like (
	seqno NUMBER NOT NULL,
	userid VARCHAR2(50) NOT NULL ,
	mylikecheck CHAR(1) NULL ,
	mydislikecheck CHAR(1) NULL ,
	likedate VARCHAR2(50) NULL ,
	dislikedate VARCHAR2(50) NULL ,
	CONSTRAINT pk_tbl_like PRIMARY KEY (seqno, userid)
);

CREATE SEQUENCE TBL_LIKE_SEQ
	INCREMENT BY 1 
	START WITH 1 
	NOCYCLE NOCACHE NOORDER;


CREATE TABLE tbl_member (
	userid VARCHAR2(50) NOT NULL ,
	username NVARCHAR2(50) NOT NULL ,
	password VARCHAR2(200) NOT NULL ,
	telno VARCHAR2(20) NOT NULL ,
	email VARCHAR2(20) NOT NULL ,
    gender NVARCHAR2(20) NOT NULL,
    hobby NVARCHAR2(20) NOT NULL,
    job NVARCHAR2(20) NOT NULL,
    description NVARCHAR2(200) NOT NULL,
	zipcode VARCHAR2(10) NOT NULL,
	address NVARCHAR2(200) NOT NULL,
	regdate DATE NOT NULL ,
	lastlogindate DATE NULL,
	lastlogoutdate DATE NULL,
	lastpwdate DATE NULL,
	lastpwcheckdate DATE NULL,
	pwcheck NUMBER NULL,
	role VARCHAR2(50) NOT NULL ,
	org_filename NVARCHAR2(200) NULL ,
	stored_filename VARCHAR2(200) NULL ,
	filesize NUMBER NULL,
    authkey VARCHAR2(200) NULL,
	CONSTRAINT pk_tbl_member PRIMARY KEY (userid)
);

CREATE TABLE tbl_member_log (
	userid VARCHAR2(50) NOT NULL ,
	inouttime DATE NOT NULL ,
	status VARCHAR2(10) NULL ,
	CONSTRAINT pk_tbl_member_log PRIMARY KEY (userid, inouttime)
);

CREATE TABLE tbl_reply (
	replyseqno NUMBER NOT NULL,
	seqno NUMBER NOT NULL,
	replywriter NVARCHAR2(200) NOT NULL ,
	replycontent NVARCHAR2(200) NOT NULL ,
	replyregdate DATE NOT NULL,
	userid VARCHAR2(50) NOT NULL,
	CONSTRAINT pk_tbl_reply PRIMARY KEY (replyseqno)
);

CREATE SEQUENCE TBL_REPLY_SEQ
	INCREMENT BY 1
	START WITH 1 
	NOCYCLE NOCACHE NOORDER;

alter table tbl_like add constraint fk_tbl_like_seqno 
	foreign key(seqno) REFERENCES TBL_board(seqno) on delete cascade ;
alter table tbl_reply add constraint fk_tbl_reply_seqno 
	foreign key(seqno) REFERENCES TBL_board(seqno) on delete cascade ;

alter table tbl_board add constraint fk_tbl_board_userid 
	foreign key(userid) REFERENCES TBL_member(userid) on delete cascade ;
alter table tbl_file add constraint fk_tbl_file_userid 
	foreign key(userid) REFERENCES TBL_member(userid) on delete cascade ;
alter table tbl_like add constraint fk_tbl_like_userid 
	foreign key(userid) REFERENCES TBL_member(userid) on delete cascade ;
alter table tbl_reply add constraint fk_tbl_reply_userid 
	foreign key(userid) REFERENCES TBL_member(userid) on delete cascade ;
alter table tbl_member_log add constraint fk_tbl_member_log_userid 
	foreign key(userid) REFERENCES TBL_member(userid) on delete cascade;