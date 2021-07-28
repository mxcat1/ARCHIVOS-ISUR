-- -- Vistas (views)
--     Diseñador
--     Codigo
--         Crear
--         Ver la definicion de la vista
--         Modificar
--         Eliminar
--         Ejecutar

-- Crear una vista
Create or alter view Lista_Productos
as
select ProductID, ProductName
from Products;

sp_helptext Lista_Productos;

select *
from Lista_Productos

-- Actializar vista

update Lista_Productos
set ProductName = upper(ProductName)

-- Agregar elementos en la vista

insert into Lista_Productos(ProductName)
values ('Boligrafo')

--------Ejemplo

create or alter view Ventas
as
select o.OrderID, c.CompanyName, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) + max(o.Freight) Monto
from Products as P
         join [Order Details] OD on P.ProductID = OD.ProductID
         join Orders O on O.OrderID = OD.OrderID
         join Customers C on C.CustomerID = O.CustomerID
group by o.OrderID, c.CompanyName;

select *
from Ventas

select o.OrderID, c.CompanyName, os.Subtotal + o.Freight as total
from [Order Subtotals] OS
         join Orders O on OS.OrderID = O.OrderID
         join Customers C on C.CustomerID = O.CustomerID

-----------Ejercicio

------ 1.- Sacar cuanto a comprado cada cliente mensualmenteç

select distinct c.CompanyName,
                format(o.OrderDate, 'MMMM', 'es-Es'),
                o.OrderID,
                sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))
from Orders O
         join [Order Details] OD on O.OrderID = OD.OrderID
         join Customers C on O.CustomerID = C.CustomerID
GROUP BY c.CompanyName, format(o.OrderDate, 'MMMM', 'es-Es'), o.OrderID


select NombreCompañia, MesAño, sum(Monto)
from (select distinct c.CompanyName                                               NombreCompañia,
                      convert(varchar(max), year(o.OrderDate)) + ' ' +
                      convert(varchar(max), format(o.OrderDate, 'MMMM', 'es-Es')) MesAño,
                      sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))       Monto
      from Orders O
               join [Order Details] OD on O.OrderID = OD.OrderID
               join Customers C on O.CustomerID = C.CustomerID
      GROUP BY c.CompanyName,
               convert(varchar(max), year(o.OrderDate)) + ' ' +
               convert(varchar(max), format(o.OrderDate, 'MMMM', 'es-Es')), o.OrderID) TV1
group by NombreCompañia, MesAño


select *
from (select distinct c.CompanyName                                               NombreCompañia,
                            convert(varchar(max), year(o.OrderDate)) + ' ' +
                            convert(varchar(max), format(o.OrderDate, 'MMMM', 'es-Es')) MesAño,
                            sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))       Monto
            from Orders O
                     join [Order Details] OD on O.OrderID = OD.OrderID
                     join Customers C on O.CustomerID = C.CustomerID
            GROUP BY c.CompanyName,
                     convert(varchar(max), year(o.OrderDate)) + ' ' +
                     convert(varchar(max), format(o.OrderDate, 'MMMM', 'es-Es'))) tvs pivot ( sum(Monto) for MesAño IN ([1998 mayo],
    [1998 marzo],
    [1998 febrero],
    [1998 enero],
    [1998 abril],
    [1997 septiembre],
    [1997 octubre],
    [1997 noviembre],
    [1997 mayo],
    [1997 marzo],
    [1997 junio],
    [1997 julio],
    [1997 febrero],
    [1997 enero],
    [1997 diciembre],
    [1997 agosto],
    [1997 abril],
    [1996 septiembre],
    [1996 octubre],
    [1996 noviembre],
    [1996 julio],
    [1996 diciembre],
    [1996 agosto])) as pvt