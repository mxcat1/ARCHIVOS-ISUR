/*3.	Haz un listado que muestre el 
ID y nombre del cliente, el país de la 
venta y el monto total vendido (con fletes 
y descuentos), debe aparecer también el 
total por cada país y el total por 
cada cliente	5 Ptos*/
Select	*,
		(Select Sum(OS.Subtotal+O.Freight) From Orders As O Join [Order Subtotals] As OS On O.OrderID=OS.OrderID Where O.ShipCountry = Ventas.ShipCountry) As Total_Pais,
		(Select Sum(OS.Subtotal+O.Freight) From Orders As O Join [Order Subtotals] As OS On O.OrderID=OS.OrderID Where O.CustomerID = Ventas.CustomerID) As Total_Cliente
From	(
Select	C.CustomerID,
		C.CompanyName,
		O.ShipCountry,
		Sum(OS.Subtotal + O.Freight) As Monto
From	Customers As C
		Join Orders As O
			On C.CustomerID = O.CustomerID
		Join [Order Subtotals] As OS
			On O.OrderID = OS.OrderID
Group by C.CustomerID,
		C.CompanyName,
		O.ShipCountry) As Ventas
Order By 1