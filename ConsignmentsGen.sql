CREATE PROCEDURE GenerateConsignmentForStock
@StockID INT,
@DATE DATE 
AS
BEGIN
	DECLARE @ConsignmentSize INT
	SET @ConsignmentSize = FLOOR(RAND()*50)+10
	DECLARE @EmployeeID INT
	SET @EmployeeID = (SELECT BusinessUnitManagerID FROM dbo.BusinessUnits WHERE BusinessUnitID = @StockID)
	INSERT INTO dbo.Consignments(ConsignmentDate,EmployeeID,BusinessUnitID)
	VALUES
	(   
	    @DATE, 
	    @EmployeeID,         
	    @StockID          
	    )
	DECLARE @ConsignmentID INT
	SET @ConsignmentID = SCOPE_IDENTITY()
	DECLARE RandomProducts CURSOR
	FOR SELECT TOP(@ConsignmentSize)ProductID,VendorID,VendorPrice FROM dbo.Products WHERE Active =1 ORDER BY NEWID()
	DECLARE @ProductID int,@VendorID INT,@VendorPrice MONEY,@ProductQuantity INT
	OPEN RandomProducts
	FETCH NEXT FROM RandomProducts INTO @ProductID,@VendorID,@VendorPrice
	WHILE(@@fetch_status <> -1)
	BEGIN
		SET @ProductQuantity = FLOOR(RAND()*100)+40
		INSERT INTO dbo.ConsignmentsDetails	(ConsignmentNumber,VendorID,ProductID,Quantity,VendorPrice)	
		VALUES
		(   @ConsignmentID,
		    @VendorID,   
		    @ProductID,   
		    @ProductQuantity,   
		    @VendorPrice
		)
		FETCH NEXT FROM RandomProducts INTO @ProductID,@VendorID,@VendorPrice
	END
	CLOSE RandomProducts
	DEALLOCATE RandomProducts
END
GO

CREATE PROCEDURE FillConsignments
AS
BEGIN
	DECLARE BUnits CURSOR
	FOR SELECT BusinessUnitID FROM dbo.BusinessUnits
	DECLARE @BUID INT
	OPEN BUnits
	FETCH NEXT FROM BUnits INTO @BUID
	DECLARE @RandDate DATE
	WHILE(@@FETCH_STATUS <> -1)
	BEGIN
		SET @RandDate = DATEADD(DAYOFYEAR,DATEDIFF(DAYOFYEAR,'2018-01-01',GETDATE())*(RAND())+1,'2018-01-01')
		EXEC dbo.GenerateConsignmentForStock @StockID = @BUID,        
		                                     @DATE = @RandDate
		FETCH NEXT FROM BUnits INTO @BUID
	END
	CLOSE BUnits
	DEALLOCATE BUnits
END

EXEC dbo.FillConsignments
DROP PROC dbo.GenerateConsignmentForStock
DELETE FROM dbo.ConsignmentsDetails WHERE ProductID IN (SELECT ProductID FROM dbo.Products WHERE Active = 0)