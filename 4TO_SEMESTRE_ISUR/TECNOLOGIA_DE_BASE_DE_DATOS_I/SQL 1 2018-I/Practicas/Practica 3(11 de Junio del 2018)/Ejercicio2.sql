SELECT   Distinct Format(O.OrderDate, 'MMMM yyyy', 'ES-pe') As Periodo,
		1000 + Dense_Rank() Over (Order By Year(O.Orderdate), Month(O.OrderDate))*100 Meta
Into	Metas
From	orders O

Delete From Metas Where Periodo In ('Octubre 1996', 'Diciembre 1996')

Select	*,
		Sum(Monto + Flete) Over(Partition By Empleado, Año, Mes Order By ID) As Acumulado,
		Metas.Meta,
		Case IsNull(Meta, '')
			When '' Then 'No hay meta registrada para ese mes'
		Else
			Case
				When Sum(Monto + Flete) Over(Partition By Empleado, Año, Mes Order By ID) < Metas.Meta Then
					'Aún falta llegar a la meta'
				Else
					'Ya llegaste a la meta! Felicidades, este mes no te despediré'
			End
		End As Observacion
From	(
				SELECT        O.OrderID As ID,
						O.OrderDate As Fecha,
						Format(O.OrderDate, 'MMMM yyyy', 'ES-pe') As Periodo,
						Year(O.OrderDate) As Año,
						Month(O.OrderDate) As Mes,
						E.LastName + N',  '+ FirstName AS Empleado,
						Round(SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)), 2) AS Monto,
						O.Freight As Flete
				FROM            [Order Details] AS OD INNER JOIN
										 Orders AS O ON OD.OrderID = O.OrderID INNER JOIN
										 Employees AS E ON O.EmployeeID = E.EmployeeID
				GROUP BY O.OrderID, O.OrderDate, E.LastName + N',  '+FirstName, O.Freight
	) As Ordenes
	left Join Metas On Metas.Periodo = Ordenes.Periodo