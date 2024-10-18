create table tbl_cart (
	cart_id number not null,
	cart_email varchar2(50) not null,
	p_id number not null,
	cart_quantity number not null,
	cart_regdate date not null,
	cart_status char(2) not null,
	invoice char(6) null,
	constraint pk_tbl_cart primary key(cart_id)
);

create sequence tbl_cart_seq
	increment by 1
	start with 1 
	nocycle nocache noorder;

create table tbl_like (
	like_id number not null,
	like_email varchar2(20) not null,
	p_id varchar2(20) not null,
	like_regdate date not null,
	constraint pk_tbl_like primary key(like_id)
);

create sequence tbl_like_seq
	increment by 1
	start with 1 
	nocycle nocache noorder;

create table tbl_member (
	email varchar2(50) not null,
	username varchar2(50) not null,
	password varchar2(200) not null,
	regdate date not null,
	role varchar2(20) not null,
	telno varchar2(20) not null,
	zipcode varchar2(6) not null,
	address varchar2(200) not null,
	authkey varchar2(200) null,
	constraint pk_tbl_member primary key(email)
);

create table tbl_member_log (
	log_id number not null,
	email varchar2(50) not null,
	log_status varchar2(20) not null,
	log_regdate date not null,
	constraint pk_tbl_member_log primary key(log_id)
);

create sequence tbl_member_log_seq
	increment by 1
	start with 1 
	nocycle nocache noorder;

create table tbl_order (
	order_id char(6) not null,
	cart_id number not null,
	p_id number not null,
	order_email varchar2(20) not null,
	order_quantity number not null,
	order_price number not null,
	order_status char(2) not null,
	order_regdate date not null,
	constraint pk_tbl_order primary key(order_id,cart_id)
);

create table tbl_order_info (
	order_id char(6) not null,
	p_name varchar2(200) not null,
	order_email varchar2(20) not null,
	order_name varchar2(50) not null,
	order_quantity number not null,
	order_amount number not null,
	order_status char(2) not null,
	order_regdate date not null,
	rv_zipcode varchar2(6) not null,
	rv_address varchar2(200) not null,
	rv_name varchar2(50) not null,
	rv_telno varchar2(20) not null,
	rv_email varchar2(50) not null,
	constraint pk_tbl_order_info primary key(order_id)
);

create table tbl_order_info_rv_addr (
	rv_id number not null,
	order_email varchar2(50) not null,
	rv_zipcode varchar2(6) not null,
	rv_address varchar2(200) not null,
	rv_name varchar2(50) not null,
	rv_telno varchar2(20) not null,
	rv_email varchar2(50) not null,
	constraint pk_tbl_order_info_rv_addr primary key(rv_id)
);

create sequence tbl_order_info_rv_addr_seq
	increment by 1
	start with 1 
	nocycle nocache noorder;

create table tbl_order_info_product (
	order_id char(6) not null,
	p_id number not null,
	order_price number not null,
	order_quantity number not null,
	constraint pk_tbl_order_info_product primary key(order_id,p_id)
);

create table tbl_order_status (
	order_status_id char(2) not null,
	order_status_name varchar2(20) not null,
	constraint pk_tbl_order_status primary key(order_status_id)
);

/*
00 : 장바구니
01 : 주문서작성중
02 : 주문요청
03 : 배송중
04 : 배송완료
05 : 주문확정
06 : 주문취소
07 : 반품요청
08 : 반품중
09 : 반품완료
*/

insert into tbl_order_status (order_status_id,order_status_name) values ('00', '장바구니');
insert into tbl_order_status (order_status_id,order_status_name) values ('01', '주문서작성중');
insert into tbl_order_status (order_status_id,order_status_name) values ('02', '주문요청');
insert into tbl_order_status (order_status_id,order_status_name) values ('03', '배송중');
insert into tbl_order_status (order_status_id,order_status_name) values ('04', '배송완료');
insert into tbl_order_status (order_status_id,order_status_name) values ('05', '주문확정');
insert into tbl_order_status (order_status_id,order_status_name) values ('06', '주문취소');
insert into tbl_order_status (order_status_id,order_status_name) values ('07', '반품요청');
insert into tbl_order_status (order_status_id,order_status_name) values ('08', '반품중');
insert into tbl_order_status (order_status_id,order_status_name) values ('09', '반품완료');
commit;

create table tbl_product (
	p_id number not null,
	p_name varchar2(200) not null,
	p_manufacturer varchar2(200) not null,
	p_price number not null,
	p_stock number not null,
	p_description varchar2(2000) not null,
	p_org_image varchar2(200) not null,
	p_stored_image varchar2(200) not null,
	p_regdate date not null,
	p_status char(1) not null,
	constraint pk_tbl_product primary key(p_id)
);

create sequence tbl_product_seq
	increment by 1
	start with 1 
	nocycle nocache noorder;

Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'나이키 에어포스','나이키',105000,102,'좋은 신발. 푹신한 신발...','나이키에어포스1.png','d1f89ebbe74b4dcc80f143a0e9589933.png',to_date('23/01/20','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'아디다스  NMD V3','아디다스',145000,98,'가볍고 예뻐요~~~','아디다스_NMD_V3.png','e65f819ff1ea41209f7830fe810125a3.png',to_date('23/01/27','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'아디다스 슈퍼스타82','아디다스',115000,99,'발이 편해요.
2023년 새 모델...','아디다스_슈퍼스타82.png','e635cb06e6ae4eacb0b4773803802531.png',to_date('23/01/27','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'아디다스 포럼 로우','아디다스',145600,99,'좋은 신발
예쁜 신발
편한 신발','아디다스_포럼_로우.png','e1bd745b2bd346feb2c4ef34ca8f2012.png',to_date('23/01/27','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'언더아머 UA HOVR 소닉5','언더아머',137000,96,'세련된 디자인','언더아머_UA_HOVR_소닉5.png','7fffff859fa34bb8ad0f9d4ed15f09a5.png',to_date('23/01/27','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'언더아머 UA HOVR 팬텀3','언더아머',118000,100,'좋은 신발
2023년 신상...','언더아머_UA_HOVR_팬텀3.png','9ef44f7f3e0548ce913f6b9fd1241f70.png',to_date('23/01/27','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'언더아머 커리플로우 코지','언더아머',167000,99,'고급 운동화','언더아머_커리_플로우_코지.png','9178e447445142e282acc693ed1c8a6a.png',to_date('23/01/27','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'오니츠카 타이거 세라노 D109L-0142','오니츠카 타이거',145000,93,'세련된 신발.
양아치 신발 ...
그렇지만 좋은 신발...','세라노 D109L-0142.png','d2e6bcd924984edf833bcac076269c44.png',to_date('23/01/28','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'나이키 덩크 로우','나이키',139000,93,'나이키 덩크 로우 2023 신상품...
신발 사이즈 270','나이키덩크로우SE.png','7e96dca67a9c45b882b4f5e739832afb.png',to_date('23/01/17','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'나이키 덩크 로우 레트로','나이키',129000,87,'나이키 덩크 로우 레트로 2023 신상품.
신발 사이즈 275','나이키덩크로우레트로.png','70c9232da7fb4392965a983be2b95a4f.png',to_date('23/01/17','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'나이키 에어맥스 테라스케이프플러스','나이키',123000,0,'푹신푹신해요...','나이키에어맥스테라스케이프플러스.png','30e91862caa0469c8a3a305b04b0ca65.png',to_date('23/01/22','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'나이키 에어조던6 레트로','나이키',154000,99,'발이 편해요.
2023 신상...','에어조던6레트로.png','61206371e5654fac848517e42326e879.png',to_date('23/01/22','RR/MM/DD'),'O');
Insert into SHOPMASTER.TBL_PRODUCT (P_ID,P_NAME,P_MANUFACTURER,P_PRICE,P_STOCK,P_DESCRIPTION,P_ORG_IMAGE,P_STORED_IMAGE,P_REGDATE,P_STATUS) values (tbl_product_seq.nextval,'나이키 P-6000','나이키',98000,0,'조깅하기 좋아요.
발이 편해요.','나이키P-6000.png','e724e4b52ab9449681e7ce9e5df75c88.png',to_date('23/01/22','RR/MM/DD'),'O');
commit;












	