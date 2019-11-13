select distinct P.ProductName,
                C.CategoryName,
                datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate) Fecha,
                sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                    over (partition by p.ProductName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate) ORDER BY p.ProductName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)),
                sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                    over ( partition by ProductName order by ProductName)
from Products as P
         join Categories C
              on P.CategoryID = C.CategoryID
         join [Order Details] OD
              on P.ProductID = OD.ProductID
         join Orders O
              on OD.OrderID = O.OrderID
order by CategoryName;


declare
    @mes_anioM varchar(max);

select @mes_anioM = string_agg(MA, ',')
from (select quotename(Mes_Año) MA
      FROM (select distinct year(OrderDate)                Año,
                            format(OrderDate, 'MM')        Mes,
                            format(OrderDate, 'MMMM-yyyy') Mes_Año
            from Orders) TD1) TDA1A;

print @mes_anioM;


select *
from (select distinct P.ProductName,
                      C.CategoryName,
                      datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate) Fecha,
                      sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                          over (partition by p.ProductName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)
                              ORDER BY p.ProductName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)) TMA,
                      sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                          over ( partition by ProductName
                              order by ProductName) TT
      from Products as P
               join Categories C
                    on P.CategoryID = C.CategoryID
               join [Order Details] OD
                    on P.ProductID = OD.ProductID
               join Orders O
                    on OD.OrderID = O.OrderID) TDA1
pivot ( sum(TMA) for Fecha in ([julio-1996],[agosto-1996],[septiembre-1996],[octubre-1996],[noviembre-1996],[diciembre-1996],[enero-1997],[febrero-1997],[marzo-1997],[abril-1997],[mayo-1997],[junio-1997],[julio-1997],[agosto-1997],[septiembre-1997],[octubre-1997],[noviembre-1997],[diciembre-1997],[enero-1998],[febrero-1998],[marzo-1998],[abril-1998],[mayo-1998])) PV1;


select distinct C.CategoryName ,
                C.CategoryName C1,
                datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate) Fecha,
                sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                    over (partition by C.CategoryName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate) ORDER BY C.CategoryName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)),
                sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                    over ( partition by C.CategoryName order by C.CategoryName)
from Products as P
         join Categories C
              on P.CategoryID = C.CategoryID
         join [Order Details] OD
              on P.ProductID = OD.ProductID
         join Orders O
              on OD.OrderID = O.OrderID
order by CategoryName;


select *
from (select distinct C.CategoryName,
                      C.CategoryName C1,
                      datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate) Fecha,
                      sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                          over (partition by C.CategoryName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)
                              ORDER BY C.CategoryName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)) TMA1,
                      sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                          over ( partition by C.CategoryName
                              order by C.CategoryName) TT1
      from Products as P
               join Categories C
                    on P.CategoryID = C.CategoryID
               join [Order Details] OD
                    on P.ProductID = OD.ProductID
               join Orders O
                    on OD.OrderID = O.OrderID) TDA2
pivot ( sum(TMA1) for Fecha in ([julio-1996],[agosto-1996],[septiembre-1996],[octubre-1996],[noviembre-1996],[diciembre-1996],[enero-1997],[febrero-1997],[marzo-1997],[abril-1997],[mayo-1997],[junio-1997],[julio-1997],[agosto-1997],[septiembre-1997],[octubre-1997],[noviembre-1997],[diciembre-1997],[enero-1998],[febrero-1998],[marzo-1998],[abril-1998],[mayo-1998])) PV1;


with Eje1 AS (
    select *
    from (select distinct C.CategoryName Nombre_Item,
                          C.CategoryName Categoria,
                          datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate) Fecha,
                          sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                              over (partition by C.CategoryName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)
                                  ORDER BY C.CategoryName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)) TMA1,
                          sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                              over ( partition by C.CategoryName
                                  order by C.CategoryName) Total_Mes_Año
          from Products as P
                   join Categories C
                        on P.CategoryID = C.CategoryID
                   join [Order Details] OD
                        on P.ProductID = OD.ProductID
                   join Orders O
                        on OD.OrderID = O.OrderID) TDA2
             pivot ( sum(TMA1) for Fecha in ([julio-1996],[agosto-1996],[septiembre-1996],[octubre-1996],[noviembre-1996],[diciembre-1996],[enero-1997],[febrero-1997],[marzo-1997],[abril-1997],[mayo-1997],[junio-1997],[julio-1997],[agosto-1997],[septiembre-1997],[octubre-1997],[noviembre-1997],[diciembre-1997],[enero-1998],[febrero-1998],[marzo-1998],[abril-1998],[mayo-1998])) PV1

    union all

    select *
    from (select distinct P.ProductName,
                          C.CategoryName,
                          datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)Fecha,
                          sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                              over (partition by p.ProductName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)
                                  ORDER BY p.ProductName,datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)) TMA,
                          sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                              over ( partition by ProductName
                                  order by ProductName)TT
          from Products as P
                   join Categories C
                        on P.CategoryID = C.CategoryID
                   join [Order Details] OD
                        on P.ProductID = OD.ProductID
                   join Orders O
                        on OD.OrderID = O.OrderID) TDA1
             pivot ( sum(TMA) for Fecha in ([julio-1996],[agosto-1996],[septiembre-1996],[octubre-1996],[noviembre-1996],[diciembre-1996],[enero-1997],[febrero-1997],[marzo-1997],[abril-1997],[mayo-1997],[junio-1997],[julio-1997],[agosto-1997],[septiembre-1997],[octubre-1997],[noviembre-1997],[diciembre-1997],[enero-1998],[febrero-1998],[marzo-1998],[abril-1998],[mayo-1998])) PV1

)select * from Eje1 order by Categoria,Total_Mes_Año desc ;