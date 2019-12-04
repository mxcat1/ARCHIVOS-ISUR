SELECT ISNULL( p.ProductName, 'Total') AS Producto,
       ISNULL( c.CategoryName, 'Global') AS Categoria,
       SUM(( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight),
       SUM(CASE WHEN o.OrderDate >= '19960701' AND o.OrderDate < '19960801' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [julio-1996], 
       SUM(CASE WHEN o.OrderDate >= '19960801' AND o.OrderDate < '19960901' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [agosto-1996], 
       SUM(CASE WHEN o.OrderDate >= '19960901' AND o.OrderDate < '19961001' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [septiembre-1996],
       SUM(CASE WHEN o.OrderDate >= '19961001' AND o.OrderDate < '19961101' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [octubre-1996], 
       SUM(CASE WHEN o.OrderDate >= '19961101' AND o.OrderDate < '19961201' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [noviembre-1996], 
       SUM(CASE WHEN o.OrderDate >= '19961201' AND o.OrderDate < '19970101' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [diciembre-1996], 
       SUM(CASE WHEN o.OrderDate >= '19970101' AND o.OrderDate < '19970201' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [enero-1997], 
       SUM(CASE WHEN o.OrderDate >= '19970201' AND o.OrderDate < '19970301' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [febrero-1997], 
       SUM(CASE WHEN o.OrderDate >= '19970301' AND o.OrderDate < '19970401' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [marzo-1997], 
       SUM(CASE WHEN o.OrderDate >= '19970401' AND o.OrderDate < '19970501' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [abril-1997], 
       SUM(CASE WHEN o.OrderDate >= '19970501' AND o.OrderDate < '19970601' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [mayo-1997], 
       SUM(CASE WHEN o.OrderDate >= '19970601' AND o.OrderDate < '19970701' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS [junio-1997]
FROM   Products         AS P
JOIN   Categories       AS C  ON P.CategoryID = C.CategoryID
JOIN   [Order Details]  AS OD ON P.ProductID  = OD.ProductID
JOIN   Orders           AS O  ON OD.OrderID   = O.OrderID
GROUP BY c.CategoryName, p.ProductName WITH ROLLUP
ORDER BY c.CategoryName, p.ProductName;