create pluggable database springpdb admin user springadmin identified by 12345 roles=(dba) file_name_convert = ('pdbseed','springpdb') ;

alter pluggable database springpdb open read write; 
alter pluggable database springpdb save state ;

alter session set container = "springpdb";  
grant resource, dba to springadmin; 

conn springadmin/12345@localhost/springpdb as sysdba 
create tablespace springtbls 
datafile 'c:\oracle\data\springtbls.dbf' size 64M autoextend on; 

create user springdev identified by 12345 default tablespace springtbls ;
alter user springdev quota unlimited on springtbls ;
grant connect, resource, dba to springdev ;


connect springdev/12345@localhost/springpdb
