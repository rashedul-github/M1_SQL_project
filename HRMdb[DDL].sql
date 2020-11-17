/*
	**[Md Rasheddul Islam]**
	**Object: Database HRMdb[DDL] Script Date: 01/12/2019**
*/

USE master;
IF DB_ID('HRMdb') IS NOT NULL
DROP DATABASE HRMdb;
GO
--Database HRMdb
CREATE DATABASE HRMdb
GO
USE HRMdb
GO
--sequence
CREATE SEQUENCE sequence01
START WITH 10
INCREMENT BY 1;
GO

--table for database HRMdb
CREATE TABLE Departments 
(
	departmentID NVARCHAR(10) PRIMARY KEY NONCLUSTERED,
	departmentName NVARCHAR(30) NOT NULL
)
GO
CREATE TABLE Posts 
(
	postID INT PRIMARY KEY DEFAULT(NEXT VALUE FOR sequence01),
	postTitle NVARCHAR(30) NOT NULL,
	minSalary MONEY NULL,
	maxSalary MONEY NULL,
	departmentID NVARCHAR(10) NOT NULL REFERENCES Departments (departmentID)	  
)
GO
CREATE TABLE Employees
(
	employeeID INT PRIMARY KEY,
	employeName VARCHAR(30) NOT NULL,
	[address] NVARCHAR(30) NOT NULL,
	phoneNumber INT NOT NULL,
	email NVARCHAR(30) NOT NULL,
	salary MONEY NOT NULL,
	postID INT NOT NULL REFERENCES Posts (postID),
	departmentID NVARCHAR(10) NOT NULL REFERENCES Departments (departmentID)	  
)
GO
CREATE TABLE Job_History
(
	employeeID INT NOT NULL REFERENCES Employees (employeeID),
	startDate DATE NOT NULL,
	endDate DATE NULL,
	postID INT NOT NULL REFERENCES Posts (postID),
	departmentID NVARCHAR(10) NOT NULL REFERENCES Departments (departmentID)
	PRIMARY KEY (employeeID,startDate)
)
GO
--Index
CREATE CLUSTERED INDEX deptIndex
ON Departments (departmentID)
GO
CREATE INDEX postIndex
ON Posts (postTitle)
GO
CREATE INDEX employeeIndex
ON Employees (employeName)
GO
--constraint
ALTER TABLE Posts 
ADD CHECK (minSalary>10000)
GO
ALTER TABLE Posts 
ADD CHECK (maxSalary<100000)
GO
--view
CREATE VIEW vEmployeeInfo
AS
SELECT em.employeeID,employeName,d.departmentName,p.postTitle,em.salary
FROM Employees em
INNER JOIN Departments d
ON em.departmentID=d.departmentID
INNER JOIN Posts p
ON em.postID=p.postID
GO
--procedure
CREATE PROC spDeptInsert @dN NVARCHAR(30)
AS
	DECLARE @dID INT
	SELECT @dID= ISNULL(MAX(departmentID),100)+1 FROM Departments
BEGIN TRY
	INSERT INTO Departments(departmentID,departmentName)
	VALUES (@dID,UPPER(@dN))
	RETURN @dID;
END TRY
BEGIN CATCH
	;
	THROW 50001,'INVALID INSERT INTO Departments',1
END CATCH
GO
--tablar function 
CREATE FUNCTION fnEmployeeinfo (@eID int) RETURNS TABLE
AS 
RETURN
(
SELECT em.employeeID,employeName,d.departmentName,p.postTitle,em.salary
FROM Employees em
INNER JOIN Departments d
ON em.departmentID=d.departmentID
INNER JOIN Posts p
ON em.postID=p.postID
WHERE em.employeeID=@eID    
)
GO
--Trigger
CREATE TRIGGER Employees_Insert_Update
on Employees FOR INSERT,UPDATE
AS
	UPDATE Employees
	SET email = LOWER(email),
	[address]= LTRIM(RTRIM([address]))
	WHERE employeeID IN (SELECT employeeID FROM inserted)
GO
PRINT 'Successfull, Thank You'


