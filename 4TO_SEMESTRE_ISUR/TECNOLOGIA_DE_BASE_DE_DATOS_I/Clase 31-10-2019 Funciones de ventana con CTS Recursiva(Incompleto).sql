-- Ejercicio 1
-- Listado donde diga quien es el cliente y cada una de sus compras
-- ejem
-- Codigo#      Nombre_Cliente      ID_Orden        Monto_Orden         Porcentaje
-- 1            Tal_Sujeto          null            null                null
-- 1.1          Tal_Sujeto          10248           600                 11%
-- 1.2          Tal_Sujeto          10244           500                 11%
-- 2            Tal_Sujeto          null            null                null
-- 2.1          Tal_Sujeto          10241           100                 11%
-- 2.2          Tal_Sujeto          10242           300                 11%
-- 2.3          Tal_Sujeto          10243           500                 11%


--Parte1

select dense_rank() over ( order by c.CustomerID)                                                   NrCliente,
       row_number() over (partition by c.CompanyName order by c.CustomerID)                         NroOrden,
       format(dense_rank() over ( order by c.CustomerID) +
              row_number() over (partition by c.CompanyName order by c.CustomerID) / 100.0, '0.00') codigo,
       c.CompanyName                                                                                Nombre_Cliente,
       o.OrderID                                                                                    Id_Orden,
       os.Subtotal + o.Freight                                                                      Monto
from Orders O
         join [Order Subtotals] OS
              on O.OrderID = OS.OrderID
         join Customers C
              on O.CustomerID = C.CustomerID;

--Parte2
select format(dense_rank() over ( order by c.CustomerID), '00') NrCliente,
       c.CompanyName                                            Nombre_Cliente,
       null                                                     Id_Orden,
       null                                                     Monto,
       null                                                     Porcentaje
from Customers C
union
select format(dense_rank() over ( order by c.CustomerID) +
              row_number() over (partition by c.CompanyName order by c.CustomerID) / 100.0, '00.00') codigo,
       c.CompanyName                                                                                 Nombre_Cliente,
       o.OrderID                                                                                     Id_Orden,
       os.Subtotal + o.Freight                                                                       Monto,
       format((OS.Subtotal + o.Freight) /
              (first_value(OS.Subtotal + o.Freight) over (partition by c.CompanyName order by c.CustomerID)) - 1,
              '0.00%')
from Orders O
         join [Order Subtotals] OS
              on O.OrderID = OS.OrderID
         join Customers C
              on O.CustomerID = C.CustomerID;

--nota funcion sing() sirve para verificar si es positivo o negativo