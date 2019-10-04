/*
3.	Mostrar el ID, nombre y 
monto comprado (con fletes y 
descuentos) de todos los 
clientes que en total hayan 
comprado entre 1000 y 3000 soles.
*/
Select CustomerID, CompanyName, Sum(Monto) As Total
From (
		Select	C.CustomerID,
				C.CompanyName,
				Round(Sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount)) + O.Freight, 2) As Monto
		From	Orders As O
				Join [Order Details] As OD
					On O.OrderID = OD.OrderID
				Join Customers As C
					On C.CustomerID = O.CustomerID
		Group By C.CustomerID,
				C.CompanyName,
				O.Freight,
				O.OrderID) As TD1
Group By CustomerID, CompanyName
Having Sum(Monto) Between 1000 And 3000