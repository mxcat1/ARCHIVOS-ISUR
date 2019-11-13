
declare @mes_anioM varchar(max);

select @mes_anioM = string_agg(MA,',') from (select quotename(Mes_Año) MA
FROM (select distinct year(OrderDate)                Año,
                      format(OrderDate, 'MM')        Mes,
                      format(OrderDate, 'MMMM-yyyy') Mes_Año
      from Orders) TD1) TDA1A;

print @mes_anioM;

exec ('select *
from (select P.ProductName,
             C.CategoryName,
             (od.UnitPrice * od.Quantity) * (1 - od.Discount) + o.Freight                                   Total,
             sum(sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight) over ( order by ProductName) Año,
             format(o.OrderDate, ''MMMM-yyyy'')                                                                    Fecha
      from Products P
               join Categories C
                    on P.CategoryID = C.CategoryID
               join [Order Details] OD
                    on P.ProductID = OD.ProductID
               join Orders O
                    on OD.OrderID = O.OrderID
      group by P.ProductName, C.CategoryName, format(o.OrderDate, ''MMMM-yyyy''), o.Freight, o.OrderDate,OD.UnitPrice,od.Quantity,od.Discount) TDA1
pivot (sum (Total)
    FOR Fecha in ('+@mes_anioM+')) as PVT1  order by ProductName;
');
