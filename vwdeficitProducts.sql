USE TopStore
GO

CREATE VIEW vwdeficitProduct
AS
    SELECT ProductName,BusinessUnitName,BusinessUnitAddress,BusinessUnitCity,
	   CASE
    WHEN quantity < 20 THEN 'we need more stuff'
    WHEN quantity > 20  THEN 'quantity of stuff is admissible'
    ELSE 'we have no information about stuff'
    END AS 'StuffDeficit'
    FROM dbo.BestSellingProducts bsp JOIN 
    dbo.Stocks s ON s.ProductID = bsp.ProductID
	JOIN dbo.BusinessUnits bu ON s.BusinessUnitID=Bu.BusinessUnitID 
	GO

	SELECT * FROM vwdeficitProduct
