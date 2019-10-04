Select Distinct O.*
From	Orders As O
Join (Select Top 30 CustomerID
		From Orders As O
		Join [Order Details] As OD
		On O.OrderID = OD.OrderID
		Group By CustomerID
		Order By Sum(UnitPrice*Quantity)  Desc) As C
	On O.CustomerID = C.CustomerID
Join [Order Details] As OD
	On O.OrderID = OD.OrderID
Join (Select	Top 20 OD.ProductID
	From	[Order Details] As OD
	Group By OD.ProductID
	Order By Sum(OD.Quantity) Desc) As P
On OD.ProductID = P.ProductID