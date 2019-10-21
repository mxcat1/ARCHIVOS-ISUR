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
Order By Monto Desc