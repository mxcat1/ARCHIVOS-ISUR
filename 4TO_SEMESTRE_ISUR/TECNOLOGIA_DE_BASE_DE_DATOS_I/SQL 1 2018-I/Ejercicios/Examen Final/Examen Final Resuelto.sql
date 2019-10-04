/*
1)	Usando operadores de conjunto: Haz un listado que muestre los productos (ID y nombre) que se enviaron a Espa�a y que tambi�n fueron enviados a Francia.
	Considera el campo ShipCountry de la tabla Orders para hacer la comparaci�n.	2 Ptos
*/
Select	Distinct
		P.ProductID, P.ProductName
From	Products	As P
		Join [Order Details] As OD
			On P.ProductID = OD.ProductID
		Join Orders As O
			On O.OrderID = OD.OrderID
Where	O.ShipCountry = 'Spain'
Intersect
Select	Distinct
		P.ProductID, P.ProductName
From	Products	As P
		Join [Order Details] As OD
			On P.ProductID = OD.ProductID
		Join Orders As O
			On O.OrderID = OD.OrderID
Where	O.ShipCountry = 'France'
/*
2)	Usando operadores de conjunto: Haz un listado de los clientes (ID y CompanyName) que compraron en el a�o 1996 pero que no compraron en el a�o 1998	2 Ptos
*/
Select	C.CustomerID, C.CompanyName
From	Customers As C
		Join Orders As O
			On C.CustomerID = O.CustomerID
Where	Year(O.OrderDate) = 1996
Except
Select	C.CustomerID, C.CompanyName
From	Customers As C
		Join Orders As O
			On C.CustomerID = O.CustomerID
Where	Year(O.OrderDate) = 1998
/*
3)	Haz un listado donde se vea el ID y nombre completo (apellidos y nombres) de los trabajadores, clientes y proveedores.
	Para el caso de los clientes y proveedores utiliza el campo ContactName. Tambi�n se deben ver tres columnas: Proveedor, Cliente y Trabajador.
	En cada una de �stas columnas deber� aparecer una �X� dependiendo de cada uno de los registros.
	Si una persona fuese a la vez proveedor y cliente, deber� aparecer una �X� en ambas columnas	4 Ptos
*/
Select	*,
Case (Select Count(*) From Customers As P Where P.ContactName = Personas.ContactName)					When 0 Then '' Else 'X' End As Cliente,
Case (Select Count(*) From Suppliers As P Where P.ContactName = Personas.ContactName)					When 0 Then '' Else 'X' End As Proveedor,
Case (Select Count(*) From Employees As P Where P.FirstName + ' ' + P.LastName = Personas.ContactName)	When 0 Then '' Else 'X' End As Empleado
From	(Select ContactName From Customers
		Union Select ContactName From Suppliers
		Union Select FirstName + ' ' + LastName From Employees) As Personas
/*
4)	Usando PIVOT: Muestra un listado donde se vea el monto vendido por cada pa�s y cada a�o. El monto debe incluir fletes y descuentos.
	Los pa�ses deben salir en las filas y los a�os en las columnas. Si aumento m�s �rdenes de otros a�os, deber�n salir autom�ticamente en la consulta	4 Ptos
*/
Declare @A�os Varchar(MAX)
Declare @A�osSelect Varchar(MAX)

Set @A�os = Stuff((
					Select	Distinct
							',' + QuoteName(Year(O.OrderDate))
					From	Orders As O
					Order By 1
					For XML Path('')), 1, 1, '')

Set @A�osSelect = Stuff((
						Select	Distinct
								', IsNull(' + QuoteName(Year(O.OrderDate)) + ', 0) As ' + QuoteName(Year(O.OrderDate))
						From	Orders As O
						Order By 1
						For XML Path('')), 1, 1, '')

exec('Select	ShipCountry, '+@A�osSelect+'
From	(
		Select	Year(O.OrderDate) As A�o,
				O.ShipCountry,
				Round(Sum(OD.Quantity*OD.UnitPrice*(1-OD.Discount))+O.Freight, 2) As Monto
		From	Orders As O
				Join [Order Details] As OD
					On O.OrderID = OD.OrderID
		Group By
				O.OrderID,
				Year(O.OrderDate),
				O.ShipCountry,
				O.Freight) As Ventas
Pivot	(Sum(Monto) For A�o In('+@A�os+')) As PVT')
/*
5)	Haz un listado donde se aprecie el nombre del cliente, el a�o (1996, 1997, 1998), el monto de sus compras (con flete y descuento),
	el monto que compr� dicho cliente en el a�o anterior y el porcentaje de aumento (o disminuci�n) de su compra con respecto al a�o anterior.	2 Ptos
*/
	Select	Cliente, A�o, IsNull(Monto, 0) As Monto, Lag(Monto,1,0) Over(Partition By Cliente Order By A�o) As MontoAnterior,
			Format(IsNull((Monto/((Lag(Monto,1) Over(Partition By Cliente Order By A�o)))) - 1, 1 * Sign(IsNull(Monto, -1))), '0.00%') As Porcentaje
	From
	(
	Select	CA.*, Sum(VTA.Monto) As Monto
	From	
		(Select	Distinct
				C.ContactName As Cliente,
				Year(O.OrderDate) As A�o
		From	Customers As C
				Cross Join Orders As O) As CA
		Left Join
		(Select	C.ContactName,
				Year(O.OrderDate) As A�o,
				Round(Sum(OD.Quantity*OD.UnitPrice*(1-OD.Discount))+O.Freight, 2) As Monto
		From	Orders As O
				Join [Order Details] As OD
					On O.OrderID = OD.OrderID
				Join Customers As C
					On C.CustomerID = O.CustomerID
		Group By
				O.OrderID,
				C.ContactName,
				Year(O.OrderDate),
				O.Freight) As VTA
		On CA.Cliente =  VTA.ContactName
			And CA.A�o = VTA.A�o
Group By CA.Cliente, CA.A�o) As Datos
/*
6)	Muestra las tres mejores �rdenes (las que tienen mayor monto) de cada cliente	2 Ptos
*/
		Select	*
		From
			(Select	O.OrderID,
					C.ContactName,
					Round(Sum(OD.Quantity*OD.UnitPrice*(1-OD.Discount))+O.Freight, 2) As Monto,
					Rank() Over(Partition By C.ContactName Order By Round(Sum(OD.Quantity*OD.UnitPrice*(1-OD.Discount))+O.Freight, 2) Desc) As Puesto
			From	Orders As O
					Join [Order Details] As OD
						On O.OrderID = OD.OrderID
					Join Customers As C
						On C.CustomerID = O.CustomerID
			Group By
					O.OrderID,
					C.ContactName,
					O.Freight) As Datos
		Where Datos.Puesto <= 3
/*
7)	Haz un listado donde se vea el nombre de todas las tablas de la base de datos y sus campos (ordenados seg�n el orden en que fueron ingresados al dise�ar la tabla)	2 Ptos
*/
Select	T.Name, C.Name
From	Sys.Tables As T
		Join Sys.Columns As C
			On T.object_id = C.object_id
Where T.type='U'
Order By T.Name, C.column_id
/*
8)	Haz un listado que muestre el monto vendido por cada producto y qu� porcentaje representa dicho monto de las ventas totales de su categor�a	2 Ptos
*/
	Select	*,
			Format(Monto / Sum(Monto) Over(Partition By CategoryName), '0.00%') As MontoCategoria
	From
		(Select	
				C.CategoryName,
				P.ProductName,
				Round(Sum(OD.Quantity*OD.UnitPrice*(1-OD.Discount)), 2) As Monto
		From	[Order Details] As OD
				Right Join Products As P
					On	P.ProductID = OD.ProductID
				Right Join Categories	As C
					On C.CategoryID = P.CategoryID
		Group By
				C.CategoryName,
				P.ProductName) As Datos
