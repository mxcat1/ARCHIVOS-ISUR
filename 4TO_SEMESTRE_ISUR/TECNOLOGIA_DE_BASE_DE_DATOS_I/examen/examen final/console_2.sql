-- 4.-

BEGIN
declare
    @mes_anioM varchar(max);

select @mes_anioM = string_agg(MA, ',')
from (select quotename(Mes_Año) MA
      FROM (select distinct year(OrderDate)                Año,
                            format(OrderDate, 'MM')        Mes,
                            format(OrderDate, 'MMMM-yyyy') Mes_Año
            from Orders) TD1) TDA1A;

exec ('with Eje1 AS (
    select *
    from (select distinct ''Categoria ''+C.CategoryName Nombre_Item,
                          C.CategoryName Categoria,
                          datename(mm, o.OrderDate) + ''-'' + datename(yyyy, o.OrderDate) Fecha,
                          sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                              over (partition by C.CategoryName,datename(mm, o.OrderDate) + ''-'' + datename(yyyy, o.OrderDate)
                                  ORDER BY C.CategoryName,datename(mm, o.OrderDate) + ''-'' + datename(yyyy, o.OrderDate)) TMA1,
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
             pivot ( sum(TMA1) for Fecha in ('+@mes_anioM+')) PV1

    union all

    select *
    from (select distinct ''    ''+P.ProductName Nombre_Producto,
                          C.CategoryName,
                          datename(mm, o.OrderDate) + ''-'' + datename(yyyy, o.OrderDate)Fecha,
                          sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                              over (partition by p.ProductName,datename(mm, o.OrderDate) + ''-'' + datename(yyyy, o.OrderDate)
                                  ORDER BY p.ProductName,datename(mm, o.OrderDate) + ''-'' + datename(yyyy, o.OrderDate)) TMA,
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
             pivot ( sum(TMA) for Fecha in ('+@mes_anioM+')) PV1

)select Nombre_Item,'+@mes_anioM+',Total_Mes_Año from Eje1 order by Categoria,Total_Mes_Año desc ');
END ;