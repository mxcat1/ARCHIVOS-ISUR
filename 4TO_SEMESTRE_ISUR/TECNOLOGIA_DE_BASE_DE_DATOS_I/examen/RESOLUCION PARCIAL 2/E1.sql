/*1.	Haz un listado que muestre el ID
y nombre de los productos que se han
vendido únicamente una vez durante
el año (cualquier año)	3 Ptos*/
Select distinct 	OD.ProductID,
	P.ProductName
From	Orders As O
	Join [Order Details] As OD
		On O.OrderID = OD.OrderID
	Join Products As P
		On P.ProductID = OD.ProductID
Group by Year(O.OrderDate),
	OD.ProductID,
	P.ProductName
	Having Count(*) = 1
Order by ProductName;

Select distinct 	Productos.ID,
		Productos.Nombre
From
		(Select	Distinct year(OrderDate) As Año
		from	Orders) As Años
		Cross Join
		(Select ProductID As ID, ProductName As Nombre
		From products) As Productos
Where	(Select Count(*)
			From	[Order Details] As OD
			Join Orders As O
				On O.OrderID = OD.OrderID
			Where	Year(O.OrderDate) = Años.Año
				And OD.ProductID = Productos.ID) = 1
Order By Nombre;

Select	Distinct TDerivada.ProductID,
	TDerivada.ProductName
From
		(Select	year(o.OrderDate) As Año,
				P.ProductID,
				P.ProductName,
				Count(*) Over(Partition By year(o.OrderDate),P.ProductID) As Veces
		From	Orders As O
			Join [Order Details] As OD
				On O.OrderID = OD.OrderID
			Join Products As P
				On P.ProductID = OD.ProductID) As TDerivada
Where	Veces = 1
Order By 2