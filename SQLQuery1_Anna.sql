
CREATE TABLE Employees (
  EmployeeID int NOT NULL IDENTITY(1,1),
  [Name] varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  Email varchar(50) NOT NULL,
  [Address] varchar(50) NOT NULL,
  PhoneNumber varchar(20) NOT NULL,
  City varchar(20) NOT NULL,
  Birthday date NOT NULL,
  Salary money NOT NULL,
  SalaryBonus money NOT NULL,
  CONSTRAINT PK_Employees PRIMARY KEY CLUSTERED (EmployeeID) );
  GO

CREATE TABLE RolesEmployees2 (
  EmployeeID int NOT NULL,
  RoleID varchar(50) NOT NULL,
  StartDate date NOT NULL,
  EndDate date NOT NULL);
  GO

ALTER TABLE Employees
ADD CONSTRAINT CN_PhoneNumber
CHECK (PhoneNumber LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')  
GO

ALTER TABLE Employees
ADD CONSTRAINT CN_Employees_Birthday
CHECK (Birthday BETWEEN  DATEADD(YEAR, -50, GETDATE()) AND DATEADD(YEAR, -18, GETDATE()))

ALTER TABLE Employees
ADD CONSTRAINT CN_Employees_Salary
CHECK (SalaryBonus < Salary)  
GO

ALTER TABLE RolesEmployees2
ADD CONSTRAINT CN_Employees_Date
CHECK (StartDate < EndDate)  
GO

ALTER TABLE Employees 
ADD CONSTRAINT CN_Email 
CHECK (Email like '%_@__%.__%')
