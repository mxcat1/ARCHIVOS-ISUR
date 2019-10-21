-- 6.- has unnlistado que muestre elmes y año de la compra (ejm juenio 1996)),
-- el monto vendido ese mes y el monto acumulado de ventas hasta ese periodo (un acumulado)

SET language spanish;

-- Paso 1

select o.OrderID,datename(MONTH ,o.OrderDate) +' - '+ DATENAME(year,O.OrderDate) [MES Y AÑO],
       sum((OD.UnitPrice*OD.Quantity)*(1-od.Discount)) + o.Freight Total
from Orders O
    join [Order Details] OD
        on O.OrderID = OD.OrderID
group by o.OrderID, datename(MONTH ,o.OrderDate) +' - '+ DATENAME(year,O.OrderDate),O.Freight;

-- Paso 2

select T1Total.[MES Y AÑO],
       sum(T1Total.Total) TOTAL_MES_AÑO
from (select o.OrderID,
             datename(MONTH, o.OrderDate) + ' - ' + DATENAME(year, O.OrderDate) [MES Y AÑO],
             sum((OD.UnitPrice * OD.Quantity) * (1 - od.Discount)) + o.Freight  Total
      from Orders O
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
      group by o.OrderID, datename(MONTH, o.OrderDate) + ' - ' + DATENAME(year, O.OrderDate), O.Freight) T1Total
group by T1Total.[MES Y AÑO];


-- Paso 3
select T1Total.[MES Y AÑO],
       sum(T1Total.Total) TOTAL_MES_AÑO
from (select o.OrderID,
             datename(MONTH, o.OrderDate) + ' - ' + DATENAME(year, O.OrderDate) [MES Y AÑO],
             DATENAME(year, O.OrderDate) Año,
             MONTH(O.OrderDate) Mes,
             sum((OD.UnitPrice * OD.Quantity) * (1 - od.Discount)) + o.Freight  Total
      from Orders O
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
      group by o.OrderID, datename(MONTH, o.OrderDate) + ' - ' + DATENAME(year, O.OrderDate), O.Freight,DATENAME(year, O.OrderDate),MONTH(O.OrderDate)) T1Total
group by T1Total.[MES Y AÑO],T1Total.Año,T1Total.Mes
order by Año,Mes;

--PASO 4

with Untotal
AS (
        select TOP 1000000 T1Total.[MES Y AÑO],
               sum(T1Total.Total) TOTAL_MES_AÑO,
                SUM(SUM(T1Total.Total)) OVER (order by Año, Mes) [Acumulado]
        from (select o.OrderID,
                     datename(MONTH, o.OrderDate) + ' - ' + DATENAME(year, O.OrderDate) [MES Y AÑO],
                     DATENAME(year, O.OrderDate)                                        Año,
                     MONTH(O.OrderDate)                                                 Mes,
                     sum((OD.UnitPrice * OD.Quantity) * (1 - od.Discount)) + o.Freight  Total
              from Orders O
                       join [Order Details] OD
                            on O.OrderID = OD.OrderID
              group by o.OrderID, datename(MONTH, o.OrderDate) + ' - ' + DATENAME(year, O.OrderDate), O.Freight,
                       DATENAME(year, O.OrderDate), MONTH(O.OrderDate)) T1Total
        group by T1Total.[MES Y AÑO], T1Total.Año, T1Total.Mes
        order by Año, Mes



) select * from Untotal;