Select	P.ProductName,
		O.ShipCountry,
		Last_Value(Sum(Round(OD.UnitPrice * OD.Quantity * (1-OD.Discount), 2)))
			Over(
				Partition By ProductName, ShipCountry
				Order By ProductName
				) As Acumulado
From	Orders As O
		Join [Order Details] As OD
			On O.OrderID = OD.OrderID
		Join Products As P
			On P.ProductID = OD.ProductID
group by P.ProductName,
		O.ShipCountry