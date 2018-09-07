USE TopStore

IF OBJECT_ID ('spAddProducts') IS NOT NULL
DROP PROCEDURE spAddProducts
GO

CREATE PROCEDURE spAddProducts
	@ProductName NVARCHAR(25),
	@Material NVARCHAR(20),
	@VendorID INT = NULL,
	@CategoryID INT = NULL,
	@SubCategoryID INT = NULL,
	@Size INT = NULL,
	@Color NVARCHAR(10) = NULL,
	@VendorPrice MONEY = NULL,
    @Markup DECIMAL(2,1) = NULL
AS
BEGIN
	declare @CurrentlogKey datetime2 = getdate() 	
	EXEC spLOG @ProcedName = 'spAddProducts', @TableName = 'Products',  @Action = 'Start', @LogKey = @CurrentlogKey
-- add  new employee
BEGIN TRY
		INSERT Into Products (ProductName,  
        Material,  
        VendorID,
        CategoryID,
        SubCategoryID,
		Size,
		Color,
		VendorPrice,
		Markup)
VALUES
(@ProductName,
@Material,
@VendorID,
@CategoryID,
@SubCategoryID,
@Size,
@Color,
@VendorPrice,
@Markup)


			EXEC spLOG @ProcedName = 'spAddProducts', @TableName = 'Products',  @Action = 'Stop', @in=@@ROWCOUNT, @LogKey = @CurrentlogKey							
							
				

END TRY
BEGIN CATCH
			PRINT ERROR_MESSAGE()
	EXEC spLOG @ProcedName = 'spEmployees', @TableName = 'Employees',  @Action = 'Error', @LogKey = @CurrentlogKey		
END CATCH
		
End
GO


EXEC spAddProducts
    
	@ProductName =null,
	@Material = Shovk
