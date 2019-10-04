--Listado de productos(id,nombre,precio,nombre del cliente que MAS haya comprado ese producto)

select P.ProductID,
       ProductName,
	   P.UnitPrice,
	   (select T.CompanyName
	    from(
	    select top 1 OD.ProductID,
		             C.CompanyName,  
		             sum(Od.Quantity) as Cantidad	              
	    from [Order Details] OD join Orders O
		on OD.OrderID = O.OrderID join Customers C
		on C.CustomerID = O.CustomerID
		Where OD.ProductID = P.ProductID
		group by OD.ProductID,C.CompanyName
		Order by Cantidad desc) as T 
		) [Cliente que compro mas]
from Products P 







