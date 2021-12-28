-- 2---


select distinct  o.OrderID,
       c.CustomerID,
       sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) over (partition by O.OrderID) + Freight Monto, o.OrderDate
from Customers C
         inner join Orders O on C.CustomerID = O.CustomerID
         inner join [Order Details] OD on O.OrderID = OD.OrderID