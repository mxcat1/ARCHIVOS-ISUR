SELECT Clientes.CustomerID AS [ID del Cliente], 
       Clientes.CompanyName AS Empresa, 
       ISNULL(A�o96.Monto, 0) AS [Monto del A�o96], 
       ISNULL(A�o97.Monto, 0) AS [Monto del A�o97], 
       ISNULL(A�o98.Monto, 0) AS [Monto del A�o98]
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
) AS A�o96 ON Clientes.CustomerID = A�o96.ID
     LEFT JOIN
(
    SELECT C.CustomerID AS ID, 
           SUM(O.Freight + S.SubTotal) AS Monto
    FROM Customers AS C
         JOIN Orders AS O ON C.CustomerID = O.CustomerID
         JOIN [Order Subtotals] AS S ON O.OrderID = S.OrderID
    WHERE YEAR(O.OrderDate) = 1997
    GROUP BY C.CustomerID
) AS A�o97 ON Clientes.CustomerID = A�o97.ID
     LEFT JOIN
(
    SELECT C.CustomerID AS ID, 
           SUM(O.Freight + S.SubTotal) AS Monto
    FROM Customers AS C
         JOIN Orders AS O ON C.CustomerID = O.CustomerID
         JOIN [Order Subtotals] AS S ON O.OrderID = S.OrderID
    WHERE YEAR(O.OrderDate) = 1998
    GROUP BY C.CustomerID
) AS A�o98 ON Clientes.CustomerID = A�o98.ID;