create or replace procedure Update_User1()
language sql as $$
lock table Summer_Practice.Users in row exclusive mode;
update Summer_Practice.Users
set Credit=Credit+5
where User_Id=3;
select pg_sleep(20);$$
call Update_User1();