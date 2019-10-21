--2.- Haz unluistado que muestre los 3 cliente que mas compraron en(monto, con fletes y despuestos)


-- paso 1
select C.CustomerID,
       c.CompanyName,
       sum((OD.UnitPrice * OD.Quantity) * (1 - od.Discount)) + o.Freight  Total
from [Order Details] OD
    join Orders O
        on OD.OrderID = O.OrderID
    join Customers C
        on O.CustomerID = C.CustomerID
group by c.CustomerID, c.CompanyName,O.Freight
ORDER BY Total DESC ;
-- paso 2
select top 3 with ties C.CustomerID,
       c.CompanyName,
       sum((OD.UnitPrice * OD.Quantity) * (1 - od.Discount))  Total
from [Order Details] OD
    join Orders O
        on OD.OrderID = O.OrderID
    join Customers C
        on O.CustomerID = C.CustomerID
group by c.CustomerID, c.CompanyName
ORDER BY Total DESC ;
--paso 3
select top 3 with ties T1Total.CustomerID,
       T1Total.CompanyName,
       sum(T1Total.Total) total1
from (select C.CustomerID,
       c.CompanyName,
       sum((OD.UnitPrice * OD.Quantity) * (1 - od.Discount)) + o.Freight  Total
from [Order Details] OD
    join Orders O
        on OD.OrderID = O.OrderID
    join Customers C
        on O.CustomerID = C.CustomerID
group by c.CustomerID, c.CompanyName,O.Freight) T1Total
group by T1Total.CustomerID, T1Total.CompanyName
order by total1 desc ;