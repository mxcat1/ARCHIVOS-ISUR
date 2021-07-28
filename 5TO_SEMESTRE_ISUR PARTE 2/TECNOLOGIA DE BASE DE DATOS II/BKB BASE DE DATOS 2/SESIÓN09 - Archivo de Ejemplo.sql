/*
FUNCIONES
    - Devuelven una respuesta
    - Escalar
    - Table-valued function (TVF)
	   - TVF inline
		  - CROSS APPLY = INNER JOIN
		  - OUTER APPLY = LEFT JOIN
	   - TVF Multistatement
*/

Alter Function Ordenes_Cliente
    (@Cod_Cliente As Varchar(5))
Returns Table
As
Return (Select CustomerID, OrderID, Freight, ShipCity + ', ' + ShipCountry As Lugar
	   From Orders
	   Where CustomerID = @Cod_Cliente)

Select  *
From dbo.Ordenes_Cliente('BONAP')

Select  C.CustomerID,
	   C.CompanyName,
	   C.City,
	   OC.*
From	   Customers As C
	   OUTER Apply dbo.Ordenes_Cliente(C.CustomerID) As OC
Where   C.Country In ('France', 'Spain')
Order By 1


Select *
From Customers

Create Function Clientes_Pares()
Returns Table
As
Return
	   (Select  TD.CustomerID,
				    TD.CompanyName,
				    TD.Country
	   From
			 (Select  C.CustomerID,
				    C.CompanyName,
				    C.Country,
				    ROW_NUMBER() Over(Order By Country, CompanyName) As Nro
			 From	   Customers As C) As TD
	   Where TD.Nro % 2 = 0)

Select * 
From dbo.Clientes_Pares()

Alter Function Ventas_Mes(@Cliente As Varchar(5))
Returns Table
As
Return
    (Select  *
    From
		  (Select  O.CustomerID,
				FORMAT(OrderDate, 'MMMM', 'es-pe') As Mes,
				O.Freight + OD.Subtotal As Monto
		  From	   Orders As O
			 Join [Order Subtotals] As OD On O.OrderID = OD.OrderID
		Where CustomerID = @Cliente) As TD
    Pivot (Sum(Monto) For Mes In ([Enero], [Febrero], [Marzo], [Abril], [Mayo], [Junio], [Julio], [Agosto], [Setiembre], [Octubre], [Noviembre], [Diciembre])) As PVT)

Select  *
From	   dbo.Ventas_Mes('BONAP')


Select  *
From	   dbo.Clientes_Pares() As C
	   OUTER APPLY dbo.Ventas_Mes(C.CustomerID) As V


Create Function Prueba()
Returns @VAR Table(Nombre  Varchar(30),
				ID  Varchar(5))
As
Begin
    Declare @X As Varchar(5)
    Declare @Rpta As Table
    
    Return  @Rpta  
End