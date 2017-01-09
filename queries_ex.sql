use ex;
select * from ex.departments;
delete from ex.departments where department_number=6;
insert into ex.departments value (6, 'Production');
replace into ex.departments value (6, 'Production');
create view v as SELECT employee_id, last_name, first_name, department_name FROM ex.employees a, ex.departments b where a.department_number = b.department_number;
select * from ex.v;
drop view ex.v