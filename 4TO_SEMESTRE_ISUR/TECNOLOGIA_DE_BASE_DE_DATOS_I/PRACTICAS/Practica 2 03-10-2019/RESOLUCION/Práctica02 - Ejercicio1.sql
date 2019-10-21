SELECT Clientes.CustomerID AS [ID del Cliente], 
       Clientes.CompanyName AS Empresa, 
       ISNULL(Año96.Monto, 0) AS [Monto del Año96], 
       ISNULL(Año97.Monto, 0) AS [Monto del Año97], 
       ISNULL(Año98.Monto, 0) AS [Monto del Año98]
FROM Customers AS Clientes
     LEFT JOIN
(
    SELECT C.CustomerID AS ID, 
           SUM(O.Freight + S.SubTotal) AS Monto
    FROM Customers AS C
         JOIN Orders AS O ON C.CustomerID = O.CustomerID
         JOIN [Order Subtotals] AS S ON O.OrderID = S.OrderID
    WHERE YEAR(O.OrderDate) = 1996
    GROUP BY C.CustomerID
) AS Año96 ON Clientes.CustomerID = Año96.ID
     LEFT JOIN
(
    SELECT C.CustomerID AS ID, 
           SUM(O.Freight + S.SubTotal) AS Monto
    FROM Customers AS C
         JOIN Orders AS O ON C.CustomerID = O.CustomerID
         JOIN [Order Subtotals] AS S ON O.OrderID = S.OrderID
    WHERE YEAR(O.OrderDate) = 1997
    GROUP BY C.CustomerID
) AS Año97 ON Clientes.CustomerID = Año97.ID
     LEFT JOIN
(
    SELECT C.CustomerID AS ID, 
           SUM(O.Freight + S.SubTotal) AS Monto
    FROM Customers AS C
         JOIN Orders AS O ON C.CustomerID = O.CustomerID
         JOIN [Order Subtotals] AS S ON O.OrderID = S.OrderID
    WHERE YEAR(O.OrderDate) = 1998
    GROUP BY C.CustomerID
) AS Año98 ON Clientes.CustomerID = Año98.ID;