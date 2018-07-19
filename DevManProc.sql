CREATE PROCEDURE SP_MostPopularProducts
    @startDate date =NULL,
    @endDate date = NULL,
    @count INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
	IF(@startDate IS NULL AND @endDate IS NULL)
	SELECT @startDate = '2018-01-01', @endDate = GETDATE()
	ELSE IF (@startDate IS NOT NULL AND @endDate IS NULL)
	SET @endDate = GETDATE()
	ELSE IF (@startDate IS NULL AND @endDate IS NOT NULL)
	SET @startDate = '2018-01-01'
	ELSE IF (@endDate<@startDate)
	RAISERROR('Start Date can`t be bigger than End Date',16,1)
	ELSE IF (@count<=0)
	RAISERROR('Procedure cannot return 0 or less rows',16,1)

	SELECT TOP(@count) P.ProductID,P.ProductName,J.ProductAmount,P.FinalPrice,P.VendorPrice,P.Markup
	FROM dbo.Products P 
		JOIN(SELECT OD.ProductID, SUM(OD.Quantity) AS ProductAmount
		FROM dbo.Orders O 
			JOIN dbo.OrderDetails OD
				ON O.OrderID = OD.OrderID
		WHERE O.OrderDate BETWEEN @startDate AND @endDate
		GROUP BY OD.ProductID) J
			ON P.ProductID = J.ProductID
	WHERE P.Active = 1
	ORDER BY J.ProductAmount DESC
	END TRY
	BEGIN CATCH
	DECLARE @MSG VARCHAR(100)
	SET @MSG = ERROR_MESSAGE();
	THROW 500001 ,@MSG,1
	END CATCH	
	SET NOCOUNT OFF
END
go

CREATE PROCEDURE SP_LeastPopularProducts
    @startDate date = NULL,
    @endDate date = NULL,
    @count INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
	IF(@startDate IS NULL AND @endDate IS NULL)
	SELECT @startDate = '2018-01-01', @endDate = GETDATE()
	ELSE IF (@startDate IS NOT NULL AND @endDate IS NULL)
	SET @endDate = GETDATE()
	ELSE IF (@startDate IS NULL AND @endDate IS NOT NULL)
	SET @startDate = '2018-01-01'
	ELSE IF (@endDate<@startDate)
	RAISERROR('Start Date can`t be bigger than End Date',16,1)
	ELSE IF (@count<=0)
	RAISERROR('Procedure cannot return 0 or less rows',16,1)

	SELECT TOP(@count) P.ProductID,P.ProductName, J.ProductAmount,P.FinalPrice,P.VendorPrice,P.Markup
	FROM dbo.Products P 
		JOIN(SELECT OD.ProductID, SUM(OD.Quantity) AS ProductAmount
		FROM Orders O 
			JOIN OrderDetails OD
				ON O.OrderID = OD.OrderID
		WHERE (O.OrderDate BETWEEN @startDate AND @endDate)
		GROUP BY OD.ProductID) J
			ON P.ProductID = J.ProductID
	WHERE P.Active = 1
	ORDER BY J.ProductAmount ASC
	END TRY
	BEGIN CATCH
	DECLARE @MSG VARCHAR(100)
	SET @MSG = ERROR_MESSAGE();
	THROW 500001 ,@MSG,1
	END CATCH	
	SET NOCOUNT OFF
END
GO


CREATE PROCEDURE SP_ReturnedProducts
	@startDate date = NULL,
    @endDate date = NULL,
    @count INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
	IF(@startDate IS NULL AND @endDate IS NULL)
	SELECT @startDate = '2018-01-01', @endDate = GETDATE()
	ELSE IF (@startDate IS NOT NULL AND @endDate IS NULL)
	SET @endDate = GETDATE()
	ELSE IF (@startDate IS NULL AND @endDate IS NOT NULL)
	SET @startDate = '2018-01-01'
	ELSE IF (@endDate<@startDate)
	RAISERROR('Start Date can`t be bigger than End Date',16,1)
	ELSE IF (@count<=0)
	RAISERROR('Procedure cannot return 0 or less rows',16,1)

	SELECT TOP(@count) P.ProductID,P.ProductName,J.ProductAmount,J.ReturnType,P.FinalPrice,P.VendorPrice,P.Markup
		FROM dbo.Products P JOIN (SELECT ProductID, ReturnType, SUM(Quantity) AS ProductAmount
		FROM dbo.ReturnProducts 
		WHERE DateMonth BETWEEN @startDate AND @endDate
		GROUP BY ProductID ,ReturnType ) J
		ON P.ProductID = J.ProductID
		ORDER BY J.ProductAmount DESC
	END TRY
	BEGIN CATCH
	DECLARE @MSG VARCHAR(100)
	SET @MSG = ERROR_MESSAGE();
	THROW 500001 ,@MSG,1
	END CATCH

	SET NOCOUNT OFF
END
GO

CREATE VIEW VW_ProductsPopularity
AS 
SELECT P.ProductID,P.ProductName,P.VendorPrice,P.Markup,P.FinalPrice,S1.CustomerCity,S1.Quantity,S1.[Percent]
FROM dbo.Products P 
	JOIN (SELECT C.CustomerCity,OD.ProductID,OD.Quantity ,CAST(OD.Quantity AS FLOAT)/SUM(OD.Quantity) OVER(PARTITION BY C.CustomerCity)*100 AS [Percent]
	FROM dbo.Customers C 
		JOIN dbo.Orders O 
			ON O.CustomerID = C.CustomerID
		JOIN dbo.OrderDetails OD 
			ON OD.OrderID = O.OrderID) S1 
		ON  S1.ProductID = P.ProductID
WHERE P.Active = 1

