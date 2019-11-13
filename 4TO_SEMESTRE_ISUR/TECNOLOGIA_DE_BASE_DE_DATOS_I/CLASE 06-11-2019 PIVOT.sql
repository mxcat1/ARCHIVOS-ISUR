--PIVOT
--UNPIVOT
-- Puede usar los operadores relacionales PIVOTy UNPIVOTpara cambiar una
-- expresión con valores de tabla en otra tabla. PIVOTgira una expresión
-- con valores de tabla al convertir los valores únicos de una columna en l
-- a expresión en varias columnas en la salida. Y PIVOTejecuta agregaciones
-- donde se requieren en los valores de columna restantes que se desean en
-- la salida final. UNPIVOTrealiza la operación opuesta a PIVOTAR girando
-- las columnas de una expresión con valores de tabla en valores de columna.
-- La sintaxis para PIVOTprovide es más simple y más fácil de leer que la
-- sintaxis que de otro modo podría especificarse en una serie compleja de SELECT...CASEdeclaraciones.


--Ejemplso donde se utiliza el pivot
--https://www.capterra.es/directory


-- Ejercicio de pivot

select o.ShipCountry           as Pais,
       year(o.OrderDate)       as Año,
       o.Freight + os.Subtotal as Monto
from [Order Subtotals] as OS
         join Orders as O
              on OS.OrderID = O.OrderID;


-- Paso Pivot

select Pais,
       isnull([1996], 0) as [1996],
       isnull([1997], 0) as [1997],
       isnull([1998], 0) as [1998]
from (select o.ShipCountry           as Pais,
             year(o.OrderDate)       as Año,
             o.Freight + os.Subtotal as Monto
      from [Order Subtotals] as OS
               join Orders as O
                    on OS.OrderID = O.OrderID) TD
         pivot (
         sum(TD.Monto)
         For TD.Año
         IN ([1996],[1997],[1998])
         ) as PV1
order by Pais;

--pivot dinamico

select *
from (select o.ShipCountry           as Pais,
             year(o.OrderDate)       as Año,
             o.Freight + os.Subtotal as Monto
      from [Order Subtotals] as OS
               join Orders as O
                    on OS.OrderID = O.OrderID) TD
pivot (  );

select distinct year(OrderDate)
from Orders order by 1;

declare @años varchar(max);
select @años=coalesce(@años+'['+cast(Año as varchar(12))+'],','')
from (select distinct year(OrderDate) as Año
from Orders) TD1;

set @años=left(@años,LEN(@años)-1)
select @años;


--pivot dinamico url
--https://geeks.ms/fangarita/2012/01/02/code-pivote-dinmico-con-sql-server/