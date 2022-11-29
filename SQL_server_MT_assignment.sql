
--Table Creation


CREATE TABLE Manufacturer_Nis1023(
	MfName NVARCHAR(30) PRIMARY KEY,
	City NVARCHAR(20),
	State NVARCHAR(20)
);

CREATE TABLE Employee_Nis1023(
	EmployeeId INT PRIMARY KEY,
	EmpName NVARCHAR(30),
	Phone NVARCHAR(12),
	Email NVARCHAR(30)
);

CREATE TABLE Computer_Nis1023(
	SerialNumber INT PRIMARY KEY,
	MfName NVARCHAR(30)
		CONSTRAINT fk_mfname_comptr
		FOREIGN KEY (MfName)
		REFERENCES Manufacturer_Nis1023(MfName),
	Model NVARCHAR(20),
	Weight INT,
	EmployeeId INT
		CONSTRAINT fk_emp_comptr
		FOREIGN KEY (EmployeeId)
		REFERENCES Employee_Nis1023(EmployeeId)

);

ALTER TABLE Employee_Nis1023 ADD area_code INT;


--Demo data Insertion

Insert into Manufacturer_Nis1023 VALUES('Dell','Pune','Maharashtra'),
										('HP','Delhi','Delhi'),
										('Lenovo','Trivendrum','Kerala'),
										('Asus','South Dakota','Karnataka');

INSERT INTO Employee_Nis1023 VALUES(1,'Prajot','989888','prajot@gmail.com',21),
									(2,'Pratik','67765','pratik@gmail.com',34),
									(3,'Dipak','90988','dipak@gmail.com',29),
									(4,'Bhushan','67323','bhushan@gmail.com',16);


INSERT INTO Computer_Nis1023 VALUES(1111,'HP','Pavillion',2,1),
									(1112,'Dell','Gamers',4,3),
									(1113,'Lenovo','Ideapad',1,2),
									(1114,'Dell','DellPad',3,null);

Select * FROM Computer_Nis1023;
SELECT * FROM Employee_Nis1023;
Select * FROM Manufacturer_Nis1023;

-------------------------------------------------------------------------------

--Questions
/*
1. List the manufacturers’ names that are located in South Dakota.
*/

SELECT MfName, City 
FROM Manufacturer_Nis1023
WHERE City LIKE 'South Dakota';

/*
2. Calculate the average weight of the computers in use.
*/

SELECT CAST(AVG(Weight) AS NUMERIC(4,2)) AS Avg_weight
FROM Computer_Nis1023
WHERE EmployeeId IS NOT NULL;

/*
3. List the employee names for employees whose area_code starts with 2
*/

SELECT EmpName,area_code FROM Employee_Nis1023
WHERE area_code LIKE '2%';

/*
4. List the serial numbers for computers that have a weight below
average.
*/

SELECT SerialNumber, Weight
FROM Computer_Nis1023
WHERE Weight < (SELECT AVG(Weight) FROM Computer_Nis1023);

/*
5. List the manufacturer names of companies that do not have any
computers in use. Use a subquery.
*/

SELECT MfName FROM Manufacturer_Nis1023
WHERE MfName NOT IN
(SELECT DISTINCT MfName FROM Computer_Nis1023);

/*
6. Create a VIEW with the list of employee name, their computer serial
number, and the city that they were manufactured in. Use a join.
*/

CREATE VIEW vwEmpCompReport
AS
SELECT e.EmpName, c.SerialNumber, m.City 
FROM Employee_Nis1023 e
JOIN Computer_Nis1023 c
ON e.EmployeeId=c.EmployeeId
JOIN Manufacturer_Nis1023 m
ON c.MfName=m.MfName;

/*
7. Write a Stored Procedure to accept EmployeeId as parameter and
List the serial number, manufacturer name, model, and weight of
computer that belong to the specified Employeeid.
*/

CREATE PROCEDURE spCompReport
@EmpId INT
AS
BEGIN

SELECT SerialNumber, MfName, Model, Weight
FROM Computer_Nis1023
WHERE EmployeeId=@EmpId;

END

EXEC spCompReport 2;