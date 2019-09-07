-- JOINS CON STANDAR ANSI SQL81

--donde se utiliza solo el where para la relacion
--Desventaja si se olvida de poner la relacion en
-- el where funciona pero no de la manera de deberia ser


select *
from Customers,
     Orders
where Customers.CustomerID=Orders.CustomerID;

--- JOINS CON SQL ANSI 92
select *
from Customers C join Orders O
    on C.CustomerID = O.CustomerID;

--solo muestra los clientes custumers q compraron o q se encuentren en las dos tablas si repetir

select DISTINCT C.CustomerID,C.CompanyName,C.ContactName
from Customers C join Orders O
    on C.CustomerID = O.CustomerID;

select DISTINCT C.CustomerID,C.CompanyName,C.ContactName,O.OrderID
from Customers C join Orders O
    on C.CustomerID = O.CustomerID;

-- left join muestra los registros de la
-- izquierda q tengan o no relacion entre las dos tablas
select DISTINCT C.CustomerID,
                C.CompanyName,
                C.ContactName,
                O.OrderID
    --izquierda            --derecha
from Customers C left join Orders O
    on C.CustomerID = O.CustomerID;

--outer join
--o left outer join muestra los elementos de la izquierda q tengan o no relacion solo del aizquierd
-- lo mismo seria con right outer join
-- nota se puede omitir el outer

select DISTINCT C.CustomerID,
                C.CompanyName,
                C.ContactName,
                O.OrderID
from Customers C left outer join Orders O
    on C.CustomerID = O.CustomerID;

-- full join
-- sirve para mostrar todos los elementos

select DISTINCT C.CustomerID,
                C.CompanyName,
                C.ContactName,
                O.OrderID
from Customers C full join Orders O
    on C.CustomerID = O.CustomerID;

--cross join
-- muestra un producto cartesiano
-- osea relaciona todos los elementos de una tabla con otra
-- elemento por elemento
-- nota no lleva ON

select DISTINCT C.CustomerID,
                C.CompanyName,
                C.ContactName,
                O.OrderID
from Customers C cross join Orders O

-- nota el left o right join en el ansi 89 es igual a *= o =*