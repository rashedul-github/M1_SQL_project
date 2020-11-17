/*
	**[Md Rasheddul Islam]**
	**Object: Database HRMdb[DML] Script Date: 01/12/2019**
*/

USE HRMdb;
GO
--insert INTO departments through procedure
EXEC spDeptInsert 'Admin'
EXEC spDeptInsert 'Human Resource'  
EXEC spDeptInsert 'Accounts'  
EXEC spDeptInsert 'Marketing'  
GO
SELECT * FROM Departments
GO
--INSERT INTO Pots table with DEFAULT value
INSERT INTO Posts VALUES
(DEFAULT,'Office Admin',16000,60000,101),
(DEFAULT,'Office assistant',14000,50000,101),
(DEFAULT,'HR manager',15000,65000,102),
(DEFAULT,'HR Assistant',13000,55000,102),
(DEFAULT,'Accountant–Cost',22000,80000,103),
(DEFAULT,'Accountant–Tax',25000,90000,103),
(DEFAULT,'Product Manager',35000,90000,104),
(DEFAULT,'Marketing Assistant',25000,50000,104)
GO
SELECT * FROM Posts
GO
INSERT INTO Employees VALUES
(01,'Rashedul','Nobabganj Dhaka',01677822063,'rashedul@gmail.com',25000,10,101),
(02,'Faysal','Nohakhli',01555555,'faysal@gmail.com',30000,11,101),
(03,'Shagor','Dhaka',017555555,'shagor@gmail.com',18000,12,102),
(04,'Shumi','Gazipur',016444555,'shumi@gmail.com',35000,13,102),
(05,'Shaon','Dhaka',018444555,'shaon@gmail.com',34000,14,103),
(06,'Ritu','Dhaka',015444555,'ritu@gmail.com',40000,15,103),
(07,'Jamal','Uttara',0192200011,'jamal@gmail.com',24000,16,104),
(08,'Hamid','Mirpur',014225588,'hamid@gmail.com',26000,17,104)
GO
SELECT * FROM Employees
GO
INSERT INTO Job_History (employeeID,startDate,endDate,postID,departmentID) VALUES
(01,'2006-02-12','2015-03-15',10,101),
(02,'2010-10-28',NULL,11,101),
(03,'2011-09-18','2017-03-25',12,102),
(04,'2012-05-02',NULL,13,102),
(05,'2012-09-16','2015-08-23',14,103),
(06,'2013-11-02','2017-11-21',15,103),
(07,'2015-12-25',NULL,16,104),
(08,'2019-11-10',NULL,17,104)
GO
SELECT * FROM Job_History
GO
--cheek index
EXEC sp_helpindex 'Departments'
GO
--cheek constraint
EXEC sp_helpconstraint 'Posts'
GO
--use view
SELECT * FROM vEmployeeInfo
GO
--use tablar function
SELECT * FROM fnEmployeeinfo (5)
GO
--effect of trigger
INSERT INTO Employees VALUES
(09,'Jamshed','   Dhanmondi Dhaka   ',017225588,'Jamshed@Gmail.com',46000,17,104)
GO
SELECT * FROM Employees
GO
--trigger remove extra space from address & insert email as lower case


