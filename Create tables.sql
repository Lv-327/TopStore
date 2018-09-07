USE TopStore
GO

CREATE TABLE Products (
  ProductID int NOT NULL IDENTITY(1,1),
  ProductName nvarchar(50) NOT NULL,
  Material nvarchar(20) NULL,
  VendorID int NULL,
  CategoryID int NULL,
  SubcategoryID int NULL,
  Size nvarchar(5) NULL,
  Color nvarchar(10) NULL,
  VendorPrice money  NULL,
  Markup decimal(3,2) NULL,
  Active bit NULL,
  CONSTRAINT PK_Products PRIMARY KEY CLUSTERED (ProductID) );
  GO

  IF OBJECT_ID('LogProcessesTable') is not null
DROP TABLE LogProcessesTable
GO

CREATE TABLE LogProcessesTable
	(
	LogID bigint IDENTITY(1,1) NOT NULL PRIMARY KEY,
	StateDescription nvarchar(50) NOT NULL,
	UserName sysname NOT NULL,
	StartTime datetime NOT NULL,
	EndTime datetime NULL,
	ProcessName nvarchar(50) NOT NULL,
	TableName nvarchar(20) NOT NULL,
	InsertRows int NOT NULL,
	UpdateRows int NOT NULL,
	DeleteRows int NOT NULL,
	Report nvarchar (150) NULL,
	LogKey datetime2(7) NOT NULL
	)
GO


ALTER TABLE Products ADD 
	CONSTRAINT FK_Products_ProductCategories FOREIGN KEY (CategoryID)
	REFERENCES ProductCategories(CategoryID) 
GO

ALTER TABLE Products ADD 
	CONSTRAINT FK_Products_ProductSubCategories FOREIGN KEY (SubCategoryID)
	REFERENCES ProductSubCategories(SubCategoryID) 
GO



ALTER TABLE Products ADD 
	CONSTRAINT FK_Products_Vendors FOREIGN KEY (VendorID)
	REFERENCES Vendors(VendorID) 
GO

