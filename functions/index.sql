drop function Gnt_num;
drop function Gnt_text;
create function Gnt_text() returns varchar(20) as $$--генерация текста
declare
	len varchar(20);
begin
	len :='';
	for i in 1..20 loop
		len=len||chr(ascii('A')+cast(random()*95 as integer));
	end loop;
	return len;
end;
$$ language 'plpgsql' volatile;

create function Gnt_num() returns integer as $$--генерация чисел
declare
	sum integer;
begin
	sum :=1;
	sum=sum*floor(random()*100);
	return sum;
end;
$$ language 'plpgsql' volatile;
drop function Fil_cur_tab1;
create function Fil_cur_tab1() returns void as $$--заполнение таблицы 1 пункт
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
drop function Fil_cur_tab2;
create function Fil_cur_tab2() returns void as $$--заполнение таблицы 2 пункт
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
drop function Summer_Practice.Cr_tab1();
create function Summer_Practice.Cr_tab1()--функция возврата таблицы 1
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
drop function Summer_Practice.Cr_tab2(int);
create function Summer_Practice.Cr_tab2(int)--функция возврата таблицы 2(чеез курсоры)
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
create function func(int) 
returns table(id int, name varchar(20), birthdate date) as $$--функция возврата таблицы для установки курсора
select *
from Summer_Practice.Func_tab
where Id in ($1,$1+2);
$$ language 'sql' volatile;
drop function Summer_Practice.ret_nm_len;
create function Summer_Practice.ret_nm_len(varchar(20))--функция возврата данных о столбцах таблицы
returns table(column_name text, type text) as $$
select column_name,data_type
from information_schema.columns
where table_name=$1;
$$ language 'sql' volatile;
select * 
from Summer_Practice.ret_nm_len('test_tab');

drop function Summer_Practice.Main_func;
create function Summer_Practice.Main_func(text, int)--функция заполнения таблицы пункт 3
returns void as $$
declare
	crs cursor for select * from Summer_Practice.ret_nm_len($1);
	tmp record;
	answer text;
	flag int;
begin
	for i in 1..$2 loop
		answer:='Insert into Summer_Practice.'||$1||' values (';
		flag:=0;
		for tmp in crs loop
			if tmp.type='integer' then answer=answer||cast(random()*10 as integer)||', '; end if;
			if tmp.type='character varying' then answer=answer||''''||chr(ascii('A')+cast(random()*95 as integer))||''', '; end if; 
			if tmp.type='boolean' then
				flag:=cast(random() as integer);
				if flag=0 then answer=answer||'false, '; end if;
				if flag=1 then answer=answer||'true, '; end if; end if;
		end loop;
		answer=substring(answer for char_length(answer)-2)||')';
		EXECUTE answer;
	end loop;
end;
$$ language 'plpgsql' volatile;