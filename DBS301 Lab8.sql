set pagesize 100;
set linesize 500;

select department_id
from departments
MINUS
select department_id
from employees
where JOB_ID = 'ST_CLERK';


select country_id,COUNTRY_NAME,to_number(null)
from countries
minus
(select country_id,to_char(null),location_id
from locations 
minus
select to_char(null),to_char(null),location_id
from departments)


select employee_id, job_id
from employees
INTERSECT
select employee_id,job_id
from job_history;

select department_id, job_id
from employees
UNION ALL
select department_id,job_id
from employees
where department_id=10
union all
select department_id,job_id
from employees
where department_id=50
union all
select department_id,job_id
from employees
where department_id=20




select last_name,department_id
from employees 
union all
select to_char(null),department_id
from departments;

