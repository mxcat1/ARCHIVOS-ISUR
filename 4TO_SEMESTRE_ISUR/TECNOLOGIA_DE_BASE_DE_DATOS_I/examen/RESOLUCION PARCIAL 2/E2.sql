/*2.	Haz un listado que muestre
los 3 clientes que más compraron
(en monto, con fletes y descuentos)	2 Ptos*/
Select	Top 3 With Ties O.CustomerID,
		C.CompanyName,
		Sum(O.Freight + OS.Subtotal) As Monto
From	Orders As O
	Join [Order Subtotals] As OS
		On O.OrderID = OS.OrderID
	Join Customers As C
		On C.CustomerID = O.CustomerID
Group By O.CustomerID,
		C.CompanyName
Order By Monto Desc;

Select	Top 3 With Ties C.CustomerID,
		C.CompanyName,
		(Select Sum(O.Freight + OS.Subtotal)
		From	Orders As O
			Join [Order Subtotals] As OS
				On O.OrderID = OS.OrderID
		Where	O.CustomerID = C.CustomerID) As [Monto Comprado]
From	Customers As C
Order By [Monto Comprado] Desc
Go
Create Function MontoXCliente
	(@IDCliente	Varchar(5))
Returns Money
As
Begin
	Return (Select Sum(O.Freight + OS.SubTotal)
			From	Orders As O
				Join [Order Subtotals] As OS
					On O.OrderID = OS.OrderID
			Where O.CustomerID = @IDCliente)
End

Select	Top 3 With Ties	C.CustomerID,
		C.CompanyName,
		dbo.MontoXCliente(C.CustomerID) As Monto
From	Customers As C
Order by Monto Desc