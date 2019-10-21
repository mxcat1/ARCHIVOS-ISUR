/*
4.	Elimina las órdenes que no tienen
detalles de orden	2 Ptos
*/
Delete O
From	Orders As O
	Left Join [Order Details] As OD
		On O.OrderID = OD.OrderID
Where	OD.OrderID Is Null


Insert Into Orders(OrderDate) Values(GetDate())
delete Orders
OUTPUT deleted.OrderID,
		deleted.OrderDate
Where	OrderID In (
Select O.OrderID
From	Orders As O
Except
Select	OD.OrderID
From	[Order Details] As OD)

delete O
From	Orders As O
Where	Not Exists (Select * From [Order Details] As OD
				Where	O.OrderID = OD.OrderID)

Delete From Orders
Where	OrderID IN (
Select	OrderID
From	(
		Select O.OrderID, Count(OD.OrderID) As Items
		From	Orders As O
			Left Join [Order Details] As OD
				On O.OrderID = OD.OrderID
		Group by O.OrderID) As TD1
Where	TD1.Items = 0)