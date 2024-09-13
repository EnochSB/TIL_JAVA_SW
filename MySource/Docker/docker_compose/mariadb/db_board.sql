create table tbl_board (
    seqno int not null auto_increment,
    writer varchar(50) not null,
    title varchar(200) not null,
    regdate timestamp not null default current_timestamp(),
    content text not null,
    primary key(seqno)
);