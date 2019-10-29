--Ejericio 1


select O.OrderDate,
       P.ProductName,
       O.ShipCountry,
       (od.UnitPrice * od.Quantity) * (1 - od.Discount)           Total,
       sum(round((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2))
           over ( partition by P.ProductName,o.ShipCountry
               order by P.ProductName,o.ShipCountry
               rows between unbounded preceding and current row ) Acumulado
from Orders O
         join [Order Details] OD
              on O.OrderID = OD.OrderID
         join Products P
              on OD.ProductID = P.ProductID;


--Ejercicio 2
--solo el acumulado total por pais y producto

--Funciones offset
-- LAG() devuelve un registro arriba ejm LAG(DATO,FILAS ARRIBA,VALOR POR DEFECTO SI ES NULL)

select O.OrderDate,
       P.ProductName,
       O.ShipCountry,
       (od.UnitPrice * od.Quantity) * (1 - od.Discount)           Total,
       sum(round((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2))
           over ( partition by P.ProductName,o.ShipCountry
               order by P.ProductName,o.ShipCountry
               rows between unbounded preceding and current row ) Acumulado,
       lag((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2, 0)
           over ( partition by P.ProductName,o.ShipCountry
               order by P.ProductName,o.ShipCountry)              Acumulado_Con_LAG
from Orders O
         join [Order Details] OD
              on O.OrderID = OD.OrderID
         join Products P
              on OD.ProductID = P.ProductID;

-- LEAD() devuelve cantidad fila mas abajo ejm LEAD(DATO,FILAS ABAJO,VALOR POR DEFECTO SI ES NULL)

select O.OrderDate,
       P.ProductName,
       O.ShipCountry,
       (od.UnitPrice * od.Quantity) * (1 - od.Discount)           Total,
       sum(round((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2))
           over ( partition by P.ProductName,o.ShipCountry
               order by P.ProductName,o.ShipCountry
               rows between unbounded preceding and current row ) Acumulado,
       Lead((od.UnitPrice * od.Quantity) * (1 - od.Discount), 1, 0)
            over ( partition by P.ProductName,o.ShipCountry
                order by P.ProductName)                           Acumulado_Con_LAG
from Orders O
         join [Order Details] OD
              on O.OrderID = OD.OrderID
         join Products P
              on OD.ProductID = P.ProductID;

--FIRST_VALUE() devuelve el primer valor de la particion o de la tabla ejm FIRST_VALUE(DATOS)
select O.OrderDate,
       P.ProductName,
       O.ShipCountry,
       (od.UnitPrice * od.Quantity) * (1 - od.Discount)           Total,
       sum(round((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2))
           over ( partition by P.ProductName,o.ShipCountry
               order by P.ProductName,o.ShipCountry
               rows between unbounded preceding and current row ) Acumulado,
       FIRST_VALUE((od.UnitPrice * od.Quantity) * (1 - od.Discount))
                   over ( partition by P.ProductName,o.ShipCountry
                       order by P.ProductName)                    Acumulado_Con_LAG
from Orders O
         join [Order Details] OD
              on O.OrderID = OD.OrderID
         join Products P
              on OD.ProductID = P.ProductID;


--LAST_VALUE() devuelve el ultimo valor de la particion o de la tabla ejm LAST_VALUE(DATOS)
select O.OrderDate,
       P.ProductName,
       O.ShipCountry,
       (od.UnitPrice * od.Quantity) * (1 - od.Discount)           Total,
       sum(round((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2))
           over ( partition by P.ProductName,o.ShipCountry
               order by P.ProductName,o.ShipCountry
               rows between unbounded preceding and current row ) Acumulado,
       LAST_VALUE((od.UnitPrice * od.Quantity) * (1 - od.Discount))
                  over ( partition by P.ProductName,o.ShipCountry
                      order by P.ProductName)                     Acumulado_Con_LAG
from Orders O
         join [Order Details] OD
              on O.OrderID = OD.OrderID
         join Products P
              on OD.ProductID = P.ProductID;


--Ejercicio 2
--solo el acumulado total por pais y producto

select TD1.OrderDate, ProductName, ShipCountry, Total,Acumulado,
       LAST_VALUE(Acumulado) over (order by ProductName,ShipCountry) Acumulado_total
from (select O.OrderDate,
             P.ProductName,
             O.ShipCountry,
             (od.UnitPrice * od.Quantity) * (1 - od.Discount)           Total,
             sum(round((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2))
                 over ( partition by P.ProductName,o.ShipCountry
                     order by P.ProductName,o.ShipCountry DESC
                     rows between unbounded preceding and current row ) Acumulado
      from Orders O
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
               join Products P
                    on OD.ProductID = P.ProductID) TD1;


select *
from (select TD1.OrderDate,
             ProductName,
             ShipCountry,
             Total,
             Acumulado,
             LAST_VALUE(Acumulado) over (order by ProductName,ShipCountry) Acumulado_total
      from (select O.OrderDate,
                   P.ProductName,
                   O.ShipCountry,
                   (od.UnitPrice * od.Quantity) * (1 - od.Discount)           Total,
                   sum(round((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2))
                       over ( partition by P.ProductName,o.ShipCountry
                           order by P.ProductName,o.ShipCountry
                           rows between unbounded preceding and current row ) Acumulado
            from Orders O
                     join [Order Details] OD
                          on O.OrderID = OD.OrderID
                     join Products P
                          on OD.ProductID = P.ProductID) TD1) TD2
where Acumulado=Acumulado_total;


select distinct ProductName, ShipCountry,
       LAST_VALUE(Acumulado) over (order by ProductName,ShipCountry) Acumulado_total
from (select O.OrderDate,
             P.ProductName,
             O.ShipCountry,
             (od.UnitPrice * od.Quantity) * (1 - od.Discount)           Total,
             sum(round((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2))
                 over ( partition by P.ProductName,o.ShipCountry
                     order by P.ProductName,o.ShipCountry DESC
                     rows between unbounded preceding and unbounded following ) Acumulado
      from Orders O
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
               join Products P
                    on OD.ProductID = P.ProductID) TD1;
