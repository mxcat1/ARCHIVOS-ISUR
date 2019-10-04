/*
4.	Usando IN: Considerando la cantidad de órdenes realizadas por año y país, 
haz un listado de los clientes que viven en aquellos países en los cuales se 
han realizado menos de 7 órdenes en dos o más años. En el cuadro de ejemplo, 
solo deberían salir los clientes de los países que tienen un ícono verde.
*/

select *
from Customers C
Where C.Country in(
	select ShipCountry
	from(
		select O.ShipCountry,
						Year(O.OrderDate) as Año,
						count(O.OrderID) as Ordenes
		from Orders O
		group by O.ShipCountry,
				 Year(O.OrderDate)) as T
	Where Ordenes < 7)






