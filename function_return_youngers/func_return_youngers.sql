create or replace function func_return_younger(integer)
returns text as $$
declare
	crs cursor for WITH RECURSIVE temp1 (User_Id, Admin_Id, PATH, LEVEL) as
					(Select User_Id, Admin_Id,cast (User_Id as varchar(50)) as Path,1
					from Summer_Practice.test_level_tab T1 where User_Id=$1
					union
					Select T2.User_Id,T2.Admin_Id,cast(temp1.PATH||'->'||T2.User_Id as varchar(50)), LEVEL+1
					from Summer_Practice.test_level_tab T2 inner join temp1 on (temp1.User_Id=T2.Admin_Id))
					Select *
					from temp1
					order by level desc;
	tmp record;
	answer text='';
begin
	for tmp in crs loop
		if position(tmp.path in answer)=0 then
			answer=answer||tmp.path||', '; 
		end if;
	end loop;
	while position('->' in answer)!=0 loop
		answer=regexp_replace(answer,'\d*->','');
	end loop;
	return substring(answer,1,length(answer)-2);
end;
$$ language 'plpgsql';