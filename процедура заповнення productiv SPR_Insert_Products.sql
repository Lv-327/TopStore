
CREATE PROCEDURE [dbo].[SPR_Insert_Products](@Quantity INT)
AS
BEGIN TRY
SET NOCOUNT ON;
DECLARE 
@i INT,
@r1 DECIMAL,
@a2 NVARCHAR(50),
@a3 INT
SET @i = 1

WHILE @i < @Quantity
BEGIN
SET @r1 = CEILING(RAND()*4) -- generet category
 BEGIN
   SET @a2 = (SELECT productname FROM [Halynatest327].[dbo].[Products] WHERE productid = @i)
   SET @a3 = (SELECT subcategoryid FROM [Halynatest327].[dbo].[ProductCategories] WHERE subcategoryname = @a2)
  END
 
 UPDATE [dbo].[Products] SET 	
									   [CategoryID]			=  @r1,
									   [SubCategoryID]		=  @a3
									   WHERE productid = @i
SET @i +=1
END 
SET NOCOUNT OFF;

END TRY


        
		BEGIN CATCH
		IF ERROR_NUMBER() = 245
		BEGIN 
		PRINT 'error 245'
END 		
		END CATCH
	

-- ----------------------------------------

-----------------------------------------------
GO

 go 
Drop PROCEDURE [dbo].[SPR_Insert_Products]


go

exec [dbo].[SPR_Insert_Products] yuyuy