Select	Distinct P.ProductName,
		O.ShipCountry,
		Sum(Round(OD.UnitPrice * OD.Quantity * (1-OD.Discount), 2))
			Over(
				Partition By ProductName, ShipCountry
				Order By ProductName
				Rows Between Unbounded Preceding
						And Unbounded Following) As Acumulado
From	Orders As O
		Join [Order Details] As OD
			On O.OrderID = OD.OrderID
		Join Products As P
			On P.ProductID = OD.ProductID

