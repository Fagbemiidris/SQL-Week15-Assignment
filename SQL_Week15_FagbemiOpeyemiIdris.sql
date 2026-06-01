/*
Today's Topic: CTEs
*/


--To Select all from the CTE_Employee 
WITH CTE_Employee AS 
(SELECT FirstName, LastName, Gender, Salary
	,COUNT(gender) OVER (PARTITION BY Gender) AS TotalGender
	,AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQL_Tutorial..EmployeeDemographics emp
JOIN SQL_Tutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee


--To Select selected values from the CTE_Employee 
WITH CTE_Employee AS 
(SELECT FirstName, LastName, Gender, Salary
	,COUNT(gender) OVER (PARTITION BY Gender) AS TotalGender
	,AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQL_Tutorial..EmployeeDemographics emp
JOIN SQL_Tutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee


/*
Today's Topic: Temp Tables
*/

--To create a #temp table
CREATE TABLE #temp_Employee (
EmployeeID Int,
Jobtitle varchar(100),
Salary int
)

--To confirm the #temp_Employee table
Select *
FROM #temp_Employee


--To insert values into the #temp_Employee table
INSERT INTO #temp_Employee VALUES (
'1001', 'HR', '45000'
)


--To insert values from employeesalary data into #temp_Employee
INSERT INTO #temp_Employee
SELECT *
FROM SQL_Tutorial..EmployeeSalary


--To create the second table 
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)


SELECT *
FROM #Temp_Employee2

--To insert into the second tale
INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle), Avg(Age), AVG(Salary)
FROM SQL_Tutorial..EmployeeDemographics emp
JOIN SQL_Tutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle


SELECT *
FROM #Temp_Employee2


--TO delete the table if already exist
DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)


--To insert into the second tale
INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle), Avg(Age), AVG(Salary)
FROM SQL_Tutorial..EmployeeDemographics emp
JOIN SQL_Tutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle


SELECT *
FROM #Temp_Employee2



/*
Today's Topic: Subqueries (in the Select, from and where statement)
*/

SELECT *
FROM EmployeeSalary

--Subquery in Select
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary)
FROM EmployeeSalary

--How to do it with partition by
SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
FROM EmployeeSalary

--Why Group By doesn't work
SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1,2

--Subquery in From
SELECT a.EmployeeID, AllAvgSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
		FROM EmployeeSalary) a


--Subquery in Where
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
		SELECT EmployeeID
		FROM EmployeeDemographics
		WHERE Age > 30);