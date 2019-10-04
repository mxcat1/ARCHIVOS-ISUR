--3.	Mostrar el ID, nombre y monto comprado (con fletes y descuentos)
-- de todos los clientes que en total hayan comprado entre 1000 y 3000 soles.


select *
from Customers;

select *
from Orders;

select *
from [Order Details];


select o.OrderID,
       od.*
from Orders O
join [Order Details] OD on O.OrderID = OD.OrderID;

select o.OrderID,
       c.CustomerID,
       c.CompanyName,
       o.Freight,
       od.Discount,
       (sum(((od.Quantity*od.UnitPrice)-((od.Quantity*od.UnitPrice)*od.Discount))))+o.Freight TOTAL
from Customers C
join Orders O
    on C.CustomerID = O.CustomerID
join [Order Details] OD
    on O.OrderID = OD.OrderID
group by c.CustomerID, c.CompanyName,o.OrderID,o.Freight,od.Discount;

--- REAL OFICIAL

select o.OrderID,
       c.CustomerID,
       c.CompanyName,
       o.Freight,
       od.Discount,
       (sum((od.Quantity*od.UnitPrice)*(1-od.Discount)))+o.Freight TOTAL
from Customers C
join Orders O
    on C.CustomerID = O.CustomerID
join [Order Details] OD
    on O.OrderID = OD.OrderID
group by c.CustomerID, c.CompanyName,o.Freight,od.Discount,o.OrderID;

--CORRECION DEL LA PREGUNTA 3

select o.OrderID,
       c.CustomerID,
       c.CompanyName,
       o.Freight,
       (sum((od.Quantity*od.UnitPrice)*(1-od.Discount)))+o.Freight TOTAL
from Customers C
join Orders O
    on C.CustomerID = O.CustomerID
join [Order Details] OD
    on O.OrderID = OD.OrderID
group by c.CustomerID, c.CompanyName,o.Freight,o.OrderID;
    --parte 2

    SELECT CustomerID,CompanyName, SUM(TOTAL) TOTAL1 FROM (select o.OrderID,
                          c.CustomerID,
                          c.CompanyName,
                          o.Freight,
                          (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL
                   from Customers C
                            join Orders O
                                 on C.CustomerID = O.CustomerID
                            join [Order Details] OD
                                 on O.OrderID = OD.OrderID
                   group by c.CustomerID, c.CompanyName, o.Freight, o.OrderID) tABLA1
    GROUP BY CustomerID, CompanyName
    HAVING sum(TOTAL) BETWEEN 1000 AND 3000;