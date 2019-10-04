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
de las órdenes atendidas por el mejor empleado 
del año.

Select	O.OrderID,
		O.EmployeeID,
		Year(O.OrderDate) As Año1,
		DatePart(Year, O.OrderDate) As Año2,
		Format(O.OrderDate, 'yyyy') As Año3,
		Left(Convert(Varchar(10), O.OrderDate, 112), 4) As Año4,
		Right(Convert(Varchar(10), O.OrderDate, 103),4) As Año5,
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
		(Select	EmployeeID, TD3.Año
		From	(
				Select	EmployeeID, Año, Sum(Monto) As Total
				From	(
						Select	O.OrderID,
								O.EmployeeID,
								Year(O.OrderDate) As Año,
								Round(O.Freight + Sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount)), 2) As Monto
						From	Orders As O
								Join [Order Details] As OD
									On O.OrderID = OD.OrderID
						Group by O.OrderID,
								O.EmployeeID,
								Year(O.OrderDate),
								O.Freight) As TD1
				Group by EmployeeID, Año) As TD3
				Join
				(Select	Año, Max(Total) As Maximo
				From	(
						Select	EmployeeID, Año, Sum(Monto) As Total
						From	(
								Select	O.OrderID,
										O.EmployeeID,
										Year(O.OrderDate) As Año,
										Round(O.Freight + Sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount)), 2) As Monto
								From	Orders As O
										Join [Order Details] As OD
											On O.OrderID = OD.OrderID
								Group by O.OrderID,
										O.EmployeeID,
										Year(O.OrderDate),
										O.Freight) As TD1
						Group by EmployeeID, Año) As TD2
				Group by Año) As TD4
					ON TD3.Año = TD4.Año
						And Round(TD3.Total,2) = Round(TD4.Maximo,2)) As TD5
			On O.EmployeeID = TD5.EmployeeID
				And Year(Orderdate) = TD5.Año
/*
3.- Listado de los productos que se hayan
vendido a más de dos precios diferentes.

Select	*
From	Products	As P
Where	(Select	Count(Distinct UnitPrice)
		From	[Order Details] As OD
		Where	ProductID = P.ProductID) > 2
*/