-- Tarea quiero saber por cada producto cuanto se a vendido cada mes-año
--EJM

--NOMBRE PRODUCTO       Enero 1996      Febrero 1996      Marzo 1996      Abril 1996      Mayo 1996     ETC....         TOTAL DE TODOS LOS AÑOS Y MES
-- Categoria 1          1080            Total               Total           Total           Total       ETC...          TOTAL DE TODOS LOS AÑOS Y MES DE CATEGORIA PRODUCTO
--Producto1             50              1500                1110            111             1111        ETC..           TOTAL DE TODOS LOS AÑOS Y MES DEL PRODUCTO
--Producto2             510             1500                1110            111             1111        ETC..           TOTAL DE TODOS LOS AÑOS Y MES DEL PRODUCTO
--Producto3             520             1500                1110            111             1111        ETC..           TOTAL DE TODOS LOS AÑOS Y MES DEL PRODUCTO
-- Categoria 2          1120            Total               Total           Total           Total       ETC...          TOTAL DE TODOS LOS AÑOS Y MES DE CATEGORIA PRODUCTO
--Producto1             50              1500                1110            111             1111        ETC..           TOTAL DE TODOS LOS AÑOS Y MES DEL PRODUCTO
--Producto2             530             1500                1110            111             1111        ETC..           TOTAL DE TODOS LOS AÑOS Y MES DEL PRODUCTO
--Producto3             540             1500                1110            111             1111        ETC..           TOTAL DE TODOS LOS AÑOS Y MES DEL PRODUCTO


select P.ProductName,
       C.CategoryName,
       sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight Total,
       format(o.OrderDate, 'MMMM-yyyy')                                  Fecha,
       o.OrderID
from Products as P
         join Categories C
              on P.CategoryID = C.CategoryID
         join [Order Details] OD
              on P.ProductID = OD.ProductID
         join Orders O
              on OD.OrderID = O.OrderID
group by P.ProductName, C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate, o.OrderID
order by o.OrderDate;

select distinct format(OrderDate, 'MMMM-yyyy') Mes_Año
from Orders
order by year(OrderDate), format(OrderDate, 'MM') asc;

select Mes_Año
FROM (select distinct year(OrderDate)                Año,
                      format(OrderDate, 'MM')        Mes,
                      format(OrderDate, 'MMMM-yyyy') Mes_Año
      from Orders) TD1
order by Año, Mes;


select P.ProductName,
       C.CategoryName,
       sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight Total,
       format(o.OrderDate, 'MMMM-yyyy')                                  Fecha
from Products as P
         join Categories C
              on P.CategoryID = C.CategoryID
         join [Order Details] OD
              on P.ProductID = OD.ProductID
         join Orders O
              on OD.OrderID = O.OrderID
group by P.ProductName, C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate
order by o.OrderDate;


-- with prueba1 as (
--     SELECT 'Customer' As Type, ContactName, City, Country
--     FROM Customers
--     UNION ALL
--     SELECT 'Supplier', ContactName, City, Country
--     FROM Suppliers
-- )select row_number() over (partition by Type  order by Type) num,* from prueba1
-- ORDER BY num,Type;

with ProductoVenta_Año as (
    select P.ProductName,
           C.CategoryName,
           sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight Total,
           format(o.OrderDate, 'MMMM-yyyy')                                  Fecha,
           o.OrderDate
    from Products as P
             join Categories C
                  on P.CategoryID = C.CategoryID
             join [Order Details] OD
                  on P.ProductID = OD.ProductID
             join Orders O
                  on OD.OrderID = O.OrderID
    group by P.ProductName, C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate
)
select PA.ProductName,
       CategoryName,
       Total,
       SUM(Total) OVER (ORDER BY ProductName),
       Fecha
from ProductoVenta_Año PA
order by ProductName, OrderDate;


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
order by ProductName, OrderDate


declare
    @mes_anioM varchar(max);

select @mes_anioM = string_agg(MA, ',')
from (select quotename(Mes_Año) MA
      FROM (select distinct year(OrderDate)                Año,
                            format(OrderDate, 'MM')        Mes,
                            format(OrderDate, 'MMMM-yyyy') Mes_Año
            from Orders) TD1) TDA1A

print @mes_anioM;


-- select *
-- from (select P.ProductName,
--              C.CategoryName,
--              (od.UnitPrice * od.Quantity) * (1 - od.Discount) + o.Freight                                   Total,
--              sum(sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight) over ( order by ProductName) Año,
--              format(o.OrderDate, 'MMMM-yyyy')                                                                    Fecha
--       from Products as P
--                join Categories C
--                     on P.CategoryID = C.CategoryID
--                join [Order Details] OD
--                     on P.ProductID = OD.ProductID
--                join Orders O
--                     on OD.OrderID = O.OrderID
--       group by P.ProductName, C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate,OD.UnitPrice,od.Quantity,od.Discount) TDA1
-- pivot (sum (Total)
--     FOR Fecha in ([julio-1996],[agosto-1996],[septiembre-1996],[octubre-1996],[noviembre-1996],[diciembre-1996],[enero-1997],[febrero-1997],[marzo-1997],[abril-1997],[mayo-1997],[junio-1997],[julio-1997],[agosto-1997],[septiembre-1997],[octubre-1997],[noviembre-1997],[diciembre-1997],[enero-1998],[febrero-1998],[marzo-1998],[abril-1998],[mayo-1998]) )as PVT order by ProductName;


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

select C.CategoryName,
       sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
           over ( order by CategoryName,OrderDate) Total,
       format(o.OrderDate, 'MMMM-yyyy')            Fecha
from Products as P
         join Categories C
              on P.CategoryID = C.CategoryID
         join [Order Details] OD
              on P.ProductID = OD.ProductID
         join Orders O
              on OD.OrderID = O.OrderID
order by CategoryName, o.OrderDate;

--no funka
select CategoryName,
       sum(Total)                               TotalA,
       sum(Total) over ( order by CategoryName) TotalAño,
       Fecha
from (select C.CategoryName,
             sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                 over ( order by CategoryName,OrderDate) Total,
             format(o.OrderDate, 'MMMM-yyyy')            Fecha,
             OrderDate
      from Products as P
               join Categories C
                    on P.CategoryID = C.CategoryID
               join [Order Details] OD
                    on P.ProductID = OD.ProductID
               join Orders O
                    on OD.OrderID = O.OrderID
     ) TDA1
group by CategoryName, Fecha, Total
order by 1, 3;

--mal
select C.CategoryName,
       sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight                                    Total,
       sum(sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight) over ( order by CategoryName) Año,
       format(o.OrderDate, 'MMMM-yyyy')                                                                     Fecha
from Products as P
         join Categories C
              on P.CategoryID = C.CategoryID
         join [Order Details] OD
              on P.ProductID = OD.ProductID
         join Orders O
              on OD.OrderID = O.OrderID
group by C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate
order by CategoryName, OrderDate;


--Como no funcionaba en una sola subconsulta
-- lo mete en una derivada
select CategoryName,
       CategoryName c1,
       sum(Total)   tmesaño,
       Año,
       Fecha
from (select C.CategoryName,
             sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight                                    Total,
             sum(sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight) over ( order by CategoryName) Año,
             format(o.OrderDate, 'MMMM-yyyy')                                                                     Fecha
      from Products as P
               join Categories C
                    on P.CategoryID = C.CategoryID
               join [Order Details] OD
                    on P.ProductID = OD.ProductID
               join Orders O
                    on OD.OrderID = O.OrderID
      group by C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate) TDA1
group by CategoryName, Fecha, Año;


--pivot
--mal
select *
from (select CategoryName,
             CategoryName c1,
             Total        tmesaño,
             Año,
             Fecha
      from (select C.CategoryName,
                   sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight Total,
                   sum(sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)) + o.Freight)
                       over ( order by CategoryName)                                 Año,
                   format(o.OrderDate, 'MMMM-yyyy')                                  Fecha
            from Products as P
                     join Categories C
                          on P.CategoryID = C.CategoryID
                     join [Order Details] OD
                          on P.ProductID = OD.ProductID
                     join Orders O
                          on OD.OrderID = O.OrderID
            group by C.CategoryName, format(o.OrderDate, 'MMMM-yyyy'), o.Freight, o.OrderDate) TDA1
      group by CategoryName, Fecha, Año,Total) TDA12
pivot (sum(tmesaño) for Fecha
        in ([julio-1996],[agosto-1996],[septiembre-1996],[octubre-1996],[noviembre-1996],[diciembre-1996],[enero-1997],[febrero-1997],[marzo-1997],[abril-1997],[mayo-1997],[junio-1997],[julio-1997],[agosto-1997],[septiembre-1997],[octubre-1997],[noviembre-1997],[diciembre-1997],[enero-1998],[febrero-1998],[marzo-1998],[abril-1998],[mayo-1998])) AS PVA1
