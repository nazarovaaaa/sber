alter table Summer_Practice.Users
add column Credit int;
alter table Summer_Practice.Users
add column Department int;
update Summer_Practice.Users
set Department=User_Id;
update Summer_Practice.Users
set Credit=cast(('1.'||department) as float) * 100;

create procedure Update_Proc_1()
language sql  as $$
alter table Summer_Practice.Users
add column Credit int;
alter table Summer_Practice.Users
add column Department int;
update Summer_Practice.Users
set Department=User_Id;
update Summer_Practice.Users
set Credit=cast(('1.'||department) as float) * 100;$$