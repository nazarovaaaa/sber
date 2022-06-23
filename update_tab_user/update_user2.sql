create or replace procedure Update_User2()
language sql as $$
update Summer_Practice.Users
set Credit=Credit+10
where User_Id=3;
select pg_sleep(15);$$
call Update_User2();