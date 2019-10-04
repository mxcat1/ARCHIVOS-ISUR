
--1.Listado de los 20 productos mas vendidos /Tabla Derivada
--2.un listado de los 30 clientes que mas han comprado en dinero /Tabla Derivada
    /*Listado de las ordenes realizadas por alguno de los 30 mejores clientes en cuyo
	  detalle se encuente cualquiera de los 20 productos mas vendidos */

select Ordenes.*
from(
		select *
		from Orders O
		where O.CustomerID in(
				select Clientes.CustomerID
				from
				(select top 30 T.CustomerID, sum(T.Monto) as Monto
				from(
				select  O.OrderID, O.CustomerID,
					   (select round(sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount)),2)as Monto
						from [Order Details] OD
						where O.OrderID = OD.OrderID)as Monto
				from Orders O
				) T
				group by T.CustomerID
				order by Monto desc) as Clientes)) as Ordenes

		join [Order Details] OD on
		Ordenes.OrderID = OD.OrderID 
		join

		(select top 20 P.ProductID, P.ProductName,
			   (select sum(OD.Quantity) as Cantidad
			   from [Order Details] OD
			   where P.ProductID = OD.ProductID) as Cantidad
		from Products P
		order by Cantidad desc) as Productos
		on OD.ProductID = Productos.ProductID












