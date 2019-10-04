/*
Listado de clientes(Campos del cliente)que han comprado menos de 10 productos diferentes 
*/

 select *
 from Customers C
 where C.CustomerID in(
	select O.CustomerID		   
	from Orders O join [Order Details] OD
	on O.OrderID = OD.OrderID
	group by O.CustomerID
	having count(distinct OD.ProductID) < 10)
