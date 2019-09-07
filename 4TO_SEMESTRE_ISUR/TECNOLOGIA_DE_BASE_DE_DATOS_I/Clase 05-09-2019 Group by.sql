--Funciones de agrupacion
-- GROUPS
-- GROUP BY -> FUNCIONES DE AGRAGADOS -> COUNT,AVG,SUM,MAX,MIN

--EJEMPLO1
-- listar Cantidad de productos por categorias

select c.CategoryName,
       count(P.ProductName) [Cantidad de Productos]
from Products P
join Categories C
    on P.CategoryID = C.CategoryID
group by c.CategoryName;

--EJEMPL2
-- por categoria quiero saver cual es el precio promedio por categoria
select c.CategoryName,
       count(P.ProductName) [Cantidad de Productos],
       avg(p.UnitPrice) [Precio Promedio]
from Products P
join Categories C
    on P.CategoryID = C.CategoryID
group by c.CategoryName;

-- modificacion 1
-- cantidad de productos por categoria discontinuados
select c.CategoryName,
       count(P.ProductName) [Cantidad de Productos],
       avg(p.UnitPrice) [Precio Promedio]
from Products P
join Categories C
    on P.CategoryID = C.CategoryID
where P.Discontinued=1
group by c.CategoryName;
-- modificacion 1
-- cantidad de productos por categoria discontinuados con having
-- having funciona despues de agrupar
select c.CategoryName,
       count(P.ProductName) [Cantidad de Productos],
       avg(p.UnitPrice) [Precio Promedio]
from Products P
join Categories C
    on P.CategoryID = C.CategoryID
where P.Discontinued=1
group by c.CategoryName
having count(p.ProductName)>1;


--EJERCICIO 1

--Quiero saber cuanto se compro por pais y por ciudad en dinero

--CON ROLLUP
select ISNULL(o.ShipCountry,'TOTAL GENERAL') PAIS, -- si es nulo remplazar con el segundo parametro
       ISNULL(O.ShipCity,'Todas') CIUDAD,
       SUM(OS.Subtotal) TOTAL
from Orders O
join [Order Subtotals] OS
    on OS.OrderID=O.OrderID
group by  o.ShipCountry,o.ShipCity with rollup --arma subtotales por cada grupo por eso se ve null y un numero en total
order by o.ShipCountry,o.ShipCity;

-- CON CUBE
select ISNULL(o.ShipCountry,'TOTAL GENERAL') PAIS, -- si es nulo remplazar con el segundo parametro
       ISNULL(O.ShipCity,'Todas') CIUDAD,
       SUM(OS.Subtotal) TOTAL
from Orders O
join [Order Subtotals] OS
    on OS.OrderID=O.OrderID
group by  o.ShipCountry,o.ShipCity with CUBE --SACA UN SUBTOTAL CONVINANDO TODOS CON TODOS.
order by o.ShipCountry,o.ShipCity;

--CON CUBE Y ROLLUP OTRO EJEMPLO1

-- QUIERO VER VENTAS POR PRODUCTO Y POR CLIENTE
-- QUIERO SABER QUE PRODUCTO ME COMPRO QUE CLIENTE Y CUANTO CON SU DESCUENTO

--con rollup
select CU.CompanyName,
       C.CategoryName,
       P.ProductName,
       SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as MONTO
from [Order Details] OD
JOIN Products P
    on OD.ProductID = P.ProductID
join Categories C
    on P.CategoryID = C.CategoryID
join Orders O
    on OD.OrderID = O.OrderID
join Customers CU
    on O.CustomerID = CU.CustomerID
group by CU.CompanyName, C.CategoryName, P.ProductName with rollup ;
--con cube
select CU.CompanyName,
       C.CategoryName,
       P.ProductName,
       SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as MONTO
from [Order Details] OD
JOIN Products P
    on OD.ProductID = P.ProductID
join Categories C
    on P.CategoryID = C.CategoryID
join Orders O
    on OD.OrderID = O.OrderID
join Customers CU
    on O.CustomerID = CU.CustomerID
group by CU.CompanyName, C.CategoryName, P.ProductName with cube ;



--TAREA

--QUIERO VER UN LISTADO QUE ME DIGA POR CLIENTE QUE PRODUCTOS(NOMBRE) HA COMPRADO , PERIODO DE LA COMPRA(FECHA DE LA COMPRA EJM'MAR-96')
--EL MONTO DE LA COMPRA Y QUE SE VEA CONBINACIONES DE TODOS CONTRA TODOS
-- Y HAY QUE INCLUIR LOS CLIENTE QUE NO TE COMPRARON Y QUE DIGA QUE ESE CLIENTE COMPRO CERO
-- NOTA INCLUIR TODOS LOS CLIENTES POR CADA MES