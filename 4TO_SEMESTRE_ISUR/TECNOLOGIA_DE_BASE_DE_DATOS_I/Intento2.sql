With Compras
As
(
	--ANCHOR
	Select	Row_Number() Over(Order by CustomerID) As Codigo,
			CustomerID As IDCliente,
			CompanyName As Cliente,
			Convert(Money, Null) As Monto
	From	Customers
	UNION ALL
	--RECURSIVE
	Select	Row_Number() Over(Order by CustomerID),
			O.CustomerID,
			C.Cliente,
			OS.Subtotal + O.Freight
	From	Orders As O
			Join Compras As C
				On C.IDCliente = O.CustomerID
			Join [Order Subtotals] As OS
				On O.OrderID = OS.OrderID
				
)
Select	*
From	Compras