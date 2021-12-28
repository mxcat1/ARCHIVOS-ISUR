select *
from Customers c
where c.ContactName like '[A,E,I,O,U]%';

select o.OrderID, o.CustomerID, p.CategoryID, sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))
from [Order Details] od
         inner join Products P on P.ProductID = od.ProductID
         inner join Orders O on O.OrderID = od.OrderID
group by o.CustomerID, p.CategoryID, o.OrderID;

select td1.CustomerID,td1.CategoryID,sum(monto)
from (select o.OrderID, o.CustomerID, p.CategoryID, sum((od.Quantity * od.UnitPrice) * (1 - od.Discount)) monto
      from [Order Details] od
               inner join Products P on P.ProductID = od.ProductID
               inner join Orders O on O.OrderID = od.OrderID
      group by o.CustomerID, p.CategoryID, o.OrderID) td1
group by td1.CustomerID, td1.CategoryID;

select td2.CategoryID,td2.CustomerID,max(monto2)
from (select td1.CustomerID,td1.CategoryID,sum(monto) monto2
from (select o.OrderID, o.CustomerID, p.CategoryID, sum((od.Quantity * od.UnitPrice) * (1 - od.Discount)) monto
      from [Order Details] od
               inner join Products P on P.ProductID = od.ProductID
               inner join Orders O on O.OrderID = od.OrderID
      group by o.CustomerID, p.CategoryID, o.OrderID) td1
group by td1.CustomerID, td1.CategoryID)td2 inner join (select *
from Customers c
where c.ContactName like '[A,E,I,O,U]%')tda1 on td2.CustomerID=tda1.CustomerID
group by td2.CategoryID, td2.CustomerID;