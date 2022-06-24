create or replace function func_return_elders(int)
returns text as $$
declare
	crs cursor for WITH RECURSIVE temp1 (User_Id, Admin_Id, PATH, LEVEL) as
					(Select User_Id, Admin_Id,cast ('' as varchar(50)) as Path,1
					from Summer_Practice.test_level_tab T1 where User_Id=$1
					union
					Select T2.User_Id,T2.Admin_Id,cast(temp1.PATH||'->'||T2.User_Id as varchar(50)), LEVEL+1
					from Summer_Practice.test_level_tab T2 inner join temp1 on (temp1.Admin_Id=T2.User_Id))
					Select substring(replace(PATH,'->',', '),3) Answer
					from temp1
					order by Level desc limit 1;
	tmp record;
	answer text='';
begin
	for tmp in crs loop
		answer=answer||tmp.Answer;
	end loop;
	return answer;
end;
$$ language 'plpgsql';