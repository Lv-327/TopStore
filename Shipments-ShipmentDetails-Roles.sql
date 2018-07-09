CREATE TABLE Shipments (
  ShipmentID int NOT NULL IDENTITY(1,1),
  Date date NOT NULL CONSTRAINT DF_Shipments_Date DEFAULT GETDATE(),
  BusinessUnitFrom varchar(20) NOT NULL,
  BusinessUnitTo varchar(20) NOT NULL,
  EmployeeID int NOT NULL,
  CONSTRAINT PK_Shipments PRIMARY KEY CLUSTERED (ShipmentID) );
  GO

CREATE TABLE ShipmentDetails (
  ShipmentID int NOT NULL,
  ProductID int NOT NULL,
  Quantity int NOT NULL CONSTRAINT CK_ShipmentDetails_Quantity CHECK (Quantity > 0) ,
  DeliveryType varchar(10) NOT NULL CONSTRAINT CK_ShipmentDetails_DeliveryType CHECK ( DeliveryType IN ('imposed payment', 'cash payment')));
  GO

CREATE TABLE Roles (
  RoleID int NOT NULL IDENTITY(1,1),
  Position varchar(10) NOT NULL CONSTRAINT CK_Roles_Position CHECK ( Position IN ('Store Owner', 'Accountant', 
                                                                                  'Development Manager', 'Economist',                                                                               
																				  'Consultant', 'User',
																				  'Buyer', 'Warehouse manager')),
  Description varchar(256) NOT NULL, CONSTRAINT PK_Roles PRIMARY KEY CLUSTERED (RoleID) );
  GO