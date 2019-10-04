With Ventas
As(
Select	Distinct
		C.CustomerID,
		C.CompanyName,
		First_Value(O.OrderDate)
			Over(Partition By O.CustomerID
			Order by O.OrderDate) As [Primera Compra],
		Count(O.CustomerID) Over(Partition By O.CustomerID
			Order by O.CustomerID) As Cantidad,
		Last_Value(O.OrderDate)
			Over(Partition By O.CustomerID
			Order by O.OrderDate
			Rows Between Unbounded Preceding And Unbounded Following
			) As [Ultima Compra]
From	Customers As C
		Left Join Orders As O
On C.CustomerID = O.CustomerID)
Select	*
From	Ventas