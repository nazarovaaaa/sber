create schema Summer_Practice;
create table Summer_Practice.Users(User_Id serial primary key,
								  First_name varchar(20),
								  Last_name varchar(20),
								  Login varchar(20),
								  Passw varchar(20),
								  Age int);
drop table Summer_Practice.Users;
create table Test_index(Id int);
create index index_id on Test_index(Id);
create table Test_index3(Name varchar(20));
create index index_func on Test_index3(UPPER(Name));
create function Fil_cur_tab1() returns void as $$
declare
	col1 varchar(20);
	col2 varchar(20);
	col3 varchar(20);
	col4 varchar(20);
	col5 integer;
begin
	for j in 1..10 loop
			col1:='';
			col2:='';
			col3:='';
			col4:='';
			col5:=1;
			for i in 1..20 loop
				col1=col1||chr(ascii('A')+cast(random()*95 as integer));
			end loop;
			for i in 1..20 loop
				col2=col2||chr(ascii('A')+cast(random()*95 as integer));
			end loop;
			for i in 1..20 loop
				col3=col3||chr(ascii('A')+cast(random()*95 as integer));
			end loop;
			for i in 1..20 loop
				col4=col4||chr(ascii('A')+cast(random()*95 as integer));
			end loop;
			col5=col5*floor(random()*100);
	insert into Summer_Practice.Users(First_name, Last_name,Login,
									 Passw,Age)
	values (col1,col2,col3,col4,col5);
	end loop;
end;
$$ language 'plpgsql' volatile;
drop function Fil_cur_tab1;
select Fil_cur_tab1();
select *
from Summer_Practice.Users;
create function Fil_cur_tab2() returns void as $$
declare
	col1 varchar(20);
	col2 varchar(20);
	col3 varchar(20);
	col4 varchar(20);
	col5 integer;
	mas1 varchar(20) array[4];
	mas2 varchar(20) array[4];
	mas3 varchar(20) array[4];
	mas4 varchar(20) array[4];
	mas5 integer array[4];
begin
	mas1:='{"Artem", "Alexey", "Ivan", "Peter"}';
	mas2:='{"Ivanov", "Petrov", "Sidorov", "Konstantinov"}';
	mas3:='{"12345", "23456", "1as2", "1119l"}';
	mas4:='{"1sjdjgn", "so4o94g", "dsgmkg", "4942sk"}';
	mas5:='{15,28,42,59}';
	for j in 1..5 loop
			col1:=mas1[cast(random()*3 as integer)+1];
			col2:=mas2[cast(random()*3 as integer)+1];
			col3:=mas3[cast(random()*3 as integer)+1];
			col4:=mas4[cast(random()*3 as integer)+1];
			col5:=mas5[cast(random()*3 as integer)]+1;
			insert into Summer_Practice.Users(First_name, Last_name,Login,
									 		Passw,Age)
			values (col1,col2,col3,col4,col5);
	end loop;
end;
$$ language 'plpgsql' volatile;
drop function Fil_cur_tab2;
select Fil_cur_tab2();
select *
from Summer_Practice.Users;
create table Summer_Practice.Func_tab(Id int, Name varchar(20), BirthDate date);
insert into Summer_Practice.Func_tab
values (1,'Artem',to_date('01-01-2001','dd-mm-yyyy'));
insert into Summer_Practice.Func_tab
values (2,'Ivan',to_date('05-03-2002','dd-mm-yyyy'));
insert into Summer_Practice.Func_tab
values (3,'Peter',to_date('08-09-2004','dd-mm-yyyy'));
insert into Summer_Practice.Func_tab
values (4,'Sergey',to_date('17-02-2009','dd-mm-yyyy'));
select *
from Summer_Practice.Func_tab;
create function Summer_Practice.Cr_tab1()
returns table(id int, name varchar(20), birthdate date) as $$
declare
	cur RECORD;
BEGIN
	for cur in execute 'select * from Summer_Practice.Func_tab where Id in (2,4)' loop
		id=cur.id;
		name=cur.name;
		birthdate=cur.birthdate;
		return next;
	end loop;
end;
$$ language 'plpgsql' volatile;
drop function Summer_Practice.Cr_tab1();
select *
from Summer_Practice.Cr_tab1();
create function Summer_Practice.Cr_tab2(int)
returns table(id int, name varchar(20), birthdate date) as $$
declare
	cur RECORD;
	csr cursor for select * from func($1);
BEGIN
	for cur in csr loop
		id=cur.id;
		name=cur.name;
		birthdate=cur.birthdate;
		return next;
	end loop;
end;
$$ language 'plpgsql' volatile;
drop function Summer_Practice.Cr_tab2(int);
select *
from Summer_Practice.Cr_tab2(1);
create function func(int) 
returns table(id int, name varchar(20), birthdate date) as $$
select *
from Summer_Practice.Func_tab
where Id in ($1,$1+2);
$$ language 'sql' volatile;

