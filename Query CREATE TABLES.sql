
CREATE TABLE ProductSubCategories (
  SubCategoryID int NOT NULL IDENTITY(1,1),
  CategoryID int NOT NULL,
  SubCategoryName nvarchar(20) NOT NULL,
  ProdSubCatDescription nvarchar(300) NOT NULL,
  Active bit NOT NULL,
  CONSTRAINT PK_ProductSubCategories PRIMARY KEY CLUSTERED (SubCategoryID) );
  GO

CREATE TABLE ReturnProducts (
  ReturnProductId int NOT NULL IDENTITY(1,1),
  ProductId int NOT NULL,
  Quantity int NOT NULL,
  OrderID int NOT NULL,
  ReturnType nvarchar(20) NULL,
  ReturnProdDescription nvarchar(300) NULL,
  DateMonth date NOT NULL,
  BusinessUnitID int NOT NULL,
  CONSTRAINT PK_ReturnProducts PRIMARY KEY CLUSTERED (ReturnProductId) );
  GO
  -- =========================================================================

  DROP TABLE ProductSubCategories
  GO
  DROP TABLE ReturnProducts
  GO
  -- ==========================================================================