use webdev;
create user 'webmaster'@'%' identified by '12345';
grant all privileges on webdev.* to 'webmaster'@'%';