/*
Listado de OrderID, Nombre del Producto, Fecha de la Orden, Precio de Venta, Cantidad Vendida
con las siguientes limitaciones: ventas del año 1997 
*/

select O.OrderID, P.ProductName, O.OrderDate, OD.UnitPrice, OD.Quantity
from Orders O join [Order Details] OD
    on O.OrderID = OD.OrderID join Products P
	on OD.ProductID = P.ProductID
Where Year(O.OrderDate) = '1997'

/*
Listar los productos segun su stock, solamente mostrar los productos cuyo stock sea del 11 al 20 
*/

select *
from Products P
order by UnitsInStock
offset 14 rows fetch next 15 rows only