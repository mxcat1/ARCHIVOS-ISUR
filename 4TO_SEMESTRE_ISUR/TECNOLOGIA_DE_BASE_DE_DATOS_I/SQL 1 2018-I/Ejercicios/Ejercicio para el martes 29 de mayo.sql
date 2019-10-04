--listar aquellos clientes que hayan hecho alguna orden cuyo destino sea otro pais donde no sea el suyo 
--con operador de conjunto

select *
from Customers Cus
join(
	select O.CustomerID, O.ShipCountry as Pais
	from Orders O 

	except

	select C.CustomerID, C.Country as Pais
	from Customers C) as Paises 
on Cus.CustomerID = Paises.CustomerID








