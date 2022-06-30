create or replace procedure Update_User_Table(integer,integer)
language sql as $$
lock table Summer_Practice.Users in row exclusive mode;
update Summer_Practice.Users
set Credit=Credit+Credit*$2/100
where User_Id=$1;
select pg_sleep(20);$$