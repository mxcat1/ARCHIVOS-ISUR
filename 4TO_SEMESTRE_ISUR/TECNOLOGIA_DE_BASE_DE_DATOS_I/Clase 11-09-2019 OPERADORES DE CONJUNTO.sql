--OPERADORES DE CONJUNTO
-- INTERSECION -----> INTERSECT
-- UNON ----------->UNION
-- DIFERENCIA ------------>EXCEPT

-- EN LOS OPERADORES DE CONJUNTO DEBE HABER LA MISMA CANTIDAD DE COLUMNAS CON EL MISMO TIPO DE DATOSA EN EL SELECT EN AMBAS CONSULTAS


---CLIENTES QUE ME COMPRARON EL PRODUCTO CHAI


select distinct
       C.CustomerID,
       C.CompanyName,
       C.ContactName,
       C.Country
from Customers C
join Orders O
    on C.CustomerID = O.CustomerID
join [Order Details] [O D]
    on O.OrderID = [O D].OrderID
join Products P
    on [O D].ProductID = P.ProductID
where P.ProductName='chai'
-- order by c.CustomerID; --en cualquier operador de conjunto la primera consulta no puede tener order by

-- INTERSECT
-- UNION
-- UNION ALL
except
--PERSONAS QUE ME COMPRARON EN EL PRIMER TRIMESTRE  DEL AÑO 97

select distinct
       C.CustomerID,
       C.CompanyName,
       C.ContactName,
       C.Country
from Customers C
join Orders O
    on C.CustomerID = O.CustomerID
-- where o.OrderDate between '19970101' and '19970331'
-- where o.OrderDate>='19970101' and o.OrderDate<'19970401'
-- where year(o.OrderDate)=1997 and
--       month(o.OrderDate)<=3
where datepart(year,o.OrderDate)=1997
        and datepart(quarter ,o.OrderDate)=1  --quarter es primer trimestre
order by 1;


---EJER2

select c.CustomerID AS ID,
       c.ContactName as NOMBRE,
       'Cliente' as TIPO
from Customers C
union
select CONVERT(VARCHAR(2),s.SupplierID),
       s.ContactName,
       'Proveedor'
from Suppliers S
union
select CAST(E.EmployeeID AS VARCHAR(2)),
       e.FirstName +' '+ e.LastName,
       'Empleado'
from Employees E;