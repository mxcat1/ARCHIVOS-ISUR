--Haz un procedimiento almacenado que reciba el nombre de un producto y muestre un listado de cuántas unidades de dicho producto compró cada cliente. --Mostrar el nombre del cliente y la sumatoria de unidades compradas (Quantity), los registros deben estar ordenados descendentemente por cantidad



create or
alter procedure Pregunta1 @NombreProducto varchar(max)
as
begin
    select distinct c.ContactName,
                    sum(od.Quantity)
                        over (partition by c.ContactName,p.ProductName order by c.ContactName) CantidadaComprado
    from Customers c
             inner join Orders O on c.CustomerID = O.CustomerID
             inner join [Order Details] OD on O.OrderID = OD.OrderID
             inner join Products P on P.ProductID = OD.ProductID
    where p.ProductName = @NombreProducto
end
go;

execute Pregunta1 'CAMEMBERT PIERROT';

