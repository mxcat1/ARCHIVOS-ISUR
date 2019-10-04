/*
1.Listado de clientes que muestre el monto comprado por el cliente, y el porcentaje con 
respecto al total, ID y nombre
*/


select Ventas.CustomerID,
       C.CompanyName,
	   Monto,
	   Convert(varchar(100),ceiling(Monto / 100)) + '%'  as Porcentaje
from(
	select distinct O.CustomerID,
		   Round(sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount))over
		   (Partition by O.CustomerID Order by CustomerID) + O.Freight,2) as Monto
	from Orders O join [Order Details] OD
	on O.OrderID = OD.OrderID) as Ventas

	join Customers C
on C.CustomerID = Ventas.CustomerID