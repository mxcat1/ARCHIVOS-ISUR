select *
from (select P.ProductName,
             C.CategoryName,
             (od.UnitPrice * od.Quantity) * (1 - od.Discount) + o.Freight                                   Total,
             sum(sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight) over ( order by ProductName) Año,
             format(o.OrderDate, 'MMMM-yyyy')                                                                    Fecha
      from Products as P
               join Categories C
                    on P.CategoryID = C.CategoryID
               join [Order Details] OD
                    on P.ProductID = OD.ProductID
               join Orders O
                    on OD.OrderID = O.OrderID
      group by P.ProductName, C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate,OD.UnitPrice,od.Quantity,od.Discount) TDA1
pivot (sum (Total)
    FOR Fecha in ([julio-1996],[agosto-1996],[septiembre-1996],[octubre-1996],[noviembre-1996],[diciembre-1996],[enero-1997],[febrero-1997],[marzo-1997],[abril-1997],[mayo-1997],[junio-1997],[julio-1997],[agosto-1997],[septiembre-1997],[octubre-1997],[noviembre-1997],[diciembre-1997],[enero-1998],[febrero-1998],[marzo-1998],[abril-1998],[mayo-1998]) )as PVT order by ProductName;



select P.ProductName,
       C.CategoryName,
       sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight                                   Total,
       sum(sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight) over ( order by ProductName) Año,
       format(o.OrderDate, 'MMMM-yyyy')                                                                    Fecha
from Products as P
         join Categories C
              on P.CategoryID = C.CategoryID
         join [Order Details] OD
              on P.ProductID = OD.ProductID
         join Orders O
              on OD.OrderID = O.OrderID
group by P.ProductName, C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate
order by ProductName, OrderDate;


select distinct p.ProductName,
                c.CategoryName,
                sum(((od.UnitPrice*od.Quantity)*(1-od.Discount))+o.Freight) over ( partition by ProductName order by ProductName),
                sum(((od.UnitPrice*od.Quantity)*(1-od.Discount))+o.Freight) over ( partition by CategoryName order by CategoryName),
                format(o.OrderDate,'MMMM-yyyy')
from [Order Details] OD
    join Orders O on OD.OrderID = O.OrderID
    join Products P on OD.ProductID = P.ProductID
    join Categories C on P.CategoryID = C.CategoryID;