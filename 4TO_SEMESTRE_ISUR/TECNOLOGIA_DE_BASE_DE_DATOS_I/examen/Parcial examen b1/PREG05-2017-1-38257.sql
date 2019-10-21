-- 5.- Ha un listado que muestre el nombre de
-- los empleados que jamas le hayan vendido a cliente noruegos

select E.FirstName
from Orders O
         join [Order Details] OD
              on O.OrderID = OD.OrderID
         join Customers C
              on O.CustomerID = C.CustomerID
         join Employees E
              on O.EmployeeID = E.EmployeeID
where E.FirstName NOT IN (select E.FirstName
      from Orders O
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
               join Customers C
                    on O.CustomerID = C.CustomerID
               join Employees E
                    on O.EmployeeID = E.EmployeeID
      where O.ShipCountry = 'Norway'
      group by E.FirstName, O.ShipCountry)
GROUP BY E.FirstName