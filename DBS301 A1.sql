SET LINESIZE 1000;
SET PAGESIZE 100;

/*Question1*/
SELECT
  EMPLOYEE_ID,
  SUBSTR(LAST_NAME ||', ' || FIRST_NAME,1,25) AS "Full Name",
  JOB_ID,
  TO_CHAR(LAST_DAY(HIRE_DATE),'fmMonth ddth "of" YYYY') AS "Start Date"                                    
FROM EMPLOYEES  
WHERE TO_CHAR(HIRE_DATE,'fmMonth') IN ('May','November')
AND   TO_CHAR(HIRE_DATE,'YYYY') NOT IN (1994, 1995)
ORDER BY HIRE_DATE DESC;

/*Question2*/
SELECT 
        'Emp# ' || EMPLOYEE_ID ||
        ' named ' || FIRST_NAME||' '|| LAST_NAME ||
        ' who is ' || JOB_ID ||
        ' will have a new salary of ' || '$' || 
        CASE 
             WHEN upper(JOB_ID) like '%VP%' THEN SALARY * 1.3
             ELSE SALARY * 1.2 
        END
        AS "Employees with increased Pay"
FROM    EMPLOYEES
WHERE   SALARY NOT BETWEEN 6000 AND 11000
AND     (JOB_ID LIKE '%VP'
OR      JOB_ID LIKE '%MGR'
OR      JOB_ID LIKE '%MAN')
ORDER BY SALARY DESC;

/*Question3*/
SELECT 
  LAST_NAME,
  SALARY,
  JOB_ID,
  NVL(TO_CHAR(MANAGER_ID),'NONE') AS "Manager#",
  TO_CHAR(((SALARY+1000) * 12),'$999,999.00') AS "Total Income"
FROM EMPLOYEES
WHERE (NVL(COMMISSION_PCT,0) = 0
OR DEPARTMENT_ID = 80)
AND (SALARY + 1000 + (SALARY * NVL(COMMISSION_PCT,0))) > 15000
ORDER BY 4 DESC;


/*Question 4*/
SELECT
  DEPARTMENT_ID,
  JOB_ID,
  MIN(SALARY) AS "Lowest"
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID,JOB_ID
HAVING MIN(SALARY) BETWEEN 6000 AND 18000
AND JOB_ID NOT LIKE '%REP'
AND DEPARTMENT_ID NOT IN(60,80)
ORDER BY DEPARTMENT_ID, JOB_ID;

/*Question 5*/

SELECT
        A.LAST_NAME,
        A.SALARY,
        A.JOB_ID
FROM    EMPLOYEES A JOIN (SELECT
                              DEPARTMENT_ID AS "MIN_DEPARTMENT",
                              MIN(SALARY) AS "MIN_SALARY"
                        FROM EMPLOYEES
                        GROUP BY DEPARTMENT_ID)     
ON      A.DEPARTMENT_ID = MIN_DEPARTMENT
AND     A.SALARY > MIN_SALARY
AND     (A.JOB_ID NOT LIKE '%PRES' OR A.JOB_ID NOT LIKE '%VP')
JOIN    DEPARTMENTS USING(DEPARTMENT_ID)
--ON      A.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN    LOCATIONS USING(LOCATION_ID)
--ON      D.LOCATION_ID = L.LOCATION_ID
WHERE     COUNTRY_ID NOT LIKE 'US'
ORDER BY A.JOB_ID;

--VERSION2
SELECT
        LAST_NAME,
        SALARY,
        JOB_ID
FROM    EMPLOYEES 
WHERE   SALARY > ALL (SELECT
                          MIN(SALARY)
                      FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
                      JOIN LOCATIONS USING (LOCATION_ID)
                      WHERE COUNTRY_ID <> 'US'
                      GROUP BY DEPARTMENT_ID)
AND     JOB_ID NOT IN ('AD_PRES','AD_VP')
ORDER BY JOB_ID;



SELECT
                          MIN(SALARY),
                          COUNTRY_ID
                      FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
                      JOIN LOCATIONS USING (LOCATION_ID)
                     -- WHERE COUNTRY_ID <> 'US'
                      GROUP BY DEPARTMENT_ID,COUNTRY_ID;

 
--Question 6
SELECT
    LAST_NAME,
    SALARY,
    JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (20,60)
AND SALARY > (SELECT
                  MIN(SALARY)
                FROM EMPLOYEES 
                WHERE DEPARTMENT_ID = 110)
ORDER BY LAST_NAME;                          

--VERSION2                      
SELECT
    LAST_NAME,
    SALARY,
    JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT
                          DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME IN('IT','Marketing'))
AND SALARY > (SELECT
                  MIN(SALARY)
                FROM EMPLOYEES 
                WHERE DEPARTMENT_ID = (SELECT
                                          DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Accounting'))
ORDER BY LAST_NAME;             
                      
--Question 7
SELECT
      INITCAP(FIRST_NAME ||' '|| LAST_NAME) AS "Employee",
      JOB_ID,
      LPAD(TO_CHAR(SALARY,'99,999'),12,'=') AS "Salary",
      DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT
                    MAX(SALARY)
                FROM EMPLOYEES
                --WHERE JOB_ID NOT IN('ST_MAN','SA_MAN','AC_MGR','MK_MAN','AD_VP','AD_PRES')  
                WHERE JOB_ID NOT LIKE '%MAN'
                AND    JOB_ID NOT LIKE '%MGR'
                AND  JOB_ID NOT LIKE '%VP'
                AND  JOB_ID NOT LIKE '%PRES'
                AND DEPARTMENT_ID NOT IN(80,20))
ORDER BY EMPLOYEE_ID;


SELECT DISTINCT(MANAGER_ID) FROM EMPLOYEES
SELECT
                    --DEPARTMENT_ID,
                    --JOB_ID,
                    MAX(SALARY)
                  
                 
                FROM EMPLOYEES
               -- GROUP BY DEPARTMENT_ID, JOB_ID
                WHERE DEPARTMENT_ID NOT IN (80,20)
                --AND JOB_ID NOT IN('ST_MAN','SA_MAN','AC_MGR','MK_MAN','AD_VP','AD_PRES')  
              
                AND EMPLOYEE_ID  NOT IN (SELECT
                                              MANAGER_ID
                                        FROM EMPLOYEES  )  
                

SELECT
                    MAX(SALARY)
                FROM EMPLOYEES
                WHERE JOB_ID NOT IN('ST_MAN','SA_MAN','AC_MGR','MK_MAN','AD_VP','AD_PRES')  
                AND DEPARTMENT_ID NOT IN(80,20)

--Question 8
SELECT
    SUBSTR(NVL(CITY,'No Assigned City'),1,25) AS "City",
    NVL(DEPARTMENT_NAME, 'No Department') AS "Deparmtent Name",
    COUNT(DISTINCT(JOB_ID)) AS "# of Jobs"
FROM LOCATIONS LEFT JOIN DEPARTMENTS USING(LOCATION_ID)
FULL JOIN EMPLOYEES USING(DEPARTMENT_ID)
GROUP BY CITY, DEPARTMENT_NAME
ORDER BY 3 desc,2;

--Question 9
SELECT
    UPPER(LAST_NAME||', '|| FIRST_NAME)||' is '||
    CASE JOB_ID WHEN 'ST_CLERK' THEN 'Store Clerk'
                WHEN 'ST_MAN' THEN 'Store Manager'
    END AS "Job Title"
FROM EMPLOYEES
WHERE UPPER(SUBSTR(LAST_NAME,-1,1)) = 'S'         --end
AND UPPER(SUBSTR(FIRST_NAME,1,1)) IN ('C','K');   --start



select
  first_name
from employees
where instr(lower(first_name),'s') <> 0;