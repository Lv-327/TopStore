CREATE VIEW vwNoactiveProd
AS
SELECT p.Productname,p.size,p.material,v.CompanyName,bsp.BusinessUnitName,bsp.BusinessUnitAddress,bsp.BusinessUnitCity,p.Active
FROM dbo.Products p JOIN dbo.Vendors v ON v.VendorID = p.VendorID JOIN dbo.Stocks s ON s.ProductID = p.ProductID
JOIN dbo.BusinessUnits bsp ON bsp.BusinessUnitID = s.BusinessUnitID 
WHERE p.Active=0
GO
