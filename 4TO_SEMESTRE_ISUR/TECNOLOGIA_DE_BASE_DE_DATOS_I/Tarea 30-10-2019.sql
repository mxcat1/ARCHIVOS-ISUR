--Distribucion por año y pais
-- el monto comprado por el año y el pais
-- Porcentaje que representa ese monto en el año
--Diferencia con el año anterior
--AÑO       PAIS            Monto       %       Diferencia
--1996      Argentina       $50000       50%    +$50000
--1996      Brazil          $40000       40%    +$40000        =>Total al año =100000
--1996      Colombia        $10000       10%    +$10000
--------------------------------------------------------
--1997      Peru            $10          10%    +$10
--1997      Brazil          $20          20%    -$39980        =>Total al año = 100
--1997      Venezuela       $60          60%    +$60
--1997      Argentina       $10          10%    -$49990

select distinct year(o.OrderDate) Año,
                o.ShipCountry,
--              os.Subtotal+o.Freight Poruni,
                sum(os.Subtotal + o.Freight)
                    over ( partition by year(o.OrderDate),o.ShipCountry
                        order by year(o.OrderDate),o.ShipCountry
                        )         Monto
from [Order Subtotals] OS
         join Orders O
              on OS.OrderID = O.OrderID;
-- group by year(o.OrderDate), o.ShipCountry, os.Subtotal+o.Freight;

select distinct year(o.OrderDate)                                                                       Año,
                o.ShipCountry,
--              os.Subtotal+o.Freight Poruni,
                sum(os.Subtotal + o.Freight)                                                            Monto,
                sum(sum(os.Subtotal + o.Freight))
                    over (partition by year(o.OrderDate) order by year(o.OrderDate),o.ShipCountry asc ) Acumulado
from [Order Subtotals] OS
         join Orders O
              on OS.OrderID = O.OrderID
group by year(o.OrderDate), o.ShipCountry;


select distinct year(o.OrderDate)                          Año,
                o.ShipCountry                              Pais,
                sum(os.Subtotal + o.Freight)
                    over ( partition by year(o.OrderDate),o.ShipCountry
                        order by year(o.OrderDate),o.ShipCountry
                        )                                  Monto,
                sum(os.Subtotal + o.Freight)
                    over (partition by year(o.OrderDate) ) Acumulado
from [Order Subtotals] OS
         join Orders O
              on OS.OrderID = O.OrderID;


select Acumulado
from (select distinct year(o.OrderDate)                          Año,
                      o.ShipCountry                              Pais,
                      sum(os.Subtotal + o.Freight)
                          over (partition by year(o.OrderDate) ) Acumulado
      from [Order Subtotals] OS
               join Orders O
                    on OS.OrderID = O.OrderID) TD1
where Año = 1996
  and Pais = 'Austria';


select distinct year(o.OrderDate)                                  Año,
                o.ShipCountry                                      Pais,
                sum(os.Subtotal + o.Freight)
                    over ( partition by year(o.OrderDate),o.ShipCountry
                        order by year(o.OrderDate),o.ShipCountry
                        )                                          Monto,
                ((sum(os.Subtotal + o.Freight)
                      over ( partition by year(o.OrderDate),o.ShipCountry
                          order by year(o.OrderDate),o.ShipCountry
                          )) * 100) / (select Acumulado
                                       from (select distinct year(o.OrderDate)                          Año,
                                                             o.ShipCountry                              Pais,
                                                             sum(os.Subtotal + o.Freight)
                                                                 over (partition by year(o.OrderDate) ) Acumulado
                                             from [Order Subtotals] OS
                                                      join Orders O
                                                           on OS.OrderID = O.OrderID) TD1
                                       where Año = year(o.OrderDate)
                                         and Pais = o.ShipCountry) Porcentaje
from [Order Subtotals] OS
         join Orders O
              on OS.OrderID = O.OrderID;


select *,
       isnull((select distinct
                               sum(os.Subtotal + o.Freight)
                                   over ( partition by year(o.OrderDate),o.ShipCountry
                                       order by year(o.OrderDate),o.ShipCountry
                                       )         Monto
               from [Order Subtotals] OS
                        join Orders O
                             on OS.OrderID = O.OrderID
               where year(o.OrderDate) = TDA1.Año - 1
                 AND o.ShipCountry = TDA1.Pais), 0)-Monto Diferencia
from (select distinct year(o.OrderDate)                                  Año,
                      o.ShipCountry                                      Pais,
                      sum(os.Subtotal + o.Freight)
                          over ( partition by year(o.OrderDate),o.ShipCountry
                              order by year(o.OrderDate),o.ShipCountry
                              )                                          Monto,
                      ((sum(os.Subtotal + o.Freight)
                            over ( partition by year(o.OrderDate),o.ShipCountry
                                order by year(o.OrderDate),o.ShipCountry
                                )) * 100) / (select Acumulado
                                             from (select distinct year(o.OrderDate)                          Año,
                                                                   o.ShipCountry                              Pais,
                                                                   sum(os.Subtotal + o.Freight)
                                                                       over (partition by year(o.OrderDate) ) Acumulado
                                                   from [Order Subtotals] OS
                                                            join Orders O
                                                                 on OS.OrderID = O.OrderID) TD1
                                             where Año = year(o.OrderDate)
                                               and Pais = o.ShipCountry) Porcentaje
      from [Order Subtotals] OS
               join Orders O
                    on OS.OrderID = O.OrderID
     ) TDA1;


-- Forma simple

WITH Ventas AS(
    SELECT distinct YEAR( o.OrderDate) AS Año,
        o.ShipCountry     AS Pais,
        SUM(os.Subtotal + o.Freight) over ( partition by year(o.OrderDate),o.ShipCountry
                                       order by year(o.OrderDate),o.ShipCountry
                                       ) AS Monto
    FROM [Order Subtotals] AS OS
    JOIN Orders AS O ON OS.OrderID = O.OrderID
)
SELECT  Año,
        Pais,
        Monto,
        Monto * 100. / SUM( Monto) OVER( PARTITION BY Año) AS Porcentaje,
        Monto - LAG( Monto, 1, 0) OVER( PARTITION BY Pais ORDER BY Año) AS Diferencia
FROM Ventas
ORDER BY Año, Pais;


