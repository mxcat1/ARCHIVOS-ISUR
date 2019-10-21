/*
4.	Elimina las órdenes que no tienen
detalles de orden	2 Ptos
*/
Delete O
From	Orders As O
	Left Join [Order Details] As OD
		On O.OrderID = OD.OrderID
Where	OD.OrderID Is Null