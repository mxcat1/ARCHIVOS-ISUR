Declare	@Texto Varchar(MAX)

Select	@Texto = isNull(@Texto + ', ', '') + A�o
From	(Select	Distinct QuoteName(Year(OrderDate)) As A�o
		From	Orders) As TD1

Print @Texto

exec(
'Select	*
From
		(Select	O.ShipCountry As Pais,
					Year(O.OrderDate) As A�o,
					OS.Subtotal + O.Freight As Monto
			From	Orders As O
					Join [Order Subtotals] As OS
						On O.OrderID = OS.OrderID) As TD1
Pivot(Sum(Monto)
		For A�o In (' + @Texto + ')) As Pvt
Order By Pais')