Select	Format(Dense_Rank() Over(Order By C.CustomerID) + 
		Row_Number() Over(Partition By C.CustomerID Order By C.CustomerID)/100.0, '00.00') As Codigo,
		C.CompanyName As Cliente,
		O.OrderID As ID,
		O.Freight + OS.Subtotal As Monto,
		Case Sign((O.Freight + OS.Subtotal) / FIRST_VALUE(O.Freight + OS.Subtotal) Over(Partition By C.CustomerID Order By C.CustomerID) - 1)
			When -1 Then 'BAJÓ'
			When 1	Then 'SUBIÓ'
			When 0 Then 'IGUAL'
		End + Replicate(' ', 6) + Format((O.Freight + OS.Subtotal) / FIRST_VALUE(O.Freight + OS.Subtotal) Over(Partition By C.CustomerID Order By C.CustomerID) - 1, '0.00%') As Cambio
From	Orders As O
		Join [Order Subtotals] As OS
			On O.OrderID = OS.OrderID
		Join Customers As C
			On C.CustomerID = O.CustomerID

			Union

			Select	Format(Dense_Rank() Over(Order By C.CustomerID), '00') As Codigo,
		C.CompanyName As Cliente,
		Null,
		Null, NULL
From	Customers As C
