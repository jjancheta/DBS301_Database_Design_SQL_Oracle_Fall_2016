SELECT TO_CHAR(SYSDATE + 1,'fmMonth DD"th of year" YYYY') as "Tomorrow"
FROM DUAL;
SET LINESIZE 1000;

SELECT 
  LAST_NAME, 
  FIRST_NAME, 
  SALARY, 
  ROUND(SALARY * 1.07) AS "Good Salary",
 ROUND(((SALARY * 1.07) - SALARY) * 12) AS "Annual Pay Increase"
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(20,50,60);

SELECT 
  UPPER(LAST_NAME)||','||
  UPPER(FIRST_NAME)||' is ' || 
  CASE JOB_ID WHEN 'ST_CLERK' THEN 'Store Clerk'
              WHEN 'ST_MAN' THEN 'Store Manager'
              WHEN 'SA_REP' THEN 'Sales Representative'
              WHEN 'SA_MAN' THEN 'Sales Manager'
  ELSE    'No Job Title' END     
  AS "Person and Job"
FROM EMPLOYEES
WHERE UPPER(SUBSTR(LAST_NAME,-1,1)) = 'S'
AND UPPER(SUBSTR(FIRST_NAME,1,1)) IN ('C','K')
ORDER BY LAST_NAME;

SELECT 
    LAST_NAME, 
    HIRE_DATE, 
    ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) AS "Years Worked"
FROM EMPLOYEES
WHERE TO_NUMBER(TO_CHAR(HIRE_DATE,'YYYY')) < 1992
ORDER BY "Years Worked";

SELECT 
    CITY, 
    COUNTRY_ID, 
    NVL(STATE_PROVINCE,'Unknown Province') AS "Province"
FROM LOCATIONS
WHERE SUBSTR(CITY,1,1) = 'S'
AND LENGTH(CITY) >= 8;

SELECT 
    LAST_NAME, 
    HIRE_DATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE,12),'TUESDAY'),
           'fmDAY, Month "the" Ddsp "of year" YYYY') AS "Review Day"
FROM EMPLOYEES
WHERE TO_NUMBER(TO_CHAR(HIRE_DATE,'YYYY')) > 1997;

select to_timestamp(sysdate) from dual;

