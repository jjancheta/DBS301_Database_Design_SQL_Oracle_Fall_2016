SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOB_HISTORY;

SET pagesize 200;    --setting number of lines per page in iSQL plus

SELECT last_name AS "LName",job_id AS "Job Title", hire_date AS "Job Start"
FROM employees;

SELECT employee_id, last_name, commission_pct as "Emp Comm"
FROM employees;

DESCRIBE LOCATIONS;

SELECT DISTINCT JOB_ID AS "total number of Job ID"
FROM EMPLOYEES;

SELECT * FROM LOCATIONS;

SELECT LOCATION_ID AS "City#", city as "City", state_province||' IN THE ' ||country_id as "Province with Country Code"
FROM locations
WHERE location_id <= 1500;

SELECT distinct Job_id
from employees;

SELECT distinct department_id
from employees;


