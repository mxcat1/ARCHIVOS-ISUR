/*
1.- Con subconsultas: Sacar un listado de productos
 donde se muestre el ID, nombre, precio promedio 
 y unidades vendidas.


Select	P.ProductID As ID,
		P.ProductName As Nombre,
		Round((Select Avg(OD.UnitPrice)From [Order Details] As OD Where P.ProductID = OD.ProductID), 2) As [Precio Promedio],
		(Select Sum(OD.Quantity) From [Order Details] As OD Where P.ProductID = OD.ProductID) As [Unidades Vendidas]
From	Products As P
*/
/*
2.- Con tablas derivadas: Obtener un listado 
de las �rdenes atendidas por el mejor empleado 
del a�o.

Select	O.OrderID,
		O.EmployeeID,
		Year(O.OrderDate) As A�o1,
		DatePart(Year, O.OrderDate) As A�o2,
		Format(O.OrderDate, 'yyyy') As A�o3,
		Left(Convert(Varchar(10), O.OrderDate, 112), 4) As A�o4,
		Right(Convert(Varchar(10), O.OrderDate, 103),4) As A�o5,
		O.Freight,
		OD.Quantity,
		OD.UnitPrice,
		OD.Discount
From	Orders As O
		Join [Order Details] As OD
			On O.OrderID = OD.OrderID
*/
Select	*
From	Orders As O
		Join
		(Select	EmployeeID, TD3.A�o
		From	(
				Select	EmployeeID, A�o, Sum(Monto) As Total
				From	(
						Select	O.OrderID,
								O.EmployeeID,
								Year(O.OrderDate) As A�o,
								Round(O.Freight + Sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount)), 2) As Monto
						From	Orders As O
								Join [Order Details] As OD
									On O.OrderID = OD.OrderID
						Group by O.OrderID,
								O.EmployeeID,
								Year(O.OrderDate),
								O.Freight) As TD1
				Group by EmployeeID, A�o) As TD3
				Join
				(Select	A�o, Max(Total) As Maximo
				From	(
						Select	EmployeeID, A�o, Sum(Monto) As Total
						From	(
								Select	O.OrderID,
										O.EmployeeID,
										Year(O.OrderDate) As A�o,
										Round(O.Freight + Sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount)), 2) As Monto
								From	Orders As O
										Join [Order Details] As OD
											On O.OrderID = OD.OrderID
								Group by O.OrderID,
										O.EmployeeID,
										Year(O.OrderDate),
										O.Freight) As TD1
						Group by EmployeeID, A�o) As TD2
				Group by A�o) As TD4
					ON TD3.A�o = TD4.A�o
						And Round(TD3.Total,2) = Round(TD4.Maximo,2)) As TD5
			On O.EmployeeID = TD5.EmployeeID
				And Year(Orderdate) = TD5.A�o
/*
3.- Listado de los productos que se hayan
vendido a m�s de dos precios diferentes.

Select	*
From	Products	As P
Where	(Select	Count(Distinct UnitPrice)
		From	[Order Details] As OD
		Where	ProductID = P.ProductID) > 2
*/