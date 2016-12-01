--question 1
set autocommit on;
select * from employees;

INSERT INTO EMPLOYEES VALUES(999,'Jesus Jr','Ancheta','JJANCHETA','647.778.7219','01-OCT-16','IT_PROG',NULL,0.2,100,90);

UPDATE EMPLOYEES
    SET SALARY = 2500
WHERE LAST_NAME IN ('Matos','Whalen');    

--question 2

SELECT
    LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT
                            DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LAST_NAME = 'Abel');
                        
SELECT
        DEPARTMENT_ID
FROM EMPLOYEES
WHERE LAST_NAME = 'Abel';

--question 3

SELECT
    LAST_NAME
FROM EMPLOYEES
WHERE SALARY = (SELECT
                    MIN(SALARY)
                FROM EMPLOYEES);
                --WHERE NVL(SALARY,0) <> 0);
                
                
SELECT MIN(SALARY) FROM EMPLOYEES;

--QUESTION 4

SELECT
    DISTINCT(CITY)
FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
JOIN LOCATIONS USING (LOCATION_ID)
WHERE SALARY = (SELECT
                    MIN(SALARY)
                FROM EMPLOYEES);
                
--question 5
SELECT
    LAST_NAME
FROM EMPLOYEES 
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT
                                 DEPARTMENT_ID,
                                  MIN(SALARY)
                              FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID);
SELECT
                    MIN(SALARY),
                    DEPARTMENT_ID
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID;

--question 6

SELECT
       LAST_NAME,
       city,
       salary
FROM EMPLOYEES JOIN DEPARTMENTS USING(DEPARTMENT_ID)
JOIN LOCATIONS USING(LOCATION_ID)
WHERE (CITY,SALARY)IN (SELECT
                         CITY,
                         MIN(SALARY)
                       FROM EMPLOYEES JOIN DEPARTMENTS USING(DEPARTMENT_ID)
                        JOIN LOCATIONS USING(LOCATION_ID)
                        GROUP BY CITY);

SELECT
                         CITY,
                         MIN(SALARY)
                       FROM EMPLOYEES JOIN DEPARTMENTS USING(DEPARTMENT_ID)
                        JOIN LOCATIONS USING(LOCATION_ID)
                        GROUP BY CITY;

SET PAGESIZE 100;                        
--question 7
SELECT
    LAST_NAME,
    SALARY
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT
                     MIN(SALARY)
                 FROM EMPLOYEES
                 GROUP BY DEPARTMENT_ID)
ORDER BY SALARY DESC, LAST_NAME;



                 
--QUESTION 8
SELECT 
      LAST_NAME,
      JOB_ID,
      SALARY
FROM EMPLOYEES
WHERE SALARY = ANY (SELECT
                         SALARY
                    FROM EMPLOYEES
                    WHERE DEPARTMENT_ID = 60)
AND DEPARTMENT_ID <> 60                    
ORDER BY SALARY, LAST_NAME;                    