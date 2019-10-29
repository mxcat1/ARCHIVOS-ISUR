Select Productname, ShipCountry, Acumulado
From (
Select *, LEAD(Acumulado,1) Over(partition By Productname, Shipcountry
								order By ProductName, ShipCountry) As Ultimo
From (
Select	P.ProductName,
		O.ShipCountry,
		Sum(Round(OD.UnitPrice * OD.Quantity * (1-OD.Discount), 2))
			Over(
				Partition By ProductName, ShipCountry
				Order By ProductName
				Rows Between Unbounded Preceding
						And Current Row) As Acumulado
From	Orders As O
		Join [Order Details] As OD
			On O.OrderID = OD.OrderID
		Join Products As P
			On P.ProductID = OD.ProductID

) As TD1
) As TD2
Where Ultimo Is Null