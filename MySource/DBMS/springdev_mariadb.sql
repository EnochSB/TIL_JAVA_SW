CREATE TABLE IF NOT EXISTS tbl_board (
	seqno INT NOT NULL AUTO_INCREMENT ,
	writer VARCHAR(50) NOT NULL,
	title VARCHAR(200) NOT NULL,
	content TEXT NOT NULL,
	regdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ,
	userid VARCHAR(50) NOT NULL,
	hitno INT NULL,
	likecnt INT NULL,
	dislikecnt INT NULL,
	PRIMARY KEY (seqno) 
);

CREATE TABLE IF NOT EXISTS tbl_file (
	fileseqno INT NOT NULL AUTO_INCREMENT,
	seqno INT NOT NULL,
	org_filename VARCHAR(200) NOT NULL ,
	stored_filename VARCHAR(200) NOT NULL ,
	filesize INT NOT NULL,
	userid VARCHAR(50) NOT NULL ,
	checkfile VARCHAR(2) NOT NULL ,
	PRIMARY KEY (fileseqno)
);


CREATE TABLE IF NOT EXISTS tbl_like (
	seqno INT NOT NULL,
	userid VARCHAR(50) NOT NULL,
	mylikecheck CHAR(1) NULL,
	mydislikecheck CHAR(1) NULL,
	likedate VARCHAR(50) NULL,
	dislikedate VARCHAR(50) NULL,
	PRIMARY KEY (seqno, userid)
);


CREATE TABLE IF NOT EXISTS tbl_member (
	userid VARCHAR(50) NOT NULL ,
	username VARCHAR(200) NOT NULL,
	password VARCHAR(200) NOT NULL,
	telno VARCHAR(20) NOT NULL,
	email VARCHAR(20) NOT NULL,
            gender VARCHAR(20) NOT NULL,
        	hobby VARCHAR(200) NOT NULL,
        	job VARCHAR(20) NOT NULL,
        	description VARCHAR(200) NOT NULL,
	zipcode VARCHAR(10) NOT NULL,        
	address VARCHAR(200) NOT NULL,
	regdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	lastlogindate TIMESTAMP NULL,
	lastlogoutdate TIMESTAMP NULL,
	lastpwdate TIMESTAMP NULL,
	pwcheck INT NULL DEFAULT '0',
	role VARCHAR(50) NOT NULL ,
	org_filename VARCHAR(50) NULL ,
	stored_filename VARCHAR(50) NULL ,
	filesize INT NULL,
        authkey VARCHAR(200) NULL,
	PRIMARY KEY (userid)
);

CREATE TABLE IF NOT EXISTS tbl_member_log (
	userid VARCHAR(50) NOT NULL ,
	inouttime TIMESTAMP NOT NULL ,
	status VARCHAR(10) NULL ,
	PRIMARY KEY (userid, inouttime)
);


CREATE TABLE IF NOT EXISTS tbl_reply (
	replyseqno INT NOT NULL AUTO_INCREMENT,
	seqno INT NOT NULL,
	replywriter VARCHAR(200) NOT NULL ,
	replycontent VARCHAR(200) NOT NULL ,
	replyregdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	userid VARCHAR(50) NOT NULL,
	PRIMARY KEY (replyseqno)
);

alter table tbl_board add constraint fk_tbl_board_userid foreign key(userid) references tbl_member(userid) on delete CASCADE;
alter table tbl_member_log add constraint fk_tbl_member_log_userid foreign key(userid) references tbl_member(userid) on delete CASCADE;
alter table tbl_reply add constraint fk_tbl_reply_seqno foreign key(seqno) references tbl_board(seqno) on delete CASCADE;
alter table tbl_file add constraint fk_tbl_file_seqno foreign key(seqno) references tbl_board(seqno) on delete CASCADE;
alter table tbl_like add constraint fk_tbl_like_seqno foreign key(seqno) references tbl_board(seqno) on delete CASCADE;
