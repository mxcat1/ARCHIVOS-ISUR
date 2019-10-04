/*
Listado de clientes que en un mes hayan realizado mas de 3 ordenes hecho con exists
en un solo año
*/
select *
from Customers C
where exists(
		select O.CustomerID,
			   Year(O.OrderDate)as Anio,
			   Month(O.OrderDate) as Mes,
			   count(O.OrderID) as Ordenes
		from Orders O
		where C.CustomerID = O.CustomerID
		group by O.CustomerID,
				 Year(O.OrderDate),
				 Month(O.OrderDate)
		having  count(O.OrderID) > 3
		)




		







