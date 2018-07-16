

CREATE TABLE [dbo].[ProductCategories](
	[CategoryID] [INT] IDENTITY(1,1) NOT NULL,
	[CategoryName] [NVARCHAR](50) NOT NULL,
	[Active] [BIT] NOT NULL,
 CONSTRAINT [PK_ProductCategories] PRIMARY KEY CLUSTERED 
(
	[CategoryID]
)

GO

CREATE TABLE [dbo].[ProductSubCategories](
	[CategoryID] [INT] NOT NULL,
	[CategoryName] [NVARCHAR](50) NOT NULL,
	[SubCategoryID] [INT] IDENTITY(1,1) NOT NULL,
	[SubCategoryName] [NVARCHAR](50) NOT NULL,
 CONSTRAINT [PK_ProductSubCategories] PRIMARY KEY CLUSTERED 
(
	[SubCategoryID])

GO

CREATE TABLE [dbo].[ReturnProducts](
	[ReturnProductID] [INT] IDENTITY(1,1) NOT NULL,
	[ProductID] [INT] NULL,
	[Quantity] [INT] NULL,
	[OrderID] [INT] NULL,
	[ReturnType] [NVARCHAR](20) NULL,
	[DateMonth] [DATE] NULL,
	[BusinessUnitID] [INT] NULL,
 CONSTRAINT [PK_ReturnProducts] PRIMARY KEY CLUSTERED 
(
	[ReturnProductID] 
)
GO

ALTER TABLE [dbo].[ReturnProducts]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO

ALTER TABLE [dbo].[ReturnProducts]  WITH CHECK ADD  CONSTRAINT [CHK_Quantity] CHECK  (([Quantity]>(0)))
GO

  -- =========================================================================

  DROP TABLE ProductSubCategories
  GO
  DROP TABLE ReturnProducts
  GO
  DROP TABLE ProductCategories
  GO
  -- ==========================================================================