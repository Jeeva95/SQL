CREATE DATABASE CaseStudyDB;
USE CaseStudyDB;

-----------------Create the following table:-------------------
-----------------1. LOCATION
CREATE TABLE LOCATION
(
    Location_ID INT PRIMARY KEY,
    City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');

------------------2. DEPARTMENT
CREATE TABLE DEPARTMENT
(
    Department_Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Location_Id INT,
    FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);

INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES
(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167);

-----------------3. JOB
CREATE TABLE JOB
(
    Job_ID INT PRIMARY KEY,
    Designation VARCHAR(50)
);

INSERT INTO JOB (Job_ID, Designation)
VALUES
(667, 'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President');

--------------------4. EMPLOYEE
CREATE TABLE EMPLOYEE
(
    Employee_Id INT PRIMARY KEY,
    Last_Name VARCHAR(50),
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Job_Id INT,
    Hire_Date DATE,
    Salary DECIMAL(10,2),
    Comm DECIMAL(10,2) NULL,
    Department_Id INT,
    
    FOREIGN KEY (Job_Id) REFERENCES JOB(Job_ID),
    FOREIGN KEY (Department_Id) REFERENCES DEPARTMENT(Department_Id)
);

INSERT INTO EMPLOYEE
(Employee_Id, Last_Name, First_Name, Middle_Name, Job_Id, Hire_Date, Salary, Comm, Department_Id)
VALUES
(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, 300, 30),
(755, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
(756, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
(757, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 40),
(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, 50, 30);






-------------------------------------Simple Queries:
-----------------1. List all the employee details.
---------Answer 1
SELECT *
FROM EMPLOYEE;

------------------2. List all the department details.
----------Answer 2
SELECT *
FROM DEPARTMENT;

------------------3. List all job details.
----------Answer 3
SELECT *
FROM JOB;

------------------4. List all the locations.
----------Answer 4
SELECT *
FROM LOCATION;

------------------5. List out the First Name, Last Name, Salary, Commission for allEmployees.
----------Answer 5
SELECT First_Name, Last_Name, Salary, Comm
FROM EMPLOYEE;

-------------------6. List out the Employee ID, Last Name, Department ID for all employeesandalias
-------------------Employee ID as "ID of the Employee", Last Name as "Name of theEmployee", 
-------------------Department ID as "Dep_id".
-----------Answer 6
SELECT 
    Employee_Id AS "ID of the Employee",
    Last_Name AS "Name of the Employee",
    Department_Id AS "Dep_id"
FROM EMPLOYEE;

------------------7. List out the annual salary of the employees with their names only.
------------Answer 7
SELECT 
    First_Name,
    Last_Name,
    Salary * 12 AS Annual_Salary
FROM EMPLOYEE;






--------------------------------------WHERE Condition:
---------------------1. List the details about "Smith".
------------Answer 1
SELECT *
FROM EMPLOYEE
WHERE Last_Name = 'Smith';

---------------------2. List out the employees who are working in department 20.
-------------Answer 2
SELECT *
FROM EMPLOYEE
WHERE Department_Id = 20;

--------------------3. List out the employees who are earning salaries between 3000 and 4500.
--------------Answer 3
SELECT *
FROM EMPLOYEE
WHERE Salary BETWEEN 3000 AND 4500;

--------------------4. List out the employees who are working in department 10 or 20.
--------------Answer 4
SELECT *
FROM EMPLOYEE
WHERE Department_Id IN (10, 20);

---------------------5. Find out the employees who are not working in department 10 or 30.
-------------Answer 5
SELECT *
FROM EMPLOYEE
WHERE Department_Id NOT IN (10, 30);

---------------------6. List out the employees whose name starts with 'S'.
-------------Answer 6
SELECT *
FROM EMPLOYEE
WHERE First_Name LIKE 'S%';

---------------------7. List out the employees whose name starts with 'S' and ends with'H'.
-------------Answer 7
SELECT *
FROM EMPLOYEE
WHERE First_Name LIKE 'S%H';

---------------------8. List out the employees whose name length is 4 and start with 'S'.
-------------Answer 8
SELECT *
FROM EMPLOYEE
WHERE First_Name LIKE 'S___';

-------------------9. List out employees who are working in department 10 and drawsalariesmorethan 3500.
-------------Answer 9
SELECT *
FROM EMPLOYEE
WHERE Department_Id = 10
  AND Salary > 3500;

------------------10. List out the employees who are not receiving commission.
------------Answer
SELECT *
FROM EMPLOYEE
WHERE Comm IS NULL;






-----------------------------------ORDER BY Clause:
------------------1. List out the Employee ID and Last Name in ascending order basedontheEmployee ID.
------------Answer 1
SELECT Employee_Id, Last_Name
FROM EMPLOYEE
ORDER BY Employee_Id ASC;

-----------------2. List out the Employee ID and Name in descending order based onsalary.
------------Answer 2
SELECT Employee_Id, First_Name
FROM EMPLOYEE
ORDER BY Salary DESC;

----------------3. List out the employee details according to their Last Name in ascending-order.
-----------Answer 3
SELECT *
FROM EMPLOYEE
ORDER BY Last_Name ASC;

----------------4. List out the employee details according to their Last Name in ascendingorder 
----------------and then Department ID in descending order.
---------Answer 4
SELECT *
FROM EMPLOYEE
ORDER BY Last_Name ASC, Department_Id DESC;






-----------------------------------GROUP BY and HAVING Clause:
----------------1. How many employees are in different departments in theorganization?
---------Answer 1
SELECT Department_Id, COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY Department_Id;

---------------2. List out the department wise maximum salary, minimumsalary andaverage salary 
---------------of the employees.
---------Answer 2
SELECT 
    Department_Id,
    MAX(Salary) AS Maximum_Salary,
    MIN(Salary) AS Minimum_Salary,
    AVG(Salary) AS Average_Salary
FROM EMPLOYEE
GROUP BY Department_Id;

----------------3. List out the job wise maximum salary, minimum salary and averagesalary of the employees.
-----------Answer 3
SELECT 
    Job_Id,
    MAX(Salary) AS Maximum_Salary,
    MIN(Salary) AS Minimum_Salary,
    AVG(Salary) AS Average_Salary
FROM EMPLOYEE
GROUP BY Job_Id;

----------------4. List out the number of employees who joined each month in ascendingorder.
------------Answer 4
SELECT 
    MONTH(Hire_Date) AS Month_Number,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY MONTH(Hire_Date)
ORDER BY MONTH(Hire_Date) ASC;

----------------5. List out the number of employees for each month and year in
----------------ascending order based on the year and month.
-----------Answer 5
SELECT 
    YEAR(Hire_Date) AS Hire_Year,
    MONTH(Hire_Date) AS Hire_Month,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY YEAR(Hire_Date), MONTH(Hire_Date)
ORDER BY YEAR(Hire_Date) ASC, MONTH(Hire_Date) ASC;

-----------------6. List out the Department ID having at least four employees.
-----------Answer 6
SELECT Department_Id, COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY Department_Id
HAVING COUNT(*) >= 4;

-----------------7. How many employees joined in the month of January?
-----------Answer 7
SELECT COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE MONTH(Hire_Date) = 1;

-----------------8. How many employees joined in the month of January orSeptember?
------------Answer 8
SELECT COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE MONTH(Hire_Date) IN (1, 9);

-----------------9. How many employees joined in 1985?
------------Answer 9
SELECT COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985;

------------------10. How many employees joined each month in 1985?
------------Answer 10
SELECT 
    MONTH(Hire_Date) AS Month_Number,
    DATENAME(MONTH, Hire_Date) AS Month_Name,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
GROUP BY 
    MONTH(Hire_Date),
    DATENAME(MONTH, Hire_Date)
ORDER BY MONTH(Hire_Date);

---------------------11. How many employees joined in March 1985?
----------Answer 11
SELECT COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
  AND MONTH(Hire_Date) = 3;

-------------------12. Which is the Department ID having greater than or equal to 3 employeesjoining 
-------------------in April 1985?
----------Answer 12
SELECT 
    Department_Id,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
  AND MONTH(Hire_Date) = 4
GROUP BY Department_Id
HAVING COUNT(*) >= 3;






------------------------------------------Joins:
------------------------1. List out employees with their department names.
---------Answer 1
SELECT 
    E.Employee_Id,
    E.First_Name,
    E.Last_Name,
    D.Name AS Department_Name
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id;

----------------------2. Display employees with their designations.
------------Answer 2
SELECT 
    E.Employee_Id,
    E.First_Name,
    E.Last_Name,
    J.Designation
FROM EMPLOYEE E
INNER JOIN JOB J
    ON E.Job_Id = J.Job_ID;

----------------------3. Display the employees with their department names and regional groups.
--------------Answer 3
SELECT 
    E.Employee_Id,
    E.First_Name,
    E.Last_Name,
    D.Name AS Department_Name,
    L.City AS Regional_Group
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
INNER JOIN LOCATION L
    ON D.Location_Id = L.Location_ID;

---------------------4. How many employees are working in different departments?
---------------------Displaywithdepartment names.
-----------Answer 4
SELECT 
    D.Department_Id,
    D.Name AS Department_Name,
    COUNT(E.Employee_Id) AS Employee_Count
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E
    ON D.Department_Id = E.Department_Id
GROUP BY 
    D.Department_Id,
    D.Name;

----------------------5. How many employees are working in the sales department?
------------Answer 5
SELECT COUNT(E.Employee_Id) AS Employee_Count
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales';

---------------------6. Which is the department having greater than or equal to 5
---------------------employees? Display the department names in ascending order.
------------Answer 6
SELECT 
    D.Name AS Department_Name,
    COUNT(E.Employee_Id) AS Employee_Count
FROM DEPARTMENT D
INNER JOIN EMPLOYEE E
    ON D.Department_Id = E.Department_Id
GROUP BY D.Name
HAVING COUNT(E.Employee_Id) >= 5
ORDER BY D.Name ASC;

---------------------7. How many jobs are there in the organization? Display with designations.
------------Answer 7
SELECT 
    Job_ID,
    Designation
FROM JOB
ORDER BY Designation ASC;

---------------------8. How many employees are working in "New York"?
-------------Answer 8
SELECT COUNT(E.Employee_Id) AS Employee_Count
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
INNER JOIN LOCATION L
    ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York';

----------------------9. Display the employee details with salary grades. 
----------------------Use conditional statementtocreate a grade column.
-----------Answer 9
SELECT 
    E.*,
    CASE
        WHEN Salary < 1000 THEN 'Grade C'
        WHEN Salary BETWEEN 1000 AND 1999 THEN 'Grade B'
        WHEN Salary >= 2000 THEN 'Grade A'
    END AS Salary_Grade
FROM EMPLOYEE E;

------------------------10. List out the number of employees grade wise. 
------------------------Use conditional statementtocreate a grade column.
---------------Answer 10
SELECT 
    CASE
        WHEN Salary < 1000 THEN 'Grade C'
        WHEN Salary BETWEEN 1000 AND 1999 THEN 'Grade B'
        WHEN Salary >= 2000 THEN 'Grade A'
    END AS Salary_Grade,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY
    CASE
        WHEN Salary < 1000 THEN 'Grade C'
        WHEN Salary BETWEEN 1000 AND 1999 THEN 'Grade B'
        WHEN Salary >= 2000 THEN 'Grade A'
    END
ORDER BY Salary_Grade;

-----------------------11.Display the employee salary grades and the number of employees
-----------------------between 2000 to 5000 range of salary.
-------------Answer 11
SELECT 
    CASE
        WHEN Salary < 3000 THEN 'Grade B'
        WHEN Salary >= 3000 THEN 'Grade A'
    END AS Salary_Grade,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE Salary BETWEEN 2000 AND 5000
GROUP BY
    CASE
        WHEN Salary < 3000 THEN 'Grade B'
        WHEN Salary >= 3000 THEN 'Grade A'
    END
ORDER BY Salary_Grade;

------------------------12. Display all employees in sales or operation departments.
------------Answer 12
SELECT 
    E.*
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');






--------------------------------------SET Operators:
--------------------1. List out the distinct jobs in sales and accounting departments.
---------Answer 1
SELECT E.Job_Id
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales'

INTERSECT

SELECT E.Job_Id
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting';

----------------------2. List out all the jobs in sales and accounting departments.
------------Answer 2
SELECT E.Job_Id
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales'

UNION

SELECT E.Job_Id
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting';

------------------3. List out the common jobs in research and accounting
------------------departments in ascending order.
------Answer 3
SELECT E.Job_Id
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Research'

INTERSECT

SELECT E.Job_Id
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting'

ORDER BY Job_Id ASC;






----------------------------------------Subqueries:
------------------1. Display the employees list who got the maximum salary.
--------Answer 1
SELECT *
FROM EMPLOYEE
WHERE Salary = (
    SELECT MAX(Salary)
    FROM EMPLOYEE
);

-----------------------2. Display the employees who are working in the sales department.
-----------Answer 2
SELECT E.*
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales';

--------------------3. Display the employees who are working as 'Clerk'.
-----------Answer 3
SELECT E.*
FROM EMPLOYEE E
INNER JOIN JOB J
    ON E.Job_Id = J.Job_ID
WHERE J.Designation = 'Clerk';

----------------------4. Display the list of employees who are living in "New York".
------------Answer 4
SELECT E.*
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
INNER JOIN LOCATION L
    ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York';

----------------------5. Find out the number of employees working in the sales department.
-------------Answer 5
SELECT COUNT(E.Employee_Id) AS Employee_Count
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales';

--------------------6. Update the salaries of employees who are working as clerks on the basis of 10%.
------------Answer 6
UPDATE E
SET E.Salary = E.Salary * 1.10
FROM EMPLOYEE E
INNER JOIN JOB J
    ON E.Job_Id = J.Job_ID
WHERE J.Designation = 'Clerk';

SELECT E.Employee_Id, E.First_Name, E.Last_Name, E.Salary, J.Designation
FROM EMPLOYEE E
INNER JOIN JOB J
    ON E.Job_Id = J.Job_ID
WHERE J.Designation = 'Clerk';

----------------------7. Delete the employees who are working in the accounting department.
------------Answer 7
DELETE E
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting';

---------------------8. Display the second highest salary drawing employee details.
------------Answer 8
SELECT *
FROM
(
    SELECT 
        E.*,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank
    FROM EMPLOYEE E
) AS X
WHERE Salary_Rank = 2;

------------------9. Display the nth highest salary drawing employee details.
-----------Answer 9
DECLARE @N INT = 3;  -- Change 3 to any required rank

SELECT *
FROM
(
    SELECT 
        E.*,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank
    FROM EMPLOYEE E
) AS X
WHERE Salary_Rank = @N;

-----------------10. List out the employees who earn more than every employee in department 30.
---------Answer 10
SELECT *
FROM EMPLOYEE
WHERE Salary > ALL
(
    SELECT Salary
    FROM EMPLOYEE
    WHERE Department_Id = 30
);

--------------------11. List out the employees who earn more than the lowest salary in
--------------------department.Find out whose department has no employees.
----------Answer 11
-------Employees who earn more than the lowest salary in the company
SELECT *
FROM EMPLOYEE
WHERE Salary > (
    SELECT MIN(Salary)
    FROM EMPLOYEE
);

-------Find which department has no employees
SELECT 
    D.Department_Id,
    D.Name AS Department_Name
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E
    ON D.Department_Id = E.Department_Id
WHERE E.Employee_Id IS NULL;

--------------------12. Find out which department has no employees.
---------Answer 12
SELECT 
    D.Department_Id,
    D.Name AS Department_Name
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E
    ON D.Department_Id = E.Department_Id
WHERE E.Employee_Id IS NULL;

--------------------13. Find out the employees who earn greater than the average salary for
--------------------their department.
--------Answer 13
SELECT *
FROM EMPLOYEE E
WHERE Salary > (
    SELECT AVG(Salary)
    FROM EMPLOYEE
    WHERE Department_Id = E.Department_Id
);