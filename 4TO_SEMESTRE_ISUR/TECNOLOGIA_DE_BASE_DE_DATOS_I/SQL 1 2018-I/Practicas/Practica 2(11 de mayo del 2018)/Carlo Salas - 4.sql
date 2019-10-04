/*
4.	Usando IN: Considerando la cantidad de �rdenes realizadas por a�o y pa�s, 
haz un listado de los clientes que viven en aquellos pa�ses en los cuales se 
han realizado menos de 7 �rdenes en dos o m�s a�os. En el cuadro de ejemplo, 
solo deber�an salir los clientes de los pa�ses que tienen un �cono verde.
*/

select *
from Customers C
Where C.Country in(
	select ShipCountry
	from(
		select O.ShipCountry,
						Year(O.OrderDate) as A�o,
						count(O.OrderID) as Ordenes
		from Orders O
		group by O.ShipCountry,
				 Year(O.OrderDate)) as T
	Where Ordenes < 7)






