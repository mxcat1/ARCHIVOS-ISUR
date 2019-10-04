With Ordenes
As
(
	Select	O.OrderID As ID,
			C.CompanyName As Cliente,
			Round(Sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount))+O.Freight, 2) As Monto
	From	Orders As O
			Join Customers As C
				On C.CustomerID = O.CustomerID
			Join [Order Details] As OD
				On O.OrderID = OD.OrderID
	group by O.OrderID,
			C.CompanyName,
			O.Freight
)
Select	*,
		Case 
			When Monto - Lag(Monto, 1, 0.001) Over(partition By Cliente Order By ID) < 0 Then 'BAJÓ'
			When Monto - Lag(Monto, 1, 0.001) Over(partition By Cliente Order By ID) > 0 Then 'SUBIÓ'
			Else 'IGUAL'
		End + ' ' + 
		Convert(Varchar(15), Abs(Round(Monto - Lag(Monto, 1, 0) Over(partition By Cliente Order By ID), 2))) As Diferencia
From	Ordenes