create database test;
use test;
create table dep (
   product_name varchar(11) NOT NULL DEFAULT ''
);
insert into dep values ('gogo');
insert into dep values ('uiop');
insert into dep values ('bnmj');
insert into dep values ('ghjk');
insert into dep values ('tyui');
insert into dep values ('zxcv');
insert into dep values ('qwer');
insert into dep values ('asdf');

CREATE USER 'tester'@'%'
   IDENTIFIED BY 'goodPass$123';
GRANT ALL on *.* TO 'tester'@'%';
