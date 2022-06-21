create schema Summer_Practice;
drop table Summer_Practice.Users;
create table Summer_Practice.Users(User_Id serial primary key,
								  First_name varchar(20),
								  Last_name varchar(20),
								  Login varchar(20),
								  Passw varchar(20),
								  Age int);
create index index_id on Test_index(Id);
create table Test_index(Id int);
drop table Test_index2;
create table Test_index2
as (Select *
   from Test_index);
create index index_func on Test_index3(UPPER(Name));
drop table Test_index3;
create table Test_index3(Name varchar(20));
drop table Test_index4;
create table Test_index4
as (Select *
   from Test_index3);
drop table test_tab;
create table SUmmer_Practice.test_tab(id int, flag boolean, Name varchar(20));
drop table test_tab2;
create table SUmmer_Practice.test_tab2(id1 int, id2 int, flag1 boolean, flag2 boolean, Name1 varchar(10), Name2 varchar(20));
create table Summer_Practice.Func_tab(Id int, Name varchar(20), BirthDate date);