WITH C
     AS (SELECT TOP 3 C.CustomerID AS ID, 
                      YEAR(O.OrderDate) AS Año, 
                      SUM(O.Freight + S.SubTotal) AS Monto
         FROM Customers AS C
              JOIN Orders AS O ON C.CustomerID = O.CustomerID
              JOIN [Order Subtotals] AS S ON O.OrderID = S.OrderID
         WHERE YEAR(O.OrderDate) = 1996
         GROUP BY C.CustomerID, 
                  YEAR(O.OrderDate)
         ORDER BY Monto DESC
         UNION ALL
         SELECT TOP 3 C.CustomerID AS ID, 
                      YEAR(O.OrderDate), 
                      SUM(O.Freight + S.SubTotal) AS Monto
         FROM Customers AS C
              JOIN Orders AS O ON C.CustomerID = O.CustomerID
              JOIN [Order Subtotals] AS S ON O.OrderID = S.OrderID
         WHERE YEAR(O.OrderDate) = 1997
         GROUP BY C.CustomerID, 
                  YEAR(O.OrderDate)
         ORDER BY Monto DESC
         UNION ALL
         SELECT TOP 3 C.CustomerID AS ID, 
                      YEAR(O.OrderDate), 
                      SUM(O.Freight + S.SubTotal) AS Monto
         FROM Customers AS C
              JOIN Orders AS O ON C.CustomerID = O.CustomerID
              JOIN [Order Subtotals] AS S ON O.OrderID = S.OrderID
         WHERE YEAR(O.OrderDate) = 1998
         GROUP BY C.CustomerID, 
                  YEAR(O.OrderDate)
         ORDER BY Monto DESC)
     SELECT *
     FROM C;