
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


