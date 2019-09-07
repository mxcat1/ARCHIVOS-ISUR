-- subconsultas subquery

--EJEMPLO 1 - funcion de agrupacion y group by con subconsulta
-- cual es el cliente que mas a comprado de un producto determinado

-- consulta incompleta
select o.CustomerID,
       od.ProductID,
        od.Quantity
from Orders O
    join [Order Details] OD
        on O.OrderID = OD.OrderID
order by 1,2;

--consulta con el group by y la funcion de agregacion SUM

select o.CustomerID,
       c.CompanyName,
       od.ProductID,
       sum(od.Quantity) as Quantity
from Orders O
    join [Order Details] OD
        on O.OrderID = OD.OrderID
    join Customers C
        on O.CustomerID = C.CustomerID
group by o.CustomerID, od.ProductID,c.CompanyName
order by od.ProductID, Quantity desc;

--subconsulta
-- no debe haber order by a menos q exista TOP u otros
-- solo debe expulsar un campo no 4
-- cuando usas una subconsulta detro del select solo puede haber un registro un valor

select P.ProductID,
       p.ProductName,
       (select TOP 1 o.CustomerID +' - '+C.CompanyName +'('+ convert(varchar(5),sum(od.Quantity)) +')'/*,
           c.CompanyName,
           od.ProductID,
           sum(od.Quantity) as Quantity*/
        from Orders O
            join [Order Details] OD
                on O.OrderID = OD.OrderID
            join Customers C
                on O.CustomerID = C.CustomerID
       -- usa el producto id para relacionar con la tabla order details
       -- se relacion con el select de afuera
        where OD.ProductID=p.ProductID
        group by o.CustomerID, od.ProductID,c.CompanyName
        order by sum(od.Quantity) desc
        ) Cliente
from Products P
order by ProductID;

--EJEMPLO 2
-- tabla derivada
-- subconsulta que este dentro del from
-- Listado de los 10 productos mas vendidos en cantidad

select top 10 WITH TIES OD.ProductID,
       sum(OD.Quantity) Quantity
from [Order Details] OD
group by OD.ProductID
order by Quantity desc;

-- tabla deriva
-- en cada orden de producto tiene relacionado con los 10 productos mas vendidos

SELECT distinct o.orderid,
       o.CustomerID
FROM Orders O
        join [Order Details] OD
            on O.OrderID = OD.OrderID
        join (select top 10 WITH TIES OD.ProductID,
                        sum(OD.Quantity) Quantity
                from [Order Details] OD
                group by OD.ProductID
                order by Quantity desc) PMV
            on OD.ProductID=PMV.ProductID;

select p.ProductName,
       [MAS VENDIDOS].ProductID,
       [MAS VENDIDOS].Quantity
from Products P,
     (select top 10 OD.ProductID,
       sum(OD.Quantity) Quantity
    from [Order Details] OD
    group by OD.ProductID
    order by Quantity desc) [MAS VENDIDOS]
WHERE P.ProductID=[MAS VENDIDOS].ProductID