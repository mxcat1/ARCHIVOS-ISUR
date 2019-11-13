Declare	@Texto Varchar(MAX)

Select	@Texto = isNull(@Texto + ', ', '') + Año
From	(Select	Distinct QuoteName(Year(OrderDate)) As Año
		From	Orders) As TD1

Print @Texto

exec(
'Select	*
From
		(Select	O.ShipCountry As Pais,
					Year(O.OrderDate) As Año,
					OS.Subtotal + O.Freight As Monto
			From	Orders As O
					Join [Order Subtotals] As OS
						On O.OrderID = OS.OrderID) As TD1
Pivot(Sum(Monto)
		For Año In (' + @Texto + ')) As Pvt
Order By Pais')