Select	Distinct O.OrderID,
		O.CustomerID
From	Orders As O
		Join [Order Details] As OD
				On O.OrderID = OD.OrderID
		Join (	Select Top 10 With Ties OD.ProductID,
						Sum(OD.Quantity) As Cantidad
				From	[Order Details] As OD
				Group By OD.ProductID
				Order By 2 Desc) As PMV
			On OD.ProductID = PMV.ProductID