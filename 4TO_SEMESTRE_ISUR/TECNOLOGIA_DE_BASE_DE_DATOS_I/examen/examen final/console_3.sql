-- 3.-
select c.CompanyName,
       o.OrderDate,
       (os.Subtotal + o.Freight) TotalOrden,
       year(o.OrderDate) Año,
       sum(os.Subtotal + o.Freight) over ( partition by (year(o.OrderDate)),o.CustomerID order by (year(o.OrderDate)),o.CustomerID) TotalporAño,
       sum(os.Subtotal + o.Freight) over ( partition by o.CustomerID order by o.CustomerID) TotalporCliente
from Orders O
         join [Order Subtotals] os on O.OrderID = os.OrderID
         join Customers C on O.CustomerID = C.CustomerID;