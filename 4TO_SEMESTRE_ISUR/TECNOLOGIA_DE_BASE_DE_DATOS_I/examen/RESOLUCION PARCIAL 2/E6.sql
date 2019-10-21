/*6.	Haz un listado que muestre el 
mes y año de la compra (ejemplo: junio 1996),
el monto vendido ese mes y 
el monto acumulado de ventas 
hasta ese periodo (un acumulado).	5 Ptos*/
Select	Periodo, Monto, (	Select	Sum(OS.Subtotal + O.Freight) As Monto
				From	Orders As O
						Join [Order Subtotals] As OS
							On O.OrderID = OS.OrderID
				Where Format(O.OrderDate, 'yyyyMM', 'ES-pe') <= Datos.Orden
		) As Acumulado
From	(
Select	Format(O.OrderDate, 'yyyyMM', 'ES-pe') As Orden,
		Format(O.OrderDate, 'MMMM yyyy', 'ES-pe') As Periodo,
		Sum(OS.Subtotal + O.Freight) As Monto
From	Orders As O
		Join [Order Subtotals] As OS
			On O.OrderID = OS.OrderID
Group By Format(O.OrderDate, 'yyyyMM', 'ES-pe'),
		Format(O.OrderDate, 'MMMM yyyy', 'ES-pe')
) As Datos
Order By Orden