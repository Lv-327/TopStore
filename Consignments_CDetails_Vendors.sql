CREATE TABLE Consignments ( 
ConsignmentNumber int NOT NULL, 
ConsignmentDate date NOT NULL, 
Active  bit NOT NULL,   
EmployeeID int NOT NULL, 
BusinessUnitID int NOT NULL,
CONSTRAINT PK_ConsignmentNumber PRIMARY KEY (ConsignmentNumber),
) ;

CREATE TABLE ConsignmentsDetails (
ConsignmentNumber int NOT NULL, 
VendorID int NOT NULL,
Payer nvarchar(30) , 
ProductID int NOT NULL ,
Receiver nvarchar(30) , 
DescriptionDetails NVARCHAR(100),
TotalSum money NOT NULL,
Quantity int NOT NULL,
VendorPrice money
) ;


CREATE TABLE Vendors(
VendorID INT IDENTITY(1,1),
CompanyName nvarchar(30) NOT NULL,
Activity bit NOT NULL,
CONSTRAINT PK_VendorID PRIMARY KEY(VendorID)
);
