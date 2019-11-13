/* FORMA1 para concatenar*/
declare @T As Varchar(MAX),
		@T2 As Varchar(MAX)

Select	@T = IsNull(@T + ', ', '') + Pais,
		@T2 = IsNull(@T2 + ', ', '') + 'IsNull(' + Pais + ', 0) As ' + Pais
from
		(Select	Distinct QuoteName(ShipCountry) As Pais
		from	Orders
		) As TD


--Print @T
--Print @T2
/* FORMA2 para concatenar*/
--Select Stuff(Replace(Replace((Select	Distinct QuoteName(ShipCountry) As Pais
--from	Orders
--For XML Path('')),'<Pais>', ','), '</Pais>', ''), 1, 1, '')
--
/* FORMA3 para concatenar*/
--Select STRING_AGG(Pais, ',')
--from
--		(Select	Distinct QuoteName(ShipCountry) As Pais
--		From	Orders) As TD
--
If Not OBJECT_ID('Ventas') Is Null
Begin
	Drop Table Ventas
End
exec('Select	proveedor, producto, ' + @T2 + ' 
Into VENTAS From
			(SELECT        S.CompanyName As Proveedor,
						P.ProductName As Producto,
						O.ShipCountry As Pais,
						Convert(Money, OD.Quantity * OD.UnitPrice * (1- OD.Discount)) As Monto
			FROM            [Order Details] AS OD INNER JOIN
									 Orders AS O ON OD.OrderID = O.OrderID INNER JOIN
									 Products AS P ON OD.ProductID = P.ProductID INNER JOIN
									 Suppliers AS S ON P.SupplierID = S.SupplierID) As TD1
	PIVOT (Sum(Monto)
			For Pais In ('+@T+')
			) As PVT Order By Proveedor, Producto')

Select * from Ventas