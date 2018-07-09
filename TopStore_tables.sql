CREATE DATABASE TopStore
GO

USE TopStore
GO

CREATE TABLE Products (
  ProductID int NOT NULL IDENTITY(1,1),
  Material varchar(20) NOT NULL,
  VendorID int NOT NULL,
  CategoryID int NOT NULL,
  SubCategoryID int NOT NULL,
  Size varchar(5) NOT NULL,
  Color varchar(10) NOT NULL,
  Price money NOT NULL,
  Model varchar(10),
  CONSTRAINT PK_Products PRIMARY KEY CLUSTERED (ProductID) );
  GO

CREATE TABLE ProductCategories (
  CategoryID int NOT NULL IDENTITY(1,1),
  CategoryName varchar(20) NOT NULL,
  [Description] varchar(300) NULL,
  Active bit NOT NULL,
  CONSTRAINT PK_ProductCategories PRIMARY KEY CLUSTERED (CategoryID) );
  GO

