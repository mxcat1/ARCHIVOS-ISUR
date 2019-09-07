
-- en sql server magnament se puede usar el = en vez de is null
-- haceindo click derecho query options
-- en ANSI en la opcion SET ANSI NULL desrmarcarlo
-- para permitir el = envez del is null
-- nota otro forma es usando set ansi_nulls off



-- consulta par aobtener solo los elementos de una tabla q no esten relacionadas con otras tablas
-- Para obtener unicamente los dos clientes que nunca compraron en CUSTOMERS
-- LEFT JOIN + WHERE IS NULL
select distinct C.*
from Customers as C
	left outer join Orders as O
		on c.CustomerID=o.CustomerID
where O.OrderID IS NULL ;

-- otra forma
-- Para obtener unicamente los dos clientes que nunca compraron

-- USANDO EL OPERADOR IN
select *
from Customers
where CustomerID not in (select CustomerID from Orders);

    -- Operador IN Ejemplo

    select *
    from Suppliers
    where City IN ('Berlin','London','Ravenna');

    -- otro ejemplo
    select *
    from [Order Details]
    where Discount in (0.05,0.1,0.25);

    --variacion del in con subconsultas
    select *
    from Suppliers
    where City IN (select distinct City from Employees);

-- USANDO EL OPERADOR EXISTS
-- EXISTS ("Lista o consulta") "Existencia" ve si hay resultado en una subconsulta o en una lista
-- Listar los dos clientes que no me han comprado
select *
from Customers as C
where not EXISTS(select CustomerID
                    from Orders as O
                    where O.CustomerID=C.CustomerID);


