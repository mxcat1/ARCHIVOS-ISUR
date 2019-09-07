-- LISTADO DE LAS ORDENES POR CLIENTE LA CANTIDAD DE ORDENES EN CADA CLIENTE
-- y que tenga el numero de orden
-- ejemplo ordenid 10248 curtomerid VINET subtotal 4400.00 nro_orden 1/5
-- ejemplo ordenid 10274 curtomerid VINET subtotal 4400.00 nro_orden 2/5

select o.OrderID,
       o.CustomerID,
       os.Subtotal,
       convert(varchar(3),(select count(*)
           from Orders O2
           where o.CustomerID=O2.CustomerID -- subconsulta que cuenta cada orden y le pone el nro de orden
                AND o2.OrderID <= O.OrderID -- por cada customer id
        )) + '/' +
       convert(varchar(3),(select count(*)
           from Orders O2
           where o.CustomerID=O2.CustomerID -- subconsulta que saca la cantidad de ordenes en total por cada customer id
        ))
       Nro_Orden
from Orders O
    join [Order Subtotals] OS
        on O.OrderID=OS.OrderID

--SUB CONSULTA DENTRO DE UN FROM COMO TABLA DERIVADA
--EJEMPLO
-- sacar listado de los clientes en un determinado mes
-- sacar el lsitado de los clientes q hayan comprado en mayo del 98

select distinct
       c.*
from Orders O
    join Customers C
        on O.CustomerID = C.CustomerID
where O.OrderDate
        between '19980501' and '19980531';

-- haz un select de la ordenes con un join con la anterior consulta
select *
from Orders O
join (select distinct
             c.*
      from Orders O
      join Customers C
            on O.CustomerID = C.CustomerID  --subconsulta q devuelve los datos de de los customers que esten hayan echo una orden
      where O.OrderDate
            between '19980501' and '19980531') [CLIENTE ULTIMO MES]
    on O.CustomerID=[CLIENTE ULTIMO MES].CustomerID;